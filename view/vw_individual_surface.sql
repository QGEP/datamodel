DROP VIEW IF EXISTS qgep.vw_individual_surface;

CREATE OR REPLACE VIEW qgep.vw_individual_surface AS

SELECT
   IS.obj_id
   , IS.function
   , IS.inclination
   , IS.pavement
   , IS.perimeter_geometry
   , CN.identifier
   , CN.remark
   , CN.sewer_infiltration_water_production
   , CN.dataowner
   , CN.provider
   , CN.last_modification
  , CN.fk_wastewater_networkelement
  , CN.fk_owner
  , CN.fk_operator
  FROM qgep.od_individual_surface IS
 LEFT JOIN qgep.od_connection_object CN
 ON CN.obj_id = IS.obj_id;

-----------------------------------
-- individual_surface INSERT
-- Function: vw_individual_surface_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_individual_surface_insert()
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
     VALUES ( qgep.generate_oid('od_individual_surface') -- obj_id
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

INSERT INTO qgep.od_individual_surface (
             obj_id
           , function
           , inclination
           , pavement
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.function
           , NEW.inclination
           , NEW.pavement
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_individual_surface_ON_INSERT ON qgep.individual_surface;

CREATE TRIGGER vw_individual_surface_ON_INSERT INSTEAD OF INSERT ON qgep.vw_individual_surface
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_individual_surface_insert();

-----------------------------------
-- individual_surface UPDATE
-- Rule: vw_individual_surface_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_individual_surface_ON_UPDATE AS ON UPDATE TO qgep.vw_individual_surface DO INSTEAD (
UPDATE qgep.od_individual_surface
  SET
       function = NEW.function
     , inclination = NEW.inclination
     , pavement = NEW.pavement
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
-- individual_surface DELETE
-- Rule: vw_individual_surface_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_individual_surface_ON_DELETE AS ON DELETE TO qgep.vw_individual_surface DO INSTEAD (
  DELETE FROM qgep.od_individual_surface WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_connection_object WHERE obj_id = OLD.obj_id;
);

