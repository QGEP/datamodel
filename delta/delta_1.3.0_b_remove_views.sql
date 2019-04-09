DROP RULE _RETURN ON qgep_od.vw_access_aid;
DROP VIEW IF EXISTS qgep_od.vw_access_aid;
DROP FUNCTION IF EXISTS qgep_od.vw_access_aid_insert();

DROP RULE _RETURN ON qgep_od.vw_backflow_prevention;
DROP VIEW IF EXISTS qgep_od.vw_backflow_prevention;
DROP FUNCTION IF EXISTS qgep_od.vw_backflow_prevention_insert();

-- structure_part
DROP RULE _RETURN ON qgep_od.vw_benching;
DROP VIEW IF EXISTS qgep_od.vw_benching;
DROP FUNCTION IF EXISTS qgep_od.vw_benching_insert();

DROP RULE _RETURN ON qgep_od.vw_cover;
DROP VIEW IF EXISTS qgep_od.vw_cover;
DROP FUNCTION IF EXISTS qgep_od.vw_cover();

DROP RULE _RETURN ON qgep_od.vw_dryweather_downspout;
DROP VIEW IF EXISTS qgep_od.vw_dryweather_downspout;
DROP FUNCTION IF EXISTS qgep_od.vw_dryweather_downspout_insert();

DROP RULE _RETURN ON qgep_od.vw_dryweather_flume;
DROP VIEW IF EXISTS qgep_od.vw_dryweather_flume;
DROP FUNCTION IF EXISTS qgep_od.vw_dryweather_flume_insert();


-- wastewater_structure
DROP RULE _RETURN ON qgep_od.vw_channel;
DROP VIEW IF EXISTS qgep_od.vw_channel;
DROP FUNCTION IF EXISTS qgep_od.vw_channel_insert();

DROP RULE _RETURN ON qgep_od.vw_manhole;
DROP VIEW IF EXISTS qgep_od.vw_manhole;
DROP FUNCTION IF EXISTS qgep_od.vw_manhole_insert();

DROP RULE _RETURN ON qgep_od.vw_discharge_point;
DROP VIEW IF EXISTS qgep_od.vw_discharge_point;
DROP FUNCTION IF EXISTS qgep_od.vw_discharge_point_insert();

DROP RULE _RETURN ON qgep_od.vw_special_structure;
DROP VIEW IF EXISTS qgep_od.vw_special_structure;
DROP FUNCTION IF EXISTS qgep_od.vw_special_structure_insert();


-- wastewater_networkelement
DROP RULE _RETURN ON qgep_od.vw_reach;
DROP VIEW IF EXISTS qgep_od.vw_reach;
DROP FUNCTION IF EXISTS qgep_od.vw_reach_insert();

DROP RULE _RETURN ON qgep_od.vw_wastewater_node;
DROP VIEW IF EXISTS qgep_od.vw_wastewater_node;
DROP FUNCTION IF EXISTS qgep_od.vw_wastewater_node_insert();



