'''
Includes Flask and (eventually) database configurations.
'''

import flask  # External import

# Initialize Flask API
app = flask.Flask(__name__)
app.config["DEBUG"] = True
