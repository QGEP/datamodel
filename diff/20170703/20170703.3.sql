-- Moving from 2d to 3d geometry; LV95=2056 (av03=21781)
-- only tables with real 3d geometry
------------------------------------

-- FEHLER:  kann Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry nicht löschen, weil andere Objekte davon abhängen
-- DETAIL:  Sicht qgep.vw_channel hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- Sicht qgep.vw_discharge_point hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- Sicht qgep.vw_manhole hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- Sicht qgep.vw_special_structure hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- HINT:  Verwenden Sie DROP ... CASCADE, um die abhängigen Objekte ebenfalls zu löschen.


--od_wastewater_structure
ALTER TABLE qgep.od_wastewater_structure DROP COLUMN detail_geometry3d_geometry CASCADE;
ALTER TABLE qgep.od_wastewater_structure ADD COLUMN detail_geometry3d_geometry geometry(CurvePolygonZ, :SRID);
UPDATE qgep.od_wastewater_structure SET detail_geometry3d_geometry = st_force3d(detail_geometry_geometry);
ALTER TABLE qgep.od_wastewater_structure DROP COLUMN detail_geometry_geometry CASCADE;
ALTER TABLE qgep.od_wastewater_structure RENAME COLUMN detail_geometry3d_geometry TO detail_geometry_geometry;

-- FEHLER:  kann Tabelle qgep.od_reach Spalte progression3d_geometry nicht löschen, weil andere Objekte davon abhängen
-- DETAIL:  Sicht qgep.vw_qgep_reach hängt von Tabelle qgep.od_reach Spalte progression3d_geometry ab
-- Sicht qgep.vw_reach hängt von Tabelle qgep.od_reach Spalte progression3d_geometry ab
-- HINT:  Verwenden Sie DROP ... CASCADE, um die abhängigen Objekte ebenfalls zu löschen.

--od_reach
ALTER TABLE qgep.od_reach DROP COLUMN progression3d_geometry CASCADE;
ALTER TABLE qgep.od_reach ADD COLUMN progression3d_geometry geometry(CompoundCurveZ, :SRID);
UPDATE qgep.od_reach SET progression3d_geometry = st_force3d(progression_geometry);
ALTER TABLE qgep.od_reach DROP COLUMN progression_geometry CASCADE;
ALTER TABLE qgep.od_reach RENAME COLUMN progression3d_geometry TO progression_geometry;

-- add deleted views again (versions without 3d_geometry)
-- qgep.vw_discharge_point
-- qgep.vw_manhole
-- qgep.vw_special_structure
-- qgep.vw_network_node
-- qgep.vw_reach

DO language plpgsql $$
BEGIN
  RAISE NOTICE 'Add Views qgep.vw_discharge_point, qgep.vw_manhole, qgep.vw_special_structure, qgep.vw_network_node and qgep.vw_reach again if they were deleted (datamodel/view)';
END
$$;


