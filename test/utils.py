import unittest

import psycopg2
import psycopg2.extras

class DbTestBase:

    def select(self, table, obj_id):
        cur = self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

        cur.execute("SELECT * FROM qgep_od.{table} WHERE obj_id='{obj_id}'".format(table=table, obj_id=obj_id))
        return cur.fetchone()

    def cursor(self):
        return self.conn.cursor(cursor_factory=psycopg2.extras.DictCursor)

    def insert(self, table, row):
        cur = self.conn.cursor()

        cols = list(row.keys())
        cols_str = ','.join(cols)
        vals = [str(row[x]) for x in cols]
        vals_str_list = ["%s"] * len(vals)
        vals_str = ','.join(vals_str_list)

        cur.execute(
            "INSERT INTO qgep_od.{table} ({cols}) VALUES ({vals_str}) RETURNING obj_id".format(table = table, cols=cols_str, vals_str=vals_str),
            list(row.values())
        )

        return cur.fetchone()[0]

    def update(self, table, row, obj_id):
        cur = self.conn.cursor()

        cols = ['{}=%s'.format(key) for key, _ in row.items()]
        cols_str = ','.join(cols)

        cur.execute(
            "UPDATE qgep_od.{table} SET {cols_str} WHERE obj_id=%s".format(table = table, cols_str=cols_str),
            list(row.values()) + [obj_id]
        )

    def delete(self, table, obj_id):
        cur = self.conn.cursor()

        cur.execute(
            "DELETE FROM qgep_od.{table} WHERE obj_id=%s".format(table = table), [obj_id]
        )

    def insert_check(self, table, row, expected_row=None):
        obj_id = self.insert(table, row)
        result = self.select(table, obj_id)

        assert result, obj_id

        if expected_row:
            row = expected_row

        self.check_result(row, result, table, 'insert')

        return obj_id

    def update_check(self, table, row, obj_id):
        self.update(table, row, obj_id)
        result = self.select(table, obj_id)

        self.check_result(row, result, table, 'update')


    def check_result(self, expected, result, table, test_name):
        # TODO: don't convert to unicode, type inference for smallint is
        # currently broken, that's the reason at the moment.
        self.assertTrue(result, "No result set received.")

        for key, value in expected.items():
          self.assertEqual(str(result[key]), str(value), """
             ========================================================

             Data: {expected}

             ========================================================

             Failed {test_name} test on
             Table: "{table}"
             Field: "{key}"
               expected: {expected_value} ({expected_type})
               result: {result_value} ({result_type})

             ========================================================
            """.format(
                  expected = repr(expected),
                  test_name = test_name,
                  table = table,
                  key = key,
                  expected_value = value,
                  result_value = result[key],
                  expected_type = type(value),
                  result_type = type(result[key])
              ))
