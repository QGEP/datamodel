-- Moving from 2d to 3d geometry; LV95=2056 (av03=21781)
-- only tables with real 3d geometry
------------------------------------

--od_wastewater_structure
ALTER TABLE qgep.od_wastewater_structure DROP COLUMN detail_geometry3d_geometry;
ALTER TABLE qgep.od_wastewater_structure ADD COLUMN detail_geometry3d_geometry geometry(CurvePolygonZ, :SRID);
UPDATE qgep.od_wastewater_structure SET detail_geometry3d_geometry = st_force3d(detail_geometry_geometry);
ALTER TABLE qgep.od_wastewater_structure DROP COLUMN detail_geometry_geometry CASCADE;
ALTER TABLE qgep.od_wastewater_structure RENAME COLUMN detail_geometry3d_geometry TO detail_geometry_geometry;

--od_reach
ALTER TABLE qgep.od_reach DROP COLUMN progression3d_geometry;
ALTER TABLE qgep.od_reach ADD COLUMN progression3d_geometry geometry(CompoundCurveZ, :SRID);
UPDATE qgep.od_reach SET progression3d_geometry = st_force3d(progression_geometry);
ALTER TABLE qgep.od_reach DROP COLUMN progression_geometry CASCADE;
ALTER TABLE qgep.od_reach RENAME COLUMN progression3d_geometry TO progression_geometry;

