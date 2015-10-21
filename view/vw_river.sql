DROP VIEW IF EXISTS qgep.vw_river;


--------
-- Subclass: od_river
-- Superclass: od_surface_water_bodies
--------
CREATE OR REPLACE VIEW qgep.vw_river AS

SELECT
   RI.obj_id
   , RI.kind
   , CU.identifier
   , CU.remark
   , CU.dataowner
   , CU.provider
   , CU.last_modification
  FROM qgep.od_river RI
 LEFT JOIN qgep.od_surface_water_bodies CU
 ON CU.obj_id = RI.obj_id;

-----------------------------------
-- river INSERT
-- Function: vw_river_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_river_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_surface_water_bodies (
             obj_id
           , identifier
           , remark
           , dataowner
           , provider
           , last_modification
           )
     VALUES ( qgep.generate_oid('od_river') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_river (
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

-- DROP TRIGGER vw_river_ON_INSERT ON qgep.river;

CREATE TRIGGER vw_river_ON_INSERT INSTEAD OF INSERT ON qgep.vw_river
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_river_insert();

-----------------------------------
-- river UPDATE
-- Rule: vw_river_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_river_ON_UPDATE AS ON UPDATE TO qgep.vw_river DO INSTEAD (
UPDATE qgep.od_river
  SET
       kind = NEW.kind
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_surface_water_bodies
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- river DELETE
-- Rule: vw_river_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_river_ON_DELETE AS ON DELETE TO qgep.vw_river DO INSTEAD (
  DELETE FROM qgep.od_river WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_surface_water_bodies WHERE obj_id = OLD.obj_id;
);

