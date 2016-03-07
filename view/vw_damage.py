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
table: qgep.od_damage
pkey: obj_id
pkey_value: qgep.generate_oid('od_damage')
schema: qgep

children:
  channel:
    table: qgep.od_damage_channel
    pkey: obj_id
  manhole:
    table: qgep.od_damage_manhole
    pkey: obj_id

merge_view:
  name: vw_qgep_damage
  allow_type_change: false
  allow_parent_only: true
  merge_columns:
    connection:
      channel: connection
      manhole: connection
    damage_reach:
      channel: damage_reach
      manhole: damage_reach
    damage_begin:
      channel: damage_begin
      manhole: damage_begin
    damage_end:
      channel: damage_end
      manhole: damage_end
    distance:
      channel: distance
      manhole: distance
    quantification1:
      channel: quantification1
      manhole: quantification1
    quantification2:
      channel: quantification2
      manhole: quantification2
    video_counter:
      channel: video_counter
      manhole: video_counter
    view_parameters:
      channel: view_parameters
      manhole: view_parameters
"""


print pgiv.PGInheritanceView(pg_service, damage).sql_all()
