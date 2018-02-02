DROP VIEW IF EXISTS qgep_od.vw_administrative_office;


--------
-- Subclass: administrative_office
-- Superclass: organisation
--------
CREATE OR REPLACE VIEW qgep_od.vw_administrative_office AS

SELECT
   AO.obj_id
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep_od.administrative_office AO
 LEFT JOIN qgep_od.organisation OG
 ON OG.obj_id = AO.obj_id;

-----------------------------------
-- administrative_office INSERT
-- Function: vw_administrative_office_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_administrative_office_insert()
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
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','administrative_office')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.administrative_office (
             obj_id
           )
          VALUES (
            NEW.obj_id -- obj_id
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_administrative_office_ON_INSERT ON qgep_od.administrative_office;

CREATE TRIGGER vw_administrative_office_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_administrative_office
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_administrative_office_insert();

-----------------------------------
-- administrative_office UPDATE
-- Rule: vw_administrative_office_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_administrative_office_ON_UPDATE AS ON UPDATE TO qgep_od.vw_administrative_office DO INSTEAD (
--------
-- UPDATE qgep_od.administrative_office
--  SET
--  WHERE obj_id = OLD.obj_id;
--------

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
-- administrative_office DELETE
-- Rule: vw_administrative_office_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_administrative_office_ON_DELETE AS ON DELETE TO qgep_od.vw_administrative_office DO INSTEAD (
  DELETE FROM qgep_od.administrative_office WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.organisation WHERE obj_id = OLD.obj_id;
);

