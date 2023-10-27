--------
-- View for the swmm module class polygons
-- - Depends on qgep_swmm.vw_subcatchments
--------
CREATE OR REPLACE VIEW qgep_swmm.vw_polygons AS

--Subcatchments
SELECT
  Subcatchment,
  round(ST_X((dp).geom)::numeric,2) as X_Coord,
  round(ST_Y((dp).geom)::numeric,2) as Y_Coord,
  state,
  hierarchy,
  obj_id
  FROM (
    SELECT
      Name As Subcatchment,
      ST_DumpPoints(geom) AS dp,
      ST_NPoints(geom) as nvert,
      state,
      hierarchy,
      obj_id
      FROM qgep_swmm.vw_subcatchments
    ) as foo
WHERE (dp).path[2] != nvert

UNION ALL
--Storage nodes
SELECT
  StorageNode,
  round(ST_X((dp).geom)::numeric,2) as X_Coord,
  round(ST_Y((dp).geom)::numeric,2) as Y_Coord,
  state,
  hierarchy,
  obj_id
  FROM (
    SELECT
      Name As StorageNode,
      ST_DumpPoints(detail_geometry_geometry) AS dp,
      ST_NPoints(detail_geometry_geometry) as nvert,
      state,
      hierarchy,
      st.obj_id
      FROM qgep_swmm.vw_storages st
	  LEFT JOIN qgep_od.wastewater_networkelement ne on ne.obj_id=st.obj_id
	  LEFT JOIN qgep_od.wastewater_structure ws on ws.obj_id=ne.fk_wastewater_structure
    ) as foo
WHERE (dp).path[2] != nvert;	-- dont select last vertex
