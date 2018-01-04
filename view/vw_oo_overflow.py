#!/usr/bin/env python

import imp
import os
import sys

pgiv = imp.load_source('PGInheritanceView', os.path.join(os.path.dirname(__file__), '../metaproject/postgresql/pg_inheritance_view/pg_inheritance_view.py'))


if len(sys.argv) > 1:
	pg_service = sys.argv[1]
else:
	pg_service = 'pg_qgep'
	
if len(sys.argv) > 2:
	srid = sys.argv[2]
else:
	srid = 2056

overflow="""
table: qgep.od_overflow
alias: overflow
pkey: obj_id
pkey_value: qgep.generate_oid('od_overflow')
schema: qgep

children:
  leapingweir:
    table: qgep.od_leapingweir
    pkey: obj_id

  prank_weir:
    table: qgep.od_prank_weir
    pkey: obj_id

  pump:
    table: qgep.od_pump
    pkey: obj_id


merge_view:
  name: vw_qgep_overflow
  additional_columns:
    geometry: ST_MakeLine(n1.situation_geometry, n2.situation_geometry)::geometry('LineString',{0})
  additional_joins:
    n1:
      table: qgep.od_wastewater_node
      type: left
      key: obj_id
      fkey: fk_wastewater_node
    n2:
      table: qgep.od_wastewater_node
      type: left
      key: obj_id
      fkey: fk_overflow_to 
""".format(srid)


print((pgiv.PGInheritanceView(pg_service, overflow).sql_all()))
