'''
Test controller.

Routes:
    - test_route: calls a Test model method to test basic functionality.
'''

# External import
from flask import Blueprint
from flask_cors import CORS

from ..models.test import Test  # Internal import

# Define blueprint
test_controller = Blueprint("test_controller", __name__)
CORS(test_controller, supports_credentials=True)


@test_controller.route("/test_route", methods=["GET"])
def test_route():
    """
    Calls a Test model method to test basic functionality.

    Params: none

    Output: string
    """
    return Test.test_method()
