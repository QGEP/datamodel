-- updated 3.8.2017 sb
-- what is this script for?
-- where table_name = 'od_manhole' - entries are without od_

DROP TABLE qgep.is_dictionary_vw_field CASCADE;
CREATE TABLE qgep.is_dictionary_vw_field
(
  id serial NOT NULL,
  class_id integer,
  attribute_id integer,
  table_name character varying(80),
  field_name character varying(80),
  field_name_en character varying(80),
  field_name_de character varying(100),
  field_name_fr character varying(100),
  field_name_it character varying(100),
  -- 3.8.2017
  field_name_ro character varying(100),
  field_description_en text,
  field_description_de text,
  field_description_fr text,
  field_description_it text,
  -- 3.8.2017
  field_description_ro text,
field_mandatory qgep.plantype[],
  field_visible boolean,
  field_datatype character varying(40),
  field_unit_de character varying(20),
  field_unit_description_de character varying(90),
  field_unit_en character varying(20),
  field_unit_description_en character varying(90),
  field_unit_fr character varying(20),
  field_unit_description_fr character varying(90),
  field_unit_it character varying(20),
  field_unit_description_it character varying(90),
  field_unit_ro character varying(20),
  field_unit_description_ro character varying(90),
  field_min numeric,
  field_max numeric,
  CONSTRAINT is_dictionary_vw_field_pkey PRIMARY KEY (id)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE qgep.is_dictionary_vw_field
  OWNER TO qgep;

-- Reach

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_reach',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
      FROM qgep.is_dictionary_od_field
      -- 3.8.2017
    WHERE table_name = 'reach'
    OR table_name = 'wastewater_networkelement'
  UNION SELECT
    class_id,
    attribute_id,
    'vw_reach',
    'rp_from_' || field_name,
    'rp_from_' || field_name_en,
    'hp_von_' || field_name_de,
    'tp_de_' || field_name_fr,
    field_name_it, -- TODO
    field_description_en, -- TODO
    field_description_de, -- TODO
    field_description_fr, -- TODO
    field_description_it -- TODO
    FROM qgep.is_dictionary_od_field
    WHERE table_name = 'od_reach_point'
  UNION SELECT
    class_id,
    attribute_id,
    'vw_reach',
    'rp_to_' || field_name,
    'rp_to_' || field_name_en,
    'hp_nach_' || field_name_de,
    'tp_a_' || field_name_fr,
    field_name_it, -- TODO
    field_description_en, -- TODO
    field_description_de, -- TODO
    field_description_fr, -- TODO
    field_description_it -- TODO
    FROM qgep.is_dictionary_od_field
-- 3.8.2017
    WHERE table_name = 'reach_point';
    
-- Manhole

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_manhole',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
      WHERE table_name = 'manhole'
      OR table_name = 'wastewater_structure';


-- Special Structure

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_special_structure',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
    WHERE table_name = 'special_structure'
      OR table_name = 'wastewater_structure';


-- Special Structure

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_channel',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
    WHERE table_name = 'channel'
      OR table_name = 'wastewater_structure';

-- Discharge Point

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_discharge_point',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
    WHERE table_name = 'discharge_point'
      OR table_name = 'wastewater_structure';


-- Wastewater Node

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_wastewater_node',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
    WHERE table_name = 'wastewater_node'
      OR table_name = 'wastewater_networkelement';


-- Cover

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_cover',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
      WHERE table_name = 'cover'
      OR table_name = 'structure_part';


-- Access Aid

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_cover',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    -- 3.8.2017
    WHERE table_name = 'access_aid'
      OR table_name = 'structure_part';


-- Benching

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_benching',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
    WHERE table_name = 'benching'
      OR table_name = 'structure_part';


-- Dryweather Downspout

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_dryweather_downspout',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
  WHERE table_name = 'dryweather_downspout'
  OR table_name = 'structure_part';


-- Dryweather Flume

INSERT INTO qgep.is_dictionary_vw_field (
  class_id,
  attribute_id,
  table_name,
  field_name,
  field_name_en,
  field_name_de,
  field_name_fr,
  field_name_it,
  field_description_en,
  field_description_de,
  field_description_fr,
  field_description_it
) SELECT
    class_id,
    attribute_id,
    'vw_dryweather_flume',
    field_name,
    field_name_en,
    field_name_de,
    field_name_fr,
    field_name_it,
    field_description_en,
    field_description_de,
    field_description_fr,
    field_description_it
    FROM qgep.is_dictionary_od_field
  WHERE table_name = 'dryweather_flume'
  OR table_name = 'structure_part';




CREATE VIEW qgep.vw_dictionary_field AS
  SELECT *
    FROM qgep.is_dictionary_vw_field
  UNION SELECT *
    FROM qgep.is_dictionary_od_field;

ALTER VIEW qgep.vw_dictionary_field
  OWNER TO qgep;
