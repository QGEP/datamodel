DROP VIEW IF EXISTS qgep.vw_fountain;

CREATE OR REPLACE VIEW qgep.vw_fountain AS

SELECT
   FO.obj_id
   , FO.location_name
   , FO.situation_geometry
   , CN.identifier
   , CN.remark
   , CN.sewer_infiltration_water_production
   , CN.dataowner
   , CN.provider
   , CN.last_modification
  , CN.fk_wastewater_networkelement
  , CN.fk_owner
  , CN.fk_operator
  FROM qgep.od_fountain FO
 LEFT JOIN qgep.od_connection_object CN
 ON CN.obj_id = FO.obj_id;

-----------------------------------
-- fountain INSERT
-- Function: vw_fountain_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_fountain_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_connection_object (
             obj_id
           , identifier
           , remark
           , sewer_infiltration_water_production
           , dataowner
           , provider
           , last_modification
           , fk_wastewater_networkelement
           , fk_owner
           , fk_operator
           )
     VALUES ( qgep.generate_oid('od_fountain') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.sewer_infiltration_water_production
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           , NEW.fk_wastewater_networkelement
           , NEW.fk_owner
           , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_fountain (
             obj_id
           , location_name
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.location_name
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_fountain_ON_INSERT ON qgep.fountain;

CREATE TRIGGER vw_fountain_ON_INSERT INSTEAD OF INSERT ON qgep.vw_fountain
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_fountain_insert();

-----------------------------------
-- fountain UPDATE
-- Rule: vw_fountain_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_fountain_ON_UPDATE AS ON UPDATE TO qgep.vw_fountain DO INSTEAD (
UPDATE qgep.od_fountain
  SET
       location_name = NEW.location_name
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_connection_object
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , sewer_infiltration_water_production = NEW.sewer_infiltration_water_production
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
     , fk_wastewater_networkelement = NEW.fk_wastewater_networkelement
     , fk_owner = NEW.fk_owner
     , fk_operator = NEW.fk_operator
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- fountain DELETE
-- Rule: vw_fountain_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_fountain_ON_DELETE AS ON DELETE TO qgep.vw_fountain DO INSTEAD (
  DELETE FROM qgep.od_fountain WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_connection_object WHERE obj_id = OLD.obj_id;
);

