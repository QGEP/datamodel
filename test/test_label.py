import unittest
import os

import psycopg2
import psycopg2.extras
import decimal

from .utils import DbTestBase

class TestViews(unittest.TestCase, DbTestBase):

    @classmethod
    def tearDownClass(cls):
        cls.conn.rollback()

    @classmethod
    def setUpClass(cls):
        pgservice = os.environ.get('PGSERVICE') or 'pg_qgep'
        cls.conn = psycopg2.connect("service={service}".format(service=pgservice))

    def connect_reach(self, reach_id, from_id=None, to_id=None):
        """
        Helper function to connect reach from/to wastewater network elements
        """
        data = {}
        if from_id is not None:
            data['rp_from_fk_wastewater_networkelement'] = from_id
        if to_id is not None:
            data['rp_to_fk_wastewater_networkelement'] = to_id
        self.update('vw_qgep_reach', data, reach_id)

    def test_label(self):
        manholes = {
            'main': {'obj_id': None, 'wn_obj_id': None, 'coords': [2600000, 1200000]},
            'N': {'obj_id': None, 'wn_obj_id': None, 'coords': [2600000, 1200001]},
            'NE': {'obj_id': None, 'wn_obj_id': None, 'coords': [2600001, 1200001]},
            'E': {'obj_id': None, 'wn_obj_id': None, 'coords': [2600001, 1200000]},
            'SE': {'obj_id': None, 'wn_obj_id': None, 'coords': [2600001, 1199999]},
            'S': {'obj_id': None, 'wn_obj_id': None, 'coords': [2600000, 1199999]},
            'SW': {'obj_id': None, 'wn_obj_id': None, 'coords': [2599999, 1199999]},
            'W': {'obj_id': None, 'wn_obj_id': None, 'coords': [2599999, 1200000]},
            'NW': {'obj_id': None, 'wn_obj_id': None, 'coords': [2599999, 1200001]},
        }
        for manhole in manholes:
            coords = manholes[manhole]['coords']
            row = {
                'identifier': manhole,
                'ws_type': 'manhole',
                'situation_geometry': self.execute(
                    "ST_SetSRID(ST_GeomFromText('POINT({x} {y})'), 2056)".format(x=coords[0], y=coords[1])),
            }
            manholes[manhole]['obj_id'] = self.insert('vw_qgep_wastewater_structure', row)
            manholes[manhole]['wn_obj_id'] = self.select('vw_qgep_wastewater_structure', manholes[manhole]['obj_id'])['wn_obj_id']

        reaches = {
            'input': [
                {'id': 'NE', 'rp_to_level': 1011},
                {'id': 'SE', 'rp_to_level': 1012},
                {'id': 'SW', 'rp_to_level': 1013},
                {'id': 'NW', 'rp_to_level': 1014}
            ],
            'output': [
                {'id': 'N', 'rp_from_level': 1001},
                {'id': 'E', 'rp_from_level': 1002},
                {'id': 'S', 'rp_from_level': 1003},
                {'id': 'N', 'rp_from_level': 1004}
            ]
        }
        for way, reach_points in reaches.items():
            for reach_point in reach_points:
                if way == 'input':
                    start_point = manholes[reach_point['id']]
                    end_point = manholes['main']
                else:
                    start_point = manholes['main']
                    end_point = manholes[reach_point['id']]
                row = {
                    'clear_height': 100,
                    'coefficient_of_friction': 10,
                    'ws_identifier': reach_point['id'],
                    'ch_function_hierarchic': 5062,
                    'rp_from_level': decimal.Decimal(reach_point.get('rp_from_level', 1020.0)),
                    'rp_to_level': decimal.Decimal(reach_point.get('rp_to_level', 1000.0)),
                    'ch_usage_current': 4514,
                    'progression_geometry': self.execute(
                        "ST_ForceCurve(ST_SetSrid(ST_MakeLine(ST_MakePoint({sx}, {sy}, 'NaN'), ST_MakePoint({ex}, {ey}, 'NaN')), 2056))".format(
                            sx=start_point['coords'][0],
                            sy=start_point['coords'][1],
                            ex=end_point['coords'][0],
                            ey=end_point['coords'][1],
                        )
                    ),
                }
                obj_id = self.insert('vw_qgep_reach', row)
                self.connect_reach(obj_id, from_id=start_point['wn_obj_id'], to_id=end_point['wn_obj_id'])

        self.assertEqual(self.select('vw_qgep_wastewater_structure', manholes['main']['obj_id'])['_input_label'], '\nI1=1011.00\nI2=1012.00\nI3=1013.00\nI4=1014.00')
        self.assertEqual(self.select('vw_qgep_wastewater_structure', manholes['main']['obj_id'])['_output_label'], '\nO1=1004.00\nO2=1001.00\nO3=1002.00\nO4=1003.00')


if __name__ == '__main__':
    unittest.main()
