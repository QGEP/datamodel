-- Adapting first differences between the qgep kek extension and the latest release of vsa-kek 2019 for making INTERLIS import VSA-KEK plugin work.
-- Full changes will be done in a next release (expected to be 1.6.0)


-- Adding further changes to attributes and values
-- 1.5.6.2_kek_update_attribute_maintenance_event_identifier - Changing from varchar (20) to varchar (41) so that longer identifiers can be imported as in testdata

ALTER TABLE qgep_od.maintenance_event ALTER COLUMN  identifier TYPE varchar(41) ;
COMMENT ON COLUMN qgep_od.maintenance_event.identifier IS '';

-- 1.5.6.3_kek_update_attribute_maintenance_event_result - Changing from varchar (80) to varchar (255) so that longer identifiers can be imported as in testdata

ALTER TABLE qgep_od.maintenance_event ALTER COLUMN  result TYPE varchar(255) ;
COMMENT ON COLUMN qgep_od.maintenance_event.result IS 'Result or important comments for this event / Resultat oder wichtige Bemerkungen aus Sicht des Bearbeiters / Résultat ou commentaire importante de l''événement';


-- 1.5.6.5_kek_add_vl_file_kind_add_new_values

INSERT INTO qgep_vl.file_kind (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (9147,9147,'scan','Scan','scan', 'scan', 'rrr_Scan', '', '', '', '', '', 'true');
INSERT INTO qgep_vl.file_kind (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8812,8812,'sketch','Skizze','croquis', 'schizzo', 'rrr_Skizze', '', '', '', '', '', 'true');
INSERT INTO qgep_vl.file_kind (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (9146,9146,'digital_video','digitales_Video','video_numerique', 'video_digitale', 'rrr_digitales_Video', '', '', '', '', '', 'true');

-- correct data
UPDATE qgep_od.file
SET kind = 9146
WHERE  kind = 3771;

-- set old value to false
UPDATE qgep_vl.file_kind
SET active = false
WHERE  code = 3771;

-- 1.5.6.7_kek_add_vl_damage_manhole_manhole_damage_code_add_new_values
-- adding new codes to code lists

 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8909,8909,'DABAE','DABAE','DABAE', 'DABAE', 'DABAE', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8910,8910,'DABBE','DABBE','DABBE', 'DABBE', 'DABBE', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8911,8911,'DABCE','DABCE','DABCE', 'DABCE', 'DABCE', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8912,8912,'DAFAZ','DAFAZ','DAFAZ', 'DAFAZ', 'DAFAZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8913,8913,'DAFBZ','DAFBZ','DAFBZ', 'DAFBZ', 'DAFBZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8914,8914,'DAFCZ','DAFCZ','DAFCZ', 'DAFCZ', 'DAFCZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8915,8915,'DAFDZ','DAFDZ','DAFDZ', 'DAFDZ', 'DAFDZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8916,8916,'DAFEZ','DAFEZ','DAFEZ', 'DAFEZ', 'DAFEZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8917,8917,'DAFFZ','DAFFZ','DAFFZ', 'DAFFZ', 'DAFFZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8918,8918,'DAFGZ','DAFGZ','DAFGZ', 'DAFGZ', 'DAFGZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8919,8919,'DAFIZ','DAFIZ','DAFIZ', 'DAFIZ', 'DAFIZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8920,8920,'DAFJZ','DAFJZ','DAFJZ', 'DAFJZ', 'DAFJZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8921,8921,'DAFKA','DAFKA','DAFKA', 'DAFKA', 'DAFKA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8922,8922,'DAFKE','DAFKE','DAFKE', 'DAFKE', 'DAFKE', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8923,8923,'DAFKZ','DAFKZ','DAFKZ', 'DAFKZ', 'DAFKZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8924,8924,'DAFZZ','DAFZZ','DAFZZ', 'DAFZZ', 'DAFZZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8925,8925,'DAKDD','DAKDD','DAKDD', 'DAKDD', 'DAKDD', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8926,8926,'DAKF','DAKF','DAKF', 'DAKF', 'DAKF', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8927,8927,'DAKG','DAKG','DAKG', 'DAKG', 'DAKG', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8928,8928,'DAKH','DAKH','DAKH', 'DAKH', 'DAKH', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8929,8929,'DAKI','DAKI','DAKI', 'DAKI', 'DAKI', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8930,8930,'DAKJ','DAKJ','DAKJ', 'DAKJ', 'DAKJ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8931,8931,'DAKK','DAKK','DAKK', 'DAKK', 'DAKK', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8932,8932,'DAKL','DAKL','DAKL', 'DAKL', 'DAKL', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8933,8933,'DAKM','DAKM','DAKM', 'DAKM', 'DAKM', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8934,8934,'DAKN','DAKN','DAKN', 'DAKN', 'DAKN', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8935,8935,'DALC','DALC','DALC', 'DALC', 'DALC', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8936,8936,'DALD','DALD','DALD', 'DALD', 'DALD', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8937,8937,'DALE','DALE','DALE', 'DALE', 'DALE', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8938,8938,'DALF','DALF','DALF', 'DALF', 'DALF', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8939,8939,'DALG','DALG','DALG', 'DALG', 'DALG', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8940,8940,'DCBD','DCBD','DCBD', 'DCBD', 'DCBD', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8941,8941,'DCBE','DCBE','DCBE', 'DCBE', 'DCBE', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8942,8942,'DCBF','DCBF','DCBF', 'DCBF', 'DCBF', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8943,8943,'DCHC','DCHC','DCHC', 'DCHC', 'DCHC', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8944,8944,'DCIAA','DCIAA','DCIAA', 'DCIAA', 'DCIAA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8945,8945,'DCIAB','DCIAB','DCIAB', 'DCIAB', 'DCIAB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8946,8946,'DCIAC','DCIAC','DCIAC', 'DCIAC', 'DCIAC', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8947,8947,'DCIAD','DCIAD','DCIAD', 'DCIAD', 'DCIAD', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8948,8948,'DCIAZ','DCIAZ','DCIAZ', 'DCIAZ', 'DCIAZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8949,8949,'DCIBY','DCIBY','DCIBY', 'DCIBY', 'DCIBY', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8950,8950,'DCICY','DCICY','DCICY', 'DCICY', 'DCICY', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8951,8951,'DDCAB','DDCAB','DDCAB', 'DDCAB', 'DDCAB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8952,8952,'DDCAZ','DDCAZ','DDCAZ', 'DDCAZ', 'DDCAZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8953,8953,'DDCBA','DDCBA','DDCBA', 'DDCBA', 'DDCBA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8954,8954,'DDCBB','DDCBB','DDCBB', 'DDCBB', 'DDCBB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8955,8955,'DDCBZ','DDCBZ','DDCBZ', 'DDCBZ', 'DDCBZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8956,8956,'DDCCA','DDCCA','DDCCA', 'DDCCA', 'DDCCA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8957,8957,'DDCCB','DDCCB','DDCCB', 'DDCCB', 'DDCCB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8958,8958,'DDCCZ','DDCCZ','DDCCZ', 'DDCCZ', 'DDCCZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8959,8959,'DDCDA','DDCDA','DDCDA', 'DDCDA', 'DDCDA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8960,8960,'DDCDB','DDCDB','DDCDB', 'DDCDB', 'DDCDB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8961,8961,'DDCDZ','DDCDZ','DDCDZ', 'DDCDZ', 'DDCDZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8962,8962,'DDCZA','DDCZA','DDCZA', 'DDCZA', 'DDCZA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8963,8963,'DDCZB','DDCZB','DDCZB', 'DDCZB', 'DDCZB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8964,8964,'DDCZZ','DDCZZ','DDCZZ', 'DDCZZ', 'DDCZZ', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8965,8965,'DDECA','DDECA','DDECA', 'DDECA', 'DDECA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8966,8966,'DDECB','DDECB','DDECB', 'DDECB', 'DDECB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8967,8967,'DDECC','DDECC','DDECC', 'DDECC', 'DDECC', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8968,8968,'DDEDA','DDEDA','DDEDA', 'DDEDA', 'DDEDA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8969,8969,'DDEDB','DDEDB','DDEDB', 'DDEDB', 'DDEDB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8970,8970,'DDEDC','DDEDC','DDEDC', 'DDEDC', 'DDEDC', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8971,8971,'DDEEA','DDEEA','DDEEA', 'DDEEA', 'DDEEA', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8972,8972,'DDEEB','DDEEB','DDEEB', 'DDEEB', 'DDEEB', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.damage_manhole_manhole_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8973,8973,'DDEEC','DDEEC','DDEEC', 'DDEEC', 'DDEEC', '', '', '', '', '', 'true');

 


-- 1.5.6.8_kek_add_vl_damage_channel_channel_damage_code_add_new_values
-- adding new codes to code lists

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8834,8834,'BABAE','BABAE','BABAE', 'BABAE', 'BABAE', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8835,8835,'BABBE','BABBE','BABBE', 'BABBE', 'BABBE', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8836,8836,'BABCE','BABCE','BABCE', 'BABCE', 'BABCE', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8837,8837,'BAFAZ','BAFAZ','BAFAZ', 'BAFAZ', 'BAFAZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8838,8838,'BAFBZ','BAFBZ','BAFBZ', 'BAFBZ', 'BAFBZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8839,8839,'BAFCZ','BAFCZ','BAFCZ', 'BAFCZ', 'BAFCZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8840,8840,'BAFDZ','BAFDZ','BAFDZ', 'BAFDZ', 'BAFDZ', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8841,8841,'BAFEZ','BAFEZ','BAFEZ', 'BAFEZ', 'BAFEZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8842,8842,'BAFFZ','BAFFZ','BAFFZ', 'BAFFZ', 'BAFFZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8843,8843,'BAFGZ','BAFGZ','BAFGZ', 'BAFGZ', 'BAFGZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8844,8844,'BAFIZ','BAFIZ','BAFIZ', 'BAFIZ', 'BAFIZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8845,8845,'BAFJZ','BAFJZ','BAFJZ', 'BAFJZ', 'BAFJZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8846,8846,'BAFKA','BAFKA','BAFKA', 'BAFKA', 'BAFKA', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8847,8847,'BAFKE','BAFKE','BAFKE', 'BAFKE', 'BAFKE', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8848,8848,'BAFKZ','BAFKZ','BAFKZ', 'BAFKZ', 'BAFKZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8849,8849,'BAFZZ','BAFZZ','BAFZZ', 'BAFZZ', 'BAFZZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8850,8850,'BAKDD','BAKDD','BAKDD', 'BAKDD', 'BAKDD', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8851,8851,'BAKF','BAKF','BAKF', 'BAKF', 'BAKF', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8852,8852,'BAKG','BAKG','BAKG', 'BAKG', 'BAKG', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8853,8853,'BAKH','BAKH','BAKH', 'BAKH', 'BAKH', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8854,8854,'BAKI','BAKI','BAKI', 'BAKI', 'BAKI', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8855,8855,'BAKJ','BAKJ','BAKJ', 'BAKJ', 'BAKJ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8856,8856,'BAKK','BAKK','BAKK', 'BAKK', 'BAKK', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8857,8857,'BAKL','BAKL','BAKL', 'BAKL', 'BAKL', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8858,8858,'BAKM','BAKM','BAKM', 'BAKM', 'BAKM', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8859,8859,'BAKN','BAKN','BAKN', 'BAKN', 'BAKN', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8860,8860,'BALC','BALC','BALC', 'BALC', 'BALC', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8861,8861,'BALD','BALD','BALD', 'BALD', 'BALD', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8862,8862,'BALE','BALE','BALE', 'BALE', 'BALE', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8863,8863,'BALF','BALF','BALF', 'BALF', 'BALF', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8864,8864,'BALGA','BALGA','BALGA', 'BALGA', 'BALGA', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8865,8865,'BALGB','BALGB','BALGB', 'BALGB', 'BALGB', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8866,8866,'BALGC','BALGC','BALGC', 'BALGC', 'BALGC', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8867,8867,'BALGD','BALGD','BALGD', 'BALGD', 'BALGD', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8868,8868,'BCBF','BCBF','BCBF', 'BCBF', 'BCBF', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8869,8869,'BCBG','BCBG','BCBG', 'BCBG', 'BCBG', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8870,8870,'BCDXP','BCDXP','BCDXP', 'BCDXP', 'BCDXP', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8871,8871,'BCEXP','BCEXP','BCEXP', 'BCEXP', 'BCEXP', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8872,8872,'BDBM','BDBM','BDBM', 'BDBM', 'BDBM', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8873,8873,'BDCAA','BDCAA','BDCAA', 'BDCAA', 'BDCAA', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8874,8874,'BDCAB','BDCAB','BDCAB', 'BDCAB', 'BDCAB', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8875,8875,'BDCAC','BDCAC','BDCAC', 'BDCAC', 'BDCAC', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8876,8876,'BDCAD','BDCAD','BDCAD', 'BDCAD', 'BDCAD', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8877,8877,'BDCAE','BDCAE','BDCAE', 'BDCAE', 'BDCAE', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8878,8878,'BDCAZ','BDCAZ','BDCAZ', 'BDCAZ', 'BDCAZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8879,8879,'BDCBA','BDCBA','BDCBA', 'BDCBA', 'BDCBA', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8880,8880,'BDCBB','BDCBB','BDCBB', 'BDCBB', 'BDCBB', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8881,8881,'BDCBC','BDCBC','BDCBC', 'BDCBC', 'BDCBC', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8882,8882,'BDCBD','BDCBD','BDCBD', 'BDCBD', 'BDCBD', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8883,8883,'BDCBE','BDCBE','BDCBE', 'BDCBE', 'BDCBE', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8884,8884,'BDCBZ','BDCBZ','BDCBZ', 'BDCBZ', 'BDCBZ', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8885,8885,'BDCCA','BDCCA','BDCCA', 'BDCCA', 'BDCCA', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8886,8886,'BDCCB','BDCCB','BDCCB', 'BDCCB', 'BDCCB', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8887,8887,'BDCCC','BDCCC','BDCCC', 'BDCCC', 'BDCCC', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8888,8888,'BDCCD','BDCCD','BDCCD', 'BDCCD', 'BDCCD', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8889,8889,'BDCCE','BDCCE','BDCCE', 'BDCCE', 'BDCCE', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8890,8890,'BDCCZ','BDCCZ','BDCCZ', 'BDCCZ', 'BDCCZ', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8891,8891,'BDCZA','BDCZA','BDCZA', 'BDCZA', 'BDCZA', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8892,8892,'BDCZB','BDCZB','BDCZB', 'BDCZB', 'BDCZB', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8893,8893,'BDCZC','BDCZC','BDCZC', 'BDCZC', 'BDCZC', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8894,8894,'BDCZD','BDCZD','BDCZD', 'BDCZD', 'BDCZD', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8895,8895,'BDCZE','BDCZE','BDCZE', 'BDCZE', 'BDCZE', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8896,8896,'BDCZZ','BDCZZ','BDCZZ', 'BDCZZ', 'BDCZZ', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8897,8897,'BDDC','BDDC','BDDC', 'BDDC', 'BDDC', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8898,8898,'BDDD','BDDD','BDDD', 'BDDD', 'BDDD', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8899,8899,'BDDE','BDDE','BDDE', 'BDDE', 'BDDE', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8900,8900,'BDECA','BDECA','BDECA', 'BDECA', 'BDECA', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8901,8901,'BDECB','BDECB','BDECB', 'BDECB', 'BDECB', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8902,8902,'BDECC','BDECC','BDECC', 'BDECC', 'BDECC', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8903,8903,'BDEDA','BDEDA','BDEDA', 'BDEDA', 'BDEDA', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8904,8904,'BDEDB','BDEDB','BDEDB', 'BDEDB', 'BDEDB', '', '', '', '', '', 'true');

 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8905,8905,'BDEDC','BDEDC','BDEDC', 'BDEDC', 'BDEDC', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8906,8906,'BDEEA','BDEEA','BDEEA', 'BDEEA', 'BDEEA', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8907,8907,'BDEEB','BDEEB','BDEEB', 'BDEEB', 'BDEEB', '', '', '', '', '', 'true');
 
 INSERT INTO qgep_vl.damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (8908,8908,'BDEEC','BDEEC','BDEEC', 'BDEEC', 'BDEEC', '', '', '', '', '', 'true');


-- Allow to insert multiple rows at once despite cyclic dependencies
ALTER TABLE qgep_od.reach_point ALTER CONSTRAINT rel_reach_point_wastewater_networkelement DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE qgep_od.structure_part ALTER CONSTRAINT rel_structure_part_wastewater_structure DEFERRABLE INITIALLY IMMEDIATE;
