#!/usr/bin/env python3

import psycopg2
from pum.core.deltapy import DeltaPy


class CreateViews(DeltaPy):

    def run(self):
        conn = psycopg2.connect("service={0}".format(self.pg_service))
        cursor = conn.cursor()
        sql = open('view/drop_views.sql').read()
        cursor.execute(sql)
        conn.commit()
        conn.close()