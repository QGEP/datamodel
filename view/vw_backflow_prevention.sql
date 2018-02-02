DROP VIEW IF EXISTS qgep_od.vw_backflow_prevention;


--------
-- Subclass: backflow_prevention
-- Superclass: structure_part
--------
CREATE OR REPLACE VIEW qgep_od.vw_backflow_prevention AS

SELECT
   BP.obj_id
   , BP.gross_costs
   , BP.kind
   , BP.year_of_replacement
   , SP.identifier
   , SP.remark
   , SP.renovation_demand
   , SP.fk_dataowner
   , SP.fk_provider
   , SP.last_modification
  , SP.fk_wastewater_structure
  FROM qgep_od.backflow_prevention BP
 LEFT JOIN qgep_od.structure_part SP
 ON SP.obj_id = BP.obj_id;

-----------------------------------
-- backflow_prevention INSERT
-- Function: vw_backflow_prevention_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_backflow_prevention_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.structure_part (
             obj_id
           , identifier
           , remark
           , renovation_demand
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','backflow_prevention')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.renovation_demand
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.backflow_prevention (
             obj_id
           , gross_costs
           , kind
           , year_of_replacement
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.gross_costs
           , NEW.kind
           , NEW.year_of_replacement
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_backflow_prevention_ON_INSERT ON qgep_od.backflow_prevention;

CREATE TRIGGER vw_backflow_prevention_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_backflow_prevention
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_backflow_prevention_insert();

-----------------------------------
-- backflow_prevention UPDATE
-- Rule: vw_backflow_prevention_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_backflow_prevention_ON_UPDATE AS ON UPDATE TO qgep_od.vw_backflow_prevention DO INSTEAD (
UPDATE qgep_od.backflow_prevention
  SET
       gross_costs = NEW.gross_costs
     , kind = NEW.kind
     , year_of_replacement = NEW.year_of_replacement
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.structure_part
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , renovation_demand = NEW.renovation_demand
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- backflow_prevention DELETE
-- Rule: vw_backflow_prevention_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_backflow_prevention_ON_DELETE AS ON DELETE TO qgep_od.vw_backflow_prevention DO INSTEAD (
  DELETE FROM qgep_od.backflow_prevention WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.structure_part WHERE obj_id = OLD.obj_id;
);

