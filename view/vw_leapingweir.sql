DROP VIEW IF EXISTS qgep_od.vw_leapingweir;


--------
-- Subclass: leapingweir
-- Superclass: overflow
--------
CREATE OR REPLACE VIEW qgep_od.vw_leapingweir AS

SELECT
   LW.obj_id
   , LW.length
   , LW.opening_shape
   , LW.width
   , OF.actuation
   , OF.adjustability
   , OF.brand
   , OF.control
   , OF.discharge_point
   , OF.function
   , OF.gross_costs
   , OF.identifier
   , OF.qon_dim
   , OF.remark
   , OF.signal_transmission
   , OF.subsidies
   , OF.fk_dataowner
   , OF.fk_provider
   , OF.last_modification
  , OF.fk_wastewater_node
  , OF.fk_overflow_to
  , OF.fk_overflow_characteristic
  , OF.fk_control_center
  FROM qgep_od.leapingweir LW
 LEFT JOIN qgep_od.overflow OF
 ON OF.obj_id = LW.obj_id;

-----------------------------------
-- leapingweir INSERT
-- Function: vw_leapingweir_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep_od.vw_leapingweir_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep_od.overflow (
             obj_id
           , actuation
           , adjustability
           , brand
           , control
           , discharge_point
           , function
           , gross_costs
           , identifier
           , qon_dim
           , remark
           , signal_transmission
           , subsidies
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_wastewater_node
           , fk_overflow_to
           , fk_overflow_characteristic
           , fk_control_center
           )
     VALUES ( COALESCE(NEW.obj_id,qgep_sys.generate_oid('qgep_od','leapingweir')) -- obj_id
           , NEW.actuation
           , NEW.adjustability
           , NEW.brand
           , NEW.control
           , NEW.discharge_point
           , NEW.function
           , NEW.gross_costs
           , NEW.identifier
           , NEW.qon_dim
           , NEW.remark
           , NEW.signal_transmission
           , NEW.subsidies
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_node
           , NEW.fk_overflow_to
           , NEW.fk_overflow_characteristic
           , NEW.fk_control_center
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep_od.leapingweir (
             obj_id
           , length
           , opening_shape
           , width
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.length
           , NEW.opening_shape
           , NEW.width
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_leapingweir_ON_INSERT ON qgep_od.leapingweir;

CREATE TRIGGER vw_leapingweir_ON_INSERT INSTEAD OF INSERT ON qgep_od.vw_leapingweir
  FOR EACH ROW EXECUTE PROCEDURE qgep_od.vw_leapingweir_insert();

-----------------------------------
-- leapingweir UPDATE
-- Rule: vw_leapingweir_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_leapingweir_ON_UPDATE AS ON UPDATE TO qgep_od.vw_leapingweir DO INSTEAD (
UPDATE qgep_od.leapingweir
  SET
       length = NEW.length
     , opening_shape = NEW.opening_shape
     , width = NEW.width
  WHERE obj_id = OLD.obj_id;

UPDATE qgep_od.overflow
  SET
       actuation = NEW.actuation
     , adjustability = NEW.adjustability
     , brand = NEW.brand
     , control = NEW.control
     , discharge_point = NEW.discharge_point
     , function = NEW.function
     , gross_costs = NEW.gross_costs
     , identifier = NEW.identifier
     , qon_dim = NEW.qon_dim
     , remark = NEW.remark
     , signal_transmission = NEW.signal_transmission
     , subsidies = NEW.subsidies
           , fk_dataowner = NEW.fk_dataowner
           , fk_provider = NEW.fk_provider
           , last_modification = NEW.last_modification
     , fk_wastewater_node = NEW.fk_wastewater_node
     , fk_overflow_to = NEW.fk_overflow_to
     , fk_overflow_characteristic = NEW.fk_overflow_characteristic
     , fk_control_center = NEW.fk_control_center
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- leapingweir DELETE
-- Rule: vw_leapingweir_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_leapingweir_ON_DELETE AS ON DELETE TO qgep_od.vw_leapingweir DO INSTEAD (
  DELETE FROM qgep_od.leapingweir WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep_od.overflow WHERE obj_id = OLD.obj_id;
);

