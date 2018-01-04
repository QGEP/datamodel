#!/usr/bin/env python

import yaml
import sys
from sql_export_view import SqlExportView

if len(sys.argv) > 1:
    pg_service = sys.argv[1]
else:
    pg_service = "pg_qgep"

definition = yaml.load("""

name: qgep_export.vw_export_wastewater_structure

from: qgep.vw_qgep_wastewater_structure

exclude_join_fields:
  - geometry%
  - label_1%
  - label_2%

joins:
  cover_shape:
    table: qgep.vl_cover_cover_shape
    key: code
    fkey: cover_shape
  cover_fastening:
    table: qgep.vl_cover_fastening
    key: code
    fkey: fastening
  cover_material:
    table: qgep.vl_cover_material
    key: code
    fkey: cover_material
  positional_accuracy:
    table: qgep.vl_cover_positional_accuracy
    key: code
    fkey: positional_accuracy
  sludge_bucket:
    table: qgep.vl_cover_sludge_bucket
    key: code
    fkey: sludge_bucket
  venting:
    table: qgep.vl_cover_venting
    key: code
    fkey: venting
  renovation_demand:
    table: qgep.vl_structure_part_renovation_demand
    key: code
    fkey: renovation_demand
  financing:
    table: qgep.vl_wastewater_structure_financing
    key: code
    fkey: financing
  renovation_necessity:
    table: qgep.vl_wastewater_structure_renovation_necessity
    key: code
    fkey: renovation_necessity
  rv_construction_type:
    table: qgep.vl_wastewater_structure_rv_construction_type
    key: code
    fkey: rv_construction_type
  status:
    table: qgep.vl_wastewater_structure_status
    key: code
    fkey: status
  structure_condition:
    table: qgep.vl_wastewater_structure_structure_condition
    key: code
    fkey: structure_condition
  owner:
    table: qgep.od_organisation
    key: obj_id
    fkey: fk_owner
  operator:
    table: qgep.od_organisation
    key: obj_id
    fkey: fk_operator
  manhole_function:
    table: qgep.vl_manhole_function
    key: code
    fkey: manhole_function
  material:
    table: qgep.vl_manhole_material
    key: code
    fkey: material
  surface_inflow:
    table: qgep.vl_manhole_surface_inflow
    key: code
    fkey: surface_inflow
  bypass:
    table: qgep.vl_special_structure_bypass
    key: code
    fkey: bypass
  special_structure_function:
    table: qgep.vl_special_structure_function
    key: code
    fkey: special_structure_function
  stormwater_tank_arrangement:
    table: qgep.vl_special_structure_stormwater_tank_arrangement
    key: code
    fkey: stormwater_tank_arrangement
  relevance:
    table: qgep.vl_discharge_point_relevance
    key: code
    fkey: relevance
""")

print(SqlExportView(pg_service, definition).sql())
