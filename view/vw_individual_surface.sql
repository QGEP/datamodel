DROP VIEW IF EXISTS qgep_od.vw_individual_surface;


--------
-- Subclass: individual_surface
-- Superclass: connection_object
--------
CREATE OR REPLACE VIEW qgep_od.vw_individual_surface AS

SELECT
   IS.obj_id
   , IS.function
   , IS.inclination
   , IS.pavement
   , IS.perimeter_geometry
   , CN.identifier
   , CN.remark
   , CN.sewer_infiltration_water_production
   , CN.fk_dataowner
   , CN.fk_provider
   , CN.last_modification
  , CN.fk_wastewater_networkelement
  , CN.fk_owner
  , CN.fk_operator
  FROM qgep_od.individual_surface IS
 LEFT JOIN qgep_od.connection_object CN
 ON CN.obj_id = IS.obj_id;

-----------------------------------
-- individual_surface INSERT
-- Function: vw_individual_surface_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_individual_surface_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.connection_object (
             obj_id
           , identifier
           , remark
           , sewer_infiltration_water_production
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_wastewater_networkelement
           , fk_owner
           , fk_operator
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','individual_surface')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.sewer_infiltration_water_production
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_networkelement
           , NEW.fk_owner
           , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.individual_surface (
             obj_id
           , function
           , inclination
           , pavement
           , perimeter_geometry
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.function
           , NEW.inclination
           , NEW.pavement
           , NEW.perimeter_geometry
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_individual_surface_ON_INSERT ON qgep_od.individual_surface;

CREATE TRIGGER vw_individual_surface_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_individual_surface
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_individual_surface_insert();

-----------------------------------
-- individual_surface UPDATE
-- Rule: vw_individual_surface_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_individual_surface_ON_UPDATE AS ON UPDATE TO qgep_od.vw_individual_surface DO INSTEAD (
UPDATE qgep_od.individual_surface
  SET
       function = NEW.function
     , inclination = NEW.inclination
     , pavement = NEW.pavement
     , perimeter_geometry = NEW.perimeter_geometry
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.connection_object
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , sewer_infiltration_water_production = NEW.sewer_infiltration_water_production
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
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

CREATE OR REPLACE RULE vw_individual_surface_ON_DELETE AS ON DELETE TO qgep_od.vw_individual_surface DO INSTEAD (
  DELETE FROM qgep_od.individual_surface WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.connection_object WHERE obj_id = OLD.obj_id;
);

