from flask import render_template, request, redirect, session, jsonify
from flask_login import login_user, logout_user, login_required, current_user
from app import app, db, login, utils, admin
from app.models import Book, Receipt, ReceiptDetail, PaymentMethod, OrderStatus, User, UserRole
from datetime import datetime
import hashlib


@login.user_loader
def load_user(user_id):
    return utils.get_user_by_id(user_id)


@app.before_request
def before_request_tasks():
    # hủy đơn quá 48h chưa thanh toán
    utils.cancel_expired_orders()


@app.context_processor
def common_response():
    return {
        'categories': utils.load_categories(),
        'cart_stats': utils.count_cart(session.get('cart'))
    }


@app.route('/')
@app.route('/')
def index():
    kw = request.args.get('kw')
    category_id = request.args.get('category_id')
    books = utils.load_books(kw=kw, category_id=category_id)
    return render_template('index.html', books=books)


@app.route('/login', methods=['GET', 'POST'])
def login_my_user():
    err_msg = ''
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        user = utils.auth_user(username=username, password=password)
        if user:
            login_user(user)
            next_page = request.args.get('next')
            return redirect(next_page if next_page else '/')
        else:
            err_msg = 'Tên đăng nhập hoặc mật khẩu không chính xác!'
    return render_template('login.html', err_msg=err_msg)


@app.route('/logout')
def logout_my_user():
    logout_user()
    return redirect('/login')


@app.route('/admin-login', methods=['POST'])
def admin_login():
    username = request.form.get('username')
    password = request.form.get('password')
    user = utils.auth_user(username=username, password=password)
    if user:
        login_user(user)
    return redirect('/admin')


@app.route('/register', methods=['GET', 'POST'])
def register():
    err_msg = ''
    success_msg = ''
    if request.method == 'POST':
        name = request.form.get('name')
        username = request.form.get('username')
        password = request.form.get('password')
        confirm_password = request.form.get('confirm_password')

        # Kiểm tra mật khẩu xác nhận
        if password != confirm_password:
            err_msg = 'Mật khẩu nhập lại không khớp!'
        else:
            # Kiểm tra xem username đã tồn tại chưa
            existing_user = User.query.filter_by(username=username).first()
            if existing_user:
                err_msg = 'Tên đăng nhập này đã có người sử dụng!'
            else:
                # Mã hóa mật khẩu sang MD5 đúng chuẩn hệ thống
                password_hashed = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())

                # Tạo user mới với quyền khách hàng (USER)
                new_user = User(
                    name=name,
                    username=username,
                    password=password_hashed,
                    user_role=UserRole.USER
                )
                db.session.add(new_user)
                db.session.commit()
                success_msg = 'Đăng ký tài khoản thành công!'

    return render_template('register.html', err_msg=err_msg, success_msg=success_msg)





@app.route('/cart')
def cart():
    return render_template('cart.html')


@app.route('/api/cart', methods=['POST'])
def add_to_cart():
    data = request.json
    book_id = str(data.get('id'))
    name = data.get('name')
    price = data.get('price')

    cart = session.get('cart')
    if not cart:
        cart = {}

    if book_id in cart:
        cart[book_id]['quantity'] += 1
    else:
        cart[book_id] = {
            'id': int(book_id),
            'name': name,
            'price': float(price),
            'quantity': 1
        }

    session['cart'] = cart
    return jsonify(utils.count_cart(cart))


@app.route('/api/cart/<book_id>', methods=['PUT'])
def update_cart(book_id):
    cart = session.get('cart')
    if cart and book_id in cart:
        quantity = int(request.json.get('quantity', 0))
        if quantity > 0:
            cart[book_id]['quantity'] = quantity
            session['cart'] = cart
    return jsonify(utils.count_cart(cart))


@app.route('/api/cart/<book_id>', methods=['DELETE'])
def delete_cart(book_id):
    cart = session.get('cart')
    if cart and book_id in cart:
        del cart[book_id]
        session['cart'] = cart
    return jsonify(utils.count_cart(cart))


# YC 2: Đặt sách online
@app.route('/api/pay', methods=['POST'])
@login_required
def pay():
    cart = session.get('cart')
    if not cart:
        return jsonify({'status': 400, 'err_msg': 'Giỏ hàng trống!'})

    data = request.json or {}
    payment_type = data.get('payment_method', 'CASH_AT_STORE')
    delivery_address = data.get('delivery_address', '')

    # CHeck tồn kho
    for c in cart.values():
        book = Book.query.get(c['id'])
        if not book or book.quantity < c['quantity']:
            return jsonify({
                'status': 400,
                'err_msg': f'Sách "{c["name"]}" không đủ số lượng tồn kho!'
            })

    try:
        # Set trạng thái đơn hàng
        if payment_type == 'ONLINE_FREE_SHIP':
            pm_enum = PaymentMethod.ONLINE_FREE_SHIP
            status_enum = OrderStatus.PAID
            free_ship = True
        else:
            pm_enum = PaymentMethod.CASH_AT_STORE
            status_enum = OrderStatus.PENDING
            free_ship = False

        receipt = Receipt(
            user_id=current_user.id,
            customer_name=current_user.name,
            delivery_address=delivery_address,
            free_shipping=free_ship,
            payment_method=pm_enum,
            status=status_enum,
            created_date=datetime.now()
        )
        db.session.add(receipt)

        for c in cart.values():
            book = Book.query.get(c['id'])
            book.quantity -= c['quantity']
            d = ReceiptDetail(
                receipt=receipt,
                book_id=c['id'],
                quantity=c['quantity'],
                unit_price=c['price']
            )
            db.session.add(d)

        db.session.commit()
        del session['cart']
        return jsonify({
            'status': 200,
            'msg': 'Đặt sách thành công! Lưu ý: Đơn chờ thanh toán, sẽ tự động hủy nếu sau 48 tiếng không đến nhận và thanh toán.'
        })
    except Exception as ex:
        return jsonify({'status': 500, 'err_msg': str(ex)})


# YC 3: quét mã vạch
@app.route('/api/barcode/<barcode>', methods=['GET'])
def get_book_by_barcode_api(barcode):
    book = utils.get_book_by_barcode(barcode)
    if book:
        return jsonify({
            'status': 200,
            'book': {
                'id': book.id,
                'barcode': book.barcode,
                'name': book.name,
                'category_name': book.category.name,
                'price': book.price,
                'quantity': book.quantity
            }
        })
    return jsonify({'status': 404, 'err_msg': 'Không tìm thấy!'})


if __name__ == '__main__':
    app.run(debug=True)