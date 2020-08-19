'''
Includes Flask, database, and encryption configurations.
'''

# External imports
import os
import flask
import mysql.connector
from passlib.context import CryptContext

# Initialize Flask API
app = flask.Flask(__name__)
app.config["DEBUG"] = True

# Connect to database
con = mysql.connector.connect(host=os.getenv('DB_HOST'),
                              user=os.getenv('DB_USER'),
                              password=os.getenv('DB_PASS'),
                              database=os.getenv('DB_NAME'),
                              auth_plugin=os.getenv('DB_AUTH'))
db = con.cursor()

# Initialize encryption context
crypt = CryptContext(schemes=["pbkdf2_sha256"], default="pbkdf2_sha256",
                     pbkdf2_sha256__default_rounds=30000)
