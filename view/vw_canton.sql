DROP VIEW IF EXISTS qgep_od.vw_canton;


--------
-- Subclass: canton
-- Superclass: organisation
--------
CREATE OR REPLACE VIEW qgep_od.vw_canton AS

SELECT
   CT.obj_id
   , CT.perimeter_geometry
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep_od.canton CT
 LEFT JOIN qgep_od.organisation OG
 ON OG.obj_id = CT.obj_id;

-----------------------------------
-- canton INSERT
-- Function: vw_canton_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_canton_insert()
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
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','canton')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.canton (
             obj_id
           , perimeter_geometry
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.perimeter_geometry
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_canton_ON_INSERT ON qgep_od.canton;

CREATE TRIGGER vw_canton_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_canton
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_canton_insert();

-----------------------------------
-- canton UPDATE
-- Rule: vw_canton_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_canton_ON_UPDATE AS ON UPDATE TO qgep_od.vw_canton DO INSTEAD (
UPDATE qgep_od.canton
  SET
     , perimeter_geometry = NEW.perimeter_geometry
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
-- canton DELETE
-- Rule: vw_canton_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_canton_ON_DELETE AS ON DELETE TO qgep_od.vw_canton DO INSTEAD (
  DELETE FROM qgep_od.canton WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.organisation WHERE obj_id = OLD.obj_id;
);

