-- Function: qgep.fn_profile(text)

-- DROP FUNCTION qgep.fn_profile(text);

CREATE OR REPLACE FUNCTION qgep.fn_profile(reach text)
  RETURNS json AS
$BODY$
-- Function to create a profile for a set of reaches
--
-- Usage example: SELECT qgep.fn_profile('r1,r2,r3...');
-- Returns: profile JSON
DECLARE returnValue json;
DECLARE line json;
DECLARE lineStart json;
DECLARE lineEnd json;
DECLARE structure json;
DECLARE structureLevel json;

DECLARE rp_from character varying (500);
DECLARE rp_to character varying (500);
DECLARE rp_struct character varying (500);
DECLARE r qgep.vw_network_segment%rowtype;
DECLARE s qgep.vw_network_segment%rowtype;
DECLARE reFrom qgep.vw_network_node%rowtype;
DECLARE reTo qgep.vw_network_node%rowtype;
DECLARE res qgep.vw_network_node%rowtype;
DECLARE lastStartOffset float;
DECLARE lastStartOffsetTmp float;
DECLARE lastEndOffset float;
DECLARE lastStructOffset float DEFAULT 0.0;
DECLARE startLevel float DEFAULT 0.0;
DECLARE endLevel float DEFAULT 0.0;

DECLARE arr json[];

BEGIN

lastStartOffset = 0.0;
-- We need reaches in a specific order. The order is the order in downstream network.
FOR r IN (
SELECT * FROM (
	WITH RECURSIVE walk_network AS (
	    SELECT *
		FROM qgep.vw_network_segment
		WHERE ST_StartPoint(progression_geometry) = (
			SELECT ST_StartPoint(ST_LineMerge(ST_Multi(ST_Union(progression_geometry))))
			FROM qgep.vw_network_segment
			WHERE obj_id IN (SELECT unnest(string_to_array(reach,',')))
		)
		AND type='reach'
	  UNION ALL
	    SELECT n.*
	    FROM qgep.vw_network_segment n, walk_network w
	    WHERE ST_DWithin(ST_EndPoint(w.progression_geometry),ST_StartPoint(n.progression_geometry),0.01) AND n.type='reach'
	    AND ST_asText(ST_EndPoint(w.progression_geometry)) != (
		SELECT ST_asText(ST_EndPoint(ST_LineMerge(ST_Multi(ST_Union(progression_geometry)))))
		FROM qgep.vw_network_segment
		WHERE obj_id IN (SELECT unnest(string_to_array(reach,',')))
	    )
	  )
	SELECT *
	FROM walk_network
) as tbl
)
LOOP
-- We set the offset based on length_full
	lastEndOffset = lastStartOffset + r.length_full;

-- We get from object id
	rp_from = r.from_obj_id;

	SELECT * INTO reFrom FROM qgep.vw_network_node WHERE obj_id=rp_from;

-- We construct the first backflow element for reaches
	SELECT row_to_json(ls) into lineStart 
	FROM (
		SELECT 
			CASE WHEN reFrom.backflow_level IS NULL THEN null ELSE ROUND(reFrom.backflow_level,1) END as "backflowLevel",
			CASE WHEN reFrom.cover_level IS NULL THEN null ELSE ROUND(reFrom.cover_level,1) END as "coverLevel",
			'node' as "type", 
			lastStartOffset as "offset"
		) as ls;

	startLevel = CASE WHEN reFrom.level IS NULL THEN 0.0 ELSE reFrom.level END;

	lastStartOffsetTmp = lastStartOffset;
	lastStartOffset = lastEndOffset;

-- We get to object id	
	rp_to = r.to_obj_id;
	
	SELECT * INTO reTo FROM qgep.vw_network_node WHERE obj_id=rp_to;

-- We construct the second backflow element for reaches
	SELECT row_to_json(le) into lineEnd 
	FROM (
		SELECT 
			CASE WHEN reTo.backflow_level IS NULL THEN null ELSE ROUND(reTo.backflow_level,1) END as "backflowLevel",
			CASE WHEN reTo.cover_level IS NULL THEN null ELSE ROUND(reTo.cover_level,1) END as "coverLevel",
			'node' as "type", 
			lastEndOffset as "offset"
		) as le;

	endLevel = CASE WHEN reTo.level IS NULL THEN 0.0 ELSE reTo.level END;

-- We construct the reach element
	SELECT row_to_json(l) into line FROM 
		(
		SELECT endLevel as "globEndLevel",
		CASE WHEN r.clear_height IS NULL THEN 0.0 ELSE (r.clear_height::float)/1000 END as "width_m",
		ROUND(r.usage_current,1) as "usageCurrent",
		lastEndOffset as "endOffset",
		(startLevel-endLevel)/r.length_full as "gradient",
		(SELECT MAX(tbl.level) FROM (SELECT startLevel as level UNION SELECT endLevel) as tbl) as "startLevel",
		r.material as "material", 
		startLevel as "globStartLevel",
		r.length_full as "length",
		r.gid as "gid",
		r.obj_id as "objId",
		lastStartOffsetTmp as "startOffset",
		(SELECT MIN(tbl.level) FROM (SELECT startLevel as level UNION SELECT endLevel) as tbl) as "endLevel",
		(
			SELECT array_to_json(array_agg(row_to_json(rp)))
			FROM (
				SELECT reFrom.obj_id as "objId",CASE WHEN reFrom.level IS NULL THEN 0.0 ELSE reFrom.level END as "level",0 as "pos", lastStartOffset as "offset"
				UNION
				SELECT reTo.obj_id as "objId",CASE WHEN reTo.level IS NULL THEN 0.0 ELSE reTo.level END as "level",1 as "pos", lastEndOffset as "offset"
			) as rp
		) as "reachPoints",
		r.type as "type"
		) as l;

-- We add reaches to result
	arr = array_append(arr,lineStart);
	arr = array_append(arr,line);
	arr = array_append(arr,lineEnd);

-- Now it's time to build elements for structures
	lastStructOffset = lastStructOffset + r.length_full;

	SELECT obj_id INTO rp_struct FROM qgep.vw_network_segment WHERE from_obj_id=r.to_obj_id AND gid!=r.gid ORDER BY gid LIMIT 1;
	
	FOR s IN (SELECT * FROM qgep.vw_network_segment WHERE obj_id=rp_struct)
	LOOP
		IF s.to_obj_id = s.obj_id THEN
			rp_from = s.from_obj_id;
		END IF;
		IF s.from_obj_id = s.obj_id THEN
			rp_to = s.to_obj_id;
		END IF;
	END LOOP;
	
	SELECT * INTO reFrom FROM qgep.vw_network_node WHERE obj_id=rp_from;
	SELECT * INTO reTo FROM qgep.vw_network_node WHERE obj_id=rp_to;
	SELECT * INTO res FROM qgep.vw_network_node WHERE obj_id=rp_struct;

-- We construct the backflow element for structures
	SELECT row_to_json(sl) into structureLevel FROM 
	(
		SELECT 
			CASE WHEN res.backflow_level IS NULL THEN null ELSE ROUND(res.backflow_level,1) END as "backflowLevel",
			CASE WHEN res.cover_level IS NULL THEN 0.0 ELSE ROUND(res.cover_level,1) END as "coverLevel",
			'node' as "type",
			lastStructOffset as "offset"
	) as sl;
	
-- We construct the structure element
	SELECT row_to_json(st) into structure FROM 
	(
		SELECT 
			CASE WHEN reTo.level IS NULL THEN '0.0' ELSE reTo.level END as "globEndLevel",
			'manhole' as "nodeType",
			res.description as "description",
			lastStructOffset as "endOffset",
			(SELECT MAX(tbl.level) FROM (SELECT CASE WHEN reTo.level IS NULL THEN 0.0 ELSE reTo.level END UNION SELECT CASE WHEN reFrom.level IS NULL THEN 0.0 ELSE reFrom.level END UNION SELECT CASE WHEN res.level IS NULL THEN 0.0 ELSE res.level END) as tbl) as "startLevel",
			CASE WHEN s.bottom_level IS NULL THEN 0.0 ELSE s.bottom_level END as "bottomLevel",
			lastStructOffset as "wwNodeOffset",
			CASE WHEN reFrom.level IS NULL THEN '0.0' ELSE reFrom.level END as "globStartLevel",
			s.gid as "gid",
			s.obj_id as "objId",
			lastStructOffset as "startOffset",
			(SELECT MIN(tbl.level) FROM (SELECT CASE WHEN reTo.level IS NULL THEN 0.0 ELSE reTo.level END UNION SELECT CASE WHEN reFrom.level IS NULL THEN 0.0 ELSE reFrom.level END UNION SELECT CASE WHEN res.level IS NULL THEN 0.0 ELSE res.level END) as tbl) as "endLevel",
			ROUND(res.usage_current,1) as "usageCurrent",
			( 
				SELECT array_to_json(array_agg(row_to_json(sp)))
				FROM (
					SELECT reFrom.obj_id as "objId", CASE WHEN reFrom.level IS NULL THEN '0.0' ELSE reFrom.level END as "level", 0 as "pos", lastStructOffset as "offset"
					UNION
					SELECT reTo.obj_id as "objId", CASE WHEN reTo.level IS NULL THEN '0.0' ELSE reTo.level END as "level", 1 as "pos", lastStructOffset as "offset"
					UNION
					SELECT res.obj_id as "objId", CASE WHEN res.level IS NULL THEN '0.0' ELSE res.level END as "level", 0 as "pos", lastStructOffset as "offset"
				) as sp
			) as "reachPoints",
			s.type as "type",
			CASE WHEN res.cover_level IS NULL THEN 0.0 ELSE res.cover_level END as "coverLevel"
	) as st;
	
-- We add structure to result
	arr = array_append(arr,structureLevel);
	arr = array_append(arr,structure);
END LOOP;
returnValue = array_to_json(arr);
RETURN returnValue;
END$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;


-- Function: qgep.fn_downstream(integer)

