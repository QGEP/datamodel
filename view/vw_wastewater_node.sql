DROP VIEW IF EXISTS qgep.vw_wastewater_node;


--------
-- Subclass: od_wastewater_node
-- Superclass: od_wastewater_networkelement
--------
CREATE OR REPLACE VIEW qgep.vw_wastewater_node AS

SELECT
   WN.obj_id
   , WN.backflow_level
   , WN.bottom_level
   , WN.situation_geometry
   , WE.identifier
   , WE.remark
   , WE.dataowner
   , WE.provider
   , WE.last_modification
  , WE.fk_wastewater_structure
  FROM qgep.od_wastewater_node WN
 LEFT JOIN qgep.od_wastewater_networkelement WE
 ON WE.obj_id = WN.obj_id;

-----------------------------------
-- wastewater_node INSERT
-- Function: vw_wastewater_node_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_wastewater_node_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_wastewater_networkelement (
             obj_id
           , identifier
           , remark
           , dataowner
           , provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_wastewater_node')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_wastewater_node (
             obj_id
           , backflow_level
           , bottom_level
           , situation_geometry
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.backflow_level
           , NEW.bottom_level
           , NEW.situation_geometry
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_wastewater_node_ON_INSERT ON qgep.wastewater_node;

CREATE TRIGGER vw_wastewater_node_ON_INSERT INSTEAD OF INSERT ON qgep.vw_wastewater_node
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_wastewater_node_insert();

-----------------------------------
-- wastewater_node UPDATE
-- Rule: vw_wastewater_node_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_wastewater_node_ON_UPDATE AS ON UPDATE TO qgep.vw_wastewater_node DO INSTEAD (
UPDATE qgep.od_wastewater_node
  SET
       backflow_level = NEW.backflow_level
     , bottom_level = NEW.bottom_level
     , situation_geometry = NEW.situation_geometry
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_wastewater_networkelement
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- wastewater_node DELETE
-- Rule: vw_wastewater_node_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_wastewater_node_ON_DELETE AS ON DELETE TO qgep.vw_wastewater_node DO INSTEAD (
  DELETE FROM qgep.od_wastewater_node WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_wastewater_networkelement WHERE obj_id = OLD.obj_id;
);

