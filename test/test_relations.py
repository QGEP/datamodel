# Stefan Burckhardt

import unittest

import psycopg2
import psycopg2.extras
import decimal
from time import sleep

from utils import DbTestBase

class TestRelations(unittest.TestCase, DbTestBase):

    @classmethod
    def tearDownClass(cls):
        cls.conn.rollback()

    @classmethod
    def setUpClass(cls):
        cls.conn = psycopg2.connect("service=pg_qgep")


    def test_relations(self):
        # create cover element
        row = {
                'identifier': 'CO123',
                'level': decimal.Decimal('50.000')
        }

        obj_id = self.insert_check('vw_cover', row)
        
        row = {
                'identifier': 'CO456',
                'level': decimal.Decimal('60.656')
        }

        # create 2nd cover element
        obj_id2 = self.insert_check('vw_cover', row)

        # delete od_structure_part with obj_id
        row = self.select('od_structure_part', obj_id)

        cur = self.cursor()

        cur.execute("DELETE (*) FROM qgep.od_structure_part WHERE obj_id='{obj_id}'".format(obj_id=obj_id))
        
        # count amount of structure part elements and cover elements - should be one each
        amount_structure_part = cur.execute("SELECT COUNT(*) FROM qgep.od_structure_part WHERE obj_id IN ('CO123', 'CO456')")
        amount_cover = cur.execute("SELECT COUNT(*) FROM qgep.od_cover WHERE obj_id IN ('CO123', 'CO456')")
        
        
        assert amount_structure_part != amount_cover, "Relation test for structure_part - cover failed"


if __name__ == '__main__':
    unittest.main()