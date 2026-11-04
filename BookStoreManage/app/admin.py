import os
import cloudinary.uploader

from flask import redirect, request, jsonify
from flask_admin import Admin, BaseView, expose, AdminIndexView
from flask_admin.contrib.sqla import ModelView
from flask_login import current_user, logout_user
from app import app, db, utils
from app.models import Category, Book, User, Rule, Receipt, ReceiptDetail, ImportReceipt, ImportReceiptDetail, UserRole, OrderStatus, PaymentMethod
from datetime import datetime
from werkzeug.utils import secure_filename
from wtforms import FileField
from markupsafe import Markup


class AuthenticatedModelView(ModelView):
    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN


class BookView(AuthenticatedModelView):
    column_list = ['id', 'barcode', 'name', 'image', 'author', 'category', 'price', 'quantity', 'active']
    column_searchable_list = ['name', 'barcode', 'author']
    column_filters = ['name', 'price', 'category_id']
    can_export = True

    column_formatters = {
        'image': lambda v, c, m, p: Markup(
            f'<img src="{m.image}" width="60" style="object-fit: cover; border-radius: 4px;">'
        ) if m.image else ''
    }

    form_extra_fields = {
        'image': FileField('Chọn ảnh')
    }

    def on_model_change(self, form, model, is_created):
        file_data = form.image.data
        if file_data and hasattr(file_data, 'filename') and file_data.filename != '':
            res = cloudinary.uploader.upload(file_data)
            model.image = res['secure_url']
        elif not is_created:
            old_book = db.session.query(Book.image).filter_by(id=model.id).scalar()
            model.image = old_book
        else:
            model.image = 'https://via.placeholder.com/150'


# YC 1: Nhập sách
class ImportBookView(BaseView):
    @expose('/', methods=['GET', 'POST'])
    def index(self):
        rule = utils.get_rule()
        err_msg = None
        success_msg = None

        if request.method == 'POST':
            book_ids = request.form.getlist('book_id[]')
            quantities = request.form.getlist('quantity[]')

            if not book_ids:
                err_msg = 'Chọn ít nhất 1 đầu sách để lập phiếu!'
            else:
                valid_items = []
                for b_id, qty_str in zip(book_ids, quantities):
                    book = Book.query.get(int(b_id))
                    qty = int(qty_str)

                    if not book:
                        err_msg = f'Không tìm thấy sách ID {b_id}!'
                        break
                    # Nhập sách có số lượng < 300
                    if book.quantity >= rule.max_stock_to_import:
                        err_msg = f'Sách "{book.name}" còn {book.quantity} cuốn (>= {rule.max_stock_to_import}), không được phép nhập thêm!'
                        break
                    # Số lượng nhập ít nhất 150
                    if qty < rule.min_import_quantity:
                        err_msg = f'Sách "{book.name}" có số lượng nhập là {qty} (phải >= {rule.min_import_quantity})!'
                        break

                    valid_items.append((book, qty))

                if not err_msg and valid_items:
                    import_receipt = ImportReceipt(user_id=current_user.id, created_date=datetime.now())
                    db.session.add(import_receipt)

                    for book, qty in valid_items:
                        detail = ImportReceiptDetail(
                            import_receipt=import_receipt,
                            book_id=book.id,
                            quantity=qty
                        )
                        book.quantity += qty
                        db.session.add(detail)

                    db.session.commit()
                    success_msg = f'Lập phiếu nhập sách #{import_receipt.id} thành công!'

        # Lọc danh sách các sách đủ điều kiện < 300
        eligible_books = Book.query.filter(Book.quantity < rule.max_stock_to_import, Book.active.__eq__(True)).all()
        all_books = Book.query.filter(Book.active.__eq__(True)).all()

        return self.render('admin/import_book.html',
                           eligible_books=eligible_books,
                           all_books=all_books,
                           rule=rule,
                           now=datetime.now(),
                           err_msg=err_msg,
                           success_msg=success_msg)

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role in [UserRole.WAREHOUSE, UserRole.ADMIN]


# YC 3: Nv bán tạivquaafy
class CreateReceiptView(BaseView):
    @expose('/', methods=['GET', 'POST'])
    def index(self):
        err_msg = None
        success_msg = None

        if request.method == 'POST':
            customer_name = request.form.get('customer_name', 'Khách lẻ')
            book_ids = request.form.getlist('book_id[]')
            quantities = request.form.getlist('quantity[]')

            if not book_ids:
                err_msg = 'Hóa đơn phải có ít nhất 1 quyển sách!'
            else:
                valid_items = []
                for b_id, qty_str in zip(book_ids, quantities):
                    book = Book.query.get(int(b_id))
                    qty = int(qty_str)
                    if not book or qty <= 0:
                        err_msg = 'Dữ liệu sách hoặc số lượng không hợp lệ!'
                        break
                    if book.quantity < qty:
                        err_msg = f'Sách "{book.name}" còn {book.quantity}, không đủ {qty}!'
                        break
                    valid_items.append((book, qty))

                if not err_msg and valid_items:
                    receipt = Receipt(
                        customer_name=customer_name,
                        staff_id=current_user.id,
                        payment_method=PaymentMethod.DIRECT_AT_COUNTER,
                        status=OrderStatus.PAID,
                        created_date=datetime.now()
                    )
                    db.session.add(receipt)

                    for book, qty in valid_items:
                        detail = ReceiptDetail(
                            receipt=receipt,
                            book_id=book.id,
                            quantity=qty,
                            unit_price=book.price
                        )
                        book.quantity -= qty
                        db.session.add(detail)

                    db.session.commit()
                    success_msg = f'Xuất hóa đơn bán sách #{receipt.id} thành công!'

        books = utils.load_books()
        return self.render('admin/create_receipt.html',
                           books=books,
                           now=datetime.now(),
                           err_msg=err_msg,
                           success_msg=success_msg)

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role in [UserRole.STAFF, UserRole.ADMIN]


# YC 4: Thoóng kê
class StatsView(BaseView):
    @expose('/')
    def index(self):
        month = request.args.get('month', datetime.now().month, type=int)
        year = request.args.get('year', datetime.now().year, type=int)

        revenue_stats, total_revenue = utils.revenue_stats_by_month(month=month, year=year)
        freq_stats, total_books_sold = utils.book_frequency_stats_by_month(month=month, year=year)

        return self.render('admin/stats.html',
                           month=month,
                           year=year,
                           revenue_stats=revenue_stats,
                           total_revenue=total_revenue,
                           freq_stats=freq_stats,
                           total_books_sold=total_books_sold)

    def is_accessible(self):
        return current_user.is_authenticated and current_user.user_role == UserRole.ADMIN


class LogoutView(BaseView):
    @expose('/')
    def index(self):
        logout_user()
        return redirect('/admin')

    def is_accessible(self):
        return current_user.is_authenticated


admin = Admin(app=app, name='QUẢN LÝ NHÀ SÁCH')
admin.add_view(AuthenticatedModelView(Category, db.session, name='Thể loại'))
admin.add_view(BookView(Book, db.session, name='Sách'))
admin.add_view(AuthenticatedModelView(Rule, db.session, name='Quy định'))
admin.add_view(AuthenticatedModelView(User, db.session, name='User'))
admin.add_view(ImportBookView(name='Nhập sách (Kho)', endpoint='importbook'))
admin.add_view(CreateReceiptView(name='Lập HĐ Bán sách', endpoint='createreceipt'))
admin.add_view(StatsView(name='Thống kê - Báo cáo', endpoint='stats'))
admin.add_view(LogoutView(name='Đăng xuất'))