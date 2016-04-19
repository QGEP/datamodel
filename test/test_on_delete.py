import unittest

import psycopg2
import psycopg2.extras
import decimal
from time import sleep

from utils import DbTestBase

class TestTriggers(unittest.TestCase, DbTestBase):

    @classmethod
    def tearDownClass(cls):
        cls.conn.rollback()

    @classmethod
    def setUpClass(cls):
        cls.conn = psycopg2.connect("service=pg_qgep")


    def test_delete_wastewater_structure(self):
        row = {
                'identifier': 'CO123',
                'level': decimal.Decimal('50.000')
        }

        obj_id = self.insert_check('vw_cover', row)

        row = self.select('vw_cover', obj_id)

        self.delete('od_wastewater_structure', row['ws_obj_id'])

        print(self.select('vw_cover', obj_id))


if __name__ == '__main__':
    unittest.main()
