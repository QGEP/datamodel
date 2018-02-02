#!/usr/bin/env python

import imp
import os
import sys

pgiv = imp.load_source('PGInheritanceView', os.path.join(os.path.dirname(__file__), '../metaproject/postgresql/pg_inheritance_view/pg_inheritance_view.py'))


if len(sys.argv) > 1:
	pg_service = sys.argv[1]
else:
	pg_service = 'pg_qgep'

organisation="""
table: qgep_od.organisation
alias: organisation
pkey: obj_id
pkey_value: qgep_sys.generate_oid('qgep_od','organisation')
schema: qgep_od

children:
  cooperative:
    table: qgep_od.cooperative
    pkey: obj_id

  canton:
    table: qgep_od.canton
    pkey: obj_id

  waste_water_association:
    table: qgep_od.waste_water_association
    pkey: obj_id

  municipality:
    table: qgep_od.municipality
    pkey: obj_id

  administrative_office:
    table: qgep_od.administrative_office
    pkey: obj_id

  waste_water_treatment_plant:
    table: qgep_od.waste_water_treatment_plant
    pkey: obj_id
    remap:
      kind: waste_water_treatment_plant_kind

  private:
    table: qgep_od.private
    pkey: obj_id
    remap:
      kind: private_kind


merge_view:
  name: vw_organisation
  allow_type_change: true
  merge_columns:
    perimeter_geometry:
      canton: perimeter_geometry
      municipality: perimeter_geometry
"""


print((pgiv.PGInheritanceView(pg_service, organisation).sql_all()))
