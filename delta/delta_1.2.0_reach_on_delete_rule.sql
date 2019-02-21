DROP RULE vw_qgep_reach_on_delete ON qgep_od.vw_qgep_reach;

CREATE OR REPLACE RULE vw_qgep_reach_on_delete AS
    ON DELETE TO qgep_od.vw_qgep_reach DO INSTEAD ( DELETE FROM qgep_od.reach
  WHERE reach.obj_id::text = old.obj_id::text;
);

CREATE OR REPLACE RULE reach_on_delete AS
    ON DELETE TO qgep_od.reach DO ALSO ( 
 DELETE FROM qgep_od.wastewater_networkelement
  WHERE wastewater_networkelement.obj_id::text = old.obj_id::text;
 DELETE FROM qgep_od.reach_point
  WHERE reach_point.obj_id::text = old.fk_reach_point_from::text;
 DELETE FROM qgep_od.reach_point
  WHERE reach_point.obj_id::text = old.fk_reach_point_to::text;
);