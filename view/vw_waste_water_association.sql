DROP VIEW IF EXISTS qgep.vw_waste_water_association;


--------
-- Subclass: od_waste_water_association
-- Superclass: od_organisation
--------
CREATE OR REPLACE VIEW qgep.vw_waste_water_association AS

SELECT
   WA.obj_id
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.dataowner
   , OG.provider
   , OG.last_modification
  FROM qgep.od_waste_water_association WA
 LEFT JOIN qgep.od_organisation OG
 ON OG.obj_id = WA.obj_id;

-----------------------------------
-- waste_water_association INSERT
-- Function: vw_waste_water_association_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_waste_water_association_insert()
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
     VALUES ( qgep.generate_oid('od_waste_water_association') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_waste_water_association (
             obj_id
           )
          VALUES (
            NEW.obj_id -- obj_id
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_waste_water_association_ON_INSERT ON qgep.waste_water_association;

CREATE TRIGGER vw_waste_water_association_ON_INSERT INSTEAD OF INSERT ON qgep.vw_waste_water_association
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_waste_water_association_insert();

-----------------------------------
-- waste_water_association UPDATE
-- Rule: vw_waste_water_association_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_waste_water_association_ON_UPDATE AS ON UPDATE TO qgep.vw_waste_water_association DO INSTEAD (
--------
-- UPDATE qgep.od_waste_water_association
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
-- waste_water_association DELETE
-- Rule: vw_waste_water_association_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_waste_water_association_ON_DELETE AS ON DELETE TO qgep.vw_waste_water_association DO INSTEAD (
  DELETE FROM qgep.od_waste_water_association WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_organisation WHERE obj_id = OLD.obj_id;
);

