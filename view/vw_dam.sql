DROP VIEW IF EXISTS qgep.vw_dam;


--------
-- Subclass: od_dam
-- Superclass: od_water_control_structure
--------
CREATE OR REPLACE VIEW qgep.vw_dam AS

SELECT
   DA.obj_id
   , DA.kind
   , DA.vertical_drop
   , CS.identifier
   , CS.remark,
CS.situation_geometry
   , CS.fk_dataowner
   , CS.fk_provider
   , CS.last_modification
  , CS.fk_water_course_segment
  FROM qgep.od_dam DA
 LEFT JOIN qgep.od_water_control_structure CS
 ON CS.obj_id = DA.obj_id;

-----------------------------------
-- dam INSERT
-- Function: vw_dam_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_dam_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_water_control_structure (
             obj_id
           , identifier
           , remark
            , situation_geometry
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_water_course_segment
           )
     VALUES ( qgep.generate_oid('od_dam') -- obj_id
           , NEW.identifier
           , NEW.remark
            , NEW.situation_geometry
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_water_course_segment
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_dam (
             obj_id
           , kind
           , vertical_drop
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.kind
           , NEW.vertical_drop
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_dam_ON_INSERT ON qgep.dam;

CREATE TRIGGER vw_dam_ON_INSERT INSTEAD OF INSERT ON qgep.vw_dam
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_dam_insert();

-----------------------------------
-- dam UPDATE
-- Rule: vw_dam_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_dam_ON_UPDATE AS ON UPDATE TO qgep.vw_dam DO INSTEAD (
UPDATE qgep.od_dam
  SET
       kind = NEW.kind
     , vertical_drop = NEW.vertical_drop
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_water_control_structure
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
      , situation_geometry = NEW.situation_geometry
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_water_course_segment = NEW.fk_water_course_segment
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- dam DELETE
-- Rule: vw_dam_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_dam_ON_DELETE AS ON DELETE TO qgep.vw_dam DO INSTEAD (
  DELETE FROM qgep.od_dam WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_water_control_structure WHERE obj_id = OLD.obj_id;
);

