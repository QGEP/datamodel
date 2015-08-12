DROP VIEW IF EXISTS qgep.vw_infiltration_zone;

CREATE OR REPLACE VIEW qgep.vw_infiltration_zone AS

SELECT
   IZ.obj_id
   , IZ.infiltration_capacity
   , IZ.perimeter_geometry
   , ZO.identifier
   , ZO.remark
   , ZO.dataowner
   , ZO.provider
   , ZO.last_modification
  FROM qgep.od_infiltration_zone IZ
 LEFT JOIN qgep.od_zone ZO
 ON ZO.obj_id = IZ.obj_id;

-----------------------------------
-- infiltration_zone INSERT
-- Function: vw_infiltration_zone_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_infiltration_zone_insert()
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
     VALUES ( qgep.generate_oid('od_infiltration_zone') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_infiltration_zone (
             obj_id
           , infiltration_capacity
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.infiltration_capacity
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_infiltration_zone_ON_INSERT ON qgep.infiltration_zone;

CREATE TRIGGER vw_infiltration_zone_ON_INSERT INSTEAD OF INSERT ON qgep.vw_infiltration_zone
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_infiltration_zone_insert();

-----------------------------------
-- infiltration_zone UPDATE
-- Rule: vw_infiltration_zone_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_infiltration_zone_ON_UPDATE AS ON UPDATE TO qgep.vw_infiltration_zone DO INSTEAD (
UPDATE qgep.od_infiltration_zone
  SET
       infiltration_capacity = NEW.infiltration_capacity
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
-- infiltration_zone DELETE
-- Rule: vw_infiltration_zone_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_infiltration_zone_ON_DELETE AS ON DELETE TO qgep.vw_infiltration_zone DO INSTEAD (
  DELETE FROM qgep.od_infiltration_zone WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_zone WHERE obj_id = OLD.obj_id;
);

