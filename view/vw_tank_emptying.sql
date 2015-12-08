DROP VIEW IF EXISTS qgep.vw_tank_emptying;


--------
-- Subclass: od_tank_emptying
-- Superclass: od_structure_part
--------
CREATE OR REPLACE VIEW qgep.vw_tank_emptying AS

SELECT
   TE.obj_id
   , TE.flow
   , TE.gross_costs
   , TE.type
   , TE.year_of_replacement
   , SP.identifier
   , SP.remark
   , SP.renovation_demand
   , SP.dataowner
   , SP.provider
   , SP.last_modification
  , SP.fk_wastewater_structure
  FROM qgep.od_tank_emptying TE
 LEFT JOIN qgep.od_structure_part SP
 ON SP.obj_id = TE.obj_id;

-----------------------------------
-- tank_emptying INSERT
-- Function: vw_tank_emptying_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_tank_emptying_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_structure_part (
             obj_id
           , identifier
           , remark
           , renovation_demand
           , dataowner
           , provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_tank_emptying')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.renovation_demand
           , NEW.dataowner
           , NEW.provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_tank_emptying (
             obj_id
           , flow
           , gross_costs
           , type
           , year_of_replacement
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.flow
           , NEW.gross_costs
           , NEW.type
           , NEW.year_of_replacement
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_tank_emptying_ON_INSERT ON qgep.tank_emptying;

CREATE TRIGGER vw_tank_emptying_ON_INSERT INSTEAD OF INSERT ON qgep.vw_tank_emptying
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_tank_emptying_insert();

-----------------------------------
-- tank_emptying UPDATE
-- Rule: vw_tank_emptying_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_tank_emptying_ON_UPDATE AS ON UPDATE TO qgep.vw_tank_emptying DO INSTEAD (
UPDATE qgep.od_tank_emptying
  SET
       flow = NEW.flow
     , gross_costs = NEW.gross_costs
     , type = NEW.type
     , year_of_replacement = NEW.year_of_replacement
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_structure_part
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , renovation_demand = NEW.renovation_demand
           , dataowner = NEW.dataowner
           , provider = NEW.provider
           , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- tank_emptying DELETE
-- Rule: vw_tank_emptying_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_tank_emptying_ON_DELETE AS ON DELETE TO qgep.vw_tank_emptying DO INSTEAD (
  DELETE FROM qgep.od_tank_emptying WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_structure_part WHERE obj_id = OLD.obj_id;
);

