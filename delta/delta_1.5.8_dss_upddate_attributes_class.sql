-- 1. rename attribute in table qgep_od.mutation
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/

ALTER TABLE qgep_od.mutation 
RENAME COLUMN class TO classname;

-- 2. rename wrong value in qgep_sys.dictionary_od_field

-- adjust value list in dictionary_od_field
-- INSERT INTO qgep_sys.dictionary_od_field (class_id, attribute_id, table_name, field_name, field_name_en, field_name_de, field_name_fr, field_name_it, field_name_ro, field_description_en, field_description_de, field_description_fr, field_description_it, field_description_ro, field_mandatory, field_visible, field_datatype, field_unit_en, field_unit_description_en, field_unit_de, field_unit_description_de, field_unit_fr, field_unit_description_fr, field_unit_it, field_unit_description_it, field_unit_ro, field_unit_description_ro, field_max, field_min) VALUES (50,33,'pump','contruction_type','contruction_type','Bauart','GENRE_CONSTRUCTION','zzz_Bauart','tipul_constructiei','Types of pumps','Pumpenarten','Types de pompe','NULL','Observatii',ARRAY['kein_Plantyp_definiert']::qgep_od.plantype[],'true','integer',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
 

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'classname',
    field_name_en = 'classname'
WHERE (table_name = 'mutation' AND field_name = 'class' AND field_name_en = 'class')
RETURNING *;
 
-- 3. rename wrong value in qgep_sys.dictionary_od_values
-- INSERT INTO qgep_sys.dictionary_od_values (class_id, attribute_id, value_id, table_name, field_name, value_name, value_name_en, shortcut_en, value_name_de, shortcut_de, value_name_fr, shortcut_fr, value_name_it, shortcut_it, value_name_ro, shortcut_ro, value_description_en, value_description_de, value_description_fr, value_description_it, value_description_ro) VALUES (50,33,2983,'pump','contruction_type','other','other',NULL,'andere',NULL,'autres',NULL,'altro',NULL,'rrr_altul',NULL,NULL,NULL,NULL,NULL,NULL);
  
UPDATE qgep_sys.dictionary_od_values
SET field_name = 'classname'
WHERE (table_name = 'mutation' AND field_name = 'class')
RETURNING *;

-- 4. rename attribute in table qgep_od.txt_text

ALTER TABLE qgep_od.txt_text 
RENAME COLUMN class TO classname;

-- 5. rename wrong value in qgep_sys.dictionary_od_field

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'classname',
    field_name_en = 'classname'
WHERE (table_name = 'txt_text' AND field_name = 'class' AND field_name_en = 'class')
RETURNING *;
 
-- 6. rename wrong value in qgep_sys.dictionary_od_values
  
UPDATE qgep_sys.dictionary_od_values
SET field_name = 'classname'
WHERE (table_name = 'txt_text' AND field_name = 'class')
RETURNING *;

-- 7. rename attribute in table qgep_od.txt_symbol

ALTER TABLE qgep_od.txt_symbol 
RENAME COLUMN class TO classname;

-- 8. rename wrong value in qgep_sys.dictionary_od_field

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'classname',
    field_name_en = 'classname'
WHERE (table_name = 'txt_symbol' AND field_name = 'class' AND field_name_en = 'class')
RETURNING *;
 
-- 9. rename wrong value in qgep_sys.dictionary_od_values
  
UPDATE qgep_sys.dictionary_od_values
SET field_name = 'classname'
WHERE (table_name = 'txt_symbol' AND field_name = 'class')
RETURNING *;
