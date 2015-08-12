DROP VIEW IF EXISTS qgep.vw_blocking_debris;

CREATE OR REPLACE VIEW qgep.vw_blocking_debris AS

SELECT
   BD.obj_id
   , BD.vertical_drop
   , CS.identifier
   , CS.remark,
CS.situation_geometry
   , CS.dataowner
   , CS.provider
   , CS.last_modification
  , CS.fk_water_course_segment
  FROM qgep.od_blocking_debris BD
 LEFT JOIN qgep.od_water_control_structure CS
 ON CS.obj_id = BD.obj_id;

-----------------------------------
-- blocking_debris INSERT
-- Function: vw_blocking_debris_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_blocking_debris_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_water_control_structure (
             obj_id
           , identifier
           , remark
            , situation_geometry
           , dataowner
           , provider
           , last_modification
           , fk_water_course_segment
           )
     VALUES ( qgep.generate_oid('od_blocking_debris') -- obj_id
           , NEW.identifier
           , NEW.remark
            , NEW.situation_geometry
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           , NEW.fk_water_course_segment
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_blocking_debris (
             obj_id
           , vertical_drop
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.vertical_drop
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_blocking_debris_ON_INSERT ON qgep.blocking_debris;

CREATE TRIGGER vw_blocking_debris_ON_INSERT INSTEAD OF INSERT ON qgep.vw_blocking_debris
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_blocking_debris_insert();

-----------------------------------
-- blocking_debris UPDATE
-- Rule: vw_blocking_debris_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_blocking_debris_ON_UPDATE AS ON UPDATE TO qgep.vw_blocking_debris DO INSTEAD (
UPDATE qgep.od_blocking_debris
  SET
       vertical_drop = NEW.vertical_drop
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_water_control_structure
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
      , situation_geometry = NEW.situation_geometry
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
     , fk_water_course_segment = NEW.fk_water_course_segment
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- blocking_debris DELETE
-- Rule: vw_blocking_debris_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_blocking_debris_ON_DELETE AS ON DELETE TO qgep.vw_blocking_debris DO INSTEAD (
  DELETE FROM qgep.od_blocking_debris WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_water_control_structure WHERE obj_id = OLD.obj_id;
);

