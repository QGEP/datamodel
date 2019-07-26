DROP VIEW IF EXISTS qgep_swmm.vw_tags;


--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------

CREATE OR REPLACE VIEW qgep_swmm.vw_tags AS

SELECT
	'Node' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_junctions
WHERE tag IS NOT NULL

UNION 

SELECT
	'Node' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_outfalls
WHERE tag IS NOT NULL

UNION 

SELECT
	'Node' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_storages
WHERE tag IS NOT NULL

UNION 

SELECT
	'Link' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_conduits
WHERE tag IS NOT NULL

UNION 

SELECT
	'Link' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_pumps
WHERE tag IS NOT NULL

UNION

SELECT
	'Subcatch' as type,
	name as name,
	tag as value
FROM qgep_swmm.vw_subcatchments
WHERE tag IS NOT NULL