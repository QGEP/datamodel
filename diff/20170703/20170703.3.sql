-- Moving from 2d to 3d geometry; LV95=2056 (av03=21781)
-- only tables with real 3d geometry
-- Updated 18.12.2017 Stefan Burckhardt
------------------------------------

-- FEHLER:  kann Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry nicht löschen, weil andere Objekte davon abhängen
-- DETAIL:  Sicht qgep.vw_channel hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- Sicht qgep.vw_discharge_point hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- Sicht qgep.vw_manhole hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- Sicht qgep.vw_special_structure hängt von Tabelle qgep.od_wastewater_structure Spalte detail_geometry3d_geometry ab
-- HINT:  Verwenden Sie DROP ... CASCADE, um die abhängigen Objekte ebenfalls zu löschen.


DROP VIEW IF EXISTS qgep.vw_discharge_point;
DROP VIEW IF EXISTS qgep.vw_manhole;
DROP VIEW IF EXISTS qgep.vw_special_structure;
DROP VIEW IF EXISTS qgep.vw_network_node;
DROP VIEW IF EXISTS qgep.vw_reach;


--od_wastewater_structure
ALTER TABLE qgep.od_wastewater_structure DROP COLUMN detail_geometry3d_geometry;
ALTER TABLE qgep.od_wastewater_structure ADD COLUMN detail_geometry3d_geometry geometry(CurvePolygonZ, :SRID);
UPDATE qgep.od_wastewater_structure SET detail_geometry3d_geometry = st_force3d(detail_geometry_geometry);
ALTER TABLE qgep.od_wastewater_structure DROP COLUMN detail_geometry_geometry;
ALTER TABLE qgep.od_wastewater_structure RENAME COLUMN detail_geometry3d_geometry TO detail_geometry_geometry;

-- FEHLER:  kann Tabelle qgep.od_reach Spalte progression3d_geometry nicht löschen, weil andere Objekte davon abhängen
-- DETAIL:  Sicht qgep.vw_qgep_reach hängt von Tabelle qgep.od_reach Spalte progression3d_geometry ab
-- Sicht qgep.vw_reach hängt von Tabelle qgep.od_reach Spalte progression3d_geometry ab
-- HINT:  Verwenden Sie DROP ... CASCADE, um die abhängigen Objekte ebenfalls zu löschen.

--od_reach
ALTER TABLE qgep.od_reach DROP COLUMN progression3d_geometry;
ALTER TABLE qgep.od_reach ADD COLUMN progression3d_geometry geometry(CompoundCurveZ, :SRID);
UPDATE qgep.od_reach SET progression3d_geometry = st_force3d(progression_geometry);
ALTER TABLE qgep.od_reach DROP COLUMN progression_geometry;
ALTER TABLE qgep.od_reach RENAME COLUMN progression3d_geometry TO progression_geometry;

-- add deleted views again (versions without 3d_geometry)
-- qgep.vw_discharge_point
DROP VIEW IF EXISTS qgep.vw_discharge_point;

--------
-- Subclass: od_discharge_point
-- Superclass: od_wastewater_structure
--------
CREATE OR REPLACE VIEW qgep.vw_discharge_point AS

SELECT
   DP.obj_id
   , WS."_depth"
   , DP.highwater_level
   , DP.relevance
   , DP.terrain_level
   , DP.upper_elevation
   , DP.waterlevel_hydraulic
   , WS.accessibility
   , WS.contract_section
   , WS.detail_geometry_geometry
   , WS.financing
   , WS.gross_costs
   , WS.identifier
   , WS.inspection_interval
   , WS.location_name
   , WS.records
   , WS.remark
   , WS.renovation_necessity
   , WS.replacement_value
   , WS.rv_base_year
   , WS.rv_construction_type
   , WS.status
   , WS.structure_condition
   , WS.subsidies
   , WS.year_of_construction
   , WS.year_of_replacement
   , WS.fk_dataowner
   , WS.fk_provider
   , WS.last_modification
   , WS.fk_owner
   , WS.fk_operator
  FROM qgep.od_discharge_point DP
 LEFT JOIN qgep.od_wastewater_structure WS
 ON WS.obj_id = DP.obj_id;

