#!/usr/bin/env python

import yaml
import sys
from sql_export_view import SqlExportView

if len(sys.argv) > 1:
    pg_service = sys.argv[1]
else:
    pg_service = "pg_qgep"

definition = yaml.load("""

name: qgep_export.vw_export_reach

from: qgep_od.vw_qgep_reach

# exclude_join_fields:


joins:
  elevation_determination:
    table: qgep_vl.reach_elevation_determination
    key: code
    fkey: elevation_determination
  horizontal_positioning:
    table: qgep_vl.reach_horizontal_positioning
    key: code
    fkey: horizontal_positioning
  inside_coating:
    table: qgep_vl.reach_inside_coating
    key: code
    fkey: inside_coating
  material:
    table: qgep_vl.reach_material
    key: code
    fkey: material
  reliner_material:
    table: qgep_vl.reach_reliner_material
    key: code
    fkey: reliner_material
  relining_construction:
    table: qgep_vl.reach_relining_construction
    key: code
    fkey: relining_construction
  relining_kind:
    table: qgep_vl.reach_relining_kind
    key: code
    fkey: relining_kind
  fk_pipe_profile:
    table: qgep_od.pipe_profile
    key: obj_id
    fkey: fk_pipe_profile
  function_hierarchic:
    table: qgep_vl.channel_function_hierarchic
    key: code
    fkey: function_hierarchic
  connection_type:
    table: qgep_vl.channel_connection_type
    key: code
    fkey: connection_type
  function_hydraulic:
    table: qgep_vl.channel_function_hydraulic
    key: code
    fkey: function_hydraulic
  usage_current:
    table: qgep_vl.channel_usage_current
    key: code
    fkey: usage_current
  usage_planned:
    table: qgep_vl.channel_usage_planned
    key: code
    fkey: usage_planned
  accessibility:
    table: qgep_vl.wastewater_structure_accessibility
    key: code
    fkey: accessibility
  financing:
    table: qgep_vl.wastewater_structure_financing
    key: code
    fkey: financing
  renovation_necessity:
    table: qgep_vl.wastewater_structure_renovation_necessity
    key: code
    fkey: renovation_necessity
  rv_construction_type:
    table: qgep_vl.wastewater_structure_rv_construction_type
    key: code
    fkey: rv_construction_type
  status:
    table: qgep_vl.wastewater_structure_status
    key: code
    fkey: status
  structure_condition:
    table: qgep_vl.wastewater_structure_structure_condition
    key: code
    fkey: structure_condition
  owner:
    table: qgep_od.organisation
    key: obj_id
    fkey: fk_owner
  operator:
    table: qgep_od.organisation
    key: obj_id
    fkey: fk_operator
""")

print(SqlExportView(pg_service, definition).sql())
