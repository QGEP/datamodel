
CREATE OR REPLACE FUNCTION qgep_od.on_wastewater_networkelement_delete()
  RETURNS trigger AS
$BODY$
DECLARE
  channel_id text;
  reach_count integer;
BEGIN
  -- delete channel if no reach left
  SELECT COUNT(fk_wastewater_structure) INTO reach_count
    FROM qgep_od.wastewater_networkelement
    WHERE fk_wastewater_structure = OLD.fk_wastewater_structure;
  IF reach_count = 0 THEN
    RAISE NOTICE 'Removing channel (%%) since no reach are left', OLD.fk_wastewater_structure;
    DELETE FROM qgep_od.channel WHERE obj_id = OLD.fk_wastewater_structure;
    DELETE FROM qgep_od.wastewater_structure WHERE obj_id = OLD.fk_wastewater_structure;
  END IF;
  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;


CREATE TRIGGER on_wastewater_networkelement_delete
  AFTER DELETE
  ON qgep_od.wastewater_networkelement
  FOR EACH ROW
  EXECUTE PROCEDURE qgep_od.on_wastewater_networkelement_delete();