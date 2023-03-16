
DROP RULE reach_on_delete ON qgep_od.reach;


CREATE OR REPLACE FUNCTION qgep_od.on_reach_delete()
  RETURNS trigger AS
$BODY$
DECLARE
  channel_id text;
  reach_count integer;
BEGIN
  -- get channel obj_id
  SELECT fk_wastewater_structure INTO channel_id
    FROM qgep_od.wastewater_networkelement
    WHERE wastewater_networkelement.obj_id = OLD.obj_id;

  DELETE FROM qgep_od.wastewater_networkelement WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.reach_point WHERE obj_id = OLD.fk_reach_point_from;
  DELETE FROM qgep_od.reach_point WHERE obj_id = OLD.fk_reach_point_to;

  -- delete channel if no reach left
  SELECT COUNT(fk_wastewater_structure) INTO reach_count
    FROM qgep_od.wastewater_networkelement
    WHERE fk_wastewater_structure = channel_id;
  IF reach_count = 0 THEN
    RAISE NOTICE 'Removing channel (%%) since no reach is left', channel_id;
    DELETE FROM qgep_od.channel WHERE obj_id = channel_id;
    DELETE FROM qgep_od.wastewater_structure WHERE obj_id = channel_id;
  END IF;
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;

ALTER TRIGGER on_reach_change ON qgep_od.reach RENAME TO on_reach_2_change;

CREATE TRIGGER on_reach_1_delete
  AFTER DELETE
  ON qgep_od.reach
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.on_reach_delete();
