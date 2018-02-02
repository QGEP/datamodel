#!/usr/bin/env python

import imp
import os
import sys

pgiv = imp.load_source('PGInheritanceView', os.path.join(os.path.dirname(__file__), '../metaproject/postgresql/pg_inheritance_view/pg_inheritance_view.py'))


if len(sys.argv) > 1:
	pg_service = sys.argv[1]
else:
	pg_service = 'pg_qgep'


damage = """
alias: damage
table: qgep_od.damage
pkey: obj_id
pkey_value: qgep_sys.generate_oid('qgep_od','damage')
schema: qgep_od

children:
  channel:
    table: qgep_od.damage_channel
    pkey: obj_id
    
  manhole:
    table: qgep_od.damage_manhole
    pkey: obj_id 

merge_view:
  name: vw_qgep_damage
  allow_type_change: false
  allow_parent_only: true
"""


print(pgiv.PGInheritanceView(pg_service, damage).sql_all())
