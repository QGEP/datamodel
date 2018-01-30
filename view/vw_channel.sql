DROP VIEW IF EXISTS qgep_od.vw_channel;

--------
-- Subclass: channel
-- Superclass: wastewater_structure
--------
CREATE OR REPLACE VIEW qgep_od.vw_channel AS

SELECT
   CL.obj_id
   , CL.bedding_encasement
   , CL.connection_type
   , CL.function_hierarchic
   , CL.function_hydraulic
   , CL.jetting_interval
   , CL.pipe_length
   , CL.usage_current
   , CL.usage_planned
   , WS.accessibility
   , WS.contract_section
   , WS.detail_geometry_geometry
   , WS.financing
   , WS.gross_costs
   , WS.identifier
   , WS.inspection_interval
   , WS.location_name
   , WS.records
   , WS.remark
   , WS.renovation_necessity
   , WS.replacement_value
   , WS.rv_base_year
   , WS.rv_construction_type
   , WS.status
   , WS.structure_condition
   , WS.subsidies
   , WS.year_of_construction
   , WS.year_of_replacement
   , WS.fk_dataowner
   , WS.fk_provider
   , WS.last_modification
  , WS.fk_owner
  , WS.fk_operator
  FROM qgep_od.channel CL
 LEFT JOIN qgep_od.wastewater_structure WS
 ON WS.obj_id = CL.obj_id;

-----------------------------------
-- channel INSERT
-- Function: vw_channel_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_channel_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.wastewater_structure (
             obj_id
           , accessibility
           , contract_section
           , detail_geometry_geometry
           , financing
           , gross_costs
           , identifier
           , inspection_interval
           , location_name
           , records
           , remark
           , renovation_necessity
           , replacement_value
           , rv_base_year
           , rv_construction_type
           , status
           , structure_condition
           , subsidies
           , year_of_construction
           , year_of_replacement
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_owner
           , fk_operator
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','channel')) -- obj_id
           , NEW.accessibility
           , NEW.contract_section
            , NEW.detail_geometry_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.remark
           , NEW.renovation_necessity
           , NEW.replacement_value
           , NEW.rv_base_year
           , NEW.rv_construction_type
           , NEW.status
           , NEW.structure_condition
           , NEW.subsidies
           , NEW.year_of_construction
           , NEW.year_of_replacement
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_owner
           , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.channel (
             obj_id
           , bedding_encasement
           , connection_type
           , function_hierarchic
           , function_hydraulic
           , jetting_interval
           , pipe_length
           , usage_current
           , usage_planned
           )
          VALUES (
             NEW.obj_id -- obj_id
           , NEW.bedding_encasement
           , NEW.connection_type
           , NEW.function_hierarchic
           , NEW.function_hydraulic
           , NEW.jetting_interval
           , NEW.pipe_length
           , NEW.usage_current
           , NEW.usage_planned
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_channel_ON_INSERT ON qgep_od.channel;

CREATE TRIGGER vw_channel_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_channel
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_channel_insert();

-----------------------------------
-- channel UPDATE
-- Rule: vw_channel_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_channel_ON_UPDATE AS ON UPDATE TO qgep_od.vw_channel DO INSTEAD (
UPDATE qgep_od.channel
  SET
       bedding_encasement = NEW.bedding_encasement
     , connection_type = NEW.connection_type
     , function_hierarchic = NEW.function_hierarchic
     , function_hydraulic = NEW.function_hydraulic
     , jetting_interval = NEW.jetting_interval
     , pipe_length = NEW.pipe_length
     , usage_current = NEW.usage_current
     , usage_planned = NEW.usage_planned
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.wastewater_structure
  SET
       accessibility = NEW.accessibility
     , contract_section = NEW.contract_section
     , detail_geometry_geometry = NEW.detail_geometry_geometry
     , financing = NEW.financing
     , gross_costs = NEW.gross_costs
     , identifier = NEW.identifier
     , inspection_interval = NEW.inspection_interval
     , location_name = NEW.location_name
     , records = NEW.records
     , remark = NEW.remark
     , renovation_necessity = NEW.renovation_necessity
     , replacement_value = NEW.replacement_value
     , rv_base_year = NEW.rv_base_year
     , rv_construction_type = NEW.rv_construction_type
     , status = NEW.status
     , structure_condition = NEW.structure_condition
     , subsidies = NEW.subsidies
     , year_of_construction = NEW.year_of_construction
     , year_of_replacement = NEW.year_of_replacement
     , fk_dataowner = NEW.fk_dataowner
     , fk_provider = NEW.fk_provider
     , last_modification = NEW.last_modification
     , fk_owner = NEW.fk_owner
     , fk_operator = NEW.fk_operator
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- channel DELETE
-- Rule: vw_channel_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_channel_ON_DELETE AS ON DELETE TO qgep_od.vw_channel DO INSTEAD (
  DELETE FROM qgep_od.channel WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.wastewater_structure WHERE obj_id = OLD.obj_id;
);

