DROP VIEW IF EXISTS qgep.vw_administrative_office;


--------
-- Subclass: od_administrative_office
-- Superclass: od_organisation
--------
CREATE OR REPLACE VIEW qgep.vw_administrative_office AS

SELECT
   AO.obj_id
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep.od_administrative_office AO
 LEFT JOIN qgep.od_organisation OG
 ON OG.obj_id = AO.obj_id;

-----------------------------------
-- administrative_office INSERT
-- Function: vw_administrative_office_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_administrative_office_insert()
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
     VALUES ( qgep.generate_oid('od_administrative_office') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_administrative_office (
             obj_id
           )
          VALUES (
            NEW.obj_id -- obj_id
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_administrative_office_ON_INSERT ON qgep.administrative_office;

CREATE TRIGGER vw_administrative_office_ON_INSERT INSTEAD OF INSERT ON qgep.vw_administrative_office
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_administrative_office_insert();

-----------------------------------
-- administrative_office UPDATE
-- Rule: vw_administrative_office_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_administrative_office_ON_UPDATE AS ON UPDATE TO qgep.vw_administrative_office DO INSTEAD (
--------
-- UPDATE qgep.od_administrative_office
--  SET
--  WHERE obj_id = OLD.obj_id;
--------

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
-- administrative_office DELETE
-- Rule: vw_administrative_office_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_administrative_office_ON_DELETE AS ON DELETE TO qgep.vw_administrative_office DO INSTEAD (
  DELETE FROM qgep.od_administrative_office WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_organisation WHERE obj_id = OLD.obj_id;
);

