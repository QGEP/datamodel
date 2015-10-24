DROP VIEW IF EXISTS qgep.vw_municipality;


--------
-- Subclass: od_municipality
-- Superclass: od_organisation
--------
CREATE OR REPLACE VIEW qgep.vw_municipality AS

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
   , OG.dataowner
   , OG.provider
   , OG.last_modification
  FROM qgep.od_municipality MU
 LEFT JOIN qgep.od_organisation OG
 ON OG.obj_id = MU.obj_id;

-----------------------------------
-- municipality INSERT
-- Function: vw_municipality_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_municipality_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_organisation (
             obj_id
           , identifier
           , remark
           , uid
           , dataowner
           , provider
           , last_modification
           )
     VALUES ( qgep.generate_oid('od_municipality') -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.uid
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_municipality (
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

-- DROP TRIGGER vw_municipality_ON_INSERT ON qgep.municipality;

CREATE TRIGGER vw_municipality_ON_INSERT INSTEAD OF INSERT ON qgep.vw_municipality
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_municipality_insert();

-----------------------------------
-- municipality UPDATE
-- Rule: vw_municipality_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_municipality_ON_UPDATE AS ON UPDATE TO qgep.vw_municipality DO INSTEAD (
UPDATE qgep.od_municipality
  SET
       altitude = NEW.altitude
     , gwdp_year = NEW.gwdp_year
     , municipality_number = NEW.municipality_number
     , perimeter_geometry = NEW.perimeter_geometry
     , population = NEW.population
     , total_surface = NEW.total_surface
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_organisation
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , uid = NEW.uid
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- municipality DELETE
-- Rule: vw_municipality_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_municipality_ON_DELETE AS ON DELETE TO qgep.vw_municipality DO INSTEAD (
  DELETE FROM qgep.od_municipality WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_organisation WHERE obj_id = OLD.obj_id;
);

