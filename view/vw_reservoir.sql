DROP VIEW IF EXISTS qgep.vw_reservoir;


--------
-- Subclass: od_reservoir
-- Superclass: od_connection_object
--------
CREATE OR REPLACE VIEW qgep.vw_reservoir AS

SELECT
   RV.obj_id
   , RV.location_name
   , RV.situation_geometry
   , CN.identifier
   , CN.remark
   , CN.sewer_infiltration_water_production
   , CN.dataowner
   , CN.provider
   , CN.last_modification
  , CN.fk_wastewater_networkelement
  , CN.fk_owner
  , CN.fk_operator
  FROM qgep.od_reservoir RV
 LEFT JOIN qgep.od_connection_object CN
 ON CN.obj_id = RV.obj_id;

-----------------------------------
-- reservoir INSERT
-- Function: vw_reservoir_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_reservoir_insert()
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
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_reservoir')) -- obj_id
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

INSERT INTO qgep.od_reservoir (
             obj_id
           , location_name
           , situation_geometry
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.location_name
           , NEW.situation_geometry
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_reservoir_ON_INSERT ON qgep.reservoir;

CREATE TRIGGER vw_reservoir_ON_INSERT INSTEAD OF INSERT ON qgep.vw_reservoir
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_reservoir_insert();

-----------------------------------
-- reservoir UPDATE
-- Rule: vw_reservoir_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_reservoir_ON_UPDATE AS ON UPDATE TO qgep.vw_reservoir DO INSTEAD (
UPDATE qgep.od_reservoir
  SET
       location_name = NEW.location_name
     , situation_geometry = NEW.situation_geometry
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
-- reservoir DELETE
-- Rule: vw_reservoir_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_reservoir_ON_DELETE AS ON DELETE TO qgep.vw_reservoir DO INSTEAD (
  DELETE FROM qgep.od_reservoir WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_connection_object WHERE obj_id = OLD.obj_id;
);

