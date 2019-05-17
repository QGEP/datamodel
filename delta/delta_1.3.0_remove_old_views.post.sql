
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

-- import
DROP VIEW IF EXISTS qgep_import.vw_manhole;

-- big views
DROP VIEW IF EXISTS qgep_od.vw_qgep_wastewater_structure;
DROP VIEW IF EXISTS qgep_od.vw_qgep_maintenance;
DROP VIEW IF EXISTS qgep_od.vw_qgep_damage;
DROP VIEW IF EXISTS qgep_od.vw_qgep_overflow;

-- structure_part
DROP VIEW IF EXISTS qgep_od.vw_access_aid;
DROP FUNCTION IF EXISTS qgep_od.vw_access_aid_insert();

DROP VIEW IF EXISTS qgep_od.vw_backflow_prevention;
DROP FUNCTION IF EXISTS qgep_od.vw_backflow_prevention_insert();

DROP VIEW IF EXISTS qgep_od.vw_benching;
DROP FUNCTION IF EXISTS qgep_od.vw_benching_insert();

DROP VIEW IF EXISTS qgep_od.vw_cover;
DROP FUNCTION IF EXISTS qgep_od.vw_cover();

DROP VIEW IF EXISTS qgep_od.vw_dryweather_downspout;
DROP FUNCTION IF EXISTS qgep_od.vw_dryweather_downspout_insert();

DROP VIEW IF EXISTS qgep_od.vw_dryweather_flume;
DROP FUNCTION IF EXISTS qgep_od.vw_dryweather_flume_insert();


-- wastewater_structure
DROP VIEW IF EXISTS qgep_od.vw_channel;
DROP FUNCTION IF EXISTS qgep_od.vw_channel_insert();

DROP VIEW IF EXISTS qgep_od.vw_manhole;
DROP FUNCTION IF EXISTS qgep_od.vw_manhole_insert();

DROP VIEW IF EXISTS qgep_od.vw_discharge_point;
DROP FUNCTION IF EXISTS qgep_od.vw_discharge_point_insert();

DROP VIEW IF EXISTS qgep_od.vw_special_structure;
DROP FUNCTION IF EXISTS qgep_od.vw_special_structure_insert();


-- wastewater_networkelement
DROP VIEW IF EXISTS qgep_od.vw_reach;
DROP FUNCTION IF EXISTS qgep_od.vw_reach_insert();

DROP VIEW IF EXISTS qgep_od.vw_wastewater_node;
DROP FUNCTION IF EXISTS qgep_od.vw_wastewater_node_insert();

-- other
DROP VIEW IF EXISTS qgep_od.vw_administrative_office;
DROP VIEW IF EXISTS qgep_od.vw_canton;
DROP VIEW IF EXISTS qgep_od.vw_cooperative;
DROP VIEW IF EXISTS qgep_od.vw_damage_channel;
DROP VIEW IF EXISTS qgep_od.vw_damage_manhole;
DROP VIEW IF EXISTS qgep_od.vw_maintenance_examination;
DROP VIEW IF EXISTS qgep_od.vw_municipality;
DROP VIEW IF EXISTS qgep_od.vw_organisation;
DROP VIEW IF EXISTS qgep_od.vw_organisation_administrative_office;
DROP VIEW IF EXISTS qgep_od.vw_organisation_canton;
DROP VIEW IF EXISTS qgep_od.vw_organisation_cooperative;
DROP VIEW IF EXISTS qgep_od.vw_organisation_municipality;
DROP VIEW IF EXISTS qgep_od.vw_organisation_private;
DROP VIEW IF EXISTS qgep_od.vw_organisation_waste_water_association;
DROP VIEW IF EXISTS qgep_od.vw_organisation_waste_water_treatment_plant;
DROP VIEW IF EXISTS qgep_od.vw_overflow_leapingweir;
DROP VIEW IF EXISTS qgep_od.vw_overflow_prank_weir;
DROP VIEW IF EXISTS qgep_od.vw_overflow_pump;
DROP VIEW IF EXISTS qgep_od.vw_private;
DROP VIEW IF EXISTS qgep_od.vw_waste_water_association;
DROP VIEW IF EXISTS qgep_od.vw_waste_water_treatment_plant;

DROP VIEW IF EXISTS qgep_od.vw_file;
DROP VIEW IF EXISTS qgep_od.vw_change_points;
DROP VIEW IF EXISTS qgep_od.vw_catchment_area_connections;


