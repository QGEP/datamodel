#!/usr/bin/env python3

from yaml import safe_load
import os
from pirogue.join import Join
from pirogue.merge import Merge
from .vw_qgep_wastewater_structure import vw_qgep_wastewater_structure
from .vw_qgep_reach import vw_qgep_reach


def create_views(srid: int):
    """
    Creates the views for QGEP
    :param srid: the EPSG code for geometry columns
    """
    Join('qgep_od.structure_part', 'qgep_od.access_aid', view_name='vw_access_aid').create()
    Join('qgep_od.structure_part', 'qgep_od.benching', view_name='vw_benching').create()
    Join('qgep_od.structure_part', 'qgep_od.backflow_prevention', view_name='vw_backflow_prevention').create()
    Join('qgep_od.structure_part', 'qgep_od.cover', view_name='vw_cover').create()
    Join('qgep_od.structure_part', 'qgep_od.dryweather_downspout', view_name='vw_dryweather_downspout').create()
    Join('qgep_od.structure_part', 'qgep_od.dryweather_flume', view_name='vw_dryweather_flume').create()

    Join('qgep_od.wastewater_structure', 'qgep_od.channel', view_name='vw_channel').create()
    Join('qgep_od.wastewater_structure', 'qgep_od.manhole', view_name='vw_manhole').create()
    Join('qgep_od.wastewater_structure', 'qgep_od.discharge_point', view_name='vw_discharge_point').create()
    Join('qgep_od.wastewater_structure', 'qgep_od.special_structure', view_name='vw_special_structure').create()

    Join('qgep_od.wastewater_networkelement', 'qgep_od.reach', view_name='vw_reach').create()
    Join('qgep_od.wastewater_networkelement', 'qgep_od.wastewater_node', view_name='vw_wastewater_node').create()

    Merge(safe_load(open("view/vw_maintenance_examination.yaml"))).create()
    Merge(safe_load(open("view/vw_damage.yaml"))).create()

    vw_qgep_wastewater_structure(srid)
    vw_qgep_reach(srid)
    
    # file
    
    Merge(safe_load(open("view/vw_oo_overflow.yaml")), create_joins=True).create()
    Merge(safe_load(open("view/vw_oo_organisation.yaml"))).create()

    # vw_catchment_area_connections.sql
    # vw_change_points.sql
    # 13_import.sql
    # vw_qgep_import.sql


if __name__ == "__main__":
    srid = os.getenv('SRID')
    create_views(srid)
