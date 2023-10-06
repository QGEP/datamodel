-- drop connected views not needed as already listed in https://github.com/QGEP/datamodel/blob/master/view/drop_views.sql

-- class overflow
--1. add correct fk_overflow_char
ALTER TABLE IF EXISTS qgep_od.overflow ADD COLUMN fk_overflow_char varchar (16);

-- 2. add correct CONSTRAINT
-- ALTER TABLE qgep_od.overflow ADD COLUMN fk_overflow_characteristic varchar (16);
--ALTER TABLE qgep_od.overflow ADD CONSTRAINT rel_overflow_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep_od.overflow_char(obj_id) ON UPDATE CASCADE ON DELETE set null;

ALTER TABLE qgep_od.overflow ADD CONSTRAINT rel_overflow_overflow_char FOREIGN KEY (fk_overflow_char) REFERENCES qgep_od.overflow_char(obj_id) ON UPDATE CASCADE ON DELETE set null;

--3. copy data from fk_overflow_characteristic to fk_overflow_char
UPDATE qgep_od.overflow
SET fk_overflow_char = fk_overflow_characteristic;

-- 4. delete old rel_overflow_overflow_characteristic constraint
ALTER TABLE IF EXISTS qgep_od.overflow DROP CONSTRAINT rel_overflow_overflow_characteristic;

-- 5. delete wrong fk_overflow_characteristic column
ALTER TABLE IF EXISTS qgep_od.overflow DROP COLUMN fk_overflow_characteristic;

-- 6. rename wrong value in qgep_sys.dictionary_od_field
-- not needed as fk_attributes are not in qgep_sys tables


-- class hq_relation
--1. add correct fk_overflow_char
ALTER TABLE IF EXISTS qgep_od.hq_relation ADD COLUMN fk_overflow_char varchar (16);

-- 2. add correct CONSTRAINT
--ALTER TABLE qgep_od.hq_relation ADD COLUMN fk_overflow_characteristic varchar (16);
--ALTER TABLE qgep_od.hq_relation ADD CONSTRAINT rel_hq_relation_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep_od.overflow_char(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep_od.hq_relation ADD CONSTRAINT rel_hq_relation_overflow_char FOREIGN KEY (fk_overflow_char) REFERENCES qgep_od.overflow_char(obj_id) ON UPDATE CASCADE ON DELETE cascade;


--3. copy data from fk_overflow_characteristic to fk_overflow_char
UPDATE qgep_od.hq_relation
SET fk_overflow_char = fk_overflow_characteristic;

-- 4. delete old rel_overflow_overflow_characteristic constraint
ALTER TABLE IF EXISTS qgep_od.hq_relation DROP CONSTRAINT rel_hq_relation_overflow_characteristic;

-- 5. delete wrong fk_overflow_characteristic column
ALTER TABLE IF EXISTS qgep_od.hq_relation DROP COLUMN fk_overflow_characteristic;

-- 6. rename wrong value in qgep_sys.dictionary_od_field
-- not needed as fk_attributes are not in qgep_sys tables


-- class hydraulic_char_data
--1. add correct fk_overflow_char
ALTER TABLE IF EXISTS qgep_od.hydraulic_char_data ADD COLUMN fk_overflow_char varchar (16);

-- 2. add correct CONSTRAINT
--ALTER TABLE qgep_od.hydraulic_char_data ADD COLUMN fk_overflow_characteristic varchar (16);
--ALTER TABLE qgep_od.hydraulic_char_data ADD CONSTRAINT rel_hydraulic_char_data_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep_od.overflow_char(obj_id) ON UPDATE CASCADE ON DELETE cascade;

ALTER TABLE qgep_od.hydraulic_char_data ADD CONSTRAINT rel_hydraulic_char_data_overflow_char FOREIGN KEY (fk_overflow_char) REFERENCES qgep_od.overflow_char(obj_id) ON UPDATE CASCADE ON DELETE cascade;


--3. copy data from fk_overflow_characteristic to fk_overflow_char
UPDATE qgep_od.hydraulic_char_data
SET fk_overflow_char = fk_overflow_characteristic;

-- 4. delete old rel_overflow_overflow_characteristic constraint
ALTER TABLE IF EXISTS qgep_od.hydraulic_char_data DROP CONSTRAINT rel_hydraulic_char_data_overflow_characteristic;

-- 5. delete wrong fk_overflow_characteristic column
ALTER TABLE IF EXISTS qgep_od.hydraulic_char_data DROP COLUMN fk_overflow_characteristic;

-- 6. rename wrong value in qgep_sys.dictionary_od_field
-- not needed as fk_attributes are not in qgep_sys tables


-- class overflow_char
-- 1. rename attribute kind_overflow_characteristic and overflow_characteristic_digital in table qgep_od.overflow_char
-- https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-rename-column/

ALTER TABLE qgep_od.overflow_char 
RENAME COLUMN kind_overflow_characteristic TO kind_overflow_char;

ALTER TABLE qgep_od.overflow_char 
RENAME COLUMN overflow_characteristic_digital TO overflow_char_digital;


-- 2. delete primary constraint of vl_list tables neu 5.10.2023
ALTER TABLE IF EXISTS qgep_vl.overflow_char_kind_overflow_characteristic DROP CONSTRAINT pkey_qgep_vl_overflow_char_kind_overflow_characteristic_code;

ALTER TABLE IF EXISTS qgep_vl.overflow_char_overflow_characteristic_digital DROP CONSTRAINT pkey_qgep_vl_overflow_char_overflow_characteristic_digital_code;

-- 3. rename qgep_vl.overflow_char_kind_overflow_characteristic to overflow_char_kind_overflow_char
--and qgep_vl.overflow_char_overflow_characteristic_digital to overflow_char_overflow_char_digital
ALTER TABLE qgep_vl.overflow_char_kind_overflow_characteristic RENAME TO overflow_char_kind_overflow_char;

ALTER TABLE qgep_vl.overflow_char_overflow_characteristic_digital RENAME TO overflow_char_overflow_char_digital;

-- 4. re-add primary key constraint neu 5.10.2023
ALTER TABLE qgep_vl.overflow_char_kind_overflow_char ADD CONSTRAINT pkey_qgep_vl_overflow_char_kind_overflow_char_code PRIMARY KEY (code);
ALTER TABLE qgep_vl.overflow_char_overflow_char_digital ADD CONSTRAINT pkey_qgep_vl_overflow_char_overflow_char_digital_code PRIMARY KEY (code);



-- 6. rename wrong value in qgep_sys.dictionary_od_field

-- adjust value list in dictionary_od_field
-- INSERT INTO qgep_sys.dictionary_od_field (class_id, attribute_id, table_name, field_name, field_name_en, field_name_de, field_name_fr, field_name_it, field_name_ro, field_description_en, field_description_de, field_description_fr, field_description_it, field_description_ro, field_mandatory, field_visible, field_datatype, field_unit_en, field_unit_description_en, field_unit_de, field_unit_description_de, field_unit_fr, field_unit_description_fr, field_unit_it, field_unit_description_it, field_unit_ro, field_unit_description_ro, field_max, field_min) VALUES (64,6219,'overflow_char','kind_overflow_characteristic','kind_overflow_characteristic','Kennlinie_Typ','GENRE_COURBE_DE_FONCTIONNEMENT','curva_caratteristica_tipo','tipul_curbei_de_func?ionare','yyy_Die Kennlinie ist als Q /Q- (bei Bodenöffnungen) oder als H/Q-Tabelle (bei Streichwehren) zu dokumentieren. Bei einer freien Aufteilung muss die Kennlinie nicht dokumentiert werden. Bei Abflussverhältnissen in Einstaubereichen ist die Funktion separat in einer Beilage zu beschreiben.','Die Kennlinie ist als Q /Q- (bei Bodenöffnungen) oder als H/Q-Tabelle (bei Streichwehren) zu dokumentieren. Bei einer freien Aufteilung muss die Kennlinie nicht dokumentiert werden. Bei Abflussverhältnissen in Einstaubereichen ist die Funktion separat in einer Beilage zu beschreiben.','La courbe est à documenter sous forme de rapport Q/Q (Leaping weir) ou H/Q (déversoir latéral). Les conditions d’écoulement dans la chambre d’accumulation sont à fournir en annexe.','NULL','[CHF]',ARRAY['GEP_Verband','PAA']::qgep_od.plantype[],'true','integer','','','','','','','','','','',NULL,NULL);
 

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'kind_overflow_char',
    field_name_en = 'kind_overflow_char'
WHERE (table_name = 'overflow_char' AND field_name = 'kind_overflow_characteristic' AND field_name_en = 'kind_overflow_characteristic')
RETURNING *;

--  INSERT INTO qgep_sys.dictionary_od_field (class_id, attribute_id, table_name, field_name, field_name_en, field_name_de, field_name_fr, field_name_it, field_name_ro, field_description_en, field_description_de, field_description_fr, field_description_it, field_description_ro, field_mandatory, field_visible, field_datatype, field_unit_en, field_unit_description_en, field_unit_de, field_unit_description_de, field_unit_fr, field_unit_description_fr, field_unit_it, field_unit_description_it, field_unit_ro, field_unit_description_ro, field_max, field_min) VALUES (64,6222,'overflow_char','overflow_characteristic_digital','overflow_characteristic_digital','Kennlinie_digital','COURBE_DE_FONCTIONNEMENT_NUM','curva_caratteristica_digitale','curba_de_func?ionare_numerica','yyy_Falls Kennlinie_digital = ja müssen die Attribute für die Q-Q oder H-Q Beziehung  in Ueberlaufcharakteristik ausgefüllt sein in HQ_Relation.','Falls Kennlinie_digital = ja müssen die Attribute für die Q-Q oder H-Q Beziehung in HQ_Relation ausgefüllt sein.','Si courbe de fonctionnement numérique = oui, les attributs pour les relations Q-Q et H-Q doivent être saisis dans la classe RELATION_HQ.','NULL','',ARRAY['GEP_Verband','PAA']::qgep_od.plantype[],'true','integer','','','','','','','','','','',NULL,NULL);

UPDATE qgep_sys.dictionary_od_field
SET field_name = 'overflow_char_digital',
    field_name_en = 'overflow_char_digital'
WHERE (table_name = 'overflow_char' AND field_name = 'overflow_characteristic_digital' AND field_name_en = 'overflow_characteristic_digital')
RETURNING *;

 
-- 4. rename wrong value in qgep_sys.dictionary_od_values
--  INSERT INTO qgep_sys.dictionary_od_values (class_id, attribute_id, value_id, table_name, field_name, value_name, value_name_en, shortcut_en, value_name_de, shortcut_de, value_name_fr, shortcut_fr, value_name_it, shortcut_it, value_name_ro, shortcut_ro, value_description_en, value_description_de, value_description_fr, value_description_it, value_description_ro) VALUES (64,6219,6220,'overflow_char','kind_overflow_characteristic','hq','hq','','HQ','','HQ','','HQ','','','','yyy_H-Q Beziehung: Hoehe (H) und Durchfluss (Q) Richtung ARA abfüllen','H-Q Beziehung: Hoehe (H) und Durchfluss (Q) Richtung ARA abfüllen','ligne H / Q: H = hauteur d’eau lors du déversement [m.s.m.], Q = débit conservé vers STEP [l/s]','Assegnare altezza (H) e portata (Q)','');
  
UPDATE qgep_sys.dictionary_od_values
SET field_name = 'kind_overflow_char'
WHERE (table_name = 'overflow_char' AND field_name = 'kind_overflow_characteristic')
RETURNING *;

--INSERT INTO qgep_sys.dictionary_od_values (class_id, attribute_id, value_id, table_name, field_name, value_name, value_name_en, shortcut_en, value_name_de, shortcut_de, value_name_fr, shortcut_fr, value_name_it, shortcut_it, value_name_ro, shortcut_ro, value_description_en, value_description_de, value_description_fr, value_description_it, value_description_ro) VALUES (64,6222,6223,'overflow_char','overflow_characteristic_digital','yes','yes','','ja','','oui','','si','','','','','','','','');

UPDATE qgep_sys.dictionary_od_values
SET field_name = 'overflow_char_digital'
WHERE (table_name = 'overflow_char' AND field_name = 'overflow_characteristic_digital')
RETURNING *;