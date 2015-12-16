DROP VIEW IF EXISTS qgep.vw_lake;


--------
-- Subclass: od_lake
-- Superclass: od_surface_water_bodies
--------
CREATE OR REPLACE VIEW qgep.vw_lake AS

SELECT
   LA.obj_id
   , LA.perimeter_geometry
   , CU.identifier
   , CU.remark
   , CU.fk_dataowner
   , CU.fk_provider
   , CU.last_modification
  FROM qgep.od_lake LA
 LEFT JOIN qgep.od_surface_water_bodies CU
 ON CU.obj_id = LA.obj_id;

-----------------------------------
-- lake INSERT
-- Function: vw_lake_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_lake_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_surface_water_bodies (
             obj_id
           , identifier
           , remark
           , fk_dataowner
           , fk_provider
           , last_modification
           )
     VALUES ( qgep.generate_oid('od_lake') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_lake (
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

-- DROP TRIGGER vw_lake_ON_INSERT ON qgep.lake;

CREATE TRIGGER vw_lake_ON_INSERT INSTEAD OF INSERT ON qgep.vw_lake
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_lake_insert();

-----------------------------------
-- lake UPDATE
-- Rule: vw_lake_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_lake_ON_UPDATE AS ON UPDATE TO qgep.vw_lake DO INSTEAD (
UPDATE qgep.od_lake
  SET
     , perimeter_geometry = NEW.perimeter_geometry
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_surface_water_bodies
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- lake DELETE
-- Rule: vw_lake_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_lake_ON_DELETE AS ON DELETE TO qgep.vw_lake DO INSTEAD (
  DELETE FROM qgep.od_lake WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_surface_water_bodies WHERE obj_id = OLD.obj_id;
);

