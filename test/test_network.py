import unittest
import os

import psycopg2
import psycopg2.extras
import decimal
import copy

from .utils import DbTestBase


class TestNetwork(unittest.TestCase, DbTestBase):

    def tearDown(self):
        self.conn.rollback()

    def setUp(self):
        pgservice=os.environ.get('PGSERVICE') or 'pg_qgep'
        self.conn = psycopg2.connect("service={service}".format(service=pgservice))

    def make_reach(self, identifier, x1, y1, x2, y2):
        """
        Helper function that makes a reach, returns obj_id
        """
        reach = {
            'identifier': identifier,
            'progression_geometry': self.make_line(x1, y1, 100, x2, y2, 100),
        }
        reach_id = self.insert('vw_qgep_reach', reach)
        return reach_id

    def make_manhole(self, identifier, x, y):
        """
        Helper function that makes a manhole, returns (obj_id, wn_obj_id)
        """
        manhole = {
            'identifier': identifier,
            'situation_geometry': self.make_point_2d(x, y)
        }
        manhole_id = self.insert('vw_qgep_wastewater_structure', manhole)
        manhole_wn_id = self.select('vw_qgep_wastewater_structure', manhole_id)['wn_obj_id']
        return manhole_id, manhole_wn_id

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

    def refresh_graph(self):
        cur = self.cursor()
        cur.execute("REFRESH MATERIALIZED VIEW qgep_od.vw_network_segment")
        cur.execute("REFRESH MATERIALIZED VIEW qgep_od.vw_network_node")

    def test_network_basic(self):
        """
          *
          |
          | second
          |
          v
          *
          ⇓
         MH ⇐ *----------------->*
                     first

        first is connected FROM the manhole, second is connected TO manhole
        """

        manhole_id, manhole_wn_id = self.make_manhole('manhole', 0, 0)
        first_reach_id = self.make_reach('first', 0, 0, 10, 0)
        second_reach_id = self.make_reach('second', 0, 10, 0, 0)

        self.connect_reach(first_reach_id, from_id=manhole_wn_id)
        self.connect_reach(second_reach_id, to_id=manhole_wn_id)

        self.refresh_graph()

        cur = self.cursor()
        cur.execute("SELECT * FROM qgep_od.vw_network_segment")
        segments = cur.fetchall()
        cur.execute("SELECT * FROM qgep_od.vw_network_node")
        nodes = cur.fetchall()

        self.assertEqual( len(segments), 4)
        self.assertEqual( len(nodes), 5)

    def test_network_blind_connection(self):
        """
                    *
                    |
                    | second
                    |
                    v
                    *
                    ⇓
         MH ⇐ *----------------->*
                     first
        first is connected FROM manhole, second is connected TO first directly (blind connection)
        """

        manhole_id, manhole_wn_id = self.make_manhole('manhole', 0, 0)
        first_reach_id = self.make_reach('first', 0, 0, 10, 0)
        second_reach_id = self.make_reach('second', 5, 10, 5, 0)

        self.connect_reach(first_reach_id, from_id=manhole_wn_id)
        self.connect_reach(second_reach_id, to_id=first_reach_id)

        self.refresh_graph()

        cur = self.cursor()
        cur.execute("SELECT * FROM qgep_od.vw_network_segment")
        segments = cur.fetchall()
        cur.execute("SELECT * FROM qgep_od.vw_network_node")
        nodes = cur.fetchall()

        self.assertEqual( len(segments), 4)
        self.assertEqual( len(nodes), 5)

    @unittest.expectedFailure
    def test_network_blind_connection_overlaid(self):
        """
          *
          |
          | second
          |
          v
          *    ⤵
         MH ⇐ *----------------->*
                     first
        first is connected FROM manhole, second is connected TO first directly (blind connection)
        but at the same position than the node
        """

        manhole_id, manhole_wn_id = self.make_manhole('manhole', 0, 0)
        first_reach_id = self.make_reach('first', 0, 0, 10, 0)
        second_reach_id = self.make_reach('second', 0, 10, 0, 0)

        self.connect_reach(first_reach_id, from_id=manhole_wn_id)
        self.connect_reach(second_reach_id, to_id=first_reach_id)

        self.refresh_graph()

        cur = self.cursor()
        cur.execute("SELECT * FROM qgep_od.vw_network_segment")
        segments = cur.fetchall()
        cur.execute("SELECT * FROM qgep_od.vw_network_node")
        nodes = cur.fetchall()

        self.assertEqual( len(segments), 4)
        self.assertEqual( len(nodes), 5)

    def test_network_two_blind_connection(self):
        """
                     *     *
                     |     |
              second |     | third
                     |     |
                     v     v
                     *     *
                     ⇓     ⇓
         MH ⇐ *----------------->*
                     first
        first is connected FROM manhole, second and third are connected TO first directly (blind connection)
        """

        manhole_id, manhole_wn_id = self.make_manhole('manhole', 0, 0)
        first_reach_id = self.make_reach('first', 0, 0, 10, 0)
        second_reach_id = self.make_reach('second', 3, 10, 3, 0)
        third_reach_id = self.make_reach('third', 6, 10, 6, 0)

        self.connect_reach(first_reach_id, from_id=manhole_wn_id)
        self.connect_reach(second_reach_id, to_id=first_reach_id)
        self.connect_reach(third_reach_id, to_id=first_reach_id)

        self.refresh_graph()

        cur = self.cursor()
        cur.execute("SELECT * FROM qgep_od.vw_network_segment")
        segments = cur.fetchall()
        cur.execute("SELECT * FROM qgep_od.vw_network_node")
        nodes = cur.fetchall()

        self.assertEqual( len(segments), 6)
        self.assertEqual( len(nodes), 7)

    @unittest.expectedFailure
    def test_network_two_opposing_blind_connection(self):
        """
                       *
                       |
                second |
                       |
                       v
                       *
                       ⇓  first
         MH ⇐ *----------------->*
                       ⇑
                       *
                       |
                 third |
                       |
                       *
                     first
        first is connected FROM manhole, second and third are connected TO first directly (blind connection)
        but arrive at the exact same point
        """

        manhole_id, manhole_wn_id = self.make_manhole('manhole', 0, 0)
        first_reach_id = self.make_reach('first', 0, 0, 10, 0)
        second_reach_id = self.make_reach('second', 5, 10, 5, 0)
        third_reach_id = self.make_reach('third', 5, -10, 5, 0)

        self.connect_reach(first_reach_id, from_id=manhole_wn_id)
        self.connect_reach(second_reach_id, to_id=first_reach_id)
        self.connect_reach(third_reach_id, to_id=first_reach_id)

        self.refresh_graph()

        cur = self.cursor()
        cur.execute("SELECT * FROM qgep_od.vw_network_segment")
        segments = cur.fetchall()
        cur.execute("SELECT * FROM qgep_od.vw_network_node")
        nodes = cur.fetchall()

        self.assertEqual( len(segments), 5)
        self.assertEqual( len(nodes), 6)


if __name__ == '__main__':
    unittest.main()
