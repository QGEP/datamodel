#!/usr/bin/env python3

import yaml
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
    Join('qgep_od.access_aid', 'qgep_od.structure_part', view_name='vw_access_aid').create()
    Join('qgep_od.benching', 'qgep_od.structure_part', view_name='vw_benching').create()
    Join('qgep_od.backflow_prevention', 'qgep_od.structure_part', view_name='vw_backflow_prevention').create()
    Join('qgep_od.cover', 'qgep_od.structure_part', view_name='vw_cover').create()
    Join('qgep_od.dryweather_downspout', 'qgep_od.structure_part', view_name='vw_dryweather_downspout').create()
    Join('qgep_od.dryweather_flume', 'qgep_od.structure_part', view_name='vw_dryweather_flume').create()

    Join('qgep_od.channel', 'qgep_od.wastewater_structure', view_name='vw_channel').create()
    Join('qgep_od.manhole', 'qgep_od.wastewater_structure', view_name='vw_manhole').create()
    Join('qgep_od.discharge_point', 'qgep_od.wastewater_structure', view_name='vw_discharge_point').create()
    Join('qgep_od.special_structure', 'qgep_od.wastewater_structure', view_name='vw_special_structure').create()

    Join('qgep_od.reach', 'qgep_od.wastewater_networkelement', view_name='vw_reach').create()
    Join('qgep_od.wastewater_node', 'qgep_od.wastewater_networkelement', view_name='vw_wastewater_node').create()

    yaml_definition = yaml.safe_load(open("view/vw_maintenance_examination.yaml"))
    Merge(yaml_definition).create()

    vw_qgep_wastewater_structure(srid)
    vw_qgep_reach(srid)


if __name__ == "__main__":
    srid = os.getenv('SRID')
    create_views(srid)