-- DROP FUNCTION qgep.fn_downstream(integer);

CREATE OR REPLACE FUNCTION qgep.fn_downstream(IN "integer" integer)
  RETURNS TABLE(geometry geometry, reaches text) AS
$BODY$
-- Function to create a downstream starting from one reach
--
-- Usage example: SELECT qgep.fn_downstream(reach_gid);
-- Returns: TABLE(geometry geometry, reaches text) 
WITH RECURSIVE walk_network(id, progression_geometry, obj_id) AS (
    SELECT gid, progression_geometry,obj_id FROM qgep.vw_network_segment WHERE type='reach' AND gid = $1
  UNION ALL
    SELECT n.gid, n.progression_geometry, n.obj_id
    FROM qgep.vw_network_segment n, walk_network w
    WHERE ST_DWithin(ST_EndPoint(w.progression_geometry),ST_StartPoint(n.progression_geometry),0.01) AND n.type='reach'
  )
SELECT ST_Multi(ST_Union(progression_geometry)) as geometry,string_agg(obj_id,',') as reaches
FROM walk_network;
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100
  ROWS 1000;


-- Function: qgep.fn_upstream(integer)

-- DROP FUNCTION qgep.fn_upstream(integer);

CREATE OR REPLACE FUNCTION qgep.fn_upstream(IN "integer" integer)
  RETURNS TABLE(geometry geometry, reaches text) AS
$BODY$
-- Function to create a upstream starting from one reach
--
-- Usage example: SELECT qgep.fn_upstream(reach_gid);
-- Returns: TABLE(geometry geometry, reaches text) 
SELECT geometry, reaches
FROM (
WITH RECURSIVE walk_network(id, progression_geometry, obj_id) AS (
    SELECT gid, progression_geometry, obj_id FROM qgep.vw_network_segment WHERE type='reach' AND gid = $1
  UNION ALL
    SELECT n.gid, n.progression_geometry, n.obj_id
    FROM qgep.vw_network_segment n, walk_network w
    WHERE ST_DWithin(ST_StartPoint(w.progression_geometry),ST_EndPoint(n.progression_geometry),0.01) AND n.type='reach'
  )
SELECT ST_Multi(ST_Union(progression_geometry)) as geometry,string_agg(obj_id,',') as reaches
FROM walk_network) as tbl;
$BODY$
  LANGUAGE sql IMMUTABLE
  COST 100
  ROWS 1000;


-- Function: qgep.fn_reach_for_downstream(character varying)

-- DROP FUNCTION qgep.fn_reach_for_downstream(character varying);

CREATE OR REPLACE FUNCTION qgep.fn_reach_for_downstream(cover_obj_id character varying)
  RETURNS integer AS
$BODY$
-- Function to find the reach that will be used in getting the dowstream
--
-- Usage example: SELECT qgep.fn_reach_for_downstream('cover_obj_id');
-- Returns: gid
SELECT gid::integer
FROM qgep.vw_network_segment
WHERE obj_id IN (
SELECT obj_id
FROM qgep.vw_qgep_reach
WHERE (rp_from_fk_wastewater_networkelement = (
SELECT wn_obj_id FROM qgep.vw_qgep_cover
WHERE obj_id=cover_obj_id
) OR
 rp_to_fk_wastewater_networkelement = (
SELECT wn_obj_id FROM qgep.vw_qgep_cover
WHERE obj_id=cover_obj_id
) 
)
AND 
ST_Dwithin(ST_EndPoint(qgep.vw_qgep_reach.progression_geometry),
	(SELECT situation_geometry FROM qgep.vw_qgep_cover
	WHERE obj_id=cover_obj_id),0.1)
) LIMIT 1;$BODY$
  LANGUAGE sql VOLATILE
  COST 100;


-- Function: qgep.fn_reach_for_upstream(character varying)

-- DROP FUNCTION qgep.fn_reach_for_upstream(character varying);

CREATE OR REPLACE FUNCTION qgep.fn_reach_for_upstream(cover_obj_id character varying)
  RETURNS integer AS
$BODY$
-- Function to find the reach that will be used in getting the upstream
--
-- Usage example: SELECT qgep.fn_reach_for_upstream('cover_obj_id');
-- Returns: gid
SELECT gid::integer
FROM qgep.vw_network_segment
WHERE obj_id IN (
SELECT obj_id
FROM qgep.vw_qgep_reach
WHERE (rp_from_fk_wastewater_networkelement = (
SELECT wn_obj_id FROM qgep.vw_qgep_cover
WHERE obj_id=cover_obj_id
) OR
 rp_to_fk_wastewater_networkelement = (
SELECT wn_obj_id FROM qgep.vw_qgep_cover
WHERE obj_id=cover_obj_id
) 
)
AND 
ST_Dwithin(ST_StartPoint(qgep.vw_qgep_reach.progression_geometry),
	(SELECT situation_geometry FROM qgep.vw_qgep_cover
	WHERE obj_id=cover_obj_id),0.1)
) LIMIT 1;$BODY$
  LANGUAGE sql VOLATILE
  COST 100;