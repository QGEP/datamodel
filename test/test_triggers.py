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


    def test_last_modified(self):
        row = {
                'identifier': 'CO123',
                'level': decimal.Decimal('50.000')
        }

        obj_id = self.insert_check('vw_cover', row)

        row = self.select('od_structure_part', obj_id)

        last_mod = row['last_modification']
        assert last_mod is not None, "Last modification not set on insert"

        row = {
                'identifier': 'CO1234',
        }

        self.update_check('od_structure_part', row, obj_id)

        row = self.select('od_structure_part', obj_id)
        assert last_mod != row['last_modification'], "Last modification not set on update (still {})".format(row['last_modification'])

        last_mod = row['last_modification']

        row = {
                'level': decimal.Decimal('300.000')
        }

        self.update_check('od_cover', row, obj_id)

        row = self.select('od_structure_part', obj_id)
        assert last_mod != row['last_modification'], "Last modification not set on update of child table (still {})".format(row['last_modification'])

    def test_identifier(self):
        row = {
                'level': decimal.Decimal('50.000')
        }

        obj_id = self.insert_check('vw_cover', row)

        row = self.select('od_structure_part', obj_id)

        identifier = row['identifier']
        assert identifier is not None, "Identifier not set on insert"

if __name__ == '__main__':
    unittest.main()
