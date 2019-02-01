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
        pass


    def test_vw_qgep_wastewater_structure_geometry_insert(self):
        return
        
        # insert
        row = {
                'identifier': '20',
                'ws_type': 'manhole',
                'situation_geometry': '01040000A0080800000100000001010000800000000020D6434100000000804F324100000000004CCD40', # SELECT ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 15000)), 2056)
                'wn_obj_id': '1337_1001',
                'co_obj_id': '1337_2001'
        }

        expected_row = copy.deepcopy(row)
        expected_row['situation_geometry'] = '01040000A0080800000100000001010000800000000020D6434100000000804F3241000000000000F87F' # SELECT ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056)
        obj_id = self.insert_check('vw_qgep_wastewater_structure', row, expected_row)

        # check if geometry X Y Z is addapted on cover
        row = self.select('cover', '1337_2001')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F3241000000000000F87F' # SELECT ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), 1 )
        # check if geometry is addapted on wastewater_node
        row = self.select('wastewater_node', '1337_1001')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F3241000000000000F87F' # SELECT ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), 1 )
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

'''
-- Tests INSERT wastewater_node:
-- INSERT INTO qgep_od.wastewater_node (obj_id, bottom_level, situation_geometry) VALUES ('00000000RE017248', 200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056) );
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = '00000000RE017248';
-- INSERT INTO qgep_od.wastewater_node (obj_id, bottom_level, situation_geometry) VALUES ('00000000RE017248', 200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = '00000000RE017248';
-- INSERT INTO qgep_od.wastewater_node (obj_id, bottom_level, situation_geometry) VALUES ('00000000RE017248', NULL, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = '00000000RE017248';
-- INSERT INTO qgep_od.wastewater_node (obj_id, situation_geometry) VALUES ('00000000RE017248', ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = '00000000RE017248';
-- Tests UPDATE wastewater_node:
-- UPDATE qgep_od.wastewater_node SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) WHERE obj_id = 'AAA HA27010';
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = 'AAA HA27010';
-- UPDATE qgep_od.wastewater_node SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056), bottom_level=555 WHERE obj_id = 'AAA HA27010';
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = 'AAA HA27010';
-- UPDATE qgep_od.wastewater_node SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056), bottom_level=NULL WHERE obj_id = 'AAA HA27010';
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = 'AAA HA27010';
-- UPDATE qgep_od.wastewater_node SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056), bottom_level=666 WHERE obj_id = 'AAA HA27010';
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = 'AAA HA27010';
-- UPDATE qgep_od.wastewater_node SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056), bottom_level=666 WHERE obj_id = 'AAA HA27010';
-- SELECT obj_id, bottom_level, ST_AsText(situation_geometry) FROM qgep_od.wastewater_node WHERE obj_id = 'AAA HA27010';

-- Tests INSERT cover:
-- INSERT INTO qgep_od.cover (obj_id, level, situation_geometry) VALUES ('AAA DE56073', 200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056) );
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'AAA DE56073';
-- INSERT INTO qgep_od.cover (obj_id, level, situation_geometry) VALUES ('AAA RE35760', 200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'AAA RE35760';
-- INSERT INTO qgep_od.cover (obj_id, level, situation_geometry) VALUES ('ch13p7mzAA000002', NULL, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'ch13p7mzAA000002';
-- INSERT INTO qgep_od.cover (obj_id, situation_geometry) VALUES ('ch13p7mzAA000003', ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'ch13p7mzAA000003';
-- Tests UPDATE cover:
-- UPDATE qgep_od.cover SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) WHERE obj_id = 'AAA DE56073';
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'AAA DE56073';
-- UPDATE qgep_od.cover SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056), level=444 WHERE obj_id = 'AAA DE56073';
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'AAA DE56073';
-- UPDATE qgep_od.cover SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056), level=NULL WHERE obj_id = 'AAA DE56073';
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'AAA DE56073';
-- UPDATE qgep_od.cover SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056), level=666 WHERE obj_id = 'AAA DE56073';
-- SELECT obj_id, level, ST_AsText(situation_geometry) FROM qgep_od.cover WHERE obj_id = 'AAA DE56073';
-- UPDATE qgep_od.cover SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056), level=666 WHERE obj_id = 'AAA DE56073';
-- SELECT level FROM qgep_od.cover WHERE obj_id = 'AAA DE56073';

-- Tests INSERT vw_qgep_reach:
-- INSERT INTO qgep_od.vw_qgep_reach (obj_id, progression_geometry, rp_from_obj_id, rp_to_obj_id) VALUES ('AAA DEXXXXX04', ST_SetSRID(ST_GeomFromText('COMPOUNDCURVE Z ((1 2 3,4 5 6,8 9 10))'), 2056), 'BBB DEXXXXX04', 'CCC DEXXXXX04' );
-- SELECT obj_id, rp_from_level, rp_to_level, ST_AsText(progression_geometry), rp_from_obj_id, rp_to_obj_id FROM qgep_od.vw_qgep_reach  WHERE obj_id = 'AAA DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'BBB DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'CCC DEXXXXX04'
-- INSERT INTO qgep_od.vw_qgep_reach (obj_id, progression_geometry, rp_from_level, rp_to_level, rp_from_obj_id, rp_to_obj_id) VALUES ('AAA DEXXXXX05', ST_SetSRID(ST_GeomFromText('COMPOUNDCURVE Z ((1 2 3,4 5 6,8 9 10))'), 2056), NULL, 66, 'BBB DEXXXXX05', 'CCC DEXXXXX05' );
-- SELECT obj_id, rp_from_level, rp_to_level, ST_AsText(progression_geometry), rp_from_obj_id, rp_to_obj_id FROM qgep_od.vw_qgep_reach  WHERE obj_id = 'AAA DEXXXXX05'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'BBB DEXXXXX05'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'CCC DEXXXXX05'
-- INSERT INTO qgep_od.vw_qgep_reach (obj_id, progression_geometry, rp_from_level, rp_to_level, rp_from_obj_id, rp_to_obj_id) VALUES ('AAA DEXXXXX06', ST_SetSRID(ST_GeomFromText('COMPOUNDCURVE Z ((1 2 3,4 5 6,8 9 10))'), 2056), 77, NULL, 'BBB DEXXXXX06', 'CCC DEXXXXX06' );
-- SELECT obj_id, rp_from_level, rp_to_level, ST_AsText(progression_geometry), rp_from_obj_id, rp_to_obj_id FROM qgep_od.vw_qgep_reach  WHERE obj_id = 'AAA DEXXXXX06'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'BBB DEXXXXX06'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'CCC DEXXXXX06'
-- Tests UPDATE vw_qgep_reach:
-- UPDATE qgep_od.vw_qgep_reach SET progression_geometry=ST_SetSRID(ST_GeomFromText('COMPOUNDCURVE Z ((1 2 3,4 5 6,8 9 10))'), 2056) WHERE obj_id='AAA DEXXXXX04'
-- SELECT obj_id, rp_from_level, rp_to_level, ST_AsText(progression_geometry), rp_from_obj_id, rp_to_obj_id FROM qgep_od.vw_qgep_reach  WHERE obj_id = 'AAA DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'BBB DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'CCC DEXXXXX04'
-- UPDATE qgep_od.vw_qgep_reach SET progression_geometry=ST_SetSRID(ST_GeomFromText('COMPOUNDCURVE Z ((1 2 33,4 5 6,8 9 11))'), 2056), rp_from_level=NULL WHERE obj_id='AAA DEXXXXX04'
-- SELECT obj_id, rp_from_level, rp_to_level, ST_AsText(progression_geometry), rp_from_obj_id, rp_to_obj_id FROM qgep_od.vw_qgep_reach  WHERE obj_id = 'AAA DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'BBB DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'CCC DEXXXXX04'
-- UPDATE qgep_od.vw_qgep_reach SET progression_geometry=ST_SetSRID(ST_GeomFromText('COMPOUNDCURVE Z ((1 2 44,4 5 6,8 9 33))'), 2056), rp_from_level=77, rp_to_level=88 WHERE obj_id='AAA DEXXXXX04'
-- SELECT obj_id, rp_from_level, rp_to_level, ST_AsText(progression_geometry), rp_from_obj_id, rp_to_obj_id FROM qgep_od.vw_qgep_reach  WHERE obj_id = 'AAA DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'BBB DEXXXXX04'
-- SELECT level, ST_AsText(situation_geometry) FROM qgep_od.reach_point WHERE obj_id = 'CCC DEXXXXX04'
'''