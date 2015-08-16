import unittest

import psycopg2
import psycopg2.extras

from utils import DbTestBase

class TestViews(unittest.TestCase, DbTestBase):

    @classmethod
    def tearDownClass(cls):
        cls.conn.rollback()

    @classmethod
    def setUpClass(cls):
        cls.conn = psycopg2.connect("service=pg_qgep")


    def test_vw_reach(self):
        row = {
                'clear_height': 100,
                'coefficient_of_friction': 10,
                'identifier': '20'
        }

        obj_id = self.insert_check('vw_reach', row)

        row = {
                'clear_height': 200,
                'coefficient_of_friction': 20,
                'identifier': '10'
        }

        self.update_check('vw_reach', row, obj_id)

    def test_vw_qgep_reach(self):
        row = {
                'clear_height': 100,
                'coefficient_of_friction': 10,
                'identifier': '20',
                'usage_current': 4514
        }

        obj_id = self.insert_check('vw_qgep_reach', row)

        row = {
                'clear_height': 200,
                'coefficient_of_friction': 20,
                'identifier': '10',
                'usage_current': 4516
        }

        self.update_check('vw_qgep_reach', row, obj_id)

    def test_vw_qgep_cover(self):
        row = {
                'identifier': '20',
                'ws_type': 'manhole'
        }

        obj_id = self.insert_check('vw_qgep_cover', row)

        row = {
                'identifier': '10',
                'ws_type': 'special_structure'
        }

        self.update_check('vw_qgep_cover', row, obj_id)


if __name__ == '__main__':
    unittest.main()
