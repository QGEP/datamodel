-- Creates a default raingage for each status
CREATE OR REPLACE VIEW qgep_swmm.vw_raingages AS 
SELECT 
  ('raingage_' :: text || ca.state):: character varying AS name, 
  'INTENSITY' :: character varying AS format, 
  '0:15' :: character varying AS "interval", 
  '1.0' :: character varying AS scf, 
  'TIMESERIES default_qgep_raingage_timeserie' :: character varying AS source, 
  centr :: geometry(Point, 2056) AS geom, 
  ca.state, 
  'primary' :: text AS hierarchy, 
  NULL :: character varying(16) AS obj_id 
FROM 
  (
    SELECT 
      st_centroid(
        st_setsrid(
          st_extent(ca_1.perimeter_geometry):: geometry, 
          2056
        )
      ) AS centr, 
      'current' :: text AS state 
    FROM 
      qgep_od.catchment_area ca_1 
    WHERE 
      ca_1.fk_wastewater_networkelement_rw_current IS NOT NULL 
      OR ca_1.fk_wastewater_networkelement_ww_current IS NOT NULL 
    UNION 
    SELECT 
      st_centroid(
        st_setsrid(
          st_extent(ca_1.perimeter_geometry):: geometry, 
          2056
        )
      ) AS centr, 
      'planned' :: text AS state 
    FROM 
      qgep_od.catchment_area ca_1 
    WHERE 
      ca_1.fk_wastewater_networkelement_rw_planned IS NOT NULL 
      OR ca_1.fk_wastewater_networkelement_ww_planned IS NOT NULL
  ) ca;

