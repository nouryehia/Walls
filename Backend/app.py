'''
Runs the backend.
'''

import os  # External import

from src.config import app  # Flask app import

# Route imports
from src.controllers.user import user_controller

# Blueprint registrations
app.register_blueprint(user_controller, url_prefix='/user')

# Declare the home route
@app.route('/', methods=['GET'])
def home():
    '''
    Home route. Backend is running if this can be accessed.
    '''
    return '<h1>Welcome to the Walls Backend!</h1>'


app.run()  # Run the app

os.system('find . -name "*.pyc"  -delete &>/dev/null')  # Remove .pyc files
