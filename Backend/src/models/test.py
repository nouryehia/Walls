'''
Test model.

Table Accessed:
    - Test
'''

# External imports
from __future__ import annotations
from typing import Dict, Union

from ..config import db, con  # Internal imports


class Test:
    '''
    Test class.

    Instance variables:
        - id: id of test in database
        - test_string: string of test
        - test_int: int of test

    Methods:
        - to_json: converts test to json format
        - read (static): fetches all tests in database
        - write (static): adds a test to the database
    '''
    def __init__(self, id: int, test_string: str, test_int: int):
        '''
        Constructor.
        '''
        self.id = id
        self.test_string = test_string
        self.test_int = test_int

    def to_json(self) -> Dict[str, Union[str, int]]:
        '''
        Converts test to json format.

        Params: none.

        Output:
            - Json representation of test
        '''
        json = {}

        json['id'] = self.id
        json['test_string'] = self.test_string
        json['test_int'] = self.test_int

        return json

    @staticmethod
    def read() -> [Test]:
        '''
        Fetches all tests in database.

        Params: none.

        Output:
            - List containing all tests in database
        '''
        db.execute('select * from test')
        records = db.fetchall()

        tests = []

        for record in records:
            tests.append(Test(record[0], record[1], record[2]))

        return tests

    @staticmethod
    def write(test_string: str, test_int: int) -> Test:
        '''
        Adds a test to the database.

        Params:
            - test_string: string to be inserted
            - test_int: int to be inserted

        Output:
            - Test object that was inserted
        '''
        db.execute(f'insert into test (test_string, test_int) values \
                     ("{test_string}", {test_int})')
        con.commit()

        db.execute('select max(id) from test')
        id = db.fetchall()[0][0]

        return Test(id, test_string, test_int)
