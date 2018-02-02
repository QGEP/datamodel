DROP VIEW IF EXISTS qgep_od.vw_private;


--------
-- Subclass: private
-- Superclass: organisation
--------
CREATE OR REPLACE VIEW qgep_od.vw_private AS

SELECT
   PR.obj_id
   , PR.kind
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep_od.private PR
 LEFT JOIN qgep_od.organisation OG
 ON OG.obj_id = PR.obj_id;

-----------------------------------
-- private INSERT
-- Function: vw_private_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_private_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.organisation (
             obj_id
           , identifier
           , remark
           , uid
           , fk_dataowner
           , fk_provider
           , last_modification
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','private')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.private (
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

-- DROP TRIGGER vw_private_ON_INSERT ON qgep_od.private;

CREATE TRIGGER vw_private_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_private
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_private_insert();

-----------------------------------
-- private UPDATE
-- Rule: vw_private_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_private_ON_UPDATE AS ON UPDATE TO qgep_od.vw_private DO INSTEAD (
UPDATE qgep_od.private
  SET
       kind = NEW.kind
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.organisation
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , uid = NEW.uid
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- private DELETE
-- Rule: vw_private_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_private_ON_DELETE AS ON DELETE TO qgep_od.vw_private DO INSTEAD (
  DELETE FROM qgep_od.private WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.organisation WHERE obj_id = OLD.obj_id;
);

