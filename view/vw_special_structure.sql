DROP VIEW IF EXISTS qgep_od.vw_special_structure;

--------
-- Subclass: special_structure
-- Superclass: wastewater_structure
--------
CREATE OR REPLACE VIEW qgep_od.vw_special_structure AS

SELECT
   SS.obj_id
   , SS.bypass
   , WS."_depth"
   , SS.emergency_spillway
   , SS.function
   , SS.stormwater_tank_arrangement
   , SS.upper_elevation
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
  FROM qgep_od.special_structure SS
 LEFT JOIN qgep_od.wastewater_structure WS
 ON WS.obj_id = SS.obj_id;

-----------------------------------
-- special_structure INSERT
-- Function: vw_special_structure_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_special_structure_insert()
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
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','special_structure')) -- obj_id
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

INSERT INTO qgep_od.special_structure (
             obj_id
           , bypass
           , emergency_spillway
           , function
           , stormwater_tank_arrangement
           , upper_elevation
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.bypass
           , NEW.emergency_spillway
           , NEW.function
           , NEW.stormwater_tank_arrangement
           , NEW.upper_elevation
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_special_structure_ON_INSERT ON qgep_od.special_structure;

CREATE TRIGGER vw_special_structure_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_special_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_special_structure_insert();

-----------------------------------
-- special_structure UPDATE
-- Rule: vw_special_structure_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_special_structure_ON_UPDATE AS ON UPDATE TO qgep_od.vw_special_structure DO INSTEAD (
UPDATE qgep_od.special_structure
  SET
       bypass = NEW.bypass
     , emergency_spillway = NEW.emergency_spillway
     , function = NEW.function
     , stormwater_tank_arrangement = NEW.stormwater_tank_arrangement
     , upper_elevation = NEW.upper_elevation
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
-- special_structure DELETE
-- Rule: vw_special_structure_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_special_structure_ON_DELETE AS ON DELETE TO qgep_od.vw_special_structure DO INSTEAD (
  DELETE FROM qgep_od.special_structure WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.wastewater_structure WHERE obj_id = OLD.obj_id;
);

