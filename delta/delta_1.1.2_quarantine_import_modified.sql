CREATE OR REPLACE FUNCTION qgep_import.vw_manhole_insert_into_quarantine_or_delete() RETURNS trigger AS $BODY$
BEGIN
  IF NEW.verified IS TRUE THEN 
    IF NEW.deleted IS TRUE THEN
      -- delete this entry
      DELETE FROM qgep_od.vw_qgep_wastewater_structure
      WHERE obj_id = NEW.obj_id;
    ELSE
      -- insert data into quarantine
      INSERT INTO qgep_import.manhole_quarantine
      (
      obj_id,
      identifier,
      situation_geometry,
      co_shape,
      co_diameter,
      co_material,
      co_positional_accuracy,
      co_level,
      _depth,
      _channel_usage_current,
      ma_material,
      ma_dimension1,
      ma_dimension2,
      ws_type,
      ma_function,
      ss_function,
      remark,
      wn_bottom_level,
      photo1,
      photo2,
      inlet_3_material,
      inlet_3_clear_height,
      inlet_3_depth_m,
      inlet_4_material,
      inlet_4_clear_height,
      inlet_4_depth_m,
      inlet_5_material,
      inlet_5_clear_height,
      inlet_5_depth_m,
      inlet_6_material,
      inlet_6_clear_height,
      inlet_6_depth_m,
      inlet_7_material,
      inlet_7_clear_height,
      inlet_7_depth_m,
      outlet_1_material,
      outlet_1_clear_height,
      outlet_1_depth_m,
      outlet_2_material,
      outlet_2_clear_height,
      outlet_2_depth_m
      )
      VALUES
      (
      NEW.obj_id,
      NEW.identifier,
      NEW.situation_geometry,
      NEW.co_shape,
      NEW.co_diameter,
      NEW.co_material,
      NEW.co_positional_accuracy,
      NEW.co_level,
      NEW._depth,
      NEW._channel_usage_current,
      NEW.ma_material,
      NEW.ma_dimension1,
      NEW.ma_dimension2,
      NEW.ws_type,
      NEW.ma_function,
      NEW.ss_function,
      NEW.remark,
      NEW.wn_bottom_level,
      NEW.photo1,
      NEW.photo2,
      NEW.inlet_3_material,
      NEW.inlet_3_clear_height,
      NEW.inlet_3_depth_m,
      NEW.inlet_4_material,
      NEW.inlet_4_clear_height,
      NEW.inlet_4_depth_m,
      NEW.inlet_5_material,
      NEW.inlet_5_clear_height,
      NEW.inlet_5_depth_m,
      NEW.inlet_6_material,
      NEW.inlet_6_clear_height,
      NEW.inlet_6_depth_m,
      NEW.inlet_7_material,
      NEW.inlet_7_clear_height,
      NEW.inlet_7_depth_m,
      NEW.outlet_1_material,
      NEW.outlet_1_clear_height,
      NEW.outlet_1_depth_m,
      NEW.outlet_2_material,
      NEW.outlet_2_clear_height,
      NEW.outlet_2_depth_m   
      );
    END IF;
  END IF;
  RETURN NEW;
END; $BODY$
