#!/usr/bin/env python3

import sys, os
sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

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

        qgep_wastewater_structure_extra = self.variable('qgep_wastewater_structure_extra', None)
        qgep_reach_extra = self.variable('qgep_reach_extra', None)

        create_views(srid=self.variable('SRID'),
                     pg_service=self.pg_service,
                     qgep_wastewater_structure_extra=qgep_wastewater_structure_extra,
                     qgep_reach_extra=qgep_reach_extra)