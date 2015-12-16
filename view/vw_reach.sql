DROP VIEW IF EXISTS qgep.vw_reach;


--------
-- Subclass: od_reach
-- Superclass: od_wastewater_networkelement
--------
CREATE OR REPLACE VIEW qgep.vw_reach AS

SELECT
   RE.obj_id
   , RE.clear_height
   , RE.coefficient_of_friction
   , RE.elevation_determination
   , RE.horizontal_positioning
   , RE.inside_coating
   , RE.length_effective
   , RE.material
   , RE.progression_geometry
   , RE.progression_3d_geometry
   , RE.reliner_material
   , RE.reliner_nominal_size
   , RE.relining_construction
   , RE.relining_kind
   , RE.ring_stiffness
   , RE.slope_building_plan
   , RE.wall_roughness
   , WE.identifier
   , WE.remark
   , WE.fk_dataowner
   , WE.fk_provider
   , WE.last_modification
  , WE.fk_wastewater_structure
  FROM qgep.od_reach RE
 LEFT JOIN qgep.od_wastewater_networkelement WE
 ON WE.obj_id = RE.obj_id;

-----------------------------------
-- reach INSERT
-- Function: vw_reach_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_reach_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_wastewater_networkelement (
             obj_id
           , identifier
           , remark
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( qgep.generate_oid('od_reach') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_reach (
             obj_id
           , clear_height
           , coefficient_of_friction
           , elevation_determination
           , horizontal_positioning
           , inside_coating
           , length_effective
           , material
           , progression_geometry
           , progression_3d_geometry
           , reliner_material
           , reliner_nominal_size
           , relining_construction
           , relining_kind
           , ring_stiffness
           , slope_building_plan
           , wall_roughness
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.clear_height
           , NEW.coefficient_of_friction
           , NEW.elevation_determination
           , NEW.horizontal_positioning
           , NEW.inside_coating
           , NEW.length_effective
           , NEW.material
           , NEW.progression_geometry
   , NEW.progression_3d_geometry
           , NEW.reliner_material
           , NEW.reliner_nominal_size
           , NEW.relining_construction
           , NEW.relining_kind
           , NEW.ring_stiffness
           , NEW.slope_building_plan
           , NEW.wall_roughness
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_reach_ON_INSERT ON qgep.reach;

CREATE TRIGGER vw_reach_ON_INSERT INSTEAD OF INSERT ON qgep.vw_reach
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_reach_insert();

-----------------------------------
-- reach UPDATE
-- Rule: vw_reach_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_reach_ON_UPDATE AS ON UPDATE TO qgep.vw_reach DO INSTEAD (
UPDATE qgep.od_reach
  SET
       clear_height = NEW.clear_height
     , coefficient_of_friction = NEW.coefficient_of_friction
     , elevation_determination = NEW.elevation_determination
     , horizontal_positioning = NEW.horizontal_positioning
     , inside_coating = NEW.inside_coating
     , length_effective = NEW.length_effective
     , material = NEW.material
     , progression_geometry = NEW.progression_geometry
     , progression_3d_geometry = NEW.progression_3d_geometry
     , reliner_material = NEW.reliner_material
     , reliner_nominal_size = NEW.reliner_nominal_size
     , relining_construction = NEW.relining_construction
     , relining_kind = NEW.relining_kind
     , ring_stiffness = NEW.ring_stiffness
     , slope_building_plan = NEW.slope_building_plan
     , wall_roughness = NEW.wall_roughness
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_wastewater_networkelement
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- reach DELETE
-- Rule: vw_reach_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_reach_ON_DELETE AS ON DELETE TO qgep.vw_reach DO INSTEAD (
  DELETE FROM qgep.od_reach WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_wastewater_networkelement WHERE obj_id = OLD.obj_id;
);

