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
        # 1. insert geometry with Z and no co_level and no wn_bottom_level
        # INSERT INTO qgep_od.vw_qgep_wastewater_structure (situation_geometry, wn_obj_id, co_obj_id) VALUES (ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 15000)), 2056), '1337_1001', '1337_1001');
        row = {
                'situation_geometry': '01040000A0080800000100000001010000800000000020D6434100000000804F324100000000004CCD40', 
                'wn_obj_id': '1337_1001',
                'co_obj_id': '1337_1001'
        }
        expected_row = copy.deepcopy(row)
        # ws_qgep_wastewaterstructure has the geometry but NaN as Z because of no co_level (geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056)
        expected_row['situation_geometry'] = '01040000A0080800000100000001010000800000000020D6434100000000804F3241000000000000F87F' 
        # co_level is NULL
        expected_row['co_level'] = None
        # wn_bottom_level NULL
        expected_row['wn_bottom_level'] = None
        obj_id = self.insert_check('vw_qgep_wastewater_structure', row, expected_row)
        # cover geometry has the geometry but NaN as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), 1 )
        row = self.select('cover', '1337_1001')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        # wastewater_node has the geometry but NaN as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), 1 )
        row = self.select('wastewater_node', '1337_1001')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'

        # 2. insert geometry with Z and no co_level and WITH wn_bottom_level
        # INSERT INTO qgep_od.vw_qgep_wastewater_structure (situation_geometry, wn_obj_id, co_obj_id, wn_bottom_level) VALUES (ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 15000)), 2056), '1337_1002', '1337_1002', 200.000);
        row = {
                'situation_geometry': '01040000A0080800000100000001010000800000000020D6434100000000804F324100000000004CCD40', 
                'wn_obj_id': '1337_1002',
                'co_obj_id': '1337_1002',
                'wn_bottom_level': '200.000'
        }
        expected_row = copy.deepcopy(row)
        # ws_qgep_wastewaterstructure has the geometry but NaN as Z because of no co_level (geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056)
        expected_row['situation_geometry'] = '01040000A0080800000100000001010000800000000020D6434100000000804F3241000000000000F87F' 
        # co_level is NULL
        expected_row['co_level'] = None
        # wn_bottom_level is new wn_bottom_level
        expected_row['wn_bottom_level'] = '200.000'
        obj_id = self.insert_check('vw_qgep_wastewater_structure', row, expected_row)
        # cover geometry has the geometry but NaN as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), 1 )
        row = self.select('cover', '1337_1002')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        # wastewater_node has the geometry and  wn_buttom_level as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 200)), 2056), 1 )
        row = self.select('wastewater_node', '1337_1002')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000006940'

        # 3. insert geometry with Z and WITH co_level and WITH wn_bottom_level
        # INSERT INTO qgep_od.vw_qgep_wastewater_structure (situation_geometry, wn_obj_id, co_obj_id, wn_bottom_level, co_level) VALUES (ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 15000)), 2056), '1337_1003', '1337_1003', 200.000, 500.000);
        row = {
                'situation_geometry': '01040000A0080800000100000001010000800000000020D6434100000000804F324100000000004CCD40', 
                'wn_obj_id': '1337_1003',
                'co_obj_id': '1337_1003',
                'wn_bottom_level': '200.000',
                'co_level': '500.000'
        }
        expected_row = copy.deepcopy(row)
        # ws_qgep_wastewaterstructure has the geometry and co_level as Z (geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 500)), 2056)
        expected_row['situation_geometry'] = '01040000A0080800000100000001010000800000000020D6434100000000804F32410000000000407F40' 
        # co_level is new co_level
        expected_row['co_level'] = '500.000'
        # wn_bottom_level is new wn_bottom_level
        expected_row['wn_bottom_level'] = '200.000'
        obj_id = self.insert_check('vw_qgep_wastewater_structure', row, expected_row)
        # cover geometry has the geometry and co_level as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 500)), 2056), 1 )
        row = self.select('cover', '1337_1003')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000407F40'
        # wastewater_node has the geometry and wn_buttom_level as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 200)), 2056), 1 )
        row = self.select('wastewater_node', '1337_1003')
        assert row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000006940'


    def test_vw_qgep_wastewater_structure_geometry_update(self):
        # first insert
        # insert geometry with no Z and no co_level and no wn_bottom_level
        # INSERT INTO qgep_od.vw_qgep_wastewater_structure (situation_geometry, wn_obj_id, co_obj_id) VALUES (ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), '1337_1010', '1337_1010');
        row = {
                'situation_geometry': '01040000A0080800000100000001010000800000000020D6434100000000804F3241000000000000F87F', 
                'ws_type': 'manhole',
                'wn_obj_id': '1337_1010',
                'co_obj_id': '1337_1010'
        }
        obj_id = self.insert('vw_qgep_wastewater_structure', row)

        # 1. update no change on geometry with Z but WITH wn_bottom_level
        # UPDATE qgep_od.vw_wastewater_node SET wn_bottom_level=200.000 WHERE obj_id = obj_id
        row = {
                'wn_bottom_level': '200.000'
        }
        self.update('vw_qgep_wastewater_structure', row, obj_id)
        new_row = self.select('vw_qgep_wastewater_structure', obj_id)
        # no change on geometry of ws_qgep_wastewaterstructure (because it's geometry of cover that does not change)
        assert new_row['situation_geometry'] == '01040000A0080800000100000001010000800000000020D6434100000000804F3241000000000000F87F'
        # no change on co_level
        assert new_row['co_level'] == None
        # wn_bottom_level is new wn_bottom_level
        assert new_row['wn_bottom_level'] == 200.000
        # no change on cover geometry: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 'NaN')), 2056), 1 )
        new_row = self.select('cover', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        # wastewater_node geometry has Z from new wn_bottom_level: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 200)), 2056), 1 )
        new_row = self.select('wastewater_node', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000006940'

        # 2. update no change on geometry with Z but WITH co_level
        # UPDATE qgep_od.vw_wastewater_node SET level=500.000 WHERE obj_id = obj_id
        row = {
                'co_level': '500.000'
        }
        self.update('vw_qgep_wastewater_structure', row, obj_id)
        new_row = self.select('vw_qgep_wastewater_structure', obj_id)
        # geometry of ws_qgep_wastewaterstructure has co_level as Z (because it's geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 500)), 2056)
        assert new_row['situation_geometry'] == '01040000A0080800000100000001010000800000000020D6434100000000804F32410000000000407F40'
        # co_level is new co_level
        assert new_row['co_level'] == 500.000
        # no change on wn_bottom_level
        assert new_row['wn_bottom_level'] == 200.000
        # cover geometry has Z from new co_level: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 500), 2056), 1 )
        new_row = self.select('cover', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000407F40'
        # no change on wastewater_node geometry: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 200)), 2056), 1 )
        new_row = self.select('wastewater_node', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000006940'

        # 3. update no change on geometry with Z but WITH co_level and WITH wn_bottom_level
        # UPDATE qgep_od.vw_wastewater_node SET co_level=600.000, wn_bottom_level=300.000 WHERE obj_id = obj_id
        row = {
                'co_level': '600.000',
                'wn_bottom_level': '300.000'
        }
        self.update('vw_qgep_wastewater_structure', row, obj_id)
        new_row = self.select('vw_qgep_wastewater_structure', obj_id)
        # geometry of ws_qgep_wastewaterstructure has co_level as Z (because it's geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 600)), 2056)
        assert new_row['situation_geometry'] == '01040000A0080800000100000001010000800000000020D6434100000000804F32410000000000C08240'
        # co_level is new co_level
        assert new_row['co_level'] == 600.000
        # wn_bottom_level is new wn_bottom_level
        assert new_row['wn_bottom_level'] == 300.000
        # cover geometry has Z from new co_level: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 600), 2056), 1 )
        new_row = self.select('cover', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000C08240'
        # no change on wastewater_node geometry: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(2600000, 1200000, 300)), 2056), 1 )
        new_row = self.select('wastewater_node', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000C07240'

        # 4. update change geometry with Z but WITH co_level and WITH wn_bottom_level
        # UPDATE qgep_od.vw_wastewater_node SET situation_geometry=ST_SetSRID(ST_Collect(ST_MakePoint(400, 800, 1100)), 2056), co_level=20.000, wn_bottom_level=30.000 WHERE obj_id = obj_id
        row = {
                'situation_geometry': '01040000A008080000010000000101000080000000000000794000000000000089400000000000309140',
                'co_level': '20.000',
                'wn_bottom_level': '30.000'
        }
        self.update('vw_qgep_wastewater_structure', row, obj_id)
        new_row = self.select('vw_qgep_wastewater_structure', obj_id)
        # geometry of ws_qgep_wastewaterstructure has XY from new geometry and has co_level as Z (because it's geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(400, 800, 20)), 2056)
        assert new_row['situation_geometry'] == '01040000A008080000010000000101000080000000000000794000000000000089400000000000003440'
        # co_level is new co_level
        assert new_row['co_level'] == 20.000
        # wn_bottom_level is new wn_bottom_level
        assert new_row['wn_bottom_level'] == 30.000
        # cover geometry has XY from new geometry and has Z from new co_level: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(400, 800, 20)), 2056), 1 )
        new_row = self.select('cover', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A008080000000000000000794000000000000089400000000000003440'
        # wastewater_node geometry has XY from new geometry and has Z from new wn_bottom_level: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(400, 800, 30)), 2056), 1 )
        new_row = self.select('wastewater_node', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A008080000000000000000794000000000000089400000000000003E40'


        # 5. update change geometry with Z and no change on co_level and no change on wn_bottom_level (never happens, but just in case)
        # UPDATE qgep_od.vw_wastewater_node SET situation_geometry=ST_SetSRID(ST_Collect(ST_MakePoint(500, 900, 100)), 2056) WHERE obj_id = obj_id
        row = {
                'situation_geometry': '01040000A0080800000100000001010000800000000000407F400000000000208C400000000000005940'
        }
        self.update('vw_qgep_wastewater_structure', row, obj_id)
        new_row = self.select('vw_qgep_wastewater_structure', obj_id)
        # geometry of ws_qgep_wastewaterstructure has XY from new geometry but old co_level as Z (because it's geometry of cover): ST_SetSRID(ST_Collect(ST_MakePoint(500, 900, 20)), 2056)
        assert new_row['situation_geometry'] == '01040000A0080800000100000001010000800000000000407F400000000000208C400000000000003440'
        # co_level is not overwritten with Z value
        assert new_row['co_level'] == 20.000
        # wn_bottom_level is not overwritten with Z value
        assert new_row['wn_bottom_level'] == 30.000
        # cover geometry has XY from new geometry but old co_level as Z : ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(500, 900, 20)), 2056), 1 )
        new_row = self.select('cover', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000000407F400000000000208C400000000000003440'
        # wastewater_node geometry has XY from new geometry but old new wn_bottom_level as Z: ST_GeometryN( ST_SetSRID(ST_Collect(ST_MakePoint(500, 900, 30)), 2056), 1 )
        new_row = self.select('wastewater_node', '1337_1010')
        assert new_row['situation_geometry'] == '01010000A0080800000000000000407F400000000000208C400000000000003E40'


    def test_wastewater_node_geometry_sync_on_insert(self):
        # 1. bottom level 200 and no Z
        # INSERT INTO qgep_od.vw_wastewater_node (bottom_level, situation_geometry) VALUES (200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056) );
        row = {
                'bottom_level': '200.000',
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F3241000000000000F87F',
        }
        expected_row = copy.deepcopy(row)
        # bottom_level 200 overwrites Z (NaN) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 200), 2056)
        expected_row['bottom_level'] = '200.000'
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F32410000000000006940'
        obj_id = self.insert_check('vw_wastewater_node', row, expected_row)

        # 2. bottom level 200 and 555 Z
        # INSERT INTO qgep_od.vw_wastewater_node (bottom_level, situation_geometry) VALUES (200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
        row = {
                'bottom_level': '200.000',
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        expected_row = copy.deepcopy(row)
        # bottom_level 200 overwrites Z (555) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 200), 2056)
        expected_row['bottom_level'] = '200.000'
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F32410000000000006940'
        obj_id = self.insert_check('vw_wastewater_node', row, expected_row)

        # 3. bottom level NULL and 555 Z
        # INSERT INTO qgep_od.vw_wastewater_node (bottom_level, situation_geometry) VALUES (NULL, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
        row = {
                'bottom_level': None,
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        expected_row = copy.deepcopy(row)
        # bottom_level NULL overwrites Z (555) (to NaN) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056)
        expected_row['bottom_level'] = None
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        obj_id = self.insert_check('vw_wastewater_node', row, expected_row)

        # 4. no bottom level and 555 Z
        # INSERT INTO qgep_od.vw_wastewater_node (situation_geometry) VALUES (ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
        row = {
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        expected_row = copy.deepcopy(row)
        # no bottom_level overwrites Z (555) (to NaN) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056)
        expected_row['bottom_level'] = None
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        obj_id = self.insert_check('vw_wastewater_node', row, expected_row)


    def test_wastewater_node_geometry_sync_on_update(self):

        # first insert
        # no bottom level and no Z
        # INSERT INTO qgep_od.vw_wastewater_node (bottom_level, situation_geometry) VALUES (200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056) );
        row = {
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F3241000000000000F87F',
        }
        obj_id = self.insert('vw_wastewater_node', row)

        # 1. change Z to 555 (don't change bottom_level)
        # UPDATE qgep_od.vw_wastewater_node SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) WHERE obj_id = obj_id;
        row = {
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        self.update('vw_wastewater_node', row, obj_id)
        # Z (555) overwrites bottom_level results in: 555.000
        new_row = self.select('vw_wastewater_node', obj_id)
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000588140'
        assert new_row['bottom_level'] == 555.000

        # 2. change bottom_level to 200 (don't change Z)
        # UPDATE qgep_od.vw_wastewater_node SET bottom_level=200 WHERE obj_id = obj_id;
        row = {
                'bottom_level': '200.000'
        }
        self.update('vw_wastewater_node', row, obj_id)
        # bottom_level 200 overwrites Z results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 200), 2056)
        new_row = self.select('vw_wastewater_node', obj_id)
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000006940'
        assert new_row['bottom_level'] == 200.000

        # 3. change bottom_level to 555 and Z to 666
        # UPDATE qgep_od.vw_wastewater_node SET bottom_level=200 WHERE obj_id = obj_id;
        row = {
                'bottom_level': '555.000',
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000D08440',
        }
        self.update('vw_wastewater_node', row, obj_id)
        # bottom_level 555 overwrites Z (666) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056)
        new_row = self.select('vw_wastewater_node', obj_id)
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000588140'
        assert new_row['bottom_level'] == 555.000


    def test_cover_geometry_sync_on_insert(self):
        # 1. level 200 and no Z
        # INSERT INTO qgep_od.vw_cover (level, situation_geometry) VALUES (200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056) );
        row = {
                'level': '200.000',
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F3241000000000000F87F',
        }
        expected_row = copy.deepcopy(row)
        # level 200 overwrites Z (NaN) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 200), 2056)
        expected_row['level'] = '200.000'
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F32410000000000006940'
        obj_id = self.insert_check('vw_cover', row, expected_row)

        # 2. level 200 and 555 Z
        # INSERT INTO qgep_od.vw_cover (level, situation_geometry) VALUES (200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
        row = {
                'level': '200.000',
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        expected_row = copy.deepcopy(row)
        # level 200 overwrites Z (555) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 200), 2056)
        expected_row['level'] = '200.000'
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F32410000000000006940'
        obj_id = self.insert_check('vw_cover', row, expected_row)

        # 3. level NULL and 555 Z
        # INSERT INTO qgep_od.vw_cover (level, situation_geometry) VALUES (NULL, ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
        row = {
                'level': None,
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        expected_row = copy.deepcopy(row)
        # level NULL overwrites Z (555) (to NaN) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056)
        expected_row['level'] = None
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        obj_id = self.insert_check('vw_cover', row, expected_row)

        # 4. no level and 555 Z
        # INSERT INTO qgep_od.vw_cover (situation_geometry) VALUES (ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) );
        row = {
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        expected_row = copy.deepcopy(row)
        # no level overwrites Z (555) (to NaN) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056)
        expected_row['level'] = None
        expected_row['situation_geometry'] = '01010000A0080800000000000020D6434100000000804F3241000000000000F87F'
        obj_id = self.insert_check('vw_cover', row, expected_row)


    def test_cover_node_geometry_sync_on_update(self):

        # first insert
        # no level and no Z
        # INSERT INTO qgep_od.vw_cover (level, situation_geometry) VALUES (200, ST_SetSRID(ST_MakePoint(2600000, 1200000, 'NaN'), 2056) );
        row = {
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F3241000000000000F87F',
        }
        obj_id = self.insert('vw_cover', row)

        # 1. change Z to 555 (don't change level)
        # UPDATE qgep_od.vw_cover SET situation_geometry=ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056) WHERE obj_id = obj_id;
        row = {
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000588140',
        }
        self.update('vw_cover', row, obj_id)
        # Z (555) overwrites level results in: 555.000
        new_row = self.select('vw_cover', obj_id)
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000588140'
        assert new_row['level'] == 555.000

        # 2. change level to 200 (don't change Z)
        # UPDATE qgep_od.vw_cover SET level=200 WHERE obj_id = obj_id;
        row = {
                'level': '200.000'
        }
        self.update('vw_cover', row, obj_id)
        # level 200 overwrites Z results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 200), 2056)
        new_row = self.select('vw_cover', obj_id)
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000006940'
        assert new_row['level'] == 200.000

        # 3. change level to 555 and Z to 666
        # UPDATE qgep_od.cover_node SET level=200 WHERE obj_id = obj_id;
        row = {
                'level': '555.000',
                'situation_geometry': '01010000A0080800000000000020D6434100000000804F32410000000000D08440',
        }
        self.update('vw_cover', row, obj_id)
        # level 555 overwrites Z (666) results in: ST_SetSRID(ST_MakePoint(2600000, 1200000, 555), 2056)
        new_row = self.select('vw_cover', obj_id)
        assert new_row['situation_geometry'] == '01010000A0080800000000000020D6434100000000804F32410000000000588140'
        assert new_row['level'] == 555.000



if __name__ == '__main__':
    unittest.main()
