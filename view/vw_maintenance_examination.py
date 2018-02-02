#!/usr/bin/env python

import imp
import os
import sys

pgiv = imp.load_source('PGInheritanceView', os.path.join(os.path.dirname(__file__), '../metaproject/postgresql/pg_inheritance_view/pg_inheritance_view.py'))


if len(sys.argv) > 1:
	pg_service = sys.argv[1]
else:
	pg_service = 'pg_qgep'


maintenance = """
alias: maintenance
table: qgep_od.maintenance_event
pkey: obj_id
pkey_value: qgep_sys.generate_oid('qgep_od','maintenance_event')
schema: qgep_od

children:
  examination:
    table: qgep_od.examination
    pkey: obj_id


merge_view:
  name: vw_qgep_maintenance
  allow_type_change: false
  allow_parent_only: true
"""


print(pgiv.PGInheritanceView(pg_service, maintenance).sql_all())
