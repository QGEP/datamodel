
DROP FUNCTION IF EXISTS vw_qgep_wastewater_structure_INSERT();
DROP FUNCTION IF EXISTS vw_qgep_wastewater_structure_UPDATE();
DROP FUNCTION IF EXISTS vw_qgep_wastewater_structure_DELETE();

DROP FUNCTION IF EXISTS vw_qgep_reach_INSERT();
DROP FUNCTION IF EXISTS vw_qgep_reach_on_UPDATE();

DROP RULE IF EXISTS vw_access_aid_ON_DELETE ON qgep_od.vw_access_aid;
DROP RULE IF EXISTS vw_backflow_prevention_ON_DELETE ON qgep_od.vw_backflow_prevention;
DROP RULE IF EXISTS vw_benching_ON_DELETE ON qgep_od.vw_benching;
DROP RULE IF EXISTS vw_channel_ON_DELETE ON qgep_od.vw_channel;
DROP RULE IF EXISTS vw_cover_ON_DELETE ON qgep_od.vw_cover;
DROP RULE IF EXISTS vw_discharge_point_ON_DELETE ON qgep_od.vw_discharge_point;
DROP RULE IF EXISTS vw_dryweather_downspout_ON_DELETE ON qgep_od.vw_dryweather_downspout;
DROP RULE IF EXISTS vw_dryweather_flume_ON_DELETE ON qgep_od.vw_dryweather_flume;
DROP RULE IF EXISTS vw_manhole_ON_DELETE ON qgep_od.vw_manhole;
DROP RULE IF EXISTS vw_reach_ON_DELETE ON qgep_od.vw_reach;
DROP RULE IF EXISTS vw_special_structure_ON_DELETE ON qgep_od.vw_special_structure;
DROP RULE IF EXISTS vw_wastewater_node_ON_DELETE ON qgep_od.vw_wastewater_node;






