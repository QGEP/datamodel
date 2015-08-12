DROP VIEW IF EXISTS qgep.vw_cooperative;

CREATE OR REPLACE VIEW qgep.vw_cooperative AS

SELECT
   CP.obj_id
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.dataowner
   , OG.provider
   , OG.last_modification
  FROM qgep.od_cooperative CP
 LEFT JOIN qgep.od_organisation OG
 ON OG.obj_id = CP.obj_id;

-----------------------------------
-- cooperative INSERT
-- Function: vw_cooperative_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_cooperative_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_organisation (
             obj_id
           , identifier
           , remark
           , uid
           , dataowner
           , provider
           , last_modification
           )
     VALUES ( qgep.generate_oid('od_cooperative') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_cooperative (
             obj_id
           )
          VALUES (
            NEW.obj_id -- obj_id
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_cooperative_ON_INSERT ON qgep.cooperative;

CREATE TRIGGER vw_cooperative_ON_INSERT INSTEAD OF INSERT ON qgep.vw_cooperative
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_cooperative_insert();

-----------------------------------
-- cooperative UPDATE
-- Rule: vw_cooperative_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_cooperative_ON_UPDATE AS ON UPDATE TO qgep.vw_cooperative DO INSTEAD (
--------
-- UPDATE qgep.od_cooperative
--  SET
--  WHERE obj_id = OLD.obj_id;
--------

UPDATE qgep.od_organisation
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , uid = NEW.uid
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- cooperative DELETE
-- Rule: vw_cooperative_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_cooperative_ON_DELETE AS ON DELETE TO qgep.vw_cooperative DO INSTEAD (
  DELETE FROM qgep.od_cooperative WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_organisation WHERE obj_id = OLD.obj_id;
);

