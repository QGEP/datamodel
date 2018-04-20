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
        # Create a new cover(structure part) with manhole(wastewater structure)
        row = {
                'identifier': 'CO698',
                'co_level': decimal.Decimal('50.000'),
                'ws_type': 'manhole'
        }

        obj_id = self.insert_check('vw_qgep_wastewater_structure', row)

        # Get the new cover
        row = self.select('vw_qgep_wastewater_structure', obj_id)
        row = self.select('vw_cover', row['co_obj_id'])

        self.delete('wastewater_structure', row['fk_wastewater_structure'])

        # Just to be sure the structure really was deleted
        self.assertIsNone(self.select('manhole', row['fk_wastewater_structure']))
        self.assertIsNone(self.select('wastewater_structure', row['fk_wastewater_structure']))
        # The cover should be delted as well. If not, the foreign key constraint action does not work properly
        self.assertIsNone(self.select('vw_cover', obj_id))


if __name__ == '__main__':
    unittest.main()
