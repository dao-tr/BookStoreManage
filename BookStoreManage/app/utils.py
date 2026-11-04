from app import db
from app.models import User, Category, Book, Receipt, ReceiptDetail, ImportReceipt, ImportReceiptDetail, Rule, OrderStatus, PaymentMethod
from sqlalchemy import func, extract
from datetime import datetime, timedelta
import hashlib
from sqlalchemy import or_


def get_rule():
    rule = Rule.query.first()
    if not rule:
        rule = Rule(min_import_quantity=150, max_stock_to_import=300, cancel_order_hours=48)
        db.session.add(rule)
        db.session.commit()
    return rule


def auth_user(username, password):
    password = str(hashlib.md5(password.strip().encode('utf-8')).hexdigest())
    return User.query.filter(User.username == username.strip(),
                             User.password == password,
                             User.active.__eq__(True)).first()


def get_user_by_id(user_id):
    return User.query.get(user_id)


def load_categories():
    return Category.query.all()


def load_books(kw=None, category_id=None):
    query = Book.query.filter(Book.active.__eq__(True))

    if category_id:
        query = query.filter(Book.category_id.__eq__(int(category_id)))

    if kw:
        kw = kw.strip()
        query = query.filter(or_(
            Book.name.contains(kw),
            Book.author.contains(kw),
            Book.barcode.contains(kw)
        ))

    return query.all()


def get_book_by_barcode(barcode):
    return Book.query.filter(Book.barcode == barcode.strip(), Book.active.__eq__(True)).first()


# YC 2: Hủy quá 48h
def cancel_expired_orders():
    rule = get_rule()
    expire_time = datetime.now() - timedelta(hours=rule.cancel_order_hours)

    expired_orders = Receipt.query.filter(
        Receipt.status == OrderStatus.PENDING,
        Receipt.created_date <= expire_time
    ).all()

    for order in expired_orders:
        order.status = OrderStatus.CANCELLED
        # Khôi phục số lượng
        for d in order.details:
            if d.book:
                d.book.quantity += d.quantity

    if expired_orders:
        db.session.commit()
    return len(expired_orders)


def count_cart(cart):
    total_quantity, total_amount = 0, 0
    if cart:
        for c in cart.values():
            total_quantity += c['quantity']
            total_amount += c['quantity'] * c['price']
    return {
        'total_quantity': total_quantity,
        'total_amount': total_amount
    }


# YC 4: Báo cáo doanh thu theo tháng cho từng thể loại
def revenue_stats_by_month(month, year=None):
    if not year:
        year = datetime.now().year

    query = db.session.query(
        Category.id,
        Category.name,
        func.sum(ReceiptDetail.quantity * ReceiptDetail.unit_price).label('revenue'),
        func.count(func.distinct(Receipt.id)).label('order_count')
    ).join(Book, Book.category_id == Category.id)\
     .join(ReceiptDetail, ReceiptDetail.book_id == Book.id)\
     .join(Receipt, Receipt.id == ReceiptDetail.receipt_id)\
     .filter(
         Receipt.status == OrderStatus.PAID,
         extract('month', Receipt.created_date) == int(month),
         extract('year', Receipt.created_date) == int(year)
     ).group_by(Category.id, Category.name).all()

    total_revenue = sum([row.revenue or 0 for row in query])

    results = []
    for row in query:
        rev = row.revenue or 0
        ratio = round((rev / total_revenue * 100), 2) if total_revenue > 0 else 0
        results.append({
            'id': row.id,
            'category_name': row.name,
            'revenue': rev,
            'order_count': row.order_count,
            'ratio': ratio
        })

    return results, total_revenue


# Báo cáo sách bán theo tháng
def book_frequency_stats_by_month(month, year=None):
    if not year:
        year = datetime.now().year

    query = db.session.query(
        Book.id,
        Book.name,
        Category.name.label('category_name'),
        func.sum(ReceiptDetail.quantity).label('total_qty')
    ).join(Category, Category.id == Book.category_id)\
     .join(ReceiptDetail, ReceiptDetail.book_id == Book.id)\
     .join(Receipt, Receipt.id == ReceiptDetail.receipt_id)\
     .filter(
         Receipt.status == OrderStatus.PAID,
         extract('month', Receipt.created_date) == int(month),
         extract('year', Receipt.created_date) == int(year)
     ).group_by(Book.id, Book.name, Category.name).all()

    total_books_sold = sum([row.total_qty or 0 for row in query])

    results = []
    for row in query:
        qty = row.total_qty or 0
        ratio = round((qty / total_books_sold * 100), 2) if total_books_sold > 0 else 0
        results.append({
            'id': row.id,
            'book_name': row.name,
            'category_name': row.category_name,
            'quantity': qty,
            'ratio': ratio
        })

    return results, total_books_sold