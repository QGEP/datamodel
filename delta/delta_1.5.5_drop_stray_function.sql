-- There are inconsistencies in functions between the migrated demo data and a freshly created 
-- database, probably because paramter-less functions were overlooked by pum check
-- (see https://github.com/opengisch/pum/pull/97).

-- This can be quite error prone, e.g. for the obsolete qgep_od.drop_symbology_triggers()
-- which clashes with qgep_sys.drop_symbology_triggers(), and/or introduce nasty bugs
-- because of differences in functions btw updated demo data vs freshly created database.

-- This delta cleans things up :
--  1. it removes stray functions
--  2. it recreates functions where a difference is found


-- Inconsistencies found with pum check before this delta (inspect full function
-- source through pgadmin to see the actual difference, as most of the time it's
-- truncated) :

/*
- ('qgep_sys', 'create_symbology_triggers', None, '\nBEGIN\n  -- only update ->
+ ('qgep_sys', 'create_symbology_triggers', None, '\nBEGIN\n  -- only update ->
- ('qgep_sys', 'drop_symbology_triggers', None, '\nBEGIN\n  DROP TRIGGER IF EXI
+ ('qgep_sys', 'drop_symbology_triggers', None, '\nBEGIN\n  DROP TRIGGER IF EXI
- ('qgep_od', 'drop_symbology_triggers', None, '\nBEGIN\n  DROP TRIGGER IF EXIS
- ('qgep_od', 'ft_damage_channel_delete', None, '\n\tBEGIN\n\t\tDELETE FROM qge
- ('qgep_od', 'ft_damage_channel_insert', None, "\n\tBEGIN\n\t\tINSERT INTO qge
- ('qgep_od', 'ft_damage_channel_update', None, '\n\tBEGIN\n\tUPDATE qgep_od.da
- ('qgep_od', 'ft_damage_manhole_delete', None, '\n\tBEGIN\n\t\tDELETE FROM qge
- ('qgep_od', 'ft_damage_manhole_insert', None, "\n\tBEGIN\n\t\tINSERT INTO qge
- ('qgep_od', 'ft_damage_manhole_update', None, '\n\tBEGIN\n\tUPDATE qgep_od.da
- ('qgep_od', 'ft_maintenance_examination_delete', None, '\n\tBEGIN\n\t\tDELETE
- ('qgep_od', 'ft_maintenance_examination_insert', None, "\n\tBEGIN\n\t\tINSERT
- ('qgep_od', 'ft_maintenance_examination_update', None, '\n\tBEGIN\n\tUPDATE q
- ('qgep_od', 'ft_organisation_administrative_office_delete', None, '\n\tBEGIN\
- ('qgep_od', 'ft_organisation_administrative_office_insert', None, "\n\tBEGIN\
- ('qgep_od', 'ft_organisation_administrative_office_update', None, '\n\tBEGIN\
- ('qgep_od', 'ft_organisation_canton_delete', None, '\n\tBEGIN\n\t\tDELETE FRO
- ('qgep_od', 'ft_organisation_canton_insert', None, "\n\tBEGIN\n\t\tINSERT INT
- ('qgep_od', 'ft_organisation_canton_update', None, '\n\tBEGIN\n\tUPDATE qgep_
- ('qgep_od', 'ft_organisation_cooperative_delete', None, '\n\tBEGIN\n\t\tDELET
- ('qgep_od', 'ft_organisation_cooperative_insert', None, "\n\tBEGIN\n\t\tINSER
- ('qgep_od', 'ft_organisation_cooperative_update', None, '\n\tBEGIN\n\tUPDATE
- ('qgep_od', 'ft_organisation_municipality_delete', None, '\n\tBEGIN\n\t\tDELE
- ('qgep_od', 'ft_organisation_municipality_insert', None, "\n\tBEGIN\n\t\tINSE
- ('qgep_od', 'ft_organisation_municipality_update', None, '\n\tBEGIN\n\tUPDATE
- ('qgep_od', 'ft_organisation_private_delete', None, '\n\tBEGIN\n\t\tDELETE FR
- ('qgep_od', 'ft_organisation_private_insert', None, "\n\tBEGIN\n\t\tINSERT IN
- ('qgep_od', 'ft_organisation_private_update', None, '\n\tBEGIN\n\tUPDATE qgep
- ('qgep_od', 'ft_organisation_waste_water_association_delete', None, '\n\tBEGI
- ('qgep_od', 'ft_organisation_waste_water_association_insert', None, "\n\tBEGI
- ('qgep_od', 'ft_organisation_waste_water_association_update', None, '\n\tBEGI
- ('qgep_od', 'ft_organisation_waste_water_treatment_plant_delete', None, '\n\t
- ('qgep_od', 'ft_organisation_waste_water_treatment_plant_insert', None, "\n\t
- ('qgep_od', 'ft_organisation_waste_water_treatment_plant_update', None, '\n\t
- ('qgep_od', 'ft_overflow_leapingweir_delete', None, '\n\tBEGIN\n\t\tDELETE FR
- ('qgep_od', 'ft_overflow_leapingweir_insert', None, "\n\tBEGIN\n\t\tINSERT IN
- ('qgep_od', 'ft_overflow_leapingweir_update', None, '\n\tBEGIN\n\tUPDATE qgep
- ('qgep_od', 'ft_overflow_prank_weir_delete', None, '\n\tBEGIN\n\t\tDELETE FRO
- ('qgep_od', 'ft_overflow_prank_weir_insert', None, "\n\tBEGIN\n\t\tINSERT INT
- ('qgep_od', 'ft_overflow_prank_weir_update', None, '\n\tBEGIN\n\tUPDATE qgep_
- ('qgep_od', 'ft_overflow_pump_delete', None, '\n\tBEGIN\n\t\tDELETE FROM qgep
- ('qgep_od', 'ft_overflow_pump_insert', None, "\n\tBEGIN\n\t\tINSERT INTO qgep
- ('qgep_od', 'ft_overflow_pump_update', None, '\n\tBEGIN\n\tUPDATE qgep_od.ove
- ('qgep_od', 'ft_vw_channel_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
+ ('qgep_od', 'ft_vw_channel_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
- ('qgep_od', 'ft_vw_channel_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
+ ('qgep_od', 'ft_vw_channel_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
- ('qgep_od', 'ft_vw_discharge_point_insert', None, "\nBEGIN\nINSERT INTO qgep_
+ ('qgep_od', 'ft_vw_discharge_point_insert', None, "\nBEGIN\nINSERT INTO qgep_
- ('qgep_od', 'ft_vw_discharge_point_update', None, '\nBEGIN\nUPDATE qgep_od.wa
+ ('qgep_od', 'ft_vw_discharge_point_update', None, '\nBEGIN\nUPDATE qgep_od.wa
- ('qgep_od', 'ft_vw_manhole_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
+ ('qgep_od', 'ft_vw_manhole_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
- ('qgep_od', 'ft_vw_manhole_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
+ ('qgep_od', 'ft_vw_manhole_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
- ('qgep_od', 'ft_vw_organisation_delete', None, "\n    BEGIN\n    CASE\n
+ ('qgep_od', 'ft_vw_organisation_delete', None, "\n    BEGIN\n    CASE\n
- ('qgep_od', 'ft_vw_organisation_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  I
+ ('qgep_od', 'ft_vw_organisation_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  I
- ('qgep_od', 'ft_vw_organisation_update', None, "\nDECLARE\n  \nBEGIN\n  \n  U
+ ('qgep_od', 'ft_vw_organisation_update', None, "\nDECLARE\n  \nBEGIN\n  \n  U
- ('qgep_od', 'ft_vw_qgep_damage_delete', None, "\n    BEGIN\n    CASE\n
+ ('qgep_od', 'ft_vw_qgep_damage_delete', None, "\n    BEGIN\n    CASE\n
- ('qgep_od', 'ft_vw_qgep_damage_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  IN
+ ('qgep_od', 'ft_vw_qgep_damage_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  IN
- ('qgep_od', 'ft_vw_qgep_damage_update', None, "\nDECLARE\n  \nBEGIN\n  \n  UP
+ ('qgep_od', 'ft_vw_qgep_damage_update', None, "\nDECLARE\n  \nBEGIN\n  \n  UP
- ('qgep_od', 'ft_vw_qgep_overflow_delete', None, "\n    BEGIN\n    CASE\n
+ ('qgep_od', 'ft_vw_qgep_overflow_delete', None, "\n    BEGIN\n    CASE\n
- ('qgep_od', 'ft_vw_qgep_overflow_insert', None, "\nDECLARE\n  \nBEGIN\n  \n
+ ('qgep_od', 'ft_vw_qgep_overflow_insert', None, "\nDECLARE\n  \nBEGIN\n  \n
- ('qgep_od', 'ft_vw_qgep_overflow_update', None, "\nDECLARE\n  \nBEGIN\n  \n
+ ('qgep_od', 'ft_vw_qgep_overflow_update', None, "\nDECLARE\n  \nBEGIN\n  \n
- ('qgep_od', 'ft_vw_qgep_reach_insert', None, "\n    BEGIN\n      -- Synchroni
+ ('qgep_od', 'ft_vw_qgep_reach_insert', None, "\n    BEGIN\n      -- Synchroni
- ('qgep_od', 'ft_vw_qgep_reach_update', None, "\n    BEGIN\n    \n      -- Syn
+ ('qgep_od', 'ft_vw_qgep_reach_update', None, "\n    BEGIN\n    \n      -- Syn
- ('qgep_od', 'ft_vw_qgep_wastewater_structure_insert', None, "\n    BEGIN\n\n
+ ('qgep_od', 'ft_vw_qgep_wastewater_structure_insert', None, "\n    BEGIN\n\n
- ('qgep_od', 'ft_vw_qgep_wastewater_structure_update', None, "\n    DECLARE\n
+ ('qgep_od', 'ft_vw_qgep_wastewater_structure_update', None, "\n    DECLARE\n
- ('qgep_od', 'ft_vw_special_structure_insert', None, "\nBEGIN\nINSERT INTO qge
+ ('qgep_od', 'ft_vw_special_structure_insert', None, "\nBEGIN\nINSERT INTO qge
- ('qgep_od', 'ft_vw_special_structure_update', None, '\nBEGIN\nUPDATE qgep_od.
+ ('qgep_od', 'ft_vw_special_structure_update', None, '\nBEGIN\nUPDATE qgep_od.
- ('qgep_od', 'vw_cover_insert', None, "\nBEGIN\n  INSERT INTO qgep_od.structur
- ('qgep_od', 'vw_qgep_reach_insert', None, "\nBEGIN\n  -- Synchronize geometry
- ('qgep_od', 'vw_qgep_reach_on_update', None, "\nBEGIN\n\n  -- Synchronize geo
- ('qgep_od', 'vw_qgep_wastewater_structure_delete', None, '\nDECLARE\nBEGIN\n
- ('qgep_od', 'vw_qgep_wastewater_structure_insert', None, "\nBEGIN\n\n  NEW.id
- ('qgep_od', 'vw_qgep_wastewater_structure_update', None, "\nDECLARE\n  dx flo
*/

-- 1. Remove stray functions

DROP FUNCTION IF EXISTS qgep_od.drop_symbology_triggers();
DROP FUNCTION IF EXISTS qgep_od.ft_damage_channel_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_damage_channel_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_damage_channel_update();
DROP FUNCTION IF EXISTS qgep_od.ft_damage_manhole_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_damage_manhole_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_damage_manhole_update();
DROP FUNCTION IF EXISTS qgep_od.ft_maintenance_examination_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_maintenance_examination_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_maintenance_examination_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_administrative_office_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_administrative_office_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_administrative_office_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_canton_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_canton_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_canton_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_cooperative_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_cooperative_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_cooperative_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_municipality_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_municipality_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_municipality_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_private_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_private_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_private_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_waste_water_association_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_waste_water_association_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_waste_water_association_update();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_waste_water_treatment_plant_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_waste_water_treatment_plant_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_organisation_waste_water_treatment_plant_update();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_leapingweir_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_leapingweir_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_leapingweir_update();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_prank_weir_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_prank_weir_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_prank_weir_update();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_pump_delete();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_pump_insert();
DROP FUNCTION IF EXISTS qgep_od.ft_overflow_pump_update();

-- 2. Recreate inconsistent functions

-- TODO : these differences are still found by pum check (inspect through pgadmin
-- too see full differences)

/*
- ('qgep_sys', 'create_symbology_triggers', None, '\nBEGIN\n  -- only update ->
+ ('qgep_sys', 'create_symbology_triggers', None, '\nBEGIN\n  -- only update ->
- ('qgep_sys', 'drop_symbology_triggers', None, '\nBEGIN\n  DROP TRIGGER IF EXI
+ ('qgep_sys', 'drop_symbology_triggers', None, '\nBEGIN\n  DROP TRIGGER IF EXI

- ('qgep_od', 'ft_vw_channel_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
+ ('qgep_od', 'ft_vw_channel_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
- ('qgep_od', 'ft_vw_channel_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
+ ('qgep_od', 'ft_vw_channel_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
- ('qgep_od', 'ft_vw_discharge_point_insert', None, "\nBEGIN\nINSERT INTO qgep_
+ ('qgep_od', 'ft_vw_discharge_point_insert', None, "\nBEGIN\nINSERT INTO qgep_
- ('qgep_od', 'ft_vw_discharge_point_update', None, '\nBEGIN\nUPDATE qgep_od.wa
+ ('qgep_od', 'ft_vw_discharge_point_update', None, '\nBEGIN\nUPDATE qgep_od.wa
- ('qgep_od', 'ft_vw_manhole_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
+ ('qgep_od', 'ft_vw_manhole_insert', None, "\nBEGIN\nINSERT INTO qgep_od.waste
- ('qgep_od', 'ft_vw_manhole_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
+ ('qgep_od', 'ft_vw_manhole_update', None, '\nBEGIN\nUPDATE qgep_od.wastewater
- ('qgep_od', 'ft_vw_organisation_delete', None, "\n    BEGIN\n    CASE\n
+ ('qgep_od', 'ft_vw_organisation_delete', None, "\n    BEGIN\n    CASE\n
- ('qgep_od', 'ft_vw_organisation_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  I
+ ('qgep_od', 'ft_vw_organisation_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  I
- ('qgep_od', 'ft_vw_organisation_update', None, "\nDECLARE\n  \nBEGIN\n  \n  U
+ ('qgep_od', 'ft_vw_organisation_update', None, "\nDECLARE\n  \nBEGIN\n  \n  U
- ('qgep_od', 'ft_vw_qgep_damage_delete', None, "\n    BEGIN\n    CASE\n
+ ('qgep_od', 'ft_vw_qgep_damage_delete', None, "\n    BEGIN\n    CASE\n
- ('qgep_od', 'ft_vw_qgep_damage_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  IN
+ ('qgep_od', 'ft_vw_qgep_damage_insert', None, "\nDECLARE\n  \nBEGIN\n  \n  IN
- ('qgep_od', 'ft_vw_qgep_damage_update', None, "\nDECLARE\n  \nBEGIN\n  \n  UP
+ ('qgep_od', 'ft_vw_qgep_damage_update', None, "\nDECLARE\n  \nBEGIN\n  \n  UP
- ('qgep_od', 'ft_vw_qgep_overflow_delete', None, "\n    BEGIN\n    CASE\n
+ ('qgep_od', 'ft_vw_qgep_overflow_delete', None, "\n    BEGIN\n    CASE\n
- ('qgep_od', 'ft_vw_qgep_overflow_insert', None, "\nDECLARE\n  \nBEGIN\n  \n
+ ('qgep_od', 'ft_vw_qgep_overflow_insert', None, "\nDECLARE\n  \nBEGIN\n  \n
- ('qgep_od', 'ft_vw_qgep_overflow_update', None, "\nDECLARE\n  \nBEGIN\n  \n
+ ('qgep_od', 'ft_vw_qgep_overflow_update', None, "\nDECLARE\n  \nBEGIN\n  \n
- ('qgep_od', 'ft_vw_qgep_reach_insert', None, "\n    BEGIN\n      -- Synchroni
+ ('qgep_od', 'ft_vw_qgep_reach_insert', None, "\n    BEGIN\n      -- Synchroni
- ('qgep_od', 'ft_vw_qgep_reach_update', None, "\n    BEGIN\n    \n      -- Syn
+ ('qgep_od', 'ft_vw_qgep_reach_update', None, "\n    BEGIN\n    \n      -- Syn
- ('qgep_od', 'ft_vw_qgep_wastewater_structure_insert', None, "\n    BEGIN\n\n
+ ('qgep_od', 'ft_vw_qgep_wastewater_structure_insert', None, "\n    BEGIN\n\n
- ('qgep_od', 'ft_vw_qgep_wastewater_structure_update', None, "\n    DECLARE\n
+ ('qgep_od', 'ft_vw_qgep_wastewater_structure_update', None, "\n    DECLARE\n
- ('qgep_od', 'ft_vw_special_structure_insert', None, "\nBEGIN\nINSERT INTO qge
+ ('qgep_od', 'ft_vw_special_structure_insert', None, "\nBEGIN\nINSERT INTO qge
- ('qgep_od', 'ft_vw_special_structure_update', None, '\nBEGIN\nUPDATE qgep_od.
+ ('qgep_od', 'ft_vw_special_structure_update', None, '\nBEGIN\nUPDATE qgep_od.
- ('qgep_od', 'vw_cover_insert', None, "\nBEGIN\n  INSERT INTO qgep_od.structur
- ('qgep_od', 'vw_qgep_reach_insert', None, "\nBEGIN\n  -- Synchronize geometry
- ('qgep_od', 'vw_qgep_reach_on_update', None, "\nBEGIN\n\n  -- Synchronize geo
- ('qgep_od', 'vw_qgep_wastewater_structure_delete', None, '\nDECLARE\nBEGIN\n
- ('qgep_od', 'vw_qgep_wastewater_structure_insert', None, "\nBEGIN\n\n  NEW.id
- ('qgep_od', 'vw_qgep_wastewater_structure_update', None, "\nDECLARE\n  dx flo
*/
