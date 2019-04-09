#!/usr/bin/env

from pirogue.join import Join

Join('qgep_od.access_aid', 'qgep_od.structure_part', view_name='vw_access_aid')
Join('qgep_od.benching', 'qgep_od.structure_part', view_name='vw_benching')
Join('qgep_od.backflow_prevention', 'qgep_od.structure_part', view_name='vw_backflow_prevention')
Join('qgep_od.channel', 'qgep_od.wastewater_structure', view_name='vw_channel')
