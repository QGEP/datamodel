#!/usr/bin/env python3

from pirogue.join import Join
from .vw_qgep_wastewater_structure import vw_qgep_wastewater_structure
from .vw_qgep_reach import vw_qgep_reach


def create_views():
    Join('qgep_od.access_aid', 'qgep_od.structure_part', view_name='vw_access_aid')
    Join('qgep_od.benching', 'qgep_od.structure_part', view_name='vw_benching')
    Join('qgep_od.backflow_prevention', 'qgep_od.structure_part', view_name='vw_backflow_prevention')
    Join('qgep_od.cover', 'qgep_od.structure_part', view_name='vw_cover')
    Join('qgep_od.dryweather_downspout', 'qgep_od.structure_part', view_name='vw_dryweather_downspout')
    Join('qgep_od.dryweather_flume', 'qgep_od.structure_part', view_name='vw_dryweather_flume')

    Join('qgep_od.channel', 'qgep_od.wastewater_structure', view_name='vw_channel')
    Join('qgep_od.manhole', 'qgep_od.wastewater_structure', view_name='vw_manhole')
    Join('qgep_od.discharge_point', 'qgep_od.wastewater_structure', view_name='vw_discharge_point')
    Join('qgep_od.special_structure', 'qgep_od.wastewater_structure', view_name='vw_special_structure')

    Join('qgep_od.reach', 'qgep_od.wastewater_networkelement', view_name='vw_reach')
    Join('qgep_od.wastewater_node', 'qgep_od.wastewater_networkelement', view_name='vw_wastewater_node')

    vw_qgep_wastewater_structure()
    vw_qgep_reach()


if __name__ == "__main__":
    create_views()
