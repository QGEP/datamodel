

-- add missing table to dictionary
INSERT INTO qgep.is_dictionary_od_table (id, tablename, name_en, shortcut_en, name_de, shortcut_de, name_fr, shortcut_fr, name_it, shortcut_it, name_ro, shortcut_ro) VALUES (99990,'od_damage','damage','DM','Beschädigung','BD','Dégâts','DG','zzz','zz','zzz','zz');
INSERT INTO qgep.is_dictionary_od_table (id, tablename, name_en, shortcut_en, name_de, shortcut_de, name_fr, shortcut_fr, name_it, shortcut_it, name_ro, shortcut_ro) VALUES (99991,'od_examination','examniation','EM','Untersuchung','US','Inspection','IS','zzz','zz','zzz','zz');
INSERT INTO qgep.is_dictionary_od_table (id, tablename, name_en, shortcut_en, name_de, shortcut_de, name_fr, shortcut_fr, name_it, shortcut_it, name_ro, shortcut_ro) VALUES (99992,'od_damage_channel','channel damage','CD','xxx','xx','Dégâts de collecteur','DC','zzz','zz','zzz','zz');
INSERT INTO qgep.is_dictionary_od_table (id, tablename, name_en, shortcut_en, name_de, shortcut_de, name_fr, shortcut_fr, name_it, shortcut_it, name_ro, shortcut_ro) VALUES (99993,'od_damage_manhole','manhole damage','MD','xxx','xx','Dégâts de chambre','DH','zzz','zz','zzz','zz');


-- rename damage code
ALTER TABLE qgep.od_damage_manhole RENAME damage_code_manhole TO damage_code;
ALTER TABLE qgep.od_damage_channel RENAME channel_damage_code TO damage_code;

-- set quantification1/2 type to integer
ALTER TABLE qgep.od_damage_manhole ALTER COLUMN quantification1 SET DATA TYPE integer USING quantification1::integer;
ALTER TABLE qgep.od_damage_manhole ALTER COLUMN quantification2 SET DATA TYPE integer USING quantification2::integer;
ALTER TABLE qgep.od_damage_channel ALTER COLUMN quantification1 SET DATA TYPE integer USING quantification1::integer;
ALTER TABLE qgep.od_damage_channel ALTER COLUMN quantification2 SET DATA TYPE integer USING quantification2::integer;

-- rename vl tables
ALTER TABLE qgep.vl_damage_channel_channel_damage_code RENAME TO vl_damage_channel_code;
ALTER TABLE qgep.vl_damage_manhole_damage_code_manhole RENAME TO vl_damage_manhole_code;

--fix typo
ALTER TABLE qgep.od_examination RENAME inspected_lenght TO inspected_length;

-- remove redundant field
ALTER TABLE qgep.od_examination DROP COLUMN operator;
