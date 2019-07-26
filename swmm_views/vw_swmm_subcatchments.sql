--------
-- View for the swmm module class junction
-- 20190329 qgep code sprint SB, TP
--------
DROP VIEW IF EXISTS qgep_swmm.vw_subcatchments;

CREATE OR REPLACE VIEW qgep_swmm.vw_subcatchments AS

SELECT 
	replace(ca.obj_id, ' ', '_') as Name,
	('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as RainGage,
	coalesce(fk_wastewater_networkelement_rw_current, replace(ca.obj_id, ' ', '_')) as Outlet,
	CASE 
		when surface_area is null then st_area(perimeter_geometry)
		when surface_area < 0.01 then st_area(perimeter_geometry)
		else surface_area
	END as Area,
	25 as percImperv,
	CASE 
		WHEN wn.situation_geometry IS NOT NULL
		THEN 	
		(
		st_maxdistance(wn.situation_geometry, ST_ExteriorRing(perimeter_geometry)) 
		+ st_distance(wn.situation_geometry, ST_ExteriorRing(perimeter_geometry))
		)/2
		ELSE 
		(
		st_maxdistance(st_centroid(perimeter_geometry), ST_ExteriorRing(perimeter_geometry)) 
		+ st_distance(st_centroid(perimeter_geometry), ST_ExteriorRing(perimeter_geometry))
		)/2 
	END as Width, -- Width of overland flow path estimation
	0.5 as percSlope,
	0 as CurbLen,
	NULL as SnowPack,
	ca.identifier || ', ' || ca.remark as description,
	ca.obj_id as tag,
	ST_Simplify(ST_CurveToLine(perimeter_geometry), 5, TRUE) as geom
FROM qgep_od.catchment_area as ca
LEFT JOIN qgep_od.wastewater_networkelement we on we.obj_id = ca.fk_wastewater_networkelement_rw_current
LEFT JOIN qgep_od.wastewater_node wn on wn.obj_id = we.obj_id;

-- Creates subarea related to the subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_subareas;

CREATE OR REPLACE VIEW qgep_swmm.vw_subareas AS
SELECT 
	replace(ca.obj_id, ' ', '_') as Subcatchment,
	0.01 as NImperv,
	0.1 as NPerv,
	0.05 as SImperv,
	0.05 as SPerv,
	25 as PctZero,
	'OUTLET'::varchar as RouteTo,
	NULL::float as PctRouted,
	ca.identifier || ', ' || ca.remark as description,
	ca.obj_id::varchar as tag
FROM qgep_od.catchment_area as ca;

-- Creates a default raingage for each subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_raingages;

CREATE OR REPLACE VIEW qgep_swmm.vw_raingages AS
SELECT 
	('raingage@' || replace(ca.obj_id, ' ', '_'))::varchar as Name,
	'INTENSITY'::varchar as Format,
	'0:15'::varchar as Interval,
	'1.0'::varchar as SCF,
	'TIMESERIES default_qgep_raingage_timeserie'::varchar as Source,
	st_centroid(perimeter_geometry) as geom
FROM qgep_od.catchment_area as ca;

-- Creates default infiltration for each subcatchment
DROP VIEW IF EXISTS qgep_swmm.vw_infiltration;

CREATE OR REPLACE VIEW qgep_swmm.vw_infiltration AS
SELECT 
	replace(ca.obj_id, ' ', '_')  as Subcatchment,
	3 as MaxRate,
	0.5 as MinRate,
	4 as Decay,
	7 as DryTime,
	0 as MaxInfil
FROM qgep_od.catchment_area as ca;


-- creates coverages
DROP VIEW IF EXISTS qgep_swmm.vw_coverages;

CREATE OR REPLACE VIEW qgep_swmm.vw_coverages AS
SELECT 
	replace(ca.obj_id, ' ', '_')  as Subcatchment,
	pzk.value_en as landUse,
	round((st_area(st_intersection(ca.perimeter_geometry, pz.perimeter_geometry))/st_area(ca.perimeter_geometry))::numeric,2)*100 as percent
FROM qgep_od.catchment_area ca, qgep_od.planning_zone pz
LEFT JOIN qgep_vl.planning_zone_kind pzk on pz.kind = pzk.code
WHERE st_intersects(ca.perimeter_geometry, pz.perimeter_geometry) 
AND st_isvalid(ca.perimeter_geometry) AND st_isvalid(pz.perimeter_geometry)
ORDER BY ca.obj_id, percent DESC;