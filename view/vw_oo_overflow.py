#!/usr/bin/env python

import imp
import os
import sys

pgiv = imp.load_source('PGInheritanceView', os.path.join(os.path.dirname(__file__), '../metaproject/postgresql/pg_inheritance_view/pg_inheritance_view.py'))


if len(sys.argv) > 1:
	pg_service = sys.argv[1]
else:
	pg_service = 'pg_qgep'
	
overflow="""
table: qgep.od_overflow
alias: overflow
pkey: obj_id
pkey_value: qgep.generate_oid('od_reach_point')
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
    geometry: ST_MakeLine(n1.situation_geometry, n2.situation_geometry)::geometry('LineString',21781)
  
  additional_join: LEFT JOIN qgep.od_wastewater_node n1 ON overflow.fk_wastewater_node = n1.obj_id LEFT JOIN qgep.od_wastewater_node n2 ON overflow.fk_overflow_to = n2.obj_id
"""


print pgiv.PGInheritanceView(pg_service, overflow).sql_all()
