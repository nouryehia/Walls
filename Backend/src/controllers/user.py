'''
User controller.

Routes:
    - login: authenticates user credentials
    - signup: signs a user up
    - get_all_credentials: fetches all taken usernames and emails
'''

# External imports
from flask import Blueprint, request, jsonify
from flask_cors import CORS

from ..models.user import User  # Internal import

# Define blueprint
user_controller = Blueprint('user_controller', __name__)
CORS(user_controller, supports_credentials=True)


@user_controller.route('/login', methods=['POST'])
def login():
    '''
    Authenticates user credentials.

    Params:
        - user_or_email: username or email entered
        - password: password entered

    Output:
        - login: indicates whether user was succesfully logged in
        - id (optional): id of user if succesfully logged in
    '''
    user_or_email = request.json['user_or_email']
    password = request.json['password']

    login = User.login(user_or_email, password)

    toReturn = {'login': login[0]}

    if login[0]:
        toReturn['id'] = login[1]

    return jsonify(toReturn), 200


@user_controller.route('/signup', methods=['POST'])
def signup():
    '''
    Signs a user up.

    Params:
        - first_name: user's first name
        - last_name: user's last name
        - username: user's username
        - email: user's email
        - password: user's password
        - profile_photo: user's profile photo

    Output:
        - id: id of the newly-created user
    '''
    first_name = request.json['first_name']
    last_name = request.json['last_name']
    username = request.json['username']
    email = request.json['email']
    password = request.json['password']
    profile_photo = request.json['profile_photo']

    return jsonify({'id': User.signup(first_name, last_name, username, email,
                                      password, profile_photo)}), 200


@user_controller.route('/get_all_credentials', methods=['GET'])
def get_all_credentials():
    '''
    Fetches all taken usernames and emails.

    Params: None

    Output:
        - usernames: list containing all taken usernames
        - emails: list containing all taken emails
    '''
    credentials = User.get_all_credentials()

    return (jsonify({'usernames': credentials[0], 'emails': credentials[1]}),
            200)
