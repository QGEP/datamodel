#!/usr/bin/env python3

from yaml import safe_load
import psycopg2
import argparse
from pirogue import SingleInheritance, MultipleInheritance, SimpleJoins

import sys, os
sys.path.append(os.path.join(os.path.dirname(__file__)))

from vw_qgep_wastewater_structure import vw_qgep_wastewater_structure
from vw_qgep_reach import vw_qgep_reach


def run_sql(file_path: str, pg_service: str, variables: dict = {}):
    sql = open(file_path).read()
    conn = psycopg2.connect("service={0}".format(pg_service))
    cursor = conn.cursor()
    cursor.execute(sql, variables)
    conn.commit()
    conn.close()


def create_views(srid: int,
                 pg_service: str,
                 qgep_reach_extra: str = None,
                 qgep_wastewater_structure_extra: str = None):
    """
    Creates the views for QGEP
    :param srid: the EPSG code for geometry columns
    :param pg_service: the PostgreSQL service, if not given it will be determined from environment variable in Pirogue
    :param qgep_reach_extra: YAML file path of the definition of additional columns for vw_qgep_reach view
    :param qgep_wastewater_structure_extra: YAML file path of the definition of additional columns for vw_qgep_wastewater_structure_extra view"""

    variables = {'SRID': srid}

    # open YAML files
    if qgep_reach_extra:
        qgep_reach_extra = safe_load(open(qgep_reach_extra))
    if qgep_wastewater_structure_extra:
        qgep_wastewater_structure_extra = safe_load(open(qgep_wastewater_structure_extra))

    run_sql('view/drop_views.sql', pg_service, variables)

    SingleInheritance('qgep_od.structure_part', 'qgep_od.access_aid', view_name='vw_access_aid', pg_service=pg_service).create()
    SingleInheritance('qgep_od.structure_part', 'qgep_od.benching', view_name='vw_benching', pg_service=pg_service).create()
    SingleInheritance('qgep_od.structure_part', 'qgep_od.backflow_prevention', view_name='vw_backflow_prevention', pg_service=pg_service).create()
    SingleInheritance('qgep_od.structure_part', 'qgep_od.cover', view_name='vw_cover', pkey_default_value=True, pg_service=pg_service).create()
    SingleInheritance('qgep_od.structure_part', 'qgep_od.dryweather_downspout', view_name='vw_dryweather_downspout', pg_service=pg_service).create()
    SingleInheritance('qgep_od.structure_part', 'qgep_od.dryweather_flume', view_name='vw_dryweather_flume', pg_service=pg_service).create()
    SingleInheritance('qgep_od.wastewater_structure', 'qgep_od.channel', view_name='vw_channel', pg_service=pg_service).create()
    SingleInheritance('qgep_od.wastewater_structure', 'qgep_od.manhole', view_name='vw_manhole', pg_service=pg_service).create()
    SingleInheritance('qgep_od.wastewater_structure', 'qgep_od.discharge_point', view_name='vw_discharge_point', pg_service=pg_service).create()
    SingleInheritance('qgep_od.wastewater_structure', 'qgep_od.special_structure', view_name='vw_special_structure', pg_service=pg_service).create()

    SingleInheritance('qgep_od.wastewater_networkelement', 'qgep_od.reach', view_name='vw_reach', pg_service=pg_service).create()
    SingleInheritance('qgep_od.wastewater_networkelement', 'qgep_od.wastewater_node', view_name='vw_wastewater_node', pkey_default_value=True, pg_service=pg_service).create()

    SingleInheritance('qgep_od.connection_object', 'qgep_od.individual_surface', view_name='vw_individual_surface', pkey_default_value=True, pg_service=pg_service).create()

    MultipleInheritance(safe_load(open("view/vw_maintenance_examination.yaml")), drop=True, pg_service=pg_service).create()
    MultipleInheritance(safe_load(open("view/vw_damage.yaml")), drop=True, pg_service=pg_service).create()

    vw_qgep_wastewater_structure(srid, pg_service=pg_service, extra_definition=qgep_wastewater_structure_extra)
    vw_qgep_reach(pg_service=pg_service, extra_definition=qgep_reach_extra)
    
    run_sql('view/vw_file.sql', pg_service, variables)
    
    MultipleInheritance(safe_load(open("view/vw_oo_overflow.yaml")), create_joins=True, variables=variables, pg_service=pg_service, drop=True).create()
    MultipleInheritance(safe_load(open("view/vw_oo_organisation.yaml")), drop=True, pg_service=pg_service).create()

    run_sql('view/vw_catchment_area_connections.sql', pg_service, variables)
    run_sql('view/vw_change_points.sql', pg_service, variables)
    run_sql('view/vw_qgep_import.sql', pg_service, variables)

    # Recreate swmm views
    run_sql('swmm_views/01_vw_swmm_create_schema.sql', pg_service, variables)
    run_sql('swmm_views/02_vw_swmm_junctions.sql', pg_service, variables)
    run_sql('swmm_views/03_vw_swmm_aquifers.sql', pg_service, variables)
    run_sql('swmm_views/04_vw_swmm_conduits.sql', pg_service, variables)
    run_sql('swmm_views/05_vw_swmm_dividers.sql', pg_service, variables)
    run_sql('swmm_views/06_vw_swmm_landuses.sql', pg_service, variables)
    run_sql('swmm_views/07_vw_swmm_losses.sql', pg_service, variables)
    run_sql('swmm_views/08_vw_swmm_outfalls.sql', pg_service, variables)
    run_sql('swmm_views/09_vw_swmm_subcatchments.sql', pg_service, variables)
    run_sql('swmm_views/10_vw_swmm_vertices.sql', pg_service, variables)
    run_sql('swmm_views/11_vw_swmm_pumps.sql', pg_service, variables)
    run_sql('swmm_views/12_vw_swmm_polygons.sql', pg_service, variables)
    run_sql('swmm_views/13_vw_swmm_storages.sql', pg_service, variables)
    run_sql('swmm_views/14_vw_swmm_xsections.sql', pg_service, variables)
    run_sql('swmm_views/15_vw_swmm_coordinates.sql', pg_service, variables)
    run_sql('swmm_views/16_vw_swmm_tags.sql', pg_service, variables)

    SimpleJoins(safe_load(open('view/export/vw_export_reach.yaml')), pg_service).create()
    SimpleJoins(safe_load(open('view/export/vw_export_wastewater_structure.yaml')), pg_service).create()


if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('-p', '--pg_service', help='postgres service')
    parser.add_argument('-s', '--srid', help='SRID EPSG code, defaults to 2056', type=int, default=2056)
    parser.add_argument('--qgep_wastewater_structure_extra', help='YAML definition file path for additions to vw_qgep_wastewater_structure view')
    parser.add_argument('--qgep_reach_extra', help='YAML definition file path for additions to vw_qgep_reach view')
    args = parser.parse_args()

    create_views(args.srid, args.pg_service,
                 qgep_reach_extra=args.qgep_reach_extra,
                 qgep_wastewater_structure_extra=args.qgep_wastewater_structure_extra)

