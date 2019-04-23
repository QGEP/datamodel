#!/usr/bin/env python3

from yaml import safe_load
import os
from pirogue.join import Join
from pirogue.merge import Merge
from .vw_qgep_wastewater_structure import vw_qgep_wastewater_structure
from .vw_qgep_reach import vw_qgep_reach


def create_views(srid: int, pg_service: str = None):
    """
    Creates the views for QGEP
    :param srid: the EPSG code for geometry columns
    :param pg_service: the PostgreSQL service, if not given it will be determined from environment variable in Pirogue
    """
    Join('qgep_od.structure_part', 'qgep_od.access_aid', view_name='vw_access_aid', pg_service=pg_service).create()
    Join('qgep_od.structure_part', 'qgep_od.benching', view_name='vw_benching', pg_service=pg_service).create()
    Join('qgep_od.structure_part', 'qgep_od.backflow_prevention', view_name='vw_backflow_prevention', pg_service=pg_service).create()
    Join('qgep_od.structure_part', 'qgep_od.cover', view_name='vw_cover', pg_service=pg_service).create()
    Join('qgep_od.structure_part', 'qgep_od.dryweather_downspout', view_name='vw_dryweather_downspout', pg_service=pg_service).create()
    Join('qgep_od.structure_part', 'qgep_od.dryweather_flume', view_name='vw_dryweather_flume', pg_service=pg_service).create()
    Join('qgep_od.wastewater_structure', 'qgep_od.channel', view_name='vw_channel', pg_service=pg_service).create()
    Join('qgep_od.wastewater_structure', 'qgep_od.manhole', view_name='vw_manhole', pg_service=pg_service).create()
    Join('qgep_od.wastewater_structure', 'qgep_od.discharge_point', view_name='vw_discharge_point', pg_service=pg_service).create()
    Join('qgep_od.wastewater_structure', 'qgep_od.special_structure', view_name='vw_special_structure', pg_service=pg_service).create()

    Join('qgep_od.wastewater_networkelement', 'qgep_od.reach', view_name='vw_reach', pg_service=pg_service).create()
    Join('qgep_od.wastewater_networkelement', 'qgep_od.wastewater_node', view_name='vw_wastewater_node', pg_service=pg_service).create()

    Merge(safe_load(open("view/vw_maintenance_examination.yaml")), pg_service=pg_service).create()
    Merge(safe_load(open("view/vw_damage.yaml")), pg_service=pg_service).create()

    vw_qgep_wastewater_structure(srid, pg_service=pg_service)
    vw_qgep_reach(srid, pg_service=pg_service)
    
    # file
    
    Merge(safe_load(open("view/vw_oo_overflow.yaml")), create_joins=True, pg_service=pg_service).create()
    Merge(safe_load(open("view/vw_oo_organisation.yaml")), pg_service=pg_service).create()

    # vw_catchment_area_connections.sql
    # vw_change_points.sql
    # 13_import.sql
    # vw_qgep_import.sql


if __name__ == "__main__":
    pg_service = os.getenv('PGSERVICE')
    srid = os.getenv('SRID')
    create_views(srid, pg_service)
