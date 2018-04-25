#!/usr/bin/env python3

from __future__ import print_function
import imp
import os
import sys

pgiv = imp.load_source('PGInheritanceViewRecursive',
                       os.path.join(os.path.dirname(__file__),
                                    '../metaproject/postgresql/pg_inheritance_view/pg_inheritance_view_recursive.py'))

if len(sys.argv) > 1:
	pg_service = sys.argv[1]
else:
	pg_service = 'pg_qgep'

if len(sys.argv) > 2:
	srid = sys.argv[2]
else:
	srid = 2056


qgep_reach = """
table: qgep_od.wastewater_networkelement
alias: networkelement
pkey: obj_id
pkey_value: qgep_sys.generate_oid('qgep_od','wastewater_networkelement')
pkey_value_create_entry: False
schema: qgep_od
generate_child_views: True
exec_order: 1
isroot: True

children:
    reach:
        c_table: qgep_od.reach
        table: qgep_od.vw_reach
        pkey: obj_id
        alias: reach
        pkey_value: COALESCE(NEW.obj_id, qgep_sys.generate_oid('qgep_od','reach'))
        schema: qgep_od
        generate_child_views: True
        exec_order: 2
        trig_here: True

        children:
            wastewater_structure:
                c_table: qgep_od.wastewater_structure
                table: qgep_od.wastewater_structure
                alias: wastewater_structure
                prefix: ws
                pkey: obj_id
                pkey_value: COALESCE(NEW.fk_wastewater_structure,qgep_sys.generate_oid('qgep_od','channel'))
                schema: qgep_od
                generate_child_views: False
                exec_order: 3
                trig_here: True

                children:
                    channel:
                        table: qgep_od.channel
                        c_table: qgep_od.channel
                        pkey: obj_id
                        generate_view: False
                        pkey_value: NEW.fk_wastewater_structure

            reach_point_from:
                table: qgep_od.reach_point
                c_table: qgep_od.reach_point
                pkey: obj_id
                generate_view: False
                pkey_value: COALESCE(NEW.rp_from_obj_id, qgep_sys.generate_oid('qgep_od','reach_point'))
                alias: rp_from
                schema: qgep_od

            reach_point_to:
                table: qgep_od.reach_point
                c_table: qgep_od.reach_point
                pkey: obj_id
                generate_view: False
                pkey_value: COALESCE(NEW.rp_to_obj_id, qgep_sys.generate_oid('qgep_od','reach_point'))
                alias: rp_to
                schema: qgep_od

merge_view:
  name: vw_qgep_reach
  allow_type_change: false
  allow_parent_only: false
"""

trigger_plan = """
view: qgep_od.vw_node_element

view: qgep_od.vw_element_installation
  trig_for:
    qgep_od.node
    qgep_od.network_element
    qgep_od.source
    qgep_od.pump
    qgep_od.tank
    qgep_od.treatment
    qgep_od.chamber
    qgep_od.pressurecontrol

view: qgep_od.vw_element_hydrant
    trig_for:
        qgep_od.node
        qgep_od.network_element
        hydrant

view: qgep_od.vw_element_samplingpoint
view: qgep_od.vw_element_meter
view: qgep_od.vw_element_subscriber
view: qgep_od.vw_element_part


"""
# fix_print_with_import

# fix_print_with_import
print(pgiv.PGInheritanceViewRecursive(pg_service, qgep_reach).sql_all())
