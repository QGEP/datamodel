CREATE OR REPLACE FUNCTION qgep_od.on_wasterwaternode_change()
  RETURNS trigger AS
$BODY$
DECLARE
  co_obj_id TEXT;
  affected_sp RECORD;
BEGIN
  CASE
    WHEN TG_OP = 'UPDATE' THEN
      co_obj_id = OLD.obj_id;
    WHEN TG_OP = 'INSERT' THEN
      co_obj_id = NEW.obj_id;
    WHEN TG_OP = 'DELETE' THEN
      co_obj_id = OLD.obj_id;
  END CASE;

  SELECT ne.fk_wastewater_structure INTO affected_sp
  FROM qgep_od.wastewater_networkelement ne
  WHERE obj_id = co_obj_id;

  EXECUTE qgep_od.update_depth(affected_sp.fk_wastewater_structure);

  RETURN NEW;
END; $BODY$
LANGUAGE plpgsql VOLATILE;



CREATE TRIGGER on_wasterwaternode_change
  AFTER INSERT OR UPDATE
    ON qgep_od.wastewater_node
  FOR EACH ROW
    EXECUTE PROCEDURE qgep_od.on_wasterwaternode_change();