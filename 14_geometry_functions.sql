-----------------------------------------------
-----------------------------------------------
-- Synchronize GEOMETRY with bottom_level qgep_od.wastewater_node
-----------------------------------------------
-----------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.synchronize_level_with_altitude_on_wastewater_node()
  RETURNS trigger AS
$BODY$
BEGIN
  CASE
    WHEN TG_OP = 'INSERT' THEN
      NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.bottom_level,'NaN') ), :SRID );
    WHEN TG_OP = 'UPDATE' THEN
      IF NEW.bottom_level <> OLD.bottom_level OR (NEW.bottom_level IS NULL AND OLD.bottom_level IS NOT NULL) OR (NEW.bottom_level IS NOT NULL AND OLD.bottom_level IS NULL) THEN
        NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.bottom_level,'NaN') ), :SRID );
      ELSE 
        IF ST_Z(NEW.situation_geometry) <> ST_Z(OLD.situation_geometry) THEN
          NEW.bottom_level = ST_Z(NEW.situation_geometry);
        END IF;
      END IF;
  END CASE;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS synchronize_level_with_altitude ON qgep_od.wastewater_node;

CREATE TRIGGER synchronize_level_with_altitude
  BEFORE INSERT OR UPDATE
  ON qgep_od.wastewater_node
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.synchronize_level_with_altitude_on_wastewater_node();


-----------------------------------------------
-----------------------------------------------
-- Synchronize GEOMETRY with level qgep_od.cover
-----------------------------------------------
-----------------------------------------------

CREATE OR REPLACE FUNCTION qgep_od.synchronize_level_with_altitude_on_cover()
  RETURNS trigger AS
$BODY$
BEGIN
  CASE
    WHEN TG_OP = 'INSERT' THEN
      NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.level,'NaN') ), :SRID );
    WHEN TG_OP = 'UPDATE' THEN
      IF NEW.level <> OLD.level OR (NEW.level IS NULL AND OLD.level IS NOT NULL) OR (NEW.level IS NOT NULL AND OLD.level IS NULL) THEN
        NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.level,'NaN') ), :SRID );
      ELSE 
        IF ST_Z(NEW.situation_geometry) <> ST_Z(OLD.situation_geometry) THEN
          NEW.level = ST_Z(NEW.situation_geometry);
        END IF;
      END IF;
  END CASE;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;

DROP TRIGGER IF EXISTS synchronize_level_with_altitude ON qgep_od.cover;

CREATE TRIGGER synchronize_level_with_altitude
  BEFORE INSERT OR UPDATE
  ON qgep_od.cover
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.synchronize_level_with_altitude_on_cover();


-----------------------------------------------
-----------------------------------------------
-- Synchronize reach and reach_point GEOMETRY with level qgep_od.vw_qgep_reach is implemented in vw_qgep_reach.sql
-----------------------------------------------
-----------------------------------------------