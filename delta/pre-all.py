#!/usr/bin/env python3

from pum.core.deltapy import DeltaPy
import psycopg2


class DropViews(DeltaPy):

    def run(self):
        conn = psycopg2.connect("service={0}".format(self.pg_service))
        cursor = conn.cursor()

        sql = open('view/drop_views.sql').read()
        cursor.execute(sql, self.variables)

        conn.commit()
        conn.close()
