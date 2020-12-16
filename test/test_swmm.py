import unittest
import os

import psycopg2
import psycopg2.extras
import decimal
import copy

from .utils import DbTestBase


class TestSwmm(unittest.TestCase, DbTestBase):
    """Test cases to test the SWMM view

    This is supposed to run against the demo data."""

    @classmethod
    def tearDown(cls):
        cls.conn.rollback()

    @classmethod
    def setUp(cls):
        pgservice=os.environ.get('PGSERVICE') or 'pg_qgep'
        cls.conn = psycopg2.connect("service={service}".format(service=pgservice))

    def test_count_vw_aquifers(self):
        self.assert_count("vw_aquifers", "qgep_swmm", 0)

    def test_count_vw_conduits(self):
        self.assert_count("vw_conduits", "qgep_swmm", 5095)

    def test_count_vw_coordinates(self):
        self.assert_count("vw_coordinates", "qgep_swmm", 6686)

    def test_count_vw_coverages(self):
        self.assert_count("vw_coverages", "qgep_swmm", 0)

    def test_count_vw_dividers(self):
        self.assert_count("vw_dividers", "qgep_swmm", 41)

    def test_count_vw_dwf(self):
        self.assert_count("vw_dwf", "qgep_swmm", 1352)

    def test_count_vw_infiltration(self):
        self.assert_count("vw_infiltration", "qgep_swmm", 1352)

    def test_count_vw_junctions(self):
        self.assert_count("vw_junctions", "qgep_swmm", 4575)

    def test_count_vw_landuses(self):
        self.assert_count("vw_landuses", "qgep_swmm", 6)

    def test_count_vw_losses(self):
        self.assert_count("vw_losses", "qgep_swmm", 1053)

    def test_count_vw_outfalls(self):
        self.assert_count("vw_outfalls", "qgep_swmm", 54)

    def test_count_vw_polygons(self):
        self.assert_count("vw_polygons", "qgep_swmm", 16007)

    def test_count_vw_pumps(self):
        self.assert_count("vw_pumps", "qgep_swmm", 0)

    def test_count_vw_raingages(self):
        self.assert_count("vw_raingages", "qgep_swmm", 2035)

    def test_count_vw_storages(self):
        self.assert_count("vw_storages", "qgep_swmm", 23)

    def test_count_vw_subareas(self):
        self.assert_count("vw_subareas", "qgep_swmm", 2035)

    def test_count_vw_subcatchments(self):
        self.assert_count("vw_subcatchments", "qgep_swmm", 2035)

    def test_count_vw_tags(self):
        self.assert_count("vw_tags", "qgep_swmm", 11782)

    def test_count_vw_vertices(self):
        self.assert_count("vw_vertices", "qgep_swmm", 643)

    def test_count_vw_xsections(self):
        self.assert_count("vw_xsections", "qgep_swmm", 5095)

if __name__ == '__main__':
    unittest.main()
