import unittest
import os

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
        pgservice=os.environ.get('PGSERVICE')
        if not pgservice:
          pgservice='pg_qgep'
        cls.conn = psycopg2.connect("service={service}".format(service=pgservice))


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


    def test_delete_reach(self):
        # Create a new reach and reachpoints
        row = {
                'identifier': 'RP001'
        }

        rp001_obj_id = self.insert_check('reach_point', row)

        row = {
                'identifier': 'RP002'
        }

        rp002_obj_id = self.insert_check('reach_point', row)

        row = {
                'identifier': 'WN001'
        }

        wn001_obj_id = self.insert_check('wastewater_networkelement', row)

        row = {
                'obj_id': wn001_obj_id,
                'fk_reach_point_from': rp001_obj_id,
                'fk_reach_point_to': rp002_obj_id
        }

        re001_obj_id = self.insert_check('reach', row)

        self.assertIsNotNone(self.select('reach', re001_obj_id))
        self.assertIsNotNone(self.select('reach_point', rp001_obj_id))
        self.assertIsNotNone(self.select('reach_point', rp002_obj_id))
        self.assertIsNotNone(self.select('wastewater_networkelement', wn001_obj_id))

        self.delete('reach', re001_obj_id)

        self.assertIsNone(self.select('reach', re001_obj_id))
        self.assertIsNone(self.select('reach_point', rp001_obj_id))
        self.assertIsNone(self.select('reach_point', rp002_obj_id))
        self.assertIsNone(self.select('wastewater_networkelement', wn001_obj_id))

        # The same but over the view vw_qgep_reach
        # Create a new reach and reachpoints
        row = {
                'identifier': 'RP001'
        }

        rp001_obj_id = self.insert_check('reach_point', row)

        row = {
                'identifier': 'RP002'
        }

        rp002_obj_id = self.insert_check('reach_point', row)

        row = {
                'identifier': 'WN001'
        }

        wn001_obj_id = self.insert_check('wastewater_networkelement', row)

        row = {
                'obj_id': wn001_obj_id,
                'fk_reach_point_from': rp001_obj_id,
                'fk_reach_point_to': rp002_obj_id
        }

        re001_obj_id = self.insert_check('reach', row)

        self.assertIsNotNone(self.select('vw_qgep_reach', re001_obj_id))
        self.assertIsNotNone(self.select('reach_point', rp001_obj_id))
        self.assertIsNotNone(self.select('reach_point', rp002_obj_id))
        self.assertIsNotNone(self.select('wastewater_networkelement', wn001_obj_id))

        self.delete('vw_qgep_reach', re001_obj_id)

        self.assertIsNone(self.select('vw_qgep_reach', re001_obj_id))
        self.assertIsNone(self.select('reach_point', rp001_obj_id))
        self.assertIsNone(self.select('reach_point', rp002_obj_id))
        self.assertIsNone(self.select('wastewater_networkelement', wn001_obj_id))



if __name__ == '__main__':
    unittest.main()
