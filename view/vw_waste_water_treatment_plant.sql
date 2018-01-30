DROP VIEW IF EXISTS qgep_od.vw_waste_water_treatment_plant;


--------
-- Subclass: waste_water_treatment_plant
-- Superclass: organisation
--------
CREATE OR REPLACE VIEW qgep_od.vw_waste_water_treatment_plant AS

SELECT
   TP.obj_id
   , TP.bod5
   , TP.cod
   , TP.elimination_cod
   , TP.elimination_n
   , TP.elimination_nh4
   , TP.elimination_p
   , TP.installation_number
   , TP.kind
   , TP.NH4
   , TP.start_year
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep_od.waste_water_treatment_plant TP
 LEFT JOIN qgep_od.organisation OG
 ON OG.obj_id = TP.obj_id;

-----------------------------------
-- waste_water_treatment_plant INSERT
-- Function: vw_waste_water_treatment_plant_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_waste_water_treatment_plant_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.organisation (
             obj_id
           , identifier
           , remark
           , uid
           , fk_dataowner
           , fk_provider
           , last_modification
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','waste_water_treatment_plant')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.waste_water_treatment_plant (
             obj_id
           , bod5
           , cod
           , elimination_cod
           , elimination_n
           , elimination_nh4
           , elimination_p
           , installation_number
           , kind
           , NH4
           , start_year
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.bod5
           , NEW.cod
           , NEW.elimination_cod
           , NEW.elimination_n
           , NEW.elimination_nh4
           , NEW.elimination_p
           , NEW.installation_number
           , NEW.kind
           , NEW.NH4
           , NEW.start_year
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_waste_water_treatment_plant_ON_INSERT ON qgep_od.waste_water_treatment_plant;

CREATE TRIGGER vw_waste_water_treatment_plant_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_waste_water_treatment_plant
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_waste_water_treatment_plant_insert();

-----------------------------------
-- waste_water_treatment_plant UPDATE
-- Rule: vw_waste_water_treatment_plant_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_waste_water_treatment_plant_ON_UPDATE AS ON UPDATE TO qgep_od.vw_waste_water_treatment_plant DO INSTEAD (
UPDATE qgep_od.waste_water_treatment_plant
  SET
       bod5 = NEW.bod5
     , cod = NEW.cod
     , elimination_cod = NEW.elimination_cod
     , elimination_n = NEW.elimination_n
     , elimination_nh4 = NEW.elimination_nh4
     , elimination_p = NEW.elimination_p
     , installation_number = NEW.installation_number
     , kind = NEW.kind
     , NH4 = NEW.NH4
     , start_year = NEW.start_year
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.organisation
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , uid = NEW.uid
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- waste_water_treatment_plant DELETE
-- Rule: vw_waste_water_treatment_plant_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_waste_water_treatment_plant_ON_DELETE AS ON DELETE TO qgep_od.vw_waste_water_treatment_plant DO INSTEAD (
  DELETE FROM qgep_od.waste_water_treatment_plant WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.organisation WHERE obj_id = OLD.obj_id;
);

