-- class water_catchment
--1. add correct fk_surface_water_bodies
ALTER TABLE IF EXISTS qgep_od.water_catchment ADD COLUMN fk_surface_water_bodies varchar (16);

-- 2. add correct CONSTRAINT
-- ALTER TABLE qgep_od.water_catchment ADD CONSTRAINT rel_water_catchment_chute FOREIGN KEY (fk_chute) REFERENCES qgep_od.surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE IF EXISTS qgep_od.water_catchment ADD CONSTRAINT rel_water_catchment_surface_water_bodies FOREIGN KEY (fk_surface_water_bodies) REFERENCES qgep_od.surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

--3. copy data from fk_chute to fk_surface_water_bodies
UPDATE qgep_od.water_catchment
SET fk_surface_water_bodies = fk_chute;

-- 4. delete old rel_water_catchment_chute constraint
ALTER TABLE IF EXISTS qgep_od.water_catchment DROP CONSTRAINT rel_water_catchment_chute;

-- 5. delete wrong fk_chute column
ALTER TABLE IF EXISTS qgep_od.water_catchment DROP COLUMN fk_chute;

-- 6. rename wrong value in qgep_sys.dictionary_od_field
-- not needed as fk_attributes are not in qgep_sys tables


-- class bathing_area
--1. add correct fk_surface_water_bodies
ALTER TABLE IF EXISTS qgep_od.bathing_area ADD COLUMN fk_surface_water_bodies varchar (16);

-- 2. add correct CONSTRAINT
-- ALTER TABLE qgep_od.bathing_area ADD CONSTRAINT rel_bathing_area_chute FOREIGN KEY (fk_chute) REFERENCES qgep_od.surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE IF EXISTS qgep_od.bathing_area ADD CONSTRAINT rel_bathing_area_surface_water_bodies FOREIGN KEY (fk_surface_water_bodies) REFERENCES qgep_od.surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

--3. copy data from fk_chute to fk_surface_water_bodies
UPDATE qgep_od.bathing_area
SET fk_surface_water_bodies = fk_chute;

-- 4. delete old rel_water_catchment_chute constraint
ALTER TABLE IF EXISTS qgep_od.bathing_area DROP CONSTRAINT rel_bathing_area_chute;

-- 5. delete wrong fk_chute column
ALTER TABLE IF EXISTS qgep_od.bathing_area DROP COLUMN fk_chute;

-- 6. rename wrong value in qgep_sys.dictionary_od_field
-- not needed as fk_attributes are not in qgep_sys tables



-- class sector_water_body
--1. add correct fk_surface_water_bodies
ALTER TABLE IF EXISTS qgep_od.sector_water_body ADD COLUMN fk_surface_water_bodies varchar (16);

-- 2. add correct CONSTRAINT
-- ALTER TABLE qgep_od.sector_water_body ADD CONSTRAINT rel_sector_water_body_chute FOREIGN KEY (fk_chute) REFERENCES qgep_od.surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE IF EXISTS qgep_od.sector_water_body ADD CONSTRAINT rel_sector_water_body_surface_water_bodies FOREIGN KEY (fk_surface_water_bodies) REFERENCES qgep_od.surface_water_bodies(obj_id) ON UPDATE CASCADE ON DELETE set null;

--3. copy data from fk_chute to fk_surface_water_bodies
UPDATE qgep_od.sector_water_body
SET fk_surface_water_bodies = fk_chute;

-- 4. delete old rel_water_catchment_chute constraint
ALTER TABLE IF EXISTS qgep_od.sector_water_body DROP CONSTRAINT rel_sector_water_body_chute;

-- 5. delete wrong fk_chute column
ALTER TABLE IF EXISTS qgep_od.sector_water_body DROP COLUMN fk_chute;

-- 6. rename wrong value in qgep_sys.dictionary_od_field
-- not needed as fk_attributes are not in qgep_sys tables
