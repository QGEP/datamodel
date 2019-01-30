import unittest
import os

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
        pgservice=os.environ.get('PGSERVICE')
        if not pgservice:
          pgservice='pg_qgep'
        cls.conn = psycopg2.connect("service={service}".format(service=pgservice))

    def test_vw_qgep_reach(self):
        # to do
        
        # insert
        # check if geometry X Y Z of start is addapted on reach_point
        # check if geometry X Y Z of end is addapted on reach_point

        # update
        # check if geometry X Y Z of start is addapted on reach_point
        # check if geometry X Y Z of end is addapted on reach_point


    def test_vw_qgep_wastewater_structure_geometry_insert(self):
        # insert
        row = {
                'identifier': '20',
                'ws_type': 'manhole',
                'situation_geometry': '01040000A0080800000100000001010000800000000020D6434100000000804F324100000000004CCD40', # SELECT ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(2600000 1200000 15000)'), 2056)
                'wn_obj_id': '1337_1001',
                'co_obj_id': '1337_2001'
        }

        expected_row = copy.deepcopy(row)
        expected_row['situation_geometry'] = '01040000A0080800000100000001010000800000000020D6434100000000804F324100000000004CCD40' # SELECT ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(2600000 1200000 15000)'), 2056)
        obj_id = self.insert_check('vw_qgep_wastewater_structure', row, expected_row)

        # check if geometry X Y Z is addapted on cover
        row = self.select('cover', '1337_2001')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F324100000000004CCD40' # SELECT ST_GeometryN( ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(2600000 1200000 15000)'), 2056), 1 )
        # check if geometry is addapted on wastewater_node
        row = self.select('wastewater_node', '1337_1001')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F324100000000004CCD40' # SELECT ST_GeometryN( ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(2600000 1200000 15000)'), 2056), 1 )

        # to do
        # update
        '''
        row = {
                'situation_geometry': '01040000A00808000001000000010100008000000000804F32410000000020D643410000000040772B41', # SELECT ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(1200000 2600000 900000)'), 2056)
        }

        self.update_check('vw_qgep_wastewater_structure', row, obj_id)

        # check if geometry X Y but not Z is addapted on cover
        row = self.select('cover', '1337_2001')
        assert row['situation_geometry'] == '"01010000A00808000000000000804F32410000000020D6434100000000004CCD40"' # SELECT ST_GeometryN( ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(1200000 2600000 15000)'), 2056), 1 )
        #  check if geometry X Y but not Z is addapted on wastewater_node
        row = self.select('wastewater_node', '1337_1001')
        assert row['situation_geometry'] == '"01010000A00808000000000000804F32410000000020D6434100000000004CCD40"' # SELECT ST_GeometryN( ST_SetSRID(ST_GeomFromText('MULTIPOINTZ(1200000 2600000 15000)'), 2056), 1 )

        '''

if __name__ == '__main__':
    unittest.main()
