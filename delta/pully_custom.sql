--Ajout du matériau pour le radier

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_bottom_material integer;

CREATE TABLE qgep_vl.pully_node_bottom_material () INHERITS (qgep_sys.value_list_base);
ALTER TABLE qgep_vl.pully_node_bottom_material ADD CONSTRAINT pkey_qgep_vl_pully_node_bottom_material_code PRIMARY KEY (code);
 INSERT INTO qgep_vl.pully_node_bottom_material (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (4540,4540,'other','andere','autre', 'altro', 'altul', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.pully_node_bottom_material (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (4541,4541,'concrete','Beton','beton', 'zzz_Beton', 'beton', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.pully_node_bottom_material (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (4542,4542,'plastic','Kunststoff','matiere_plastique', 'zzz_Kunststoff', 'materie_plastica', '', '', '', '', '', 'true');
 INSERT INTO qgep_vl.pully_node_bottom_material (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (4543,4543,'unknown','unbekannt','inconnu', 'sconosciuto', 'necunoscut', '', '', '', '', '', 'true');
 ALTER TABLE qgep_od.wastewater_node ADD CONSTRAINT fkey_vl_pully_node_bottom_material FOREIGN KEY (pully_bottom_material)
 REFERENCES qgep_vl.pully_node_bottom_material (code) MATCH SIMPLE 
ON UPDATE RESTRICT ON DELETE RESTRICT;

/*Ajout du type de noeud pour les noeuds réseau*/

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_node_type integer;

CREATE TABLE qgep_vl.pully_node_type () INHERITS (qgep_sys.value_list_base);

ALTER TABLE qgep_vl.pully_node_type ADD CONSTRAINT pkey_qgep_vl_pully_node_type_code PRIMARY KEY (code);

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10001,10001,'bottom','sohle','radier', '', '', 'B', 'S', 'R', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10002,10002,'channel_start','','debut_canal', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10003,10003,'change_year_of_construction','','changement_annee_construction', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10004,10004,'change_diameter_material','','changement_diametre_materiau', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10005,10005,'change_diameter','','changement_diametre', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10006,10006,'change_material','','changement_materiau', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10007,10007,'change_slope','','changement_pente', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10008,10008,'channel_connection','','raccord_collecteur', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_node_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10009,10009,'se_evac','','systeme_evacuation', '', '', '', '', '', '', '', 'true');

/* Ajout du type de système d'évacuation*/

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_se_type integer;

CREATE TABLE qgep_vl.pully_se_type () INHERITS (qgep_sys.value_list_base);

ALTER TABLE qgep_vl.pully_se_type ADD CONSTRAINT pkey_qgep_vl_pully_se_type_code PRIMARY KEY (code);

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10101,10101,'utility_room','','buanderie', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10102,10102,'grating','','caillebotis', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10103,10103,'gutter','','chéneau', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10104,10104,'drop_column','','colonne_de_chute', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10105,10105,'kitchen','','cuisine', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10106,10106,'sink','','evier', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10107,10107,'connection','','raccordement', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10108,10108,'dispatch','','separateur', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10109,10109,'toilets','','wc', '', '', '', '', '', '', '', 'true');

INSERT INTO qgep_vl.pully_se_type (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active)
 VALUES (10110,10110,'manhole','','chambre_de_visite', '', '', '', '', '', '', '', 'true');

/* Ajout des orientations */

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_orientation double precision DEFAULT 0;

/* Ajout des précisions des radiers */

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_fk_positional_accuracy integer;

CREATE TABLE qgep_vl.pully_node_positional_accuracy () INHERITS (qgep_sys.value_list_base);
ALTER TABLE qgep_vl.pully_node_positional_accuracy ADD CONSTRAINT pkey_qgep_vl_pully_node_positional_accuracy_code PRIMARY KEY (code);
 INSERT INTO qgep_vl.pully_node_positional_accuracy (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (14780,14780,'accurate','genau','precise', 'precisa', 'precisa', '', 'LG', 'P', '', '', 'true');
 INSERT INTO qgep_vl.pully_node_positional_accuracy (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (14778,14778,'unknown','unbekannt','inconnue', 'sconosciuto', 'necunoscuta', '', 'U', 'I', '', '', 'true');
 INSERT INTO qgep_vl.pully_node_positional_accuracy (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (14779,14779,'inaccurate','ungenau','imprecise', 'impreciso', 'imprecisa', '', 'LU', 'IP', '', '', 'true');
 ALTER TABLE qgep_od.wastewater_node ADD CONSTRAINT fkey_vl_pully_node_positional_accuracy FOREIGN KEY (pully_fk_positional_accuracy)
 REFERENCES qgep_vl.pully_node_positional_accuracy (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;

/* Ajout des références objet de topobase*/

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_id_topobase character varying(40);

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_table_topobase character varying(40);

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_db_topobase character varying(40);

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_validation boolean;

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_fk_chantier integer;

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_controle_video_date date;

ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN pully_controle_terrain_date date;

/* Insertion des références objet des couvercles */

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_id_topobase character varying(40);

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_table_topobase character varying(40);

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_db_topobase character varying(40);

/* Insertion des références objet des couvercles */

ALTER TABLE qgep_od.cover
ADD COLUMN pully_id_topobase character varying(40);

ALTER TABLE qgep_od.cover
ADD COLUMN pully_table_topobase character varying(40);

ALTER TABLE qgep_od.cover
ADD COLUMN pully_db_topobase character varying(40);

/*
ALTER TABLE qgep_od.wastewater_structure
ADD COLUMN fk_district integer;

ALTER TABLE qgep_od.wastewater_structure
ADD CONSTRAINT ws_fk_district FOREIGN KEY (fk_district)
        REFERENCES qgep_od.district (id) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

CREATE TABLE qgep_od.district
(
    id integer NOT NULL DEFAULT nextval('qgep_od.district_id_seq'::regclass),
    name character varying(40) NOT NULL,
    shortname character varying(12),
    zip character varying(12),
    land_registry character varying(12),
    prefix character varying(12),
    geometry geometry(MultiPolygon,21781),
    CONSTRAINT district_pkey PRIMARY KEY (id),
    CONSTRAINT district_name UNIQUE (name)
);

CREATE INDEX district_geoidx
    ON qgep_od.district USING gist
    (geometry)
    TABLESPACE pg_default;

*/

-- UPDATE structure_condition values

UPDATE qgep_vl.wastewater_structure_structure_condition
SET value_fr = 'Z0_ne_fonctionne_plus'
WHERE code = 3363;

UPDATE qgep_vl.wastewater_structure_structure_condition
SET value_fr = 'Z1_defauts_graves'
WHERE code = 3359;

UPDATE qgep_vl.wastewater_structure_structure_condition
SET value_fr = 'Z2_defauts_moyens'
WHERE code = 3360;

UPDATE qgep_vl.wastewater_structure_structure_condition
SET value_fr = 'Z3_defauts_legers'
WHERE code = 3361;

UPDATE qgep_vl.wastewater_structure_structure_condition
SET value_fr = 'Z4_aucun_defaut'
WHERE code = 3362;

-- Activation_desactivation des valeurs inutilisées
/*Fonctions des chambres*/
UPDATE qgep_vl.manhole_function
SET active = FALSE
WHERE code IN (4532,4536,4537,4798,5344,5346,5347);

/*Fonctions des chambres spéciales*/
UPDATE qgep_vl.special_structure_function
SET active = FALSE
WHERE code IN (2998,386,5371,5373,5091,5575,5576,3673,3675,3676,3677,383,2745,3234,3348);

/*Fonctions des structures d'évacuation en double*/
UPDATE qgep_vl.pully_se_type
SET active = FALSE
WHERE code IN (10110,10103,10102,10107,10108);

/*Fonctions hierarchiques*/
UPDATE qgep_vl.channel_function_hierarchic
SET active = FALSE
WHERE code NOT IN (5075,5074,5065,5069);

/*Usage current */
UPDATE qgep_vl.channel_usage_current
SET active = FALSE
WHERE code NOT IN (4571,4526,4514,4522);

/* cover_positional_accuracy */
 INSERT INTO qgep_vl.cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (15378,15378,'accurate','genau','precise', 'precisa', 'precisa', '', 'LG', 'P', '', '', 'true');
 INSERT INTO qgep_vl.cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (15379,15379,'unknown','unbekannt','inconnue', 'sconosciuto', 'necunoscuta', '', 'U', 'I', '', '', 'true');
 INSERT INTO qgep_vl.cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (15380,15380,'inaccurate','ungenau','imprecise', 'impreciso', 'imprecisa', '', 'LU', 'IP', '', '', 'true');

UPDATE qgep_vl.cover_positional_accuracy
SET active = FALSE
WHERE code NOT IN (15378,15379,15380);

/*
UPDATE qgep_vl.channel_function_hierarchic
SET active = FALSE
WHERE code IN ();
*/

/*
UPDATE qgep_vl.special_structure_function
SET active = FALSE
WHERE code IN ();
*/

UPDATE qgep_vl.reach_material
SET active = FALSE
WHERE code IN (3640,2761);

GRANT ALL ON TABLE qgep_vl.reach_material TO qgep;

REFRESH MATERIALIZED VIEW qgep_od.vw_network_node with data;
REFRESH MATERIALIZED VIEW qgep_od.vw_network_segment with data;

/* Insert qgep_dr missing*/

-- Add Grants for construction sequences
GRANT ALL ON SEQUENCE qgep_dr.constructionpoint_id_seq TO qgep_user;
GRANT ALL ON SEQUENCE qgep_dr.constructionline_id_seq TO qgep_user;

/* add expected usage for unconnected nodes */

ALTER TABLE qgep_od.wastewater_node
ADD COLUMN pully_fk_usage_expected integer;

CREATE TABLE qgep_vl.pully_node_usage_expected () INHERITS (qgep_sys.value_list_base);
ALTER TABLE qgep_vl.pully_node_usage_expected ADD CONSTRAINT pkey_qgep_vl_pully_node_usage_expected_code PRIMARY KEY (code);
INSERT INTO qgep_vl.pully_node_usage_expected (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (14514,4514,'clean_wastewater','Reinabwasser','eaux_claires', 'acque_chiare', 'ape_conventional_curate', '', 'KW', 'EUR', '', '', 'true');
INSERT INTO qgep_vl.pully_node_usage_expected (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (14526,4526,'wastewater','Schmutzabwasser','eaux_usees', 'acque_luride', 'ape_uzate', '', 'SW', 'EU', '', '', 'true');
INSERT INTO qgep_vl.pully_node_usage_expected (code, vsacode, value_en, value_de, value_fr, value_it, value_ro, abbr_en, abbr_de, abbr_fr, abbr_it, abbr_ro, active) VALUES (14571,4571,'unknown','unbekannt','inconnu', 'sconosciuto', 'necunoscuta', '', 'U', 'I', '', '', 'true');
ALTER TABLE qgep_od.wastewater_node ADD CONSTRAINT fkey_vl_pully_node_usage_expected FOREIGN KEY (pully_fk_usage_expected)
  REFERENCES qgep_vl.pully_node_usage_expected (code) MATCH SIMPLE 
  ON UPDATE RESTRICT ON DELETE RESTRICT;
