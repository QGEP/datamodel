-- +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
-- kf: geometry adedd
-- View: qgep.vw_discharge_point
-- DROP VIEW qgep.vw_discharge_point;
CREATE OR REPLACE VIEW qgep.vw_discharge_point AS 
 SELECT dp.obj_id,
    dp.depth,
    dp.highwater_level,
    dp.relevance,
    dp.terrain_level,
    dp.upper_elevation,
    dp.waterlevel_hydraulic,
    ws.accessibility,
    ws.contract_section,
    ws.detail_geometry_geometry,
    ws.detail_geometry_3d_geometry,
    ws.financing,
    ws.gross_costs,
    ws.identifier,
    ws.inspection_interval,
    ws.location_name,
    ws.records,
    ws.remark,
    ws.renovation_necessity,
    ws.replacement_value,
    ws.rv_base_year,
    ws.rv_construction_type,
    ws.status,
    ws.structure_condition,
    ws.subsidies,
    ws.year_of_construction,
    ws.year_of_replacement,
    ws.fk_dataowner,
    ws.fk_provider,
    ws.last_modification,
    ws.fk_owner,
    ws.fk_operator,
  	we.bottom_level,
	we.situation_geometry,
	we.backflow_level
FROM qgep.od_discharge_point dp
LEFT JOIN qgep.od_wastewater_networkelement wn ON wn.fk_wastewater_structure = dp.obj_id
LEFT JOIN qgep.od_wastewater_node we ON we.obj_id = wn.obj_id
LEFT JOIN qgep.od_wastewater_structure ws ON ws.obj_id = wn.fk_wastewater_structure;

-- ALTER TABLE qgep.vw_discharge_point  OWNER TO postgres;
ALTER TABLE qgep.vw_discharge_point  OWNER TO postgres;
GRANT ALL ON TABLE qgep.vw_discharge_point TO postgres;

-- Rule: vw_discharge_point_on_delete ON qgep.vw_discharge_point
-- DROP RULE vw_discharge_point_on_delete ON qgep.vw_discharge_point;
CREATE OR REPLACE RULE vw_discharge_point_on_delete AS
    ON DELETE TO qgep.vw_discharge_point DO INSTEAD ( DELETE FROM qgep.od_discharge_point
  WHERE od_discharge_point.obj_id::text = old.obj_id::text;
 DELETE FROM qgep.od_wastewater_structure
  WHERE od_wastewater_structure.obj_id::text = old.obj_id::text;
);

-- Rule: vw_discharge_point_on_update ON qgep.vw_discharge_point
-- DROP RULE vw_discharge_point_on_update ON qgep.vw_discharge_point;
CREATE OR REPLACE RULE vw_discharge_point_on_update AS
    ON UPDATE TO qgep.vw_discharge_point DO INSTEAD 
    ( UPDATE qgep.od_discharge_point SET depth = new.depth, 
    highwater_level = new.highwater_level, relevance = new.relevance, terrain_level = new.terrain_level, 
    upper_elevation = new.upper_elevation, waterlevel_hydraulic = new.waterlevel_hydraulic
  WHERE od_discharge_point.obj_id::text = old.obj_id::text;
  
 UPDATE qgep.od_wastewater_structure SET accessibility = new.accessibility, contract_section = new.contract_section, 
 detail_geometry_geometry = new.detail_geometry_geometry, 
 -- detail_geometry3d_geometry = new.detail_geometry3d_geometry, 
 financing = new.financing, gross_costs = new.gross_costs, identifier = new.identifier, 
 inspection_interval = new.inspection_interval, location_name = new.location_name, records = new.records, remark = new.remark, 
 renovation_necessity = new.renovation_necessity, replacement_value = new.replacement_value, rv_base_year = new.rv_base_year, 
 rv_construction_type = new.rv_construction_type, status = new.status, structure_condition = new.structure_condition, 
 subsidies = new.subsidies, year_of_construction = new.year_of_construction, year_of_replacement = new.year_of_replacement, 
 fk_dataowner = new.fk_dataowner, fk_provider = new.fk_provider, last_modification = new.last_modification, fk_owner = new.fk_owner, 
 fk_operator = new.fk_operator
  WHERE od_wastewater_structure.obj_id::text = old.obj_id::text;
);

-- Trigger: vw_discharge_point_on_insert on qgep.vw_discharge_point
-- DROP TRIGGER vw_discharge_point_on_insert ON qgep.vw_discharge_point;
CREATE TRIGGER vw_discharge_point_on_insert
  INSTEAD OF INSERT
  ON qgep.vw_discharge_point
  FOR EACH ROW
  EXECUTE PROCEDURE qgep.vw_discharge_point_insert();
