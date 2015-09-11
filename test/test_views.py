import unittest

import psycopg2
import psycopg2.extras
import decimal

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

    def test_vw_qgep_cover(self):
        row = {
                'identifier': '20',
                'ws_type': 'manhole',
                'situation_geometry': '01010000201555000000000000006AE840000000000088D340',
		'cover_material': 5355,
                'backflow_level': decimal.Decimal('100.000')
        }

        obj_id = self.insert_check('vw_qgep_cover', row)

        row = {
                'identifier': '10',
                'ws_type': 'special_structure',
		'cover_material': 233,
        }

        self.update_check('vw_qgep_cover', row, obj_id)

        cur = self.cursor()

        cur.execute("SELECT * FROM qgep.od_structure_part WHERE obj_id='{obj_id}'".format(obj_id=obj_id))
        row = cur.fetchone()

        ws_obj_id = row['fk_wastewater_structure']

        cur.execute("SELECT * FROM qgep.od_wastewater_networkelement NE LEFT JOIN qgep.od_wastewater_node NO ON NO.obj_id = NE.obj_id WHERE fk_wastewater_structure='{obj_id}' ".format(obj_id=ws_obj_id))
        row = cur.fetchone()

        assert row['backflow_level'] == decimal.Decimal('100.000')

if __name__ == '__main__':
    unittest.main()
