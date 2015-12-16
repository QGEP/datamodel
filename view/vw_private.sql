DROP VIEW IF EXISTS qgep.vw_private;


--------
-- Subclass: od_private
-- Superclass: od_organisation
--------
CREATE OR REPLACE VIEW qgep.vw_private AS

SELECT
   PR.obj_id
   , PR.kind
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep.od_private PR
 LEFT JOIN qgep.od_organisation OG
 ON OG.obj_id = PR.obj_id;

-----------------------------------
-- private INSERT
-- Function: vw_private_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_private_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_organisation (
             obj_id
           , identifier
           , remark
           , uid
           , fk_dataowner
           , fk_provider
           , last_modification
           )
     VALUES ( qgep.generate_oid('od_private') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_private (
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

-- DROP TRIGGER vw_private_ON_INSERT ON qgep.private;

CREATE TRIGGER vw_private_ON_INSERT INSTEAD OF INSERT ON qgep.vw_private
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_private_insert();

-----------------------------------
-- private UPDATE
-- Rule: vw_private_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_private_ON_UPDATE AS ON UPDATE TO qgep.vw_private DO INSTEAD (
UPDATE qgep.od_private
  SET
       kind = NEW.kind
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_organisation
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

CREATE OR REPLACE RULE vw_private_ON_DELETE AS ON DELETE TO qgep.vw_private DO INSTEAD (
  DELETE FROM qgep.od_private WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_organisation WHERE obj_id = OLD.obj_id;
);

