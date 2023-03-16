

CREATE OR REPLACE RULE reach_on_delete AS
    ON DELETE TO qgep_od.reach DO ALSO ( 
 DELETE FROM qgep_od.wastewater_networkelement
  WHERE wastewater_networkelement.obj_id::text = old.obj_id::text;
 DELETE FROM qgep_od.reach_point
  WHERE reach_point.obj_id::text = old.fk_reach_point_from::text;
 DELETE FROM qgep_od.reach_point
  WHERE reach_point.obj_id::text = old.fk_reach_point_to::text;
);