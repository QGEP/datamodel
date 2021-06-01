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
Check...DIFFERENCES FOUND
functions
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
- ('qgep_od', 'vw_cover_insert', None, "\nBEGIN\n  INSERT INTO qgep_od.structur
- ('qgep_od', 'vw_qgep_reach_insert', None, "\nBEGIN\n  -- Synchronize geometry
- ('qgep_od', 'vw_qgep_reach_on_update', None, "\nBEGIN\n\n  -- Synchronize geo
- ('qgep_od', 'vw_qgep_wastewater_structure_delete', None, '\nDECLARE\nBEGIN\n
- ('qgep_od', 'vw_qgep_wastewater_structure_insert', None, "\nBEGIN\n\n  NEW.id
- ('qgep_od', 'vw_qgep_wastewater_structure_update', None, "\nDECLARE\n  dx flo
columns
sequences
constraints
views
rules
indexes
triggers
tables
*/

-- 1. Remove stray elements

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
DROP FUNCTION IF EXISTS qgep_od.vw_cover_insert();
-- CASCADE required for the following calls, as at this point, the view and its trigger may not yet be dropped
-- They will be recreated anyways. This would not be useful if we always ran drop_views in a pre-all step
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_reach_insert() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_reach_on_update() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_wastewater_structure_delete() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_wastewater_structure_insert() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_wastewater_structure_update() CASCADE;


-- 2. Recreate inconsistent functions (copied from 06_symbology_functions.sql)

-----------------------------------------------------------------------
-- Drop Symbology Triggers
-- To temporarily disable these cache refreshes for batch jobs like migrations
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_sys.drop_symbology_triggers() RETURNS VOID AS $$
BEGIN
  DROP TRIGGER IF EXISTS on_reach_point_update ON qgep_od.reach_point;
  DROP TRIGGER IF EXISTS on_reach_2_change ON qgep_od.reach;
  DROP TRIGGER IF EXISTS on_reach_1_delete ON qgep_od.reach;
  DROP TRIGGER IF EXISTS on_wastewater_structure_update ON qgep_od.wastewater_structure;
  DROP TRIGGER IF EXISTS ws_label_update_by_wastewater_networkelement ON qgep_od.wastewater_networkelement;
  DROP TRIGGER IF EXISTS on_structure_part_change ON qgep_od.structure_part;
  DROP TRIGGER IF EXISTS on_cover_change ON qgep_od.cover;
  DROP TRIGGER IF EXISTS on_wasterwaternode_change ON qgep_od.wastewater_node;
  DROP TRIGGER IF EXISTS ws_symbology_update_by_reach ON qgep_od.reach;
  DROP TRIGGER IF EXISTS ws_symbology_update_by_channel ON qgep_od.channel;
  DROP TRIGGER IF EXISTS ws_symbology_update_by_reach_point ON qgep_od.reach_point;
  DROP TRIGGER IF EXISTS calculate_reach_length ON qgep_od.reach;
  RETURN;
END;
$$ LANGUAGE plpgsql;

-----------------------------------------------------------------------
-- Create Symbology Triggers
-----------------------------------------------------------------------

CREATE OR REPLACE FUNCTION qgep_sys.create_symbology_triggers() RETURNS VOID AS $$
BEGIN
  -- only update -> insert and delete are handled by reach trigger
  CREATE TRIGGER on_reach_point_update
  AFTER UPDATE
    ON qgep_od.reach_point
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_reach_point_update();

  CREATE TRIGGER on_reach_2_change
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_reach_change();

  CREATE TRIGGER on_reach_1_delete
  AFTER DELETE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_reach_delete();

  CREATE TRIGGER calculate_reach_length
  BEFORE INSERT OR UPDATE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.calculate_reach_length();

  CREATE TRIGGER ws_symbology_update_by_reach
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.reach
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.ws_symbology_update_by_reach();

  CREATE TRIGGER on_wastewater_structure_update
  AFTER UPDATE
    ON qgep_od.wastewater_structure
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_wastewater_structure_update();

  CREATE TRIGGER ws_label_update_by_wastewater_networkelement
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.wastewater_networkelement
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_structure_part_change_networkelement();

  CREATE TRIGGER on_structure_part_change
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.structure_part
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_structure_part_change_networkelement();

  CREATE TRIGGER on_cover_change
  AFTER INSERT OR UPDATE OR DELETE
    ON qgep_od.cover
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_cover_change();

  CREATE TRIGGER on_wasterwaternode_change
  AFTER INSERT OR UPDATE
    ON qgep_od.wastewater_node
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_wasterwaternode_change();

  CREATE TRIGGER ws_symbology_update_by_channel
  AFTER INSERT OR UPDATE OR DELETE
  ON qgep_od.channel
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.ws_symbology_update_by_channel();

  -- only update -> insert and delete are handled by reach trigger
  CREATE TRIGGER ws_symbology_update_by_reach_point
  AFTER UPDATE
    ON qgep_od.reach_point
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.ws_symbology_update_by_reach_point();


  RETURN;
END;
$$ LANGUAGE plpgsql;
