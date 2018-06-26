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

    def test_update_1(self):

        # insert correct row in qgep_import.vw_manhole
        row = {
                'remark': 'test_remark1'
        }
        obj_id = self.insert('vw_manhole', row, 'qgep_import')

        # it shouldn't be in the quarantine (qgep_import.manhole_quarantine)
        result_row = self.select('manhole_quarantine', obj_id, 'qgep_import')
        self.assertIsNone( result_row )

        # it should be in the live table (qgep_od.wastewater_structure)
        result_row = self.select('wastewater_structure', obj_id, 'qgep_od')
        self.assertIsNotNone( result_row )
        self.assertEqual( result_row['remark'], 'test_remark1')

        # it should be in the vw_manhole view (qgep_import.vw_manhole)

        '''
        # update correct row in vw_manhole
        row = {
                'remark': 'test_remark1'
        }

        self.update_check('vw_manhole', row, 'ch13p7mzMA000011', 'qgep_import')

        # it shouldn't be in the quarantine (qgep_import.manhole_quarantine)
        result_row = self.select('manhole_quarantine', obj_id, 'qgep_import')
        self.assertIsNotNone( result_row ) # remove
        self.assertEqual( result_row['remark'], 'test_remark1') # self.assertIsNone( result_row )

        # it should be in the live table (qgep_od.wastewater_structure)
        result_row = self.select('wastewater_structure', obj_id, 'qgep_od')
        # self.assertIsNotNone( result_row )
        self.assertIsNone( result_row ) # self.assertEqual( result_row['remark'], 'test_remark1')
        '''
               
if __name__ == '__main__':
    unittest.main()