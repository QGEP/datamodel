-- 1. rename attribute in table qgep_od.pump
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/

ALTER TABLE qgep_od.pump 
RENAME COLUMN contruction_type TO construction_type;


-- 2. rename value list table in schema qgep_vl
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-table/

ALTER TABLE IF EXISTS qgep_vl.pump_contruction_type
RENAME TO pump_construction_type;

-- 3. drop existing constraint and add new constraint
-- old Constraint: fkey_vl_pump_contruction_type

ALTER TABLE IF EXISTS qgep_od.pump DROP CONSTRAINT IF EXISTS fkey_vl_pump_contruction_type;

-- old Constraint: fkey_vl_pump_construction_type

ALTER TABLE IF EXISTS qgep_od.pump
    ADD CONSTRAINT fkey_vl_pump_construction_type FOREIGN KEY (construction_type)
    REFERENCES qgep_vl.pump_construction_type (code) MATCH SIMPLE
    ON UPDATE RESTRICT
    ON DELETE RESTRICT;

-- 4. rename wrong value in qgep_sys.dictionary_od_field

-- adjust value list in dictionary_od_field
-- INSERT INTO qgep_sys.dictionary_od_field (class_id, attribute_id, table_name, field_name, field_name_en, field_name_de, field_name_fr, field_name_it, field_name_ro, field_description_en, field_description_de, field_description_fr, field_description_it, field_description_ro, field_mandatory, field_visible, field_datatype, field_unit_en, field_unit_description_en, field_unit_de, field_unit_description_de, field_unit_fr, field_unit_description_fr, field_unit_it, field_unit_description_it, field_unit_ro, field_unit_description_ro, field_max, field_min) VALUES (50,33,'pump','contruction_type','contruction_type','Bauart','GENRE_CONSTRUCTION','zzz_Bauart','tipul_constructiei','Types of pumps','Pumpenarten','Types de pompe','NULL','Observatii',ARRAY['kein_Plantyp_definiert']::qgep_od.plantype[],'true','integer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
 

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'construction_type',
    field_name_en = 'construction_type'
WHERE (table_name = 'pump' AND field_name = 'contruction_type' AND field_name_en = 'contruction_type')
RETURNING *;
 
-- 5. rename wrong value in qgep_sys.dictionary_od_field
-- INSERT INTO qgep_sys.dictionary_od_values (class_id, attribute_id, value_id, table_name, field_name, value_name, value_name_en, shortcut_en, value_name_de, shortcut_de, value_name_fr, shortcut_fr, value_name_it, shortcut_it, value_name_ro, shortcut_ro, value_description_en, value_description_de, value_description_fr, value_description_it, value_description_ro) VALUES (50,33,2983,'pump','contruction_type','other','other',NULL,'andere',NULL,'autres',NULL,'altro',NULL,'rrr_altul',NULL,NULL,NULL,NULL,NULL,NULL);
  
UPDATE qgep_sys.dictionary_od_values
SET field_name = 'construction_type'
WHERE (table_name = 'pump' AND field_name = 'contruction_type')
RETURNING *;
