'''
Test controller.

Routes:
    - read: fetches all the entries in the Test table
    - write: adds an entry to the Test table
'''

# External imports
from flask import Blueprint, request, jsonify
from flask_cors import CORS

from ..models.test import Test  # Internal import

# Define blueprint
test_controller = Blueprint("test_controller", __name__)
CORS(test_controller, supports_credentials=True)


@test_controller.route('/read', methods=['POST'])
def read():
    '''
    Fetches all the entries in the Test table.

    Params: none.

    Output:
        - [
            id: id of test entry
            test_string: string value in test entry
            test_int: string value in test entry
          ]
    '''
    tests = Test.read()

    json = []
    for test in tests:
        json.append(test.to_json())

    return jsonify(json), 200


@test_controller.route('/write', methods=['POST'])
def write():
    '''
    Adds an entry to the Test table.

    Params:
        - test_string: test string to be added
        - test_int: test int to be added

    Output:
        - id: id of test entry
        - test_string: string value in test entry
        - test_int: string value in test entry
    '''
    test_string = request.json['test_string']
    test_int = request.json['test_int']

    return jsonify(Test.write(test_string, test_int).to_json()), 200
