DROP VIEW IF EXISTS qgep_od.vw_cover;


--------
-- Subclass: cover
-- Superclass: structure_part
--------
CREATE OR REPLACE VIEW qgep_od.vw_cover AS

SELECT
   CO.obj_id
   , CO.brand
   , CO.cover_shape
   , CO.diameter
   , CO.fastening
   , CO.level
   , CO.material
   , CO.positional_accuracy
   , CO.situation_geometry
   , CO.sludge_bucket
   , CO.venting
   , SP.identifier
   , SP.remark
   , SP.renovation_demand
   , SP.fk_dataowner
   , SP.fk_provider
   , SP.last_modification
  , SP.fk_wastewater_structure
  FROM qgep_od.cover CO
 LEFT JOIN qgep_od.structure_part SP
 ON SP.obj_id = CO.obj_id;

-----------------------------------
-- cover INSERT
-- Function: vw_cover_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_cover_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.structure_part (
             obj_id
           , identifier
           , remark
           , renovation_demand
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','cover')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.renovation_demand
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.cover (
             obj_id
           , brand
           , cover_shape
           , diameter
           , fastening
           , level
           , material
           , positional_accuracy
           , situation_geometry
           , sludge_bucket
           , venting
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.brand
           , NEW.cover_shape
           , NEW.diameter
           , NEW.fastening
           , NEW.level
           , NEW.material
           , NEW.positional_accuracy
           , NEW.situation_geometry
           , NEW.sludge_bucket
           , NEW.venting
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_cover_ON_INSERT ON qgep_od.cover;

CREATE TRIGGER vw_cover_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_cover
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_cover_insert();

-----------------------------------
-- cover UPDATE
-- Rule: vw_cover_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_cover_ON_UPDATE AS ON UPDATE TO qgep_od.vw_cover DO INSTEAD (
UPDATE qgep_od.cover
  SET
       brand = NEW.brand
     , cover_shape = NEW.cover_shape
     , diameter = NEW.diameter
     , fastening = NEW.fastening
     , level = NEW.level
     , material = NEW.material
     , positional_accuracy = NEW.positional_accuracy
     , situation_geometry = NEW.situation_geometry
     , sludge_bucket = NEW.sludge_bucket
     , venting = NEW.venting
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.structure_part
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , renovation_demand = NEW.renovation_demand
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- cover DELETE
-- Rule: vw_cover_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_cover_ON_DELETE AS ON DELETE TO qgep_od.vw_cover DO INSTEAD (
  DELETE FROM qgep_od.cover WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.structure_part WHERE obj_id = OLD.obj_id;
);

