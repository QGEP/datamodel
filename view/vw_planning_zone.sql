DROP VIEW IF EXISTS qgep.vw_planning_zone;


--------
-- Subclass: od_planning_zone
-- Superclass: od_zone
--------
CREATE OR REPLACE VIEW qgep.vw_planning_zone AS

SELECT
   PL.obj_id
   , PL.kind
   , PL.perimeter_geometry
   , ZO.identifier
   , ZO.remark
   , ZO.dataowner
   , ZO.provider
   , ZO.last_modification
  FROM qgep.od_planning_zone PL
 LEFT JOIN qgep.od_zone ZO
 ON ZO.obj_id = PL.obj_id;

-----------------------------------
-- planning_zone INSERT
-- Function: vw_planning_zone_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_planning_zone_insert()
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
     VALUES ( qgep.generate_oid('od_planning_zone') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_planning_zone (
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

-- DROP TRIGGER vw_planning_zone_ON_INSERT ON qgep.planning_zone;

CREATE TRIGGER vw_planning_zone_ON_INSERT INSTEAD OF INSERT ON qgep.vw_planning_zone
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_planning_zone_insert();

-----------------------------------
-- planning_zone UPDATE
-- Rule: vw_planning_zone_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_planning_zone_ON_UPDATE AS ON UPDATE TO qgep.vw_planning_zone DO INSTEAD (
UPDATE qgep.od_planning_zone
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
-- planning_zone DELETE
-- Rule: vw_planning_zone_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_planning_zone_ON_DELETE AS ON DELETE TO qgep.vw_planning_zone DO INSTEAD (
  DELETE FROM qgep.od_planning_zone WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_zone WHERE obj_id = OLD.obj_id;
);

