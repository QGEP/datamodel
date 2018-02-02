DROP VIEW IF EXISTS qgep_od.vw_municipality;


--------
-- Subclass: municipality
-- Superclass: organisation
--------
CREATE OR REPLACE VIEW qgep_od.vw_municipality AS

SELECT
   MU.obj_id
   , MU.altitude
   , MU.gwdp_year
   , MU.municipality_number
   , MU.perimeter_geometry
   , MU.population
   , MU.total_surface
   , OG.identifier
   , OG.remark
   , OG.uid
   , OG.fk_dataowner
   , OG.fk_provider
   , OG.last_modification
  FROM qgep_od.municipality MU
 LEFT JOIN qgep_od.organisation OG
 ON OG.obj_id = MU.obj_id;

-----------------------------------
-- municipality INSERT
-- Function: vw_municipality_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_municipality_insert()
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
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','municipality')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.municipality (
             obj_id
           , altitude
           , gwdp_year
           , municipality_number
           , perimeter_geometry
           , population
           , total_surface
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.altitude
           , NEW.gwdp_year
           , NEW.municipality_number
           , NEW.perimeter_geometry
           , NEW.population
           , NEW.total_surface
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_municipality_ON_INSERT ON qgep_od.municipality;

CREATE TRIGGER vw_municipality_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_municipality
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_municipality_insert();

-----------------------------------
-- municipality UPDATE
-- Rule: vw_municipality_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_municipality_ON_UPDATE AS ON UPDATE TO qgep_od.vw_municipality DO INSTEAD (
UPDATE qgep_od.municipality
  SET
       altitude = NEW.altitude
     , gwdp_year = NEW.gwdp_year
     , municipality_number = NEW.municipality_number
     , perimeter_geometry = NEW.perimeter_geometry
     , population = NEW.population
     , total_surface = NEW.total_surface
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
-- municipality DELETE
-- Rule: vw_municipality_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_municipality_ON_DELETE AS ON DELETE TO qgep_od.vw_municipality DO INSTEAD (
  DELETE FROM qgep_od.municipality WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.organisation WHERE obj_id = OLD.obj_id;
);

