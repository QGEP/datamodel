-- Views for network following with the Python NetworkX module and the QGEP Python plugins

/*
This generates a graph representing the network.
It also provides backwards-compatible views for the plugin.
*/

CREATE SCHEMA qgep_network;

CREATE TABLE qgep_network.node (
  id SERIAL PRIMARY KEY,
  node_type TEXT, -- one of wasterwater_node, reachpoint or blind_connection
  ne_id TEXT NULL REFERENCES qgep_od.wastewater_networkelement(obj_id), -- reference to the network element (this will reference the reach object for reachpoints)
  rp_id TEXT NULL REFERENCES qgep_od.reach_point(obj_id), -- will only be set for reachpoints
  geom geometry('POINT', 2056)
);

CREATE TABLE qgep_network.segment (
  id SERIAL PRIMARY KEY,
  segment_type TEXT, -- either reach (if it's a reach segment) or junction (if it represents junction from/to a reachpoint)
  from_node INT REFERENCES qgep_network.node(id),
  to_node INT REFERENCES qgep_network.node(id),
  ne_id TEXT NULL REFERENCES qgep_od.wastewater_networkelement(obj_id), -- reference to the network element (will only be set for segments corresponding to reaches)
  geom geometry('LINESTRING', 2056)
);

CREATE OR REPLACE FUNCTION qgep_network.refresh_network_simple() RETURNS void AS $body$
BEGIN

  TRUNCATE qgep_network.segment CASCADE;
  TRUNCATE qgep_network.node CASCADE;

  -- Insert wastewater nodes
  INSERT INTO qgep_network.node(node_type, ne_id, geom)
  SELECT
    'wastewater_node',
    n.obj_id,
    ST_Force2D(n.situation_geometry)
  FROM qgep_od.wastewater_node n;

  -- Insert reachpoints
  INSERT INTO qgep_network.node(node_type, ne_id, rp_id, geom)
  SELECT
    'reachpoint',
    r.obj_id, -- the reachpoint also keeps a reference to it's reach, as it can be used by blind connections that happen exactly on start/end points
    rp.obj_id,
    ST_Force2D(rp.situation_geometry)
  FROM qgep_od.reach_point rp
  JOIN qgep_od.reach r ON rp.obj_id = r.fk_reach_point_from OR rp.obj_id = r.fk_reach_point_to;

  -- Insert virtual nodes for blind connections
  INSERT INTO qgep_network.node(node_type, ne_id, geom)
  SELECT DISTINCT
    'blind_connection',
    r.obj_id,
    ST_ClosestPoint(r.progression_geometry, rp.situation_geometry)
  FROM qgep_od.reach r
  INNER JOIN qgep_od.reach_point rp ON rp.fk_wastewater_networkelement = r.obj_id
  WHERE ST_LineLocatePoint(ST_CurveToLine(r.progression_geometry), rp.situation_geometry) NOT IN (0.0, 1.0); -- if exactly at start or at end, we don't need a virtualnode as we have the reachpoint

  -- Insert reaches, subdivided according to blind reaches
  INSERT INTO qgep_network.segment (segment_type, from_node, to_node, ne_id, geom)
  SELECT 'reach',
         sub2.node_id_1,
         sub2.node_id_2,
         obj_id,
         ST_Line_Substring(
           ST_CurveToLine(ST_Force2D(progression_geometry)), ratio_1, ratio_2
         )
  FROM (
    -- This subquery uses LAG to combine a node with the next on a reach.
    SELECT LAG(sub1.node_id) OVER (PARTITION BY sub1.obj_id ORDER BY sub1.ratio) as node_id_1,
           sub1.node_id as node_id_2,
           sub1.progression_geometry,
           LAG(sub1.ratio) OVER (PARTITION BY sub1.obj_id ORDER BY sub1.ratio) as ratio_1,
           sub1.ratio as ratio_2,
           obj_id
    FROM (
        -- This subquery joins blind node to reach, with "ratio" being the position of the node along the reach
        SELECT r.obj_id,
               r.progression_geometry,
               n.id as node_id,
               ST_LineLocatePoint(ST_CurveToLine(r.progression_geometry), n.geom) AS ratio
        FROM qgep_od.reach r
        JOIN qgep_network.node n ON n.ne_id = r.obj_id
    ) AS sub1
  ) AS sub2
  WHERE ratio_1 IS NOT NULL AND ratio_1 <> ratio_2;

  -- Insert edge between reachpoint (from) to the closest node belonging to the wasterwater network element
  INSERT INTO qgep_network.segment (segment_type, from_node, to_node, geom)
  SELECT DISTINCT ON(n1.id)
         'junction',
         n2.id,
         n1.id,
         ST_MakeLine(n2.geom, n1.geom)
  FROM (

    SELECT
      rp.obj_id as rp_obj_id,
      rp.fk_wastewater_networkelement as wwne_id
    FROM qgep_od.reach_point rp
    JOIN qgep_od.reach r ON rp.obj_id = r.fk_reach_point_from
    WHERE rp.fk_wastewater_networkelement IS NOT NULL

  ) AS sub1
  JOIN qgep_network.node as n1 ON n1.rp_id = rp_obj_id
  JOIN qgep_network.node as n2 ON n2.ne_id = wwne_id
  ORDER BY n1.id, ST_Distance(n1.geom, n2.geom);

  -- Insert edge between reachpoint (to) to the closest node belonging to the wasterwater network element
  INSERT INTO qgep_network.segment (segment_type, from_node, to_node, geom)
  SELECT DISTINCT ON(n1.id)
         'junction',
         n1.id,
         n2.id,
         ST_MakeLine(n1.geom, n2.geom)
  FROM (

    SELECT
      rp.obj_id as rp_obj_id,
      rp.fk_wastewater_networkelement as wwne_id
    FROM qgep_od.reach_point rp
    JOIN qgep_od.reach r ON rp.obj_id = r.fk_reach_point_to
    WHERE rp.fk_wastewater_networkelement IS NOT NULL

  ) AS sub1
  JOIN qgep_network.node as n1 ON n1.rp_id = rp_obj_id
  JOIN qgep_network.node as n2 ON n2.ne_id = wwne_id
  ORDER BY n1.id, ST_Distance(n1.geom, n2.geom);

  REFRESH MATERIALIZED VIEW qgep_od.vw_network_node;
  REFRESH MATERIALIZED VIEW qgep_od.vw_network_segment;

END;
$body$
LANGUAGE plpgsql;


-- Retro-compatbility views, compatible with previous implementation.

DROP MATERIALIZED VIEW IF EXISTS qgep_od.vw_network_node;
DROP MATERIALIZED VIEW IF EXISTS qgep_od.vw_network_segmen;

CREATE MATERIALIZED VIEW qgep_od.vw_network_node AS
WITH cover_levels_per_network_element AS (
  SELECT ne.obj_id,
         MAX(level) as level
  FROM qgep_od.cover co
  JOIN qgep_od.structure_part sp ON co.obj_id = sp.obj_id
  JOIN qgep_od.wastewater_structure ws ON sp.fk_wastewater_structure = ws.obj_id
  JOIN qgep_od.wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
  GROUP BY ne.obj_id
)
SELECT s.id as gid,
       CASE
         WHEN node_type = 'reachpoint' THEN s.rp_id
         WHEN node_type = 'wasterwater_node' THEN s.ne_id
         ELSE s.ne_id || '-BLIND-' || row_number() OVER (PARTITION BY s.node_type, s.ne_id ORDER BY ST_X(s.geom))
       END AS obj_id,
       node_type as type,
       s.geom AS situation_geometry,
       CASE
         WHEN node_type = 'reachpoint' THEN rp.identifier
         WHEN node_type = 'wasterwater_node' THEN ne.identifier
         ELSE ne.identifier || '-BLIND-' || row_number() OVER (PARTITION BY s.node_type, s.ne_id ORDER BY ST_X(s.geom))
       END AS description,
       rp.level as level,
       n.bottom_level as bottom_level,
       co.level as cover_level
FROM qgep_network.node s
LEFT JOIN qgep_od.reach_point rp ON rp_id = rp.obj_id
LEFT JOIN qgep_od.wastewater_networkelement ne ON ne_id = ne.obj_id
LEFT JOIN qgep_od.wastewater_node n ON ne_id = n.obj_id
LEFT JOIN cover_levels_per_network_element co ON ne_id = co.obj_id AND node_type = 'wastewater_node';

CREATE MATERIALIZED VIEW qgep_od.vw_network_segment AS
SELECT s.id as gid,
       s.geom AS progression_geometry,
       COALESCE(ne_id, '') AS obj_id, -- plugin can't pickle QVariant NULLs
       s.segment_type AS type,
       n1.obj_id AS from_obj_id,
       n2.obj_id AS to_obj_id,
       n1.obj_id AS from_obj_id_interpolate,
       n2.obj_id AS to_obj_id_interpolate,
       0 AS from_pos,
       1 AS to_pos,
       ST_Length(geom) AS length_calc,
       r.clear_height AS clear_height,
       s.geom AS detail_geometry
FROM qgep_network.segment s
JOIN qgep_od.vw_network_node n1 ON n1.gid = s.from_node
JOIN qgep_od.vw_network_node n2 ON n2.gid = s.to_node
LEFT JOIN qgep_od.reach r ON r.obj_id = s.ne_id;
