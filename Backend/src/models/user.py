'''
User model.

Table Accessed:
    - Users
'''

from typing import Dict, Union  # External imports

from ..config import db, con, crypt  # Internal imports


class User:
    '''
    User class.

    Instance variables:
        - id: user's id
        - first_name: user's first name
        - last_name: user's last name
        - username: user's username
        - email: user's email
        - password: user's password
        - profile_photo: user's profile_photo
        - qr_code: user's qr code

    Methods:
        - to_json: converts user to JSON format
        - login (static): authenticates user credentials
        - signup (static): signs a user up
        - get_all_credentials (static): fetches all taken usernames and emails
    '''

    def __init__(self, id: int, first_name: str, last_name: str, username: str,
                 email: str, password: str, profile_photo: str, qr_code: str):
        '''
        Constructor.
        '''
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.username = username
        self.email = email
        self.password = password
        self.profile_photo = profile_photo
        self.qr_code = qr_code

    def to_json(self) -> Dict[str, Union[str, int]]:
        '''
        Converts user to JSON format.

        Params: none.

        Output:
            - JSON representation of user
        '''
        json = {}

        json['id'] = self.id
        json['first_name'] = self.first_name
        json['last_name'] = self.last_name
        json['username'] = self.username
        json['email'] = self.email
        json['password'] = self.password
        json['profile_photo'] = self.profile_photo
        json['qr_code'] = self.qr_code

        return json

    @staticmethod
    def login(user_or_email: str, password: str) -> (bool, int):
        '''
        Authenticates user credentials.

        Params:
            - user_or_email: username or email provided
            - password: password provided

        Output:
            - True and user's id if user can be authenticated and False o/w.
        '''
        db.execute(f'select id, password from users where username =\
                     "{user_or_email}" or email = "{user_or_email}"')
        result = db.fetchall()

        return ((True, result[0][0])
                if result and crypt.verify(password, result[0][1]) else
                (False, None))

    @staticmethod
    def signup(first_name: str, last_name: str, username: str, email: str,
               password: str, profile_photo: str) -> int:
        '''
        Signs a user up

        Params:
            - first_name: user's first name
            - last_name: user's last name
            - username: user's username
            - email: user's email
            - password: user's password
            - profile_photo: user's profile photo

        Output:
            - id of newly-created user.
        '''
        qr_code = 'QR CODE BIT 64'

        db.execute(f'insert into users values (null, "{first_name}",\
                     "{last_name}", "{username}", "{email}",\
                     "{crypt.encrypt(password)}", "{profile_photo}",\
                     "{qr_code}")')
        con.commit()

        db.execute('select max(id) from users')
        return db.fetchall()[0][0]

    @staticmethod
    def get_all_credentials() -> ([str], [str]):
        '''
        Fetches all taken usernames and emails.

        Params: None

        Output:
            - list containing all taken usernames and list containing all taken
              emails
        '''
        db.execute('select username, email from users')
        results = db.fetchall()

        usernames = []
        emails = []

        for result in results:
            usernames.append(result[0])
            emails.append(result[1])

        return (usernames, emails)
