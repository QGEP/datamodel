DROP VIEW IF EXISTS qgep_od.vw_benching;


--------
-- Subclass: benching
-- Superclass: structure_part
--------
CREATE OR REPLACE VIEW qgep_od.vw_benching AS

SELECT
   BE.obj_id
   , BE.kind
   , SP.identifier
   , SP.remark
   , SP.renovation_demand
   , SP.fk_dataowner
   , SP.fk_provider
   , SP.last_modification
  , SP.fk_wastewater_structure
  FROM qgep_od.benching BE
 LEFT JOIN qgep_od.structure_part SP
 ON SP.obj_id = BE.obj_id;

-----------------------------------
-- benching INSERT
-- Function: vw_benching_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_benching_insert()
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
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','benching')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.renovation_demand
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.benching (
             obj_id
           , kind
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.kind
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_benching_ON_INSERT ON qgep_od.benching;

CREATE TRIGGER vw_benching_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_benching
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_benching_insert();

-----------------------------------
-- benching UPDATE
-- Rule: vw_benching_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_benching_ON_UPDATE AS ON UPDATE TO qgep_od.vw_benching DO INSTEAD (
UPDATE qgep_od.benching
  SET
       kind = NEW.kind
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
-- benching DELETE
-- Rule: vw_benching_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_benching_ON_DELETE AS ON DELETE TO qgep_od.vw_benching DO INSTEAD (
  DELETE FROM qgep_od.benching WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.structure_part WHERE obj_id = OLD.obj_id;
);

