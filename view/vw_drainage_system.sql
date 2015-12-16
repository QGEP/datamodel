DROP VIEW IF EXISTS qgep.vw_drainage_system;


--------
-- Subclass: od_drainage_system
-- Superclass: od_zone
--------
CREATE OR REPLACE VIEW qgep.vw_drainage_system AS

SELECT
   DS.obj_id
   , DS.kind
   , DS.perimeter_geometry
   , ZO.identifier
   , ZO.remark
   , ZO.dataowner
   , ZO.provider
   , ZO.last_modification
  FROM qgep.od_drainage_system DS
 LEFT JOIN qgep.od_zone ZO
 ON ZO.obj_id = DS.obj_id;

-----------------------------------
-- drainage_system INSERT
-- Function: vw_drainage_system_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_drainage_system_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_zone (
             obj_id
           , identifier
           , remark
           , dataowner
           , provider
           , last_modification
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_drainage_system')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_drainage_system (
             obj_id
           , kind
           , perimeter_geometry
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.kind
           , NEW.perimeter_geometry
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_drainage_system_ON_INSERT ON qgep.drainage_system;

CREATE TRIGGER vw_drainage_system_ON_INSERT INSTEAD OF INSERT ON qgep.vw_drainage_system
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_drainage_system_insert();

-----------------------------------
-- drainage_system UPDATE
-- Rule: vw_drainage_system_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_drainage_system_ON_UPDATE AS ON UPDATE TO qgep.vw_drainage_system DO INSTEAD (
UPDATE qgep.od_drainage_system
  SET
       kind = NEW.kind
     , perimeter_geometry = NEW.perimeter_geometry
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_zone
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- drainage_system DELETE
-- Rule: vw_drainage_system_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_drainage_system_ON_DELETE AS ON DELETE TO qgep.vw_drainage_system DO INSTEAD (
  DELETE FROM qgep.od_drainage_system WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_zone WHERE obj_id = OLD.obj_id;
);

