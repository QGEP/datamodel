import unittest

import psycopg2
import psycopg2.extras
import decimal
import copy

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

    def test_vw_overflow_prank_weir(self):
        row = {
                'identifier': 'STAR20',
                'level_max': decimal.Decimal('300.123')
        }

        obj_id = self.insert_check('vw_overflow_prank_weir', row)

        row = {
                'identifier': '30',
                'level_max': decimal.Decimal('400.321')
        }

        self.update_check('vw_overflow_prank_weir', row, obj_id)

    def test_vw_qgep_reach(self):
        row = {
                'clear_height': 100,
                'coefficient_of_friction': 10,
                'identifier': 'pra',
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

    def test_vw_qgep_wastewater_structure(self):
        row = {
                'identifier': '20',
                'ws_type': 'manhole',
                'situation_geometry': '0104000020080800000100000001010000000000000020D6434100000000804F3241', # SELECT ST_SetSRID(ST_GeomFromText('MULTIPOINT(2600000 1200000)'), 2056)
                'cover_material': 5355,
                'backflow_level': decimal.Decimal('100.000')
        }

        expected_row = copy.deepcopy(row)
        expected_row['situation_geometry'] = '0104000020080800000100000001010000000000000020D6434100000000804F3241' # SELECT ST_SetSRID(ST_GeomFromText('MULTIPOINT(2600000 1200000)'), 2056)

        obj_id = self.insert_check('vw_qgep_wastewater_structure', row, expected_row)

        row = {
                'identifier': '10',
                'ws_type': 'special_structure',
                'cover_material': 233,
                'upper_elevation': decimal.Decimal('405.000'),
        }

        self.update_check('vw_qgep_wastewater_structure', row, obj_id)

        cur = self.cursor()

        cur.execute("SELECT * FROM qgep_od.wastewater_networkelement NE LEFT JOIN qgep_od.wastewater_node NO ON NO.obj_id = NE.obj_id WHERE fk_wastewater_structure='{obj_id}' ".format(obj_id=obj_id))
        row = cur.fetchone()

        assert row['backflow_level'] == decimal.Decimal('100.000')

if __name__ == '__main__':
    unittest.main()