-----------------------------------
-- discharge_point INSERT
-- Function: vw_discharge_point_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_discharge_point_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_wastewater_structure (
             obj_id
           , accessibility
           , contract_section
            , detail_geometry_geometry
           , financing
           , gross_costs
           , identifier
           , inspection_interval
           , location_name
           , records
           , remark
           , renovation_necessity
           , replacement_value
           , rv_base_year
           , rv_construction_type
           , status
           , structure_condition
           , subsidies
           , year_of_construction
           , year_of_replacement
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_owner
           , fk_operator
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_discharge_point')) -- obj_id
           , NEW.accessibility
           , NEW.contract_section
            , NEW.detail_geometry_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.remark
           , NEW.renovation_necessity
           , NEW.replacement_value
           , NEW.rv_base_year
           , NEW.rv_construction_type
           , NEW.status
           , NEW.structure_condition
           , NEW.subsidies
           , NEW.year_of_construction
           , NEW.year_of_replacement
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_owner
           , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_discharge_point (
             obj_id
           , highwater_level
           , relevance
           , terrain_level
           , upper_elevation
           , waterlevel_hydraulic
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.highwater_level
           , NEW.relevance
           , NEW.terrain_level
           , NEW.upper_elevation
           , NEW.waterlevel_hydraulic
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_discharge_point_ON_INSERT ON qgep.discharge_point;

CREATE TRIGGER vw_discharge_point_ON_INSERT INSTEAD OF INSERT ON qgep.vw_discharge_point
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_discharge_point_insert();

-----------------------------------
-- discharge_point UPDATE
-- Rule: vw_discharge_point_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_discharge_point_ON_UPDATE AS ON UPDATE TO qgep.vw_discharge_point DO INSTEAD (
UPDATE qgep.od_discharge_point
  SET
       highwater_level = NEW.highwater_level
     , relevance = NEW.relevance
     , terrain_level = NEW.terrain_level
     , upper_elevation = NEW.upper_elevation
     , waterlevel_hydraulic = NEW.waterlevel_hydraulic
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_wastewater_structure
  SET
       accessibility = NEW.accessibility
     , contract_section = NEW.contract_section
     , detail_geometry_geometry = NEW.detail_geometry_geometry
     , financing = NEW.financing
     , gross_costs = NEW.gross_costs
     , identifier = NEW.identifier
     , inspection_interval = NEW.inspection_interval
     , location_name = NEW.location_name
     , records = NEW.records
     , remark = NEW.remark
     , renovation_necessity = NEW.renovation_necessity
     , replacement_value = NEW.replacement_value
     , rv_base_year = NEW.rv_base_year
     , rv_construction_type = NEW.rv_construction_type
     , status = NEW.status
     , structure_condition = NEW.structure_condition
     , subsidies = NEW.subsidies
     , year_of_construction = NEW.year_of_construction
     , year_of_replacement = NEW.year_of_replacement
     , fk_dataowner = NEW.fk_dataowner
     , fk_provider = NEW.fk_provider
     , last_modification = NEW.last_modification
     , fk_owner = NEW.fk_owner
     , fk_operator = NEW.fk_operator
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- discharge_point DELETE
-- Rule: vw_discharge_point_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_discharge_point_ON_DELETE AS ON DELETE TO qgep.vw_discharge_point DO INSTEAD (
  DELETE FROM qgep.od_discharge_point WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_wastewater_structure WHERE obj_id = OLD.obj_id;
);



-- qgep.vw_manhole
DROP VIEW IF EXISTS qgep.vw_manhole;

--------
-- Subclass: od_manhole
-- Superclass: od_wastewater_structure
--------
CREATE OR REPLACE VIEW qgep.vw_manhole AS

SELECT
   MA.obj_id
   , WS."_depth"
   , MA.dimension1
   , MA.dimension2
   , MA.function
   , MA.material
   , MA.surface_inflow
   , WS.accessibility
   , WS.contract_section
   , WS.detail_geometry_geometry
   , WS.financing
   , WS.gross_costs
   , WS.identifier
   , WS.inspection_interval
   , WS.location_name
   , WS.records
   , WS.remark
   , WS.renovation_necessity
   , WS.replacement_value
   , WS.rv_base_year
   , WS.rv_construction_type
   , WS.status
   , WS.structure_condition
   , WS.subsidies
   , WS.year_of_construction
   , WS.year_of_replacement
   , WS.fk_dataowner
   , WS.fk_provider
   , WS.last_modification
  , WS.fk_owner
  , WS.fk_operator
  FROM qgep.od_manhole MA
 LEFT JOIN qgep.od_wastewater_structure WS
 ON WS.obj_id = MA.obj_id;

-----------------------------------
-- manhole INSERT
-- Function: vw_manhole_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_manhole_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_wastewater_structure (
             obj_id
           , accessibility
           , contract_section
            , detail_geometry_geometry
           , financing
           , gross_costs
           , identifier
           , inspection_interval
           , location_name
           , records
           , remark
           , renovation_necessity
           , replacement_value
           , rv_base_year
           , rv_construction_type
           , status
           , structure_condition
           , subsidies
           , year_of_construction
           , year_of_replacement
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_owner
           , fk_operator
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_manhole')) -- obj_id
           , NEW.accessibility
           , NEW.contract_section
            , NEW.detail_geometry_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.remark
           , NEW.renovation_necessity
           , NEW.replacement_value
           , NEW.rv_base_year
           , NEW.rv_construction_type
           , NEW.status
           , NEW.structure_condition
           , NEW.subsidies
           , NEW.year_of_construction
           , NEW.year_of_replacement
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_owner
           , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_manhole (
             obj_id
           , dimension1
           , dimension2
           , function
           , material
           , surface_inflow
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.dimension1
           , NEW.dimension2
           , NEW.function
           , NEW.material
           , NEW.surface_inflow
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_manhole_ON_INSERT ON qgep.manhole;

CREATE TRIGGER vw_manhole_ON_INSERT INSTEAD OF INSERT ON qgep.vw_manhole
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_manhole_insert();

-----------------------------------
-- manhole UPDATE
-- Rule: vw_manhole_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_manhole_ON_UPDATE AS ON UPDATE TO qgep.vw_manhole DO INSTEAD (
UPDATE qgep.od_manhole
  SET
       dimension1 = NEW.dimension1
     , dimension2 = NEW.dimension2
     , function = NEW.function
     , material = NEW.material
     , surface_inflow = NEW.surface_inflow
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_wastewater_structure
  SET
       accessibility = NEW.accessibility
     , contract_section = NEW.contract_section
     , detail_geometry_geometry = NEW.detail_geometry_geometry
     , financing = NEW.financing
     , gross_costs = NEW.gross_costs
     , identifier = NEW.identifier
     , inspection_interval = NEW.inspection_interval
     , location_name = NEW.location_name
     , records = NEW.records
     , remark = NEW.remark
     , renovation_necessity = NEW.renovation_necessity
     , replacement_value = NEW.replacement_value
     , rv_base_year = NEW.rv_base_year
     , rv_construction_type = NEW.rv_construction_type
     , status = NEW.status
     , structure_condition = NEW.structure_condition
     , subsidies = NEW.subsidies
     , year_of_construction = NEW.year_of_construction
     , year_of_replacement = NEW.year_of_replacement
     , fk_dataowner = NEW.fk_dataowner
     , fk_provider = NEW.fk_provider
     , last_modification = NEW.last_modification
     , fk_owner = NEW.fk_owner
     , fk_operator = NEW.fk_operator
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- manhole DELETE
-- Rule: vw_manhole_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_manhole_ON_DELETE AS ON DELETE TO qgep.vw_manhole DO INSTEAD (
  DELETE FROM qgep.od_manhole WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_wastewater_structure WHERE obj_id = OLD.obj_id;
);



-- qgep.vw_special_structure
DROP VIEW IF EXISTS qgep.vw_special_structure;

--------
-- Subclass: od_special_structure
-- Superclass: od_wastewater_structure
--------
CREATE OR REPLACE VIEW qgep.vw_special_structure AS

SELECT
   SS.obj_id
   , SS.bypass
   , WS."_depth"
   , SS.emergency_spillway
   , SS.function
   , SS.stormwater_tank_arrangement
   , SS.upper_elevation
   , WS.accessibility
   , WS.contract_section
   , WS.detail_geometry_geometry
   , WS.financing
   , WS.gross_costs
   , WS.identifier
   , WS.inspection_interval
   , WS.location_name
   , WS.records
   , WS.remark
   , WS.renovation_necessity
   , WS.replacement_value
   , WS.rv_base_year
   , WS.rv_construction_type
   , WS.status
   , WS.structure_condition
   , WS.subsidies
   , WS.year_of_construction
   , WS.year_of_replacement
   , WS.fk_dataowner
   , WS.fk_provider
   , WS.last_modification
  , WS.fk_owner
  , WS.fk_operator
  FROM qgep.od_special_structure SS
 LEFT JOIN qgep.od_wastewater_structure WS
 ON WS.obj_id = SS.obj_id;

-----------------------------------
-- special_structure INSERT
-- Function: vw_special_structure_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_special_structure_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_wastewater_structure (
             obj_id
           , accessibility
           , contract_section
            , detail_geometry_geometry
           , financing
           , gross_costs
           , identifier
           , inspection_interval
           , location_name
           , records
           , remark
           , renovation_necessity
           , replacement_value
           , rv_base_year
           , rv_construction_type
           , status
           , structure_condition
           , subsidies
           , year_of_construction
           , year_of_replacement
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_owner
           , fk_operator
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_special_structure')) -- obj_id
           , NEW.accessibility
           , NEW.contract_section
            , NEW.detail_geometry_geometry
           , NEW.financing
           , NEW.gross_costs
           , NEW.identifier
           , NEW.inspection_interval
           , NEW.location_name
           , NEW.records
           , NEW.remark
           , NEW.renovation_necessity
           , NEW.replacement_value
           , NEW.rv_base_year
           , NEW.rv_construction_type
           , NEW.status
           , NEW.structure_condition
           , NEW.subsidies
           , NEW.year_of_construction
           , NEW.year_of_replacement
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_owner
           , NEW.fk_operator
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_special_structure (
             obj_id
           , bypass
           , emergency_spillway
           , function
           , stormwater_tank_arrangement
           , upper_elevation
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.bypass
           , NEW.emergency_spillway
           , NEW.function
           , NEW.stormwater_tank_arrangement
           , NEW.upper_elevation
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_special_structure_ON_INSERT ON qgep.special_structure;

CREATE TRIGGER vw_special_structure_ON_INSERT INSTEAD OF INSERT ON qgep.vw_special_structure
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_special_structure_insert();

-----------------------------------
-- special_structure UPDATE
-- Rule: vw_special_structure_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_special_structure_ON_UPDATE AS ON UPDATE TO qgep.vw_special_structure DO INSTEAD (
UPDATE qgep.od_special_structure
  SET
       bypass = NEW.bypass
     , emergency_spillway = NEW.emergency_spillway
     , function = NEW.function
     , stormwater_tank_arrangement = NEW.stormwater_tank_arrangement
     , upper_elevation = NEW.upper_elevation
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_wastewater_structure
  SET
       accessibility = NEW.accessibility
     , contract_section = NEW.contract_section
     , detail_geometry_geometry = NEW.detail_geometry_geometry
     , financing = NEW.financing
     , gross_costs = NEW.gross_costs
     , identifier = NEW.identifier
     , inspection_interval = NEW.inspection_interval
     , location_name = NEW.location_name
     , records = NEW.records
     , remark = NEW.remark
     , renovation_necessity = NEW.renovation_necessity
     , replacement_value = NEW.replacement_value
     , rv_base_year = NEW.rv_base_year
     , rv_construction_type = NEW.rv_construction_type
     , status = NEW.status
     , structure_condition = NEW.structure_condition
     , subsidies = NEW.subsidies
     , year_of_construction = NEW.year_of_construction
     , year_of_replacement = NEW.year_of_replacement
     , fk_dataowner = NEW.fk_dataowner
     , fk_provider = NEW.fk_provider
     , last_modification = NEW.last_modification
     , fk_owner = NEW.fk_owner
     , fk_operator = NEW.fk_operator
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- special_structure DELETE
-- Rule: vw_special_structure_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_special_structure_ON_DELETE AS ON DELETE TO qgep.vw_special_structure DO INSTEAD (
  DELETE FROM qgep.od_special_structure WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_wastewater_structure WHERE obj_id = OLD.obj_id;
);



-- qgep.vw_network_node
-- View: qgep.vw_network_node

DROP MATERIALIZED VIEW IF EXISTS qgep.vw_network_node;

CREATE MATERIALIZED VIEW qgep.vw_network_node AS
 SELECT
   row_number() OVER () AS gid,
   nodes.*
 FROM
 (
   SELECT
     obj_id,
     'reach_point' AS type,
     'reach_point' AS node_type,
     level AS level,
     NULL AS usage_current,
     NULL AS cover_level,
     NULL AS backflow_level,
     NULL AS description,
     situation_geometry AS detail_geometry,
     situation_geometry
   FROM qgep.od_reach_point

   UNION

   SELECT
     NE.obj_id,
     'wastewater_node' AS type,
     CASE
       WHEN MH.obj_id IS NOT NULL
         THEN 'manhole'
       WHEN WS.obj_id IS NOT NULL
         THEN 'special_WSucture'
       ELSE 'other'
     END AS node_type,
     bottom_level AS level,
     COALESCE( MAX( ch_from.usage_current ), MAX( ch_to.usage_current ) ) AS usage_current,
     MAX( CO.level ) AS cover_level,
     WN.backflow_level AS backflow_level,
     NE.identifier AS description,
     COALESCE( WS.detail_geometry_geometry, WN.situation_geometry ) AS detail_geometry, -- Will contain different geometry types: do not visualize directly. Will be handled by plugin
     WN.situation_geometry
   FROM qgep.od_wastewater_node WN
   LEFT JOIN qgep.od_wastewater_networkelement NE
     ON NE.obj_id = WN.obj_id
   LEFT JOIN qgep.od_wastewater_structure WS
     ON WS.obj_id = NE.fk_wastewater_structure
   LEFT JOIN qgep.od_manhole MH
     ON MH.obj_id = WS.obj_id
   LEFT JOIN qgep.od_structure_part SP
     ON SP.fk_wastewater_structure = WS.obj_id
   LEFT JOIN qgep.od_cover CO
     ON CO.obj_id = SP.obj_id
   LEFT JOIN qgep.od_reach_point RP
     ON NE.obj_id = RP.fk_wastewater_networkelement
   LEFT JOIN qgep.od_reach re_from
     ON re_from.fk_reach_point_from = RP.obj_id
   LEFT JOIN qgep.od_wastewater_networkelement ne_from
     ON ne_from.obj_id = re_from.obj_id
   LEFT JOIN qgep.od_channel ch_from
     ON ch_from.obj_id = ne_from.fk_wastewater_structure
   LEFT JOIN qgep.od_reach re_to
     ON re_to.fk_reach_point_to = RP.obj_id
   LEFT JOIN qgep.od_wastewater_networkelement ne_to
     ON ne_to.obj_id = re_to.obj_id
   LEFT JOIN qgep.od_channel ch_to
     ON ch_to.obj_id = ne_to.fk_wastewater_structure
   GROUP BY NE.obj_id, type, bottom_level, backflow_level, description, WN.situation_geometry, WS.detail_geometry_geometry, WS.obj_id, MH.obj_id, SP.fk_wastewater_structure
  ) AS nodes;



-- qgep.vw_reach

DROP VIEW IF EXISTS qgep.vw_reach;


--------
-- Subclass: od_reach
-- Superclass: od_wastewater_networkelement
--------
CREATE OR REPLACE VIEW qgep.vw_reach AS

SELECT
   RE.obj_id
   , RE.clear_height
   , RE.coefficient_of_friction
   , RE.elevation_determination
   , RE.horizontal_positioning
   , RE.inside_coating
   , RE.length_effective
   , RE.material
   , RE.progression_geometry
   , RE.reliner_material
   , RE.reliner_nominal_size
   , RE.relining_construction
   , RE.relining_kind
   , RE.ring_stiffness
   , RE.slope_building_plan
   , RE.wall_roughness
   , WE.identifier
   , WE.remark
   , WE.fk_dataowner
   , WE.fk_provider
   , WE.last_modification
  , WE.fk_wastewater_structure
  FROM qgep.od_reach RE
 LEFT JOIN qgep.od_wastewater_networkelement WE
 ON WE.obj_id = RE.obj_id;

-----------------------------------
-- reach INSERT
-- Function: vw_reach_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_reach_insert()
  RETURNS trigger AS
$BODY$
BEGIN
  INSERT INTO qgep.od_wastewater_networkelement (
             obj_id
           , identifier
           , remark
           , fk_dataowner
           , fk_provider
           , last_modification
           , fk_wastewater_structure
           )
     VALUES ( COALESCE(NEW.obj_id,qgep.generate_oid('od_reach')) -- obj_id
           , NEW.identifier
           , NEW.remark
           , NEW.fk_dataowner
           , NEW.fk_provider
           , NEW.last_modification
           , NEW.fk_wastewater_structure
           )
           RETURNING obj_id INTO NEW.obj_id;

INSERT INTO qgep.od_reach (
             obj_id
           , clear_height
           , coefficient_of_friction
           , elevation_determination
           , horizontal_positioning
           , inside_coating
           , length_effective
           , material
           , progression_geometry
           , reliner_material
           , reliner_nominal_size
           , relining_construction
           , relining_kind
           , ring_stiffness
           , slope_building_plan
           , wall_roughness
           )
          VALUES (
            NEW.obj_id -- obj_id
           , NEW.clear_height
           , NEW.coefficient_of_friction
           , NEW.elevation_determination
           , NEW.horizontal_positioning
           , NEW.inside_coating
           , NEW.length_effective
           , NEW.material
           , NEW.progression_geometry
           , NEW.reliner_material
           , NEW.reliner_nominal_size
           , NEW.relining_construction
           , NEW.relining_kind
           , NEW.ring_stiffness
           , NEW.slope_building_plan
           , NEW.wall_roughness
           );
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

-- DROP TRIGGER vw_reach_ON_INSERT ON qgep.reach;

CREATE TRIGGER vw_reach_ON_INSERT INSTEAD OF INSERT ON qgep.vw_reach
  FOR EACH ROW EXECUTE PROCEDURE qgep.vw_reach_insert();

-----------------------------------
-- reach UPDATE
-- Rule: vw_reach_ON_UPDATE()
-----------------------------------

CREATE OR REPLACE RULE vw_reach_ON_UPDATE AS ON UPDATE TO qgep.vw_reach DO INSTEAD (
UPDATE qgep.od_reach
  SET
       clear_height = NEW.clear_height
     , coefficient_of_friction = NEW.coefficient_of_friction
     , elevation_determination = NEW.elevation_determination
     , horizontal_positioning = NEW.horizontal_positioning
     , inside_coating = NEW.inside_coating
     , length_effective = NEW.length_effective
     , material = NEW.material
     , progression_geometry = NEW.progression_geometry
     , reliner_material = NEW.reliner_material
     , reliner_nominal_size = NEW.reliner_nominal_size
     , relining_construction = NEW.relining_construction
     , relining_kind = NEW.relining_kind
     , ring_stiffness = NEW.ring_stiffness
     , slope_building_plan = NEW.slope_building_plan
     , wall_roughness = NEW.wall_roughness
  WHERE obj_id = OLD.obj_id;

UPDATE qgep.od_wastewater_networkelement
  SET
       identifier = NEW.identifier
     , remark = NEW.remark
     , fk_dataowner = NEW.fk_dataowner
     , fk_provider = NEW.fk_provider
     , last_modification = NEW.last_modification
     , fk_wastewater_structure = NEW.fk_wastewater_structure
  WHERE obj_id = OLD.obj_id;
);

-----------------------------------
-- reach DELETE
-- Rule: vw_reach_ON_DELETE ()
-----------------------------------

CREATE OR REPLACE RULE vw_reach_ON_DELETE AS ON DELETE TO qgep.vw_reach DO INSTEAD (
  DELETE FROM qgep.od_reach WHERE obj_id = OLD.obj_id;
  DELETE FROM qgep.od_wastewater_networkelement WHERE obj_id = OLD.obj_id;
);



DO language plpgsql $$
BEGIN
  RAISE NOTICE 'Added Views qgep.vw_discharge_point, qgep.vw_manhole, qgep.vw_special_structure, qgep.vw_network_node and qgep.vw_reach again';
END
$$;


