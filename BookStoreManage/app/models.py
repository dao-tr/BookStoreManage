from sqlalchemy import Column, Integer, String, Float, Boolean, DateTime, ForeignKey, Enum
from sqlalchemy.orm import relationship
from app import db, app
from datetime import datetime
from flask_login import UserMixin
import enum
import hashlib


class UserRole(enum.Enum):
    ADMIN = 1
    STAFF = 2
    WAREHOUSE = 3
    USER = 4


class OrderStatus(enum.Enum):
    PENDING = 1
    PAID = 2
    CANCELLED = 3


class PaymentMethod(enum.Enum):
    DIRECT_AT_COUNTER = 1
    CASH_AT_STORE = 2
    ONLINE_FREE_SHIP = 3


class BaseModel(db.Model):
    __abstract__ = True
    id = Column(Integer, primary_key=True, autoincrement=True)


class User(BaseModel, UserMixin):
    name = Column(String(50), nullable=False)
    username = Column(String(50), nullable=False, unique=True)
    password = Column(String(50), nullable=False)
    avatar = Column(String(100), default='https://res.cloudinary.com/dxxwcby8l/image/upload/v1647056401/ipmsmnxjydrhpo2btdx8.jpg')
    active = Column(Boolean, default=True)
    joined_date = Column(DateTime, default=datetime.now)
    user_role = Column(Enum(UserRole), default=UserRole.USER)

    customer_receipts = relationship('Receipt', backref='customer', foreign_keys='Receipt.user_id', lazy=True)
    staff_receipts = relationship('Receipt', backref='staff', foreign_keys='Receipt.staff_id', lazy=True)
    import_receipts = relationship('ImportReceipt', backref='warehouse_manager', lazy=True)

    def __str__(self):
        return self.name


class Rule(BaseModel):
    #Rule
    min_import_quantity = Column(Integer, default=150)  # Số lượng nhập ít nhất 150
    max_stock_to_import = Column(Integer, default=300)  # Chỉ nhập sách có số lượng < 300
    cancel_order_hours = Column(Integer, default=48)    # Hủy đơn sau 48 tiếng nếu không đến lấy và thanh toán


class Category(BaseModel):
    name = Column(String(50), nullable=False, unique=True)
    books = relationship('Book', backref='category', lazy=True)

    def __str__(self):
        return self.name


class Book(BaseModel):
    barcode = Column(String(50), nullable=False, unique=True)
    name = Column(String(100), nullable=False)
    author = Column(String(100), nullable=False)
    price = Column(Float, default=0)
    quantity = Column(Integer, default=0)
    image = Column(String(255), default='https://via.placeholder.com/150')
    active = Column(Boolean, default=True)
    category_id = Column(Integer, ForeignKey(Category.id), nullable=False)

    receipt_details = relationship('ReceiptDetail', backref='book', lazy=True)
    import_details = relationship('ImportReceiptDetail', backref='book', lazy=True)

    def __str__(self):
        return self.name


# YÊU CẦU 1: Phiếu nhập sách
class ImportReceipt(BaseModel):
    created_date = Column(DateTime, default=datetime.now)
    user_id = Column(Integer, ForeignKey(User.id), nullable=False)  # Quản lý kho
    details = relationship('ImportReceiptDetail', backref='import_receipt', lazy=True)


class ImportReceiptDetail(BaseModel):
    import_receipt_id = Column(Integer, ForeignKey(ImportReceipt.id), nullable=False)
    book_id = Column(Integer, ForeignKey(Book.id), nullable=False)
    quantity = Column(Integer, default=150)


# YÊU CẦU 2 & 3: Hóa đơn bán sách & Đặt sách online
class Receipt(BaseModel):
    created_date = Column(DateTime, default=datetime.now)
    customer_name = Column(String(100), nullable=True)
    delivery_address = Column(String(255), nullable=True)
    free_shipping = Column(Boolean, default=False)
    user_id = Column(Integer, ForeignKey(User.id), nullable=True)
    staff_id = Column(Integer, ForeignKey(User.id), nullable=True)
    payment_method = Column(Enum(PaymentMethod), default=PaymentMethod.DIRECT_AT_COUNTER)
    status = Column(Enum(OrderStatus), default=OrderStatus.PAID)
    details = relationship('ReceiptDetail', backref='receipt', lazy=True)


class ReceiptDetail(BaseModel):
    receipt_id = Column(Integer, ForeignKey(Receipt.id), nullable=False)
    book_id = Column(Integer, ForeignKey(Book.id), nullable=False)
    quantity = Column(Integer, default=0)
    unit_price = Column(Float, default=0)


if __name__ == '__main__':
    with app.app_context():
        db.create_all()

        if not Rule.query.first():
            db.session.add(Rule(min_import_quantity=150, max_stock_to_import=300, cancel_order_hours=48))

        # Test
        if not User.query.first():
            pw = str(hashlib.md5('123456'.encode('utf-8')).hexdigest())
            u_admin = User(name='Admin', username='admin', password=pw, user_role=UserRole.ADMIN)
            u_warehouse = User(name='Quản lý kho', username='kho', password=pw, user_role=UserRole.WAREHOUSE)
            u_staff = User(name='Thu ngân', username='nhanvien', password=pw, user_role=UserRole.STAFF)
            u_customer = User(name='abc', username='abc', password=pw, user_role=UserRole.USER)
            db.session.add_all([u_admin, u_warehouse, u_staff, u_customer])

        # Cat
        if not Category.query.first():
            c1 = Category(name='Văn học')
            c2 = Category(name='Kinh tế')
            c3 = Category(name='Công nghệ thông tin')
            db.session.add_all([c1, c2, c3])
            db.session.commit()

            b1 = Book(barcode='0000001', name='Nhà Giả Kim', author='Paulo Coelho', price=79000, quantity=120, category_id=c1.id)
            b2 = Book(barcode='0000002', name='Đắc Nhân Tâm', author='Dale Carnegie', price=86000, quantity=350, category_id=c2.id)
            b3 = Book(barcode='0000003', name='Clean Code', author='Robert C. Martin', price=320000, quantity=80, category_id=c3.id)
            db.session.add_all([b1, b2, b3])

        db.session.commit()