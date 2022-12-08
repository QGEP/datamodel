-----------------------------------------------
-----------------------------------------------
-- Synchronize GEOMETRY with bottom_level qgep_od.wastewater_node
-----------------------------------------------
-----------------------------------------------
SELECT set_config('qgep.srid', :SRID::text, false);
DO $DO$
BEGIN
EXECUTE format($TRIGGER$
CREATE OR REPLACE FUNCTION qgep_od.synchronize_level_with_altitude_on_wastewater_node()
  RETURNS trigger AS
$BODY$
BEGIN
  CASE
    WHEN TG_OP = 'INSERT' THEN
      NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.bottom_level,'NaN') ), %1$s);
    WHEN TG_OP = 'UPDATE' THEN
      IF NEW.bottom_level <> OLD.bottom_level OR (NEW.bottom_level IS NULL AND OLD.bottom_level IS NOT NULL) OR (NEW.bottom_level IS NOT NULL AND OLD.bottom_level IS NULL) THEN
        NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.bottom_level,'NaN') ), %1$s);
      ELSE 
        IF ST_Z(NEW.situation_geometry) <> ST_Z(OLD.situation_geometry) THEN
          NEW.bottom_level = NULLIF(ST_Z(NEW.situation_geometry),'NaN');
        END IF;
      END IF;
  END CASE;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;
$TRIGGER$, current_setting('qgep.srid'));
END
$DO$;

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
SELECT set_config('qgep.srid', :SRID::text, false);
DO $DO$
BEGIN
EXECUTE format($TRIGGER$
CREATE OR REPLACE FUNCTION qgep_od.synchronize_level_with_altitude_on_cover()
  RETURNS trigger AS
$BODY$
BEGIN
  CASE
    WHEN TG_OP = 'INSERT' THEN
      NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.level,'NaN') ), %1$s);
    WHEN TG_OP = 'UPDATE' THEN
      IF NEW.level <> OLD.level OR (NEW.level IS NULL AND OLD.level IS NOT NULL) OR (NEW.level IS NOT NULL AND OLD.level IS NULL) THEN
        NEW.situation_geometry = ST_SetSRID( ST_MakePoint( ST_X(NEW.situation_geometry), ST_Y(NEW.situation_geometry), COALESCE(NEW.level,'NaN') ), %1$s);
      ELSE 
        IF ST_Z(NEW.situation_geometry) <> ST_Z(OLD.situation_geometry) THEN
          NEW.level = NULLIF(ST_Z(NEW.situation_geometry),'NaN');
        END IF;
      END IF;
  END CASE;

  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE;
$TRIGGER$, current_setting('qgep.srid'));
END
$DO$;

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



-----------------------------------------------
-----------------------------------------------
-- Interpolate z value for reach GEOMETRY
-----------------------------------------------
-----------------------------------------------
CREATE OR REPLACE FUNCTION qgep_sys.re_interpolate_vertex_z(
	re_obj_id character varying)
    RETURNS geometry
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
  pg_geom geometry(CompoundCurveZ,:SRID);
	txt_geom varchar; --ST_AsText( pg_geom). Text is altered to change vertex z value
	from_level numeric(7,3);
	to_level numeric(7,3);
	distance_ratio float; --relative distance to pg_geom's end point
	z_value numeric(7,3);
	search_string varchar;
	pt_geom geometry(Point,:SRID);

BEGIN

-- populate declared variables
from_level:= (SELECT rp.level FROM qgep_od.reach re
     LEFT JOIN qgep_od.reach_point rp ON rp.obj_id::text = re.fk_reach_point_from::text
			 WHERE re.obj_id = re_obj_id);
to_level:= (SELECT rp.level FROM qgep_od.reach re
     LEFT JOIN qgep_od.reach_point rp ON rp.obj_id::text = re.fk_reach_point_to::text
			 WHERE re.obj_id = re_obj_id);	
pg_geom:=(SELECT re.progression_geometry FROM qgep_od.reach re WHERE re.obj_id = re_obj_id)	;		 
txt_geom:=ST_AsText( pg_geom);

-- dump vertices in temp table
CREATE TEMP TABLE vertices (idx int,geom geometry(Point,:SRID));
INSERT INTO vertices
SELECT(ST_DumpPoints(ST_Force2D(pg_geom))).path[2],(ST_DumpPoints(ST_Force2D(pg_geom))).geom;
--get vertices 
FOR  counter in 1..ST_NPoints(pg_geom) loop
	pt_geom:=(SELECT geom from vertices WHERE idx=counter)
  
	distance_ratio:=ST_Length(
	 	ST_LineSubstring(
			ST_CurveToLine(
				ST_Force2D(pg_geom)
			),
			0,
			ST_LineLocatePoint(
				ST_CurveToLine(
					ST_Force2D(pg_geom)
				),
				pt_geom
			)
		)
 	)
	/ST_Length(ST_Force2D(pg_geom));
  
  --new z-value
	z_value:=round(
		(from_level*(1-distance_ratio)
		 +to_level*distance_ratio
		)::numeric
		,3);
    
	search_string:=left(
		substring(
			ST_AsText(
				pt_geom
			)
			,7)
		,-1); -- deletes 'POINT (' and ')' from 'POINT (xcoord ycoord)'
txt_geom:=replace(txt_geom,search_string||' 0',search_string||' '||z_value);	
 end loop;
DROP TABLE vertices;
 RETURN ST_GeomFromText(txt_geom,:SRID);
END
$BODY$;

ALTER FUNCTION qgep_sys.re_interpolate_vertex_z(character varying)
    OWNER TO postgres;
