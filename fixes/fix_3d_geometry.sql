--Moving from 2d to 3d geometry
-----------------------------------

--od_accident
ALTER TABLE qgep.od_accident
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_accident
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_accident
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_accident
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_aquifier
ALTER TABLE qgep.od_aquifier
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_aquifier
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_aquifier
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_aquifier
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_bathing_area
ALTER TABLE qgep.od_bathing_area
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_bathing_area
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_bathing_area
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_bathing_area
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_building
ALTER TABLE qgep.od_building
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_building
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_building
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_building
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_building
ALTER TABLE qgep.od_building
ADD COLUMN reference_point3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_building
set reference_point3d_geometry = st_force3d(reference_point_geometry);

ALTER TABLE qgep.od_building
DROP COLUMN reference_point_geometry CASCADE;

ALTER TABLE qgep.od_building
RENAME COLUMN reference_point3d_geometry TO reference_point_geometry;

--od_canton
ALTER TABLE qgep.od_canton
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_canton
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_canton
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_canton
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_catchment_area
ALTER TABLE qgep.od_catchment_area
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_catchment_area
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_catchment_area
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_catchment_area
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_catchment_area_text
ALTER TABLE qgep.od_catchment_area_text
ADD COLUMN textpos3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_catchment_area_text
set textpos3d_geometry = st_force3d(textpos_geometry);

ALTER TABLE qgep.od_catchment_area_text
DROP COLUMN textpos_geometry CASCADE;

ALTER TABLE qgep.od_catchment_area_text
RENAME COLUMN textpos3d_geometry TO textpos_geometry;

--od_control_center
ALTER TABLE qgep.od_control_center
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_control_center
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_control_center
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_control_center
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_cover
ALTER TABLE qgep.od_cover
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_cover
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_cover
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_cover
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_drainage_system
ALTER TABLE qgep.od_drainage_system
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_drainage_system
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_drainage_system
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_drainage_system
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_fountain
ALTER TABLE qgep.od_fountain
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_fountain
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_fountain
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_fountain
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_ground_water_protection_perimeter
ALTER TABLE qgep.od_ground_water_protection_perimeter
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_ground_water_protection_perimeter
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_ground_water_protection_perimeter
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_ground_water_protection_perimeter
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_ground_water_protection_zone
ALTER TABLE qgep.od_groundwater_protection_zone
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_groundwater_protection_zone
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_groundwater_protection_zone
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_groundwater_protection_zone
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_hazard_source
ALTER TABLE qgep.od_hazard_source
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_hazard_source
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_hazard_source
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_hazard_source
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_individual_surface
ALTER TABLE qgep.od_individual_surface
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_individual_surface
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_individual_surface
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_individual_surface
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--qgep.od_infiltration_zone
ALTER TABLE qgep.od_infiltration_zone
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_infiltration_zone
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_infiltration_zone
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_infiltration_zone
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_lake
ALTER TABLE qgep.od_lake
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_lake
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_lake
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_lake
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_measuring_point
ALTER TABLE qgep.od_measuring_point
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_measuring_point
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_measuring_point
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_measuring_point
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_municipality
ALTER TABLE qgep.od_municipality
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_municipality
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_municipality
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_municipality
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_planning_zone
ALTER TABLE qgep.od_planning_zone
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_planning_zone
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_planning_zone
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_planning_zone
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_reach
UPDATE qgep.od_reach
set progression3d_geometry = st_force3d(progression_geometry);

ALTER TABLE qgep.od_reach
DROP COLUMN progression_geometry CASCADE;

ALTER TABLE qgep.od_reach
RENAME COLUMN progression3d_geometry TO progression_geometry;

--od_reach_point
ALTER TABLE qgep.od_reach_point
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_reach_point
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_reach_point
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_reach_point
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_reach_text
ALTER TABLE qgep.od_reach_text
ADD COLUMN textpos3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_reach_text
set textpos3d_geometry = st_force3d(textpos_geometry);

ALTER TABLE qgep.od_reach_text
DROP COLUMN textpos_geometry CASCADE;

ALTER TABLE qgep.od_reach_text
RENAME COLUMN textpos3d_geometry TO textpos_geometry;

--od_reservoir
ALTER TABLE qgep.od_reservoir
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_reservoir
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_reservoir
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_reservoir
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_sector_water_body
ALTER TABLE qgep.od_sector_water_body
ADD COLUMN progression3d_geometry geometry(CompoundCurveZ,2056);

UPDATE qgep.od_sector_water_body
set progression3d_geometry = st_force3d(progression_geometry);

ALTER TABLE qgep.od_sector_water_body
DROP COLUMN progression_geometry CASCADE;

