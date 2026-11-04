import cloudinary
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from urllib.parse import quote

app = Flask(__name__)
app.secret_key = 'BOOKSTORE_SECRET_KEY_2026!@#'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:1234@localhost/bookstoredb?charset=utf8mb4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['PAGE_SIZE'] = 8

cloudinary.config(
    cloud_name='dsjytfvdz',
    api_key='841864179767685',
    api_secret='HSKtnNsA6UtWZvlI-w24ef99UD4'
)

db = SQLAlchemy(app=app)
login = LoginManager(app=app)