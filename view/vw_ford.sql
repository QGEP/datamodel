DROP VIEW IF EXISTS qgep.vw_ford;

CREATE OR REPLACE VIEW qgep.vw_ford AS

SELECT
   FD.obj_id
   , CS.identifier
   , CS.remark,
CS.situation_geometry
   , CS.dataowner
   , CS.provider
   , CS.last_modification
  , CS.fk_water_course_segment
  FROM qgep.od_ford FD
 LEFT JOIN qgep.od_water_control_structure CS
 ON CS.obj_id = FD.obj_id;

-----------------------------------
-- ford INSERT
-- Function: vw_ford_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_ford_insert()
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
     VALUES ( qgep.generate_oid('od_ford') -- obj_id
           , NEW.identifier
           , NEW.remark
            , NEW.situation_geometry
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           , NEW.fk_water_course_segment
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_ford (
             obj_id
           )
          VALUES (
            NEW.obj_id -- obj_id
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_ford_ON_INSERT ON qgep.ford;

CREATE TRIGGER vw_ford_ON_INSERT INSTEAD OF INSERT ON qgep.vw_ford
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_ford_insert();

-----------------------------------
-- ford UPDATE
-- Rule: vw_ford_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_ford_ON_UPDATE AS ON UPDATE TO qgep.vw_ford DO INSTEAD (
--------
-- UPDATE qgep.od_ford
--  SET
--  WHERE obj_id = OLD.obj_id;
--------

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
-- ford DELETE
-- Rule: vw_ford_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_ford_ON_DELETE AS ON DELETE TO qgep.vw_ford DO INSTEAD (
  DELETE FROM qgep.od_ford WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_water_control_structure WHERE obj_id = OLD.obj_id;
);

