#!/usr/bin/env python3

# https://stackoverflow.com/a/6098238/1548052
# import os, sys, inspect
# folder = os.path.realpath(os.path.abspath(os.path.split(inspect.getfile(inspect.currentframe()))[0]))
# if folder not in sys.path:
#     sys.path.insert(0, folder)
# subfolder = os.path.realpath(os.path.abspath(os.path.join(os.path.split(inspect.getfile(inspect.currentframe()))[0], "..")))
# if subfolder not in sys.path:
#     sys.path.insert(0, subfolder)

import psycopg2
from pum.core.deltapy import DeltaPy
from view.create_views import create_views


class CreateViews(DeltaPy):

    def run(self):
        conn = psycopg2.connect("service={0}".format(self.pg_service))
        cursor = conn.cursor()
        sql = open('view/drop_views.sql').read()
        cursor.execute(sql, self.variables)
        conn.commit()
        conn.close()

        create_views(srid=self.variable('SRID'), pg_service=self.pg_service)