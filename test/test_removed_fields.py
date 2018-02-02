import unittest

import psycopg2
import psycopg2.extras
import decimal
from time import sleep

from utils import DbTestBase

class TestRemovedFields(unittest.TestCase, DbTestBase):

    @classmethod
    def tearDownClass(cls):
        cls.conn.rollback()

    @classmethod
    def setUpClass(cls):
        cls.conn = psycopg2.connect("service=pg_qgep")


    def test_dataowner(self):
        cur = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

        cur.execute("SELECT * FROM qgep_od.wastewater_structure LIMIT 1")
        colnames = [desc[0] for desc in cur.description]

        self.assertNotIn('provider', colnames)
        self.assertNotIn('dataowner', colnames)

if __name__ == '__main__':
    unittest.main()
