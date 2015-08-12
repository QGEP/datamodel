DROP VIEW IF EXISTS qgep.vw_building;

CREATE OR REPLACE VIEW qgep.vw_building AS

SELECT
   BU.obj_id
   , BU.house_number
   , BU.location_name
   , BU.perimeter_geometry
   , BU.reference_point_geometry
   , CN.identifier
   , CN.remark
   , CN.sewer_infiltration_water_production
   , CN.dataowner
   , CN.provider
   , CN.last_modification
  , CN.fk_wastewater_networkelement
  , CN.fk_owner
  , CN.fk_operator
  FROM qgep.od_building BU
 LEFT JOIN qgep.od_connection_object CN
 ON CN.obj_id = BU.obj_id;

-----------------------------------
-- building INSERT
-- Function: vw_building_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_building_insert()
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
     VALUES ( qgep.generate_oid('od_building') -- obj_id
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

INSERT INTO qgep.od_building (
             obj_id
           , house_number
           , location_name
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.house_number
           , NEW.location_name
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_building_ON_INSERT ON qgep.building;

CREATE TRIGGER vw_building_ON_INSERT INSTEAD OF INSERT ON qgep.vw_building
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_building_insert();

-----------------------------------
-- building UPDATE
-- Rule: vw_building_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_building_ON_UPDATE AS ON UPDATE TO qgep.vw_building DO INSTEAD (
UPDATE qgep.od_building
  SET
       house_number = NEW.house_number
     , location_name = NEW.location_name
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
-- building DELETE
-- Rule: vw_building_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_building_ON_DELETE AS ON DELETE TO qgep.vw_building DO INSTEAD (
  DELETE FROM qgep.od_building WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_connection_object WHERE obj_id = OLD.obj_id;
);

