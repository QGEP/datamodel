CREATE OR REPLACE FUNCTION qgep_od.on_reach_point_update()
  RETURNS trigger AS
$BODY$
DECLARE
  rp_obj_id text;
  _ws_obj_id text;
  ne_obj_ids text[];
  ne_obj_id text;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      IF (NEW.fk_wastewater_networkelement = OLD.fk_wastewater_networkelement) THEN
        RETURN NEW;
      END IF;
      rp_obj_id = OLD.obj_id;
      ne_obj_ids := ARRAY[OLD.fk_wastewater_networkelement, NEW.fk_wastewater_networkelement];
    WHEN TG_OP = 'INSERT' THEN
      rp_obj_id = NEW.obj_id;
      ne_obj_ids := ARRAY[NEW.fk_wastewater_networkelement];
    WHEN TG_OP = 'DELETE' THEN
      rp_obj_id = OLD.obj_id;
      ne_obj_ids := ARRAY[OLD.fk_wastewater_networkelement];
  END CASE;


  UPDATE qgep_od.reach
    SET progression_geometry = progression_geometry
    WHERE fk_reach_point_from = rp_obj_id OR fk_reach_point_to = rp_obj_id; --To retrigger the calculate_length trigger on reach update

  FOREACH ne_obj_id IN ARRAY ne_obj_ids
  LOOP
      SELECT ws.obj_id INTO _ws_obj_id
      FROM qgep_od.wastewater_structure ws
      LEFT JOIN qgep_od.wastewater_networkelement ne ON ws.obj_id = ne.fk_wastewater_structure
      LEFT JOIN qgep_od.reach_point rp ON ne.obj_id = ne_obj_id;

      EXECUTE qgep_od.update_wastewater_structure_label(_ws_obj_id);
      EXECUTE qgep_od.update_depth(_ws_obj_id);
  END LOOP;

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;