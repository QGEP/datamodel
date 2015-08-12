DROP VIEW IF EXISTS qgep.vw_solids_retention;

CREATE OR REPLACE VIEW qgep.vw_solids_retention AS

SELECT
   SO.obj_id
   , SO.dimensioning_value
   , SO.gross_costs
   , SO.overflow_level
   , SO.type
   , SO.year_of_replacement
   , SP.identifier
   , SP.remark
   , SP.renovation_demand
   , SP.dataowner
   , SP.provider
   , SP.last_modification
  , SP.fk_wastewater_structure
  FROM qgep.od_solids_retention SO
 LEFT JOIN qgep.od_structure_part SP
 ON SP.obj_id = SO.obj_id;

-----------------------------------
-- solids_retention INSERT
-- Function: vw_solids_retention_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_solids_retention_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_structure_part (
             obj_id
           , identifier
           , remark
           , renovation_demand
           , dataowner
           , provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( qgep.generate_oid('od_solids_retention') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.renovation_demand
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_solids_retention (
             obj_id
           , dimensioning_value
           , gross_costs
           , overflow_level
           , type
           , year_of_replacement
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.dimensioning_value
           , NEW.gross_costs
           , NEW.overflow_level
           , NEW.type
           , NEW.year_of_replacement
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_solids_retention_ON_INSERT ON qgep.solids_retention;

CREATE TRIGGER vw_solids_retention_ON_INSERT INSTEAD OF INSERT ON qgep.vw_solids_retention
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_solids_retention_insert();

-----------------------------------
-- solids_retention UPDATE
-- Rule: vw_solids_retention_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_solids_retention_ON_UPDATE AS ON UPDATE TO qgep.vw_solids_retention DO INSTEAD (
UPDATE qgep.od_solids_retention
  SET
       dimensioning_value = NEW.dimensioning_value
     , gross_costs = NEW.gross_costs
     , overflow_level = NEW.overflow_level
     , type = NEW.type
     , year_of_replacement = NEW.year_of_replacement
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_structure_part
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , renovation_demand = NEW.renovation_demand
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- solids_retention DELETE
-- Rule: vw_solids_retention_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_solids_retention_ON_DELETE AS ON DELETE TO qgep.vw_solids_retention DO INSTEAD (
  DELETE FROM qgep.od_solids_retention WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_structure_part WHERE obj_id = OLD.obj_id;
);

