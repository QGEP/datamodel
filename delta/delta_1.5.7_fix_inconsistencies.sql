/*
This delta fixes some inconsistencies between the datamodel initialized
from scratch and the datamodel obtained by applying deltas with PUM that
were discovered with improvements to PUM.
*/

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

-- Activate triggers by default
SELECT qgep_sys.drop_symbology_triggers();
SELECT qgep_sys.create_symbology_triggers();


/* Drop stray functions */
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
/* it's fine cascading these, as they will be recreated in post-all */
DROP FUNCTION IF EXISTS qgep_od.vw_cover_insert() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_reach_insert() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_reach_on_update() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_wastewater_structure_delete() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_wastewater_structure_insert() CASCADE;
DROP FUNCTION IF EXISTS qgep_od.vw_qgep_wastewater_structure_update() CASCADE;
