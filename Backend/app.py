'''
Runs the backend.
'''

import os  # External import

from config import app  # Flask app import

# Route imports
from src.controllers.test import test_controller

# Blueprint registrations
app.register_blueprint(test_controller, url_prefix='/test')

# Declare the home route
@app.route('/', methods=['GET'])
def home():
    '''
    Home route. Backend is running if this can be accessed.
    '''
    return "<h1>Welcome to the Walls Backend!</h1>"


app.run()  # Run the app

os.system('find . -name "*.pyc"  -delete &>/dev/null')  # Remove .pyc files
