DROP VIEW qgep_od.vw_qgep_overflow;

CREATE OR REPLACE VIEW qgep_od.vw_qgep_overflow
 AS
 SELECT
        CASE
            WHEN leapingweir.obj_id IS NOT NULL THEN 'leapingweir'::qgep_od.overflow_type
            WHEN prank_weir.obj_id IS NOT NULL THEN 'prank_weir'::qgep_od.overflow_type
            WHEN pump.obj_id IS NOT NULL THEN 'pump'::qgep_od.overflow_type
            ELSE 'overflow'::qgep_od.overflow_type
        END AS overflow_type,
    overflow.obj_id,
    overflow.actuation,
    overflow.adjustability,
    overflow.brand,
    overflow.control,
    overflow.discharge_point,
    overflow.fk_control_center,
    overflow.fk_dataowner,
    overflow.fk_overflow_characteristic,
    overflow.fk_overflow_to,
    overflow.fk_provider,
    overflow.fk_wastewater_node,
    overflow.function,
    overflow.gross_costs,
    overflow.identifier,
    overflow.last_modification,
    overflow.qon_dim,
    overflow.remark,
    overflow.signal_transmission,
    overflow.subsidies,
    leapingweir.length,
    leapingweir.opening_shape,
    leapingweir.width,
    prank_weir.hydraulic_overflow_length,
    prank_weir.level_max,
    prank_weir.level_min,
    prank_weir.weir_edge,
    prank_weir.weir_kind,
    pump.contruction_type,
    pump.operating_point,
    pump.placement_of_actuation,
    pump.placement_of_pump,
    pump.pump_flow_max_single,
    pump.pump_flow_min_single,
    pump.start_level,
    pump.stop_level,
    pump.usage_current,
    n1.situation_geometry AS start_point
   FROM qgep_od.overflow overflow
     LEFT JOIN qgep_od.leapingweir leapingweir ON leapingweir.obj_id::text = overflow.obj_id::text
     LEFT JOIN qgep_od.prank_weir prank_weir ON prank_weir.obj_id::text = overflow.obj_id::text
     LEFT JOIN qgep_od.pump pump ON pump.obj_id::text = overflow.obj_id::text
     LEFT JOIN qgep_od.wastewater_node n1 ON overflow.fk_wastewater_node::text = n1.obj_id::text
     LEFT JOIN qgep_od.wastewater_node n2 ON overflow.fk_overflow_to::text = n2.obj_id::text;

ALTER TABLE qgep_od.vw_qgep_overflow
    OWNER TO postgres;
    
    
CREATE TRIGGER audit_trigger_row
    INSTEAD OF INSERT OR DELETE OR UPDATE 
    ON qgep_od.vw_qgep_overflow
    FOR EACH ROW
    EXECUTE FUNCTION qgep_sys.if_modified_func('true');


CREATE TRIGGER tr_vw_qgep_overflow_on_delete
    INSTEAD OF DELETE
    ON qgep_od.vw_qgep_overflow
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_qgep_overflow_delete();


CREATE TRIGGER tr_vw_qgep_overflow_on_insert
    INSTEAD OF INSERT
    ON qgep_od.vw_qgep_overflow
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_qgep_overflow_insert();


CREATE TRIGGER tr_vw_qgep_overflow_on_update
    INSTEAD OF UPDATE 
    ON qgep_od.vw_qgep_overflow
    FOR EACH ROW
    EXECUTE FUNCTION qgep_od.ft_vw_qgep_overflow_update();
