--------
-- View for the swmm module class coordinates
-- 20190329 qgep code sprint SB, TP
--------

DROP VIEW IF EXISTS qgep_swmm.vw_coordinates;

CREATE OR REPLACE VIEW qgep_swmm.vw_coordinates AS

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_junctions
WHERE geom IS NOT NULL

UNION

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_outfalls
WHERE geom IS NOT NULL

-- UNION

-- SELECT
	-- Name as Node,
	-- ROUND(ST_X(geom)::numeric,2) as X_Coord,
	-- ROUND(ST_Y(geom)::numeric,2) as Y_Coord		
-- FROM qgep_swmm.vw_dividers
-- WHERE geom IS NOT NULL

UNION

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_storages
WHERE geom IS NOT NULL

UNION

SELECT
	Name as Node,
	ROUND(ST_X(geom)::numeric,2) as X_Coord,
	ROUND(ST_Y(geom)::numeric,2) as Y_Coord
FROM qgep_swmm.vw_raingages
WHERE geom IS NOT NULL;