ALTER TABLE qgep.od_sector_water_body
RENAME COLUMN progression3d_geometry TO progression_geometry;

--od_wastewater_node
ALTER TABLE qgep.od_wastewater_node
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_wastewater_node
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_wastewater_node
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_wastewater_node
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_wastewater_structure
UPDATE qgep.od_wastewater_structure
set detail_geometry3d_geometry = st_force3d(detail_geometry_geometry);

ALTER TABLE qgep.od_wastewater_structure
DROP COLUMN detail_geometry_geometry CASCADE;

ALTER TABLE qgep.od_wastewater_structure
RENAME COLUMN detail_geometry3d_geometry TO detail_geometry_geometry;

--od_wastewater_structure_symbol
ALTER TABLE qgep.od_wastewater_structure_symbol
ADD COLUMN symbolpos3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_wastewater_structure_symbol
set symbolpos3d_geometry = st_force3d(symbolpos_geometry);

ALTER TABLE qgep.od_wastewater_structure_symbol
DROP COLUMN symbolpos_geometry CASCADE;

ALTER TABLE qgep.od_wastewater_structure_symbol
RENAME COLUMN symbolpos3d_geometry TO symbolpos_geometry;

--od_wastewater_structure_text
ALTER TABLE qgep.od_wastewater_structure_text
ADD COLUMN textpos3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_wastewater_structure_text
set textpos3d_geometry = st_force3d(textpos_geometry);

ALTER TABLE qgep.od_wastewater_structure_text
DROP COLUMN textpos_geometry CASCADE;

ALTER TABLE qgep.od_wastewater_structure_text
RENAME COLUMN textpos3d_geometry TO textpos_geometry;

--od_water_body_protection_sector
ALTER TABLE qgep.od_water_body_protection_sector
ADD COLUMN perimeter3d_geometry geometry(CurvePolygonZ,2056);

UPDATE qgep.od_water_body_protection_sector
set perimeter3d_geometry = st_force3d(perimeter_geometry);

ALTER TABLE qgep.od_water_body_protection_sector
DROP COLUMN perimeter_geometry CASCADE;

ALTER TABLE qgep.od_water_body_protection_sector
RENAME COLUMN perimeter3d_geometry TO perimeter_geometry;

--od_water_catchment
ALTER TABLE qgep.od_water_catchment
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_water_catchment
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_water_catchment
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_water_catchment
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_water_control_structure
ALTER TABLE qgep.od_water_control_structure
ADD COLUMN situation3d_geometry geometry(PointZ,2056);

UPDATE qgep.od_water_control_structure
set situation3d_geometry = st_force3d(situation_geometry);

ALTER TABLE qgep.od_water_control_structure
DROP COLUMN situation_geometry CASCADE;

ALTER TABLE qgep.od_water_control_structure
RENAME COLUMN situation3d_geometry TO situation_geometry;

--od_water_course_segment
ALTER TABLE qgep.od_water_course_segment
ADD COLUMN from_geometry3d geometry(PointZ,2056);

UPDATE qgep.od_water_course_segment
set from_geometry3d = st_force3d(from_geometry);

ALTER TABLE qgep.od_water_course_segment
DROP COLUMN from_geometry CASCADE;

ALTER TABLE qgep.od_water_course_segment
RENAME COLUMN from_geometry3d TO from_geometry;

--od_water_course_segment
ALTER TABLE qgep.od_water_course_segment
ADD COLUMN to_geometry3d geometry(PointZ,2056);

UPDATE qgep.od_water_course_segment
set to_geometry3d = st_force3d(to_geometry);

ALTER TABLE qgep.od_water_course_segment
DROP COLUMN to_geometry CASCADE;

ALTER TABLE qgep.od_water_course_segment
RENAME COLUMN to_geometry3d TO to_geometry;

--txt_symbol
ALTER TABLE qgep.txt_symbol
ADD COLUMN symbolpos3d_geometry geometry(PointZ,2056);

UPDATE qgep.txt_symbol
set symbolpos3d_geometry = st_force3d(symbolpos_geometry);

ALTER TABLE qgep.txt_symbol
DROP COLUMN symbolpos_geometry CASCADE;

ALTER TABLE qgep.txt_symbol
RENAME COLUMN symbolpos3d_geometry TO symbolpos_geometry;

--txt_text
ALTER TABLE qgep.txt_text
ADD COLUMN textpos3d_geometry geometry(PointZ,2056);

UPDATE qgep.txt_text
set textpos3d_geometry = st_force3d(textpos_geometry);

ALTER TABLE qgep.txt_text
DROP COLUMN textpos_geometry CASCADE;

ALTER TABLE qgep.txt_text
RENAME COLUMN textpos3d_geometry TO textpos_geometry;




