------ This file generates the VSA-DSS database (Modul alles) in en on QQIS
------ For questions etc. please contact Stefan Burckhardt stefan.burckhardt@sjib.ch
------ version 16.10.2015 15:43:51
BEGIN;
------ CREATE SCHEMA qgep;

------ LAST MODIFIED -----
CREATE FUNCTION qgep.update_last_modified() RETURNS trigger AS $$
BEGIN
 NEW.last_modification := TIMEOFDAY();

 RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

CREATE FUNCTION qgep.update_last_modified_parent() RETURNS trigger AS $$
DECLARE
 table_name TEXT;
BEGIN
 table_name = TG_ARGV[0];

 EXECUTE '
 UPDATE ' || table_name || '
 SET last_modification = TIMEOFDAY()::timestamp
 WHERE obj_id = ''' || NEW.obj_id || '''
';
 RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;
---------------------------

CREATE TABLE qgep.is_value_list_base
(
code integer NOT NULL,
vsacode integer NOT NULL,
value_en character varying(50),
value_de character varying(50),
value_fr character varying(50),
abbr_en character varying(3),
abbr_de character varying(3),
abbr_fr character varying(3),
active boolean,
CONSTRAINT pkey_qgep_value_list_code PRIMARY KEY (code)
)
WITH (
   OIDS = False
);
-------
CREATE TABLE qgep.txt_symbol
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_txt_symbol_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_txt_symbol_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.txt_symbol ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('txt_symbol');
COMMENT ON COLUMN qgep.txt_symbol.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.txt_symbol ADD COLUMN class  varchar(50) ;
COMMENT ON COLUMN qgep.txt_symbol.class IS 'Name of class that textclass is related to / Name der Klasse zu der die Textklasse gehört / xxx_Name der Klasse zu der die Textklasse gehört';
 ALTER TABLE qgep.txt_symbol ADD COLUMN plantype  integer ;
COMMENT ON COLUMN qgep.txt_symbol.plantype IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.txt_symbol.remark IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN symbol_scaling_heigth  decimal(2,1) ;
COMMENT ON COLUMN qgep.txt_symbol.symbol_scaling_heigth IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN symbol_scaling_width  decimal(2,1) ;
COMMENT ON COLUMN qgep.txt_symbol.symbol_scaling_width IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN symbolhali  smallint ;
COMMENT ON COLUMN qgep.txt_symbol.symbolhali IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN symbolori  decimal(4,1) ;
COMMENT ON COLUMN qgep.txt_symbol.symbolori IS '';
SELECT AddGeometryColumn('qgep', 'txt_symbol', 'symbolpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_txt_symbol_symbolpos_geometry ON qgep.txt_symbol USING gist (symbolpos_geometry );
COMMENT ON COLUMN qgep.txt_symbol.symbolpos_geometry IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN symbolvali  smallint ;
COMMENT ON COLUMN qgep.txt_symbol.symbolvali IS '';
 ALTER TABLE qgep.txt_symbol ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.txt_symbol.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.txt_symbol ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.txt_symbol.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.txt_symbol ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.txt_symbol.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.txt_symbol ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.txt_symbol.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.txt_symbol ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.txt_symbol.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_symbol
BEFORE UPDATE OR INSERT ON
 qgep.txt_symbol
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.txt_text
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_txt_text_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_txt_text_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.txt_text ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('txt_text');
COMMENT ON COLUMN qgep.txt_text.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.txt_text ADD COLUMN class  varchar(50) ;
COMMENT ON COLUMN qgep.txt_text.class IS 'Name of class that textclass is related to / Name der Klasse zu der die Textklasse gehört / xxx_Name der Klasse zu der die Textklasse gehört';
 ALTER TABLE qgep.txt_text ADD COLUMN plantype  integer ;
COMMENT ON COLUMN qgep.txt_text.plantype IS '';
 ALTER TABLE qgep.txt_text ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.txt_text.remark IS '';
 ALTER TABLE qgep.txt_text ADD COLUMN text  text ;
COMMENT ON COLUMN qgep.txt_text.text IS 'yyy_Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / valeur calculée à partir d’attributs, plusieurs lignes possible';
 ALTER TABLE qgep.txt_text ADD COLUMN texthali  smallint ;
COMMENT ON COLUMN qgep.txt_text.texthali IS '';
 ALTER TABLE qgep.txt_text ADD COLUMN textori  decimal(4,1) ;
COMMENT ON COLUMN qgep.txt_text.textori IS '';
SELECT AddGeometryColumn('qgep', 'txt_text', 'textpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_txt_text_textpos_geometry ON qgep.txt_text USING gist (textpos_geometry );
COMMENT ON COLUMN qgep.txt_text.textpos_geometry IS '';
 ALTER TABLE qgep.txt_text ADD COLUMN textvali  smallint ;
COMMENT ON COLUMN qgep.txt_text.textvali IS '';
 ALTER TABLE qgep.txt_text ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.txt_text.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.txt_text ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.txt_text.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.txt_text ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.txt_text.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_text
BEFORE UPDATE OR INSERT ON
 qgep.od_text
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_mutation
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_mutation_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_mutation_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_mutation ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_mutation');
COMMENT ON COLUMN qgep.od_mutation.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_mutation ADD COLUMN attribute  varchar(50) ;
COMMENT ON COLUMN qgep.od_mutation.attribute IS 'Attribute name of chosen object / Attributname des gewählten Objektes / Nom de l''attribut de l''objet à sélectionner';
 ALTER TABLE qgep.od_mutation ADD COLUMN class  varchar(50) ;
COMMENT ON COLUMN qgep.od_mutation.class IS 'Class name of chosen object / Klassenname des gewählten Objektes / Nom de classe de l''objet à sélectionner';
 ALTER TABLE qgep.od_mutation ADD COLUMN date_mutation  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_mutation.date_mutation IS 'if changed: Date/Time of changement. If deleted date/time of deleting / Bei geaendert Datum/Zeit der Änderung. Bei gelöscht Datum/Zeit der Löschung / changée: Date/Temps du changement. effacée: Date/Temps de la suppression';
 ALTER TABLE qgep.od_mutation ADD COLUMN date_time  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_mutation.date_time IS 'Date/Time of collecting data in the field. Else Date/Time of creating data set on the system / Datum/Zeit der Aufnahme im Feld falls vorhanden bei erstellt. Sonst Datum/Uhrzeit der Erstellung auf dem System / Date/temps de la relève, sinon date/temps de création dans le système';
 ALTER TABLE qgep.od_mutation ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_mutation.kind IS '';
 ALTER TABLE qgep.od_mutation ADD COLUMN last_value  varchar(100) ;
COMMENT ON COLUMN qgep.od_mutation.last_value IS 'last_value changed to text. Only with type=changed and deleted / Letzter Wert umgewandelt in Text. Nur bei ART=geaendert oder geloescht / Dernière valeur modifiée du texte. Seulement avec GENRE = changee ou effacee';
 ALTER TABLE qgep.od_mutation ADD COLUMN object  varchar(41) ;
COMMENT ON COLUMN qgep.od_mutation.object IS 'OBJ_ID of Object / OBJ_ID des Objektes / OBJ_ID de l''objet';
 ALTER TABLE qgep.od_mutation ADD COLUMN recorded_by  varchar(80) ;
COMMENT ON COLUMN qgep.od_mutation.recorded_by IS 'Name of person who recorded the dataset / Name des Aufnehmers im Feld / Nom de la personne, qui a relevé les données';
 ALTER TABLE qgep.od_mutation ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_mutation.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_mutation ADD COLUMN system_user  varchar(41) ;
COMMENT ON COLUMN qgep.od_mutation.system_user IS 'Name of system user / Name des Systembenutzers / Usager du système informatique';
 ALTER TABLE qgep.od_mutation ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_mutation.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_mutation ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_mutation.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_mutation ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_mutation.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_mutation ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_mutation.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_mutation ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_mutation.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_mutation
BEFORE UPDATE OR INSERT ON
 qgep.od_mutation
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_organisation
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_organisation_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_organisation_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_organisation ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_organisation');
COMMENT ON COLUMN qgep.od_organisation.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_organisation ADD COLUMN address  varchar(50) ;
COMMENT ON COLUMN qgep.od_organisation.address IS 'yyy_Attribut zur Verknüpfung der Adressdaten von Organisationen aus Fremdsystemen. Die VSA-DSS bildet keine Adressinformationen ab. Diese sind genügend oft in anderen Systemen vorhanden – eine Referenzattribut reicht. Siehe auch Organisation.UID. / Attribut zur Verknüpfung der Adressdaten von Organisationen aus Fremdsystemen. Die VSA-DSS bildet keine Adressinformationen ab. Diese sind genügend oft in anderen Systemen vorhanden – ein Referenzattribut reicht. Siehe auch Organisation.UID. / Attribut pour le lien des données liées à l’adressage d’organisations de systèmes extérieurs. La VSA-SDEE ne présente aucun adressage, car ces derniers sont déjà bien représentés dans d’autres systèmes. Voyez aussi ORGANISATION.UID.';
 ALTER TABLE qgep.od_organisation ADD COLUMN identifier  varchar(80) ;
COMMENT ON COLUMN qgep.od_organisation.identifier IS 'It is suggested to use real names, e.g. Sample_Community and not only Community. Or "Waste Water Association WWTP Example" and not only Waste Water Association because there will be multiple objects / Es wird empfohlen reale Namen zu nehmen, z.B. Mustergemeinde und nicht Gemeinde. Oder Abwasserverband ARA Muster und nicht nur Abwasserverband, da es sonst Probleme gibt bei der Zusammenführung der Daten. / Utilisez les noms réels, par ex. commune "exemple" et pas seulement commune. Ou "Association pour l''épuration des eaux usées STEP XXX" et pas seulement  Association pour l''épuration des eaux usées. Sinon vous risquer des problèmes en réunissant les donnée';
 ALTER TABLE qgep.od_organisation ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_organisation.remark IS 'yyy Fehler bei Zuordnung / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_organisation ADD COLUMN uid  varchar(12) ;
COMMENT ON COLUMN qgep.od_organisation.uid IS 'yyyReferenz zur Unternehmensidentifikation des Bundesamts fuer Statistik (www.uid.admin.ch), e.g. z.B. CHE123456789 / Referenz zur Unternehmensidentifikation des Bundesamts fuer Statistik (www.uid.admin.ch), z.B. CHE123456789 / Référence pour l’identification des entreprises selon l’Office fédéral de la statistique OFS (www.uid.admin.ch), par exemple: CHE123456789';
 ALTER TABLE qgep.od_organisation ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_organisation.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_organisation ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_organisation.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_organisation ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_organisation.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_organisation ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_organisation.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_organisation ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_organisation.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_organisation
BEFORE UPDATE OR INSERT ON
 qgep.od_organisation
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_zone
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_zone_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_zone_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_zone ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_zone');
COMMENT ON COLUMN qgep.od_zone.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_zone ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_zone.identifier IS '';
 ALTER TABLE qgep.od_zone ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_zone.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_zone ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_zone.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_zone ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_zone.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_zone ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_zone.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_zone ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_zone.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_zone ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_zone.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_zone
BEFORE UPDATE OR INSERT ON
 qgep.od_zone
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_farm
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_farm_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_farm_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_farm ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_farm');
COMMENT ON COLUMN qgep.od_farm.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_farm ADD COLUMN agriculture_aerable_surface  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_farm.agriculture_aerable_surface IS 'yyy_Landwirtschaftliche Nutzfläche in ha / Landwirtschaftliche Nutzfläche in ha / Surface agricole utile en ha';
 ALTER TABLE qgep.od_farm ADD COLUMN cesspit_comment  varchar(100) ;
COMMENT ON COLUMN qgep.od_farm.cesspit_comment IS 'Further remarks cesspit volume / Weitere Anmerkungen zur Güllegrube / Remarques additionnel volume fosse à purin';
 ALTER TABLE qgep.od_farm ADD COLUMN cesspit_volume  integer ;
COMMENT ON COLUMN qgep.od_farm.cesspit_volume IS 'yyy_Klassifizierung, ob das Volumen (teilweise) in einem Fremdbetrieb in der gleichen oder einer anderen Gemeinde vorhanden ist / Klassifizierung, ob das Volumen (teilweise) in einem Fremdbetrieb in der gleichen oder einer anderen Gemeinde vorhanden ist / Classification, si le volume est disponible (même partiellement) dans une exploitation externe dans la même commune ou dans une autre commune';
 ALTER TABLE qgep.od_farm ADD COLUMN cesspit_volume_current  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_farm.cesspit_volume_current IS 'yyy_Güllegrube: aktuell vorhandenes Volumen in m3 / Güllegrube: aktuell vorhandenes Volumen in m3 / Fosse à purin: volume actuel en m3';
 ALTER TABLE qgep.od_farm ADD COLUMN cesspit_volume_nominal  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_farm.cesspit_volume_nominal IS 'yyy_Güllegrube: erforderliches Volumen in m3  (Sollzustand); Vorgabe aus GEP / Güllegrube: erforderliches Volumen in m3  (Sollzustand); Vorgabe aus GEP / Fosse à purin: volume requis en m3; exigence selon PGEE';
 ALTER TABLE qgep.od_farm ADD COLUMN cesspit_volume_ww_treated  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_farm.cesspit_volume_ww_treated IS 'yyy_Güllegrube: erforderliches Volumen in m3, falls häusliches Abwasser separat behandelt würde / Güllegrube: erforderliches Volumen in m3, falls häusliches Abwasser separat behandelt würde / Fosse à purin: volume en m3 requis en cas de traitement séparé des eaux ménagères';
 ALTER TABLE qgep.od_farm ADD COLUMN cesspit_year_of_approval  smallint ;
COMMENT ON COLUMN qgep.od_farm.cesspit_year_of_approval IS 'yyy_Güllegrube: Bewilligungsjahr / Güllegrube: Bewilligungsjahr / Fosse à purin: année d''autorisation';
 ALTER TABLE qgep.od_farm ADD COLUMN conformity  integer ;
COMMENT ON COLUMN qgep.od_farm.conformity IS 'Conformity of Einrichtungen (Güllegrube, Mistplatz, etc.) / Konformität der Einrichtungen (Güllegrube, Mistplatz, etc.) / Conformité des installations (fosse à purin, fumière, etc.)';
 ALTER TABLE qgep.od_farm ADD COLUMN continuance  integer ;
COMMENT ON COLUMN qgep.od_farm.continuance IS 'yyy_Potentieller Fortbestand des Betriebs / Potentieller Fortbestand des Betriebs / Pérennité potentielle de l''exploitation';
 ALTER TABLE qgep.od_farm ADD COLUMN continuance_comment  varchar(80) ;
COMMENT ON COLUMN qgep.od_farm.continuance_comment IS 'yyy_Bemerkungen zum Fortbestand des Betriebs / Bemerkungen zum Fortbestand des Betriebs / Remarques concernant la pérennité de l''exploitation';
 ALTER TABLE qgep.od_farm ADD COLUMN muck_hill_area_current  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_farm.muck_hill_area_current IS 'yyy_Mistplatz: aktuell vorhandene Fläche in m2 / Mistplatz: aktuell vorhandene Fläche in m2 / Fumière: surface actuelle en m2';
 ALTER TABLE qgep.od_farm ADD COLUMN muck_hill_area_nominal  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_farm.muck_hill_area_nominal IS 'yyy_Mistplatz: erforderliche Fläche in m2 (Sollzustand); Vorgabe aus GEP / Mistplatz: erforderliche Fläche in m2 (Sollzustand); Vorgabe aus GEP / Fumière: surface requise en m2 ; exigence selon PGEE';
 ALTER TABLE qgep.od_farm ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_farm.remark IS 'General remarks / Allgmeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_farm ADD COLUMN shepherds_hut_comment  varchar(80) ;
COMMENT ON COLUMN qgep.od_farm.shepherds_hut_comment IS 'yyy_Hirtenhütte: Bemerkung betreffend Abwasserproduktion / Hirtenhütte: Bemerkung betreffend Abwasserproduktion / Rural / remise: remarque concernant production d''eau usée';
 ALTER TABLE qgep.od_farm ADD COLUMN shepherds_hut_population_equivalent  integer ;
COMMENT ON COLUMN qgep.od_farm.shepherds_hut_population_equivalent IS 'yyy_Hirtenhütte: Einwohnergleichwert / Hirtenhütte: Einwohnergleichwert / Rural / remise: équivalent-habitants';
 ALTER TABLE qgep.od_farm ADD COLUMN shepherds_hut_wastewater  integer ;
COMMENT ON COLUMN qgep.od_farm.shepherds_hut_wastewater IS 'yyy_Hirtenhütte: Fällt häusliches Abwasser an? / Hirtenhütte: Fällt häusliches Abwasser an? / Rural / remise: production d''eau usée?';
 ALTER TABLE qgep.od_farm ADD COLUMN stable_cattle  integer ;
COMMENT ON COLUMN qgep.od_farm.stable_cattle IS 'yyy_Stall: Vieh vorhanden? / Stall: Vieh vorhanden? / Etable / écurie: bétail existant?';
 ALTER TABLE qgep.od_farm ADD COLUMN stable_cattle_equivalent_other_cattle  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_farm.stable_cattle_equivalent_other_cattle IS 'yyy_Stall: Anzahl Tiere in Düngergrossvieheinheiten DGVE (Fremdvieh) fertiliser produced per livestock unit (FLU) / Stall: Anzahl Tiere in Düngergrossvieheinheiten DGVE (Fremdvieh) / Etable / écurie: nombre d''animaux exprimés en unité de gros bétail UGB (bétail "étranger")';
 ALTER TABLE qgep.od_farm ADD COLUMN stable_cattle_equivalent_own_cattle  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_farm.stable_cattle_equivalent_own_cattle IS 'yyy_Stall: Anzahl Tiere in Düngergrossvieheinheiten DGVE (eigenes Vieh) fertiliser produced per livestock unit (FLU) / Stall: Anzahl Tiere in Düngergrossvieheinheiten DGVE (eigenes Vieh) / Etable / écurie: nombre d''animaux exprimés en unité de gros bétail UGB (propre bétail)';
 ALTER TABLE qgep.od_farm ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_farm.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_farm ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_farm.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_farm ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_farm.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_farm ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_farm.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_farm ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_farm.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_farm
BEFORE UPDATE OR INSERT ON
 qgep.od_farm
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_building_group
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_building_group_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_building_group_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_building_group ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_building_group');
COMMENT ON COLUMN qgep.od_building_group.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_building_group ADD COLUMN camping_area  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_building_group.camping_area IS 'Camping: Area of camping in hectars / Camping: Fläche Campingplatz in ha / Camping: surface du camping en ha';
 ALTER TABLE qgep.od_building_group ADD COLUMN camping_lodgings  smallint ;
COMMENT ON COLUMN qgep.od_building_group.camping_lodgings IS 'Camping: Number of overnight stays per year / Camping: Anzahl Übernachtungen pro Jahr / Camping: nombre de nuitées par an';
 ALTER TABLE qgep.od_building_group ADD COLUMN church_seats  smallint ;
COMMENT ON COLUMN qgep.od_building_group.church_seats IS 'yyy_Kirche: Anzahl Sitzplätze (ohne Nebenräume) / Kirche: Anzahl Sitzplätze (ohne Nebenräume) / Eglise: nombre de places assises (sans pièces adjacentes)';
 ALTER TABLE qgep.od_building_group ADD COLUMN connecting_obligation  integer ;
COMMENT ON COLUMN qgep.od_building_group.connecting_obligation IS 'Obligation to connect the building group to the sewer systsem / Definiert, ob das Gebäude anschlusspflichtig ist / Obligation de raccordement';
 ALTER TABLE qgep.od_building_group ADD COLUMN connection_wwtp  integer ;
COMMENT ON COLUMN qgep.od_building_group.connection_wwtp IS '';
 ALTER TABLE qgep.od_building_group ADD COLUMN craft_employees  smallint ;
COMMENT ON COLUMN qgep.od_building_group.craft_employees IS 'yyy_Verwaltungsgebäude, Geschäftshaus, Fabrik (ohne Industrieabwasser): Anzahl Beschäftigte / Verwaltungsgebäude, Geschäftshaus, Fabrik (ohne Industrieabwasser): Anzahl Beschäftigte / Entreprise (sans eaux usées industrielles): nombre d''employés';
 ALTER TABLE qgep.od_building_group ADD COLUMN dorm_beds  smallint ;
COMMENT ON COLUMN qgep.od_building_group.dorm_beds IS 'Dormatory number of beds / Schlafsaal: Anzahl Betten / Dortoir: nombre de lits';
 ALTER TABLE qgep.od_building_group ADD COLUMN dorm_overnight_stays  smallint ;
COMMENT ON COLUMN qgep.od_building_group.dorm_overnight_stays IS 'Dormatory overnight stays / Schlafsaal: Anzahl Übernachtungen pro Jahr / Dortoir: nombre de nuitées par an';
 ALTER TABLE qgep.od_building_group ADD COLUMN drainage_map  integer ;
COMMENT ON COLUMN qgep.od_building_group.drainage_map IS 'yyy_Angabe ob Pläne der Entwässerungsanlagen vorhanden / Angabe ob Pläne der Entwässerungsanlagen vorhanden / Indication si plans des installations d''assainissement existants';
 ALTER TABLE qgep.od_building_group ADD COLUMN drinking_water_network  integer ;
COMMENT ON COLUMN qgep.od_building_group.drinking_water_network IS 'yyy_Angabe ob Trinkwasseranschluss an öffentliches Netz vorhanden / Angabe ob Trinkwasseranschluss an öffentliches Netz vorhanden / Indication si raccordement au réseau public d''eau potable existant';
 ALTER TABLE qgep.od_building_group ADD COLUMN drinking_water_others  integer ;
COMMENT ON COLUMN qgep.od_building_group.drinking_water_others IS 'yyy_Andere Trinkwasserversorgung als Netzanschluss (Hauptversorgung oder zusätzlich zum Netzanschluss) / Andere Trinkwasserversorgung als Netzanschluss (Hauptversorgung oder zusätzlich zum Netzanschluss) / Autre alimentation en eau potable que raccordement au réseau (alimentation principale ou supplémentaire au raccordement au réseau)';
 ALTER TABLE qgep.od_building_group ADD COLUMN electric_connection  integer ;
COMMENT ON COLUMN qgep.od_building_group.electric_connection IS 'yyy_Angabe ob Anschluss an Stromversorgung vorhanden / Angabe ob Anschluss an Stromversorgung vorhanden / Indication si raccordement au réseau électrique existant';
 ALTER TABLE qgep.od_building_group ADD COLUMN event_visitors  smallint ;
COMMENT ON COLUMN qgep.od_building_group.event_visitors IS 'yyy_Veranstaltung: Anzahl Besucher / Maximale Anzahl Besucher pro Veranstaltung / Nombre maximum de visiteurs par manifestation';
 ALTER TABLE qgep.od_building_group ADD COLUMN function  integer ;
COMMENT ON COLUMN qgep.od_building_group.function IS 'Kind of building use / Art der Gebäudenutzung / Genre d''affectation des bâtiments';
 ALTER TABLE qgep.od_building_group ADD COLUMN gym_area  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_building_group.gym_area IS 'yyy_Turnhalle: Hallenfläche in m2 / Turnhalle: Hallenfläche in m2 / Salle de gymnastique: surface de salle en m2';
 ALTER TABLE qgep.od_building_group ADD COLUMN holiday_accomodation  smallint ;
COMMENT ON COLUMN qgep.od_building_group.holiday_accomodation IS 'yyy_Ausschliesslich Feriennutzung: Anzahl Übernachtungen pro Jahr / Ausschliesslich Feriennutzung: Anzahl Übernachtungen pro Jahr / Uniquement vacances: nombre de nuitées par an';
 ALTER TABLE qgep.od_building_group ADD COLUMN hospital_beds  smallint ;
COMMENT ON COLUMN qgep.od_building_group.hospital_beds IS 'Hospital, Nursing home: Number of beds / Spital, Pflegeanstalt: Anzahl Betten / Hôpital, EMS: nombre de lits';
 ALTER TABLE qgep.od_building_group ADD COLUMN hotel_beds  smallint ;
COMMENT ON COLUMN qgep.od_building_group.hotel_beds IS 'Hotel: Number of beds / Hotel: Anzahl Betten / Hôtel: nombre de lits';
 ALTER TABLE qgep.od_building_group ADD COLUMN hotel_overnight_stays  smallint ;
COMMENT ON COLUMN qgep.od_building_group.hotel_overnight_stays IS 'Hotel: Number of overnight stays per year / Hotel: Anzahl Übernachtungen pro Jahr / Hôtel: nombre de nuitées par an';
 ALTER TABLE qgep.od_building_group ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_building_group.identifier IS '';
 ALTER TABLE qgep.od_building_group ADD COLUMN movie_theater_seats  smallint ;
COMMENT ON COLUMN qgep.od_building_group.movie_theater_seats IS 'Cinema: Number of seats / Kino: Anzahl Sitzplätze / Cinéma: nombre de places assises';
 ALTER TABLE qgep.od_building_group ADD COLUMN other_usage_population_equivalent  integer ;
COMMENT ON COLUMN qgep.od_building_group.other_usage_population_equivalent IS 'yyy_Einwohnergleichwert für andere Art der Gebäudenutzung / Einwohnergleichwert für andere Art der Gebäudenutzung / Equivalent-habitants d''autre genre d''affectation de bâtiment';
 ALTER TABLE qgep.od_building_group ADD COLUMN other_usage_type  varchar(50) ;
COMMENT ON COLUMN qgep.od_building_group.other_usage_type IS 'yyy_Beschreibung für andere Art der Gebäudenutzung / Beschreibung für andere Art der Gebäudenutzung / Description d''autre genre d''affectation de bâtiment';
 ALTER TABLE qgep.od_building_group ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_building_group.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_building_group ADD COLUMN restaurant_seats  smallint ;
COMMENT ON COLUMN qgep.od_building_group.restaurant_seats IS 'yyy_Stark frequentierte Gaststätte, wie Autobahnraststätte, Berggasthaus, etc.: Anzahl Sitzplätze / Stark frequentierte Gaststätte, wie Autobahnraststätte, Berggasthaus, etc.: Anzahl Sitzplätze / Restaurant très fréquenté, tel que restoroute, restaurant de montage, etc. : nombre de places assises';
 ALTER TABLE qgep.od_building_group ADD COLUMN restaurant_seats_hall_garden  smallint ;
COMMENT ON COLUMN qgep.od_building_group.restaurant_seats_hall_garden IS 'yyy_Restaurant: Anzahl Sitzplätze Säle und Garten / Restaurant: Anzahl Sitzplätze Säle und Garten / Restaurant: nombre de places salles et terrasses';
 ALTER TABLE qgep.od_building_group ADD COLUMN restaurant_seats_permanent  smallint ;
COMMENT ON COLUMN qgep.od_building_group.restaurant_seats_permanent IS 'yyy_Restaurant: Anzahl Sitzplätze (ohne Säle und Garten) / Restaurant: Anzahl Sitzplätze (ohne Säle und Garten) / Restaurant: nombre de places sans salles et terrasses';
 ALTER TABLE qgep.od_building_group ADD COLUMN school_students  smallint ;
COMMENT ON COLUMN qgep.od_building_group.school_students IS 'School: Number of pupils / Schule: Anzahl Schüler / Ecole: nombre d''élèves';
 ALTER TABLE qgep.od_building_group ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_building_group.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_building_group ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_building_group.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_building_group ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_building_group.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_building_group ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_building_group.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_building_group ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_building_group.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_building_group
BEFORE UPDATE OR INSERT ON
 qgep.od_building_group
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_building_group_baugwr
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_building_group_baugwr_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_building_group_baugwr_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_building_group_baugwr ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_building_group_baugwr');
COMMENT ON COLUMN qgep.od_building_group_baugwr.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN egid  integer ;
COMMENT ON COLUMN qgep.od_building_group_baugwr.egid IS 'yyy_EGID aus BAU/GWR der zur Gebäudegruppe gehörigen Gebäude / EGID aus BAU/GWR der zur Gebäudegruppe gehörigen Gebäude / EGID de BAU/RegBL des bâtiments appartenant au groupe de bâtiments';
 ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_building_group_baugwr.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_building_group_baugwr.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_building_group_baugwr.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_building_group_baugwr.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_building_group_baugwr.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_building_group_baugwr
BEFORE UPDATE OR INSERT ON
 qgep.od_building_group_baugwr
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_disposal
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_disposal_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_disposal_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_disposal ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_disposal');
COMMENT ON COLUMN qgep.od_disposal.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_disposal ADD COLUMN disposal_interval_current  decimal(4,2) ;
COMMENT ON COLUMN qgep.od_disposal.disposal_interval_current IS 'yyy_Abstände, in welchen das Bauwerk aktuell geleert wird (Jahre) / Abstände, in welchen das Bauwerk aktuell geleert wird (Jahre) / Fréquence à laquelle l''ouvrage subit actuellement une vidange (années)';
 ALTER TABLE qgep.od_disposal ADD COLUMN disposal_interval_nominal  decimal(4,2) ;
COMMENT ON COLUMN qgep.od_disposal.disposal_interval_nominal IS 'yyy_Abstände, in welchen das Bauwerk geleert werden sollte (Jahre); Vorgabe aus GEP / Abstände, in welchen das Bauwerk geleert werden sollte (Jahre); Vorgabe aus GEP / Fréquence à laquelle l''ouvrage devrait subir un vidange (années); exigence selon PGEE';
 ALTER TABLE qgep.od_disposal ADD COLUMN disposal_place_current  integer ;
COMMENT ON COLUMN qgep.od_disposal.disposal_place_current IS 'yyy_Ort der Schlammentsorgung im heutigen Zustand / Ort der Schlammentsorgung im heutigen Zustand / Lieu d''élimination des boues en état actuel';
 ALTER TABLE qgep.od_disposal ADD COLUMN disposal_place_planned  integer ;
COMMENT ON COLUMN qgep.od_disposal.disposal_place_planned IS 'yyy_Ort der Schlammentsorgung im Planungszustand (gemäss GEP) / Ort der Schlammentsorgung im Planungszustand (gemäss GEP) / Lieu d''élimination des boues en état planifié (selon PGEE)';
 ALTER TABLE qgep.od_disposal ADD COLUMN volume_pit_without_drain  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_disposal.volume_pit_without_drain IS 'yyy_Abflusslose Grube: Stapelraum in m3 / Abflusslose Grube: Stapelraum in m3 / Fosse étanche: volume de stockage en m3';
 ALTER TABLE qgep.od_disposal ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_disposal.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_disposal ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_disposal.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_disposal ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_disposal.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_disposal ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_disposal.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_disposal ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_disposal.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_disposal
BEFORE UPDATE OR INSERT ON
 qgep.od_disposal
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_sludge_treatment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_sludge_treatment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_sludge_treatment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_sludge_treatment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_sludge_treatment');
COMMENT ON COLUMN qgep.od_sludge_treatment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN composting  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.composting IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN dehydration  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.dehydration IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN digested_sludge_combustion  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.digested_sludge_combustion IS 'yyy_Dimensioning value der Verbrennungsanlage / Dimensionierungswert der Verbrennungsanlage / Valeur de dimensionnement de l''installation d''incinération';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN drying  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.drying IS 'yyy_Leistung thermische Trocknung / Leistung thermische Trocknung / Puissance du séchage thermique';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN fresh_sludge_combustion  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.fresh_sludge_combustion IS 'yyy_Dimensioning value der Verbrennungsanlage / Dimensionierungswert der Verbrennungsanlage / Valeur de dimensionnement de l''installation d''incinération';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN hygenisation  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.hygenisation IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.identifier IS '';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN predensification_of_excess_sludge  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.predensification_of_excess_sludge IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN predensification_of_mixed_sludge  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.predensification_of_mixed_sludge IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN predensification_of_primary_sludge  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.predensification_of_primary_sludge IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN stabilisation  integer ;
COMMENT ON COLUMN qgep.od_sludge_treatment.stabilisation IS 'yyy_Art der Schlammstabilisierung / Art der Schlammstabilisierung / Type de stabilisation des boues';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN stacking_of_dehydrated_sludge  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.stacking_of_dehydrated_sludge IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN stacking_of_liquid_sludge  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.stacking_of_liquid_sludge IS 'Dimensioning value / Dimensionierungswert / Valeur de dimensionnement';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_sludge_treatment.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_sludge_treatment.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_sludge_treatment.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_sludge_treatment ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_sludge_treatment.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_sludge_treatment
BEFORE UPDATE OR INSERT ON
 qgep.od_sludge_treatment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_waste_water_treatment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_waste_water_treatment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_waste_water_treatment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_waste_water_treatment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_waste_water_treatment');
COMMENT ON COLUMN qgep.od_waste_water_treatment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment.identifier IS '';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_waste_water_treatment.kind IS 'Type of wastewater  treatment / Verfahren für die Abwasserbehandlung / Genre de traitement des eaux usées';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_waste_water_treatment.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_waste_water_treatment.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_waste_water_treatment.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_waste_water_treatment
BEFORE UPDATE OR INSERT ON
 qgep.od_waste_water_treatment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_wwtp_energy_use
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wwtp_energy_use_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wwtp_energy_use_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wwtp_energy_use ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wwtp_energy_use');
COMMENT ON COLUMN qgep.od_wwtp_energy_use.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN gas_motor  integer ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.gas_motor IS 'electric power / elektrische Leistung / Puissance électrique';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN heat_pump  integer ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.heat_pump IS 'Energy production based on the heat production on the WWTP / Energienutzung aufgrund des Wärmeanfalls auf der ARA / Utilisation de l''énergie thermique de la STEP';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.identifier IS '';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN turbining  integer ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.turbining IS 'Energy production based on the (bio)gaz production on the WWTP / Energienutzung aufgrund des Gasanfalls auf der ARA / Production d''énergie issue de la production de gaz de la STEP';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_wwtp_energy_use.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_wwtp_energy_use.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_wwtp_energy_use.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_wwtp_energy_use.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_wwtp_energy_use
BEFORE UPDATE OR INSERT ON
 qgep.od_wwtp_energy_use
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_control_center
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_control_center_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_control_center_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_control_center ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_control_center');
COMMENT ON COLUMN qgep.od_control_center.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_control_center ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_control_center.identifier IS '';
SELECT AddGeometryColumn('qgep', 'od_control_center', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_control_center_situation_geometry ON qgep.od_control_center USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_control_center.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_control_center ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_control_center.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_control_center ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_control_center.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_control_center ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_control_center.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_control_center ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_control_center.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_control_center ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_control_center.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_control_center
BEFORE UPDATE OR INSERT ON
 qgep.od_control_center
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_sector_water_body
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_sector_water_body_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_sector_water_body_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_sector_water_body ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_sector_water_body');
COMMENT ON COLUMN qgep.od_sector_water_body.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN code_bwg  varchar(50) ;
COMMENT ON COLUMN qgep.od_sector_water_body.code_bwg IS 'Code as published by the Federal Office for Water and Geology (FOWG) / Code gemäss Format des Bundesamtes für Wasser und Geologie (BWG) / Code selon le format de l''Office fédéral des eaux et de la géologie (OFEG)';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_sector_water_body.identifier IS 'yyy_Eindeutiger Name des Sektors, ID des Bundesamtes für Wasserwirtschaft  und Geologie (BWG, früher BWW) falls Sektor von diesem bezogen wurde. / Eindeutiger Name des Sektors, ID des Bundesamtes für Wasserwirtschaft  und Geologie (BWG, früher BWW) falls Sektor von diesem bezogen wurde. / Nom univoque du secteur, identificateur de l''office fédéral des eaux et de la géologie (OFEG, anciennement OFEE) si existant';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_sector_water_body.kind IS 'Shore or water course line. Important to distinguish lake traversals and waterbodies / Ufer oder Gewässerlinie. Zur Unterscheidung der Seesektoren wichtig. / Rives ou limites d''eau. Permet la différenciation des différents secteurs d''un lac ou cours d''eau';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN km_down  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_sector_water_body.km_down IS 'yyy_Adresskilometer beim Sektorende (nur definieren, falls es sich um den letzten Sektor handelt oder ein Sprung in der Adresskilometrierung von einem Sektor zum nächsten  existiert) / Adresskilometer beim Sektorende (nur definieren, falls es sich um den letzten Sektor handelt oder ein Sprung in der Adresskilometrierung von einem Sektor zum nächsten  existiert) / Kilomètre de la fin du secteur (à définir uniquement s''il s''agit du dernier secteur ou lors d''un saut dans le kilométrage d''un secteur à un autre)';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN km_up  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_sector_water_body.km_up IS 'yyy_Adresskilometer beim Sektorbeginn / Adresskilometer beim Sektorbeginn / Kilomètre du début du secteur';
SELECT AddGeometryColumn('qgep', 'od_sector_water_body', 'progression_geometry', 21781, 'LINESTRING', 2, true);
CREATE INDEX in_qgep_od_sector_water_body_progression_geometry ON qgep.od_sector_water_body USING gist (progression_geometry );
COMMENT ON COLUMN qgep.od_sector_water_body.progression_geometry IS 'yyy_Reihenfolge von Punkten die den Verlauf eines Gewässersektors beschreiben / Reihenfolge von Punkten die den Verlauf eines Gewässersektors beschreiben / Suite de points qui décrivent le tracé d''un secteur d''un cours d''eau';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN ref_length  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_sector_water_body.ref_length IS 'yyy_Basislänge in Zusammenhang mit der Gewässerkilometrierung (siehe GEWISS - SYSEAU) / Basislänge in Zusammenhang mit der Gewässerkilometrierung (siehe GEWISS - SYSEAU) / Longueur de référence pour ce kilométrage des cours d''eau (voir GEWISS - SYSEAU)';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_sector_water_body.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_sector_water_body.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_sector_water_body.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_sector_water_body.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_sector_water_body.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_sector_water_body ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_sector_water_body.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_sector_water_body
BEFORE UPDATE OR INSERT ON
 qgep.od_sector_water_body
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_river_bed
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_river_bed_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_river_bed_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_river_bed ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_river_bed');
COMMENT ON COLUMN qgep.od_river_bed.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_river_bed ADD COLUMN control_grade_of_river  integer ;
COMMENT ON COLUMN qgep.od_river_bed.control_grade_of_river IS 'yyy_Flächenhafter Verbauungsgrad der Gewässersohle in %. Aufteilung in Klassen. / Flächenhafter Verbauungsgrad der Gewässersohle in %. Aufteilung in Klassen. / Pourcentage de la surface avec aménagement du fond du lit. Classification';
 ALTER TABLE qgep.od_river_bed ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_river_bed.identifier IS '';
 ALTER TABLE qgep.od_river_bed ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_river_bed.kind IS 'type of bed / Sohlentyp / Type de fond';
 ALTER TABLE qgep.od_river_bed ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_river_bed.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_river_bed ADD COLUMN river_control_type  integer ;
COMMENT ON COLUMN qgep.od_river_bed.river_control_type IS 'Type of river control / Art des Sohlenverbaus / Genre d''aménagement du fond';
 ALTER TABLE qgep.od_river_bed ADD COLUMN width  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_river_bed.width IS 'yyy_Bei Hochwasser umgelagerter Bereich (frei von höheren Wasserpflanzen) / Bei Hochwasser umgelagerter Bereich (frei von höheren Wasserpflanzen) / Zone de charriage par hautes eaux (absence de plantes aquatiques supérieures)';
 ALTER TABLE qgep.od_river_bed ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_river_bed.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_river_bed ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_river_bed.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_river_bed ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_river_bed.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_river_bed ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_river_bed.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_river_bed ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_river_bed.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_river_bed
BEFORE UPDATE OR INSERT ON
 qgep.od_river_bed
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_water_course_segment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_water_course_segment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_water_course_segment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_water_course_segment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_water_course_segment');
COMMENT ON COLUMN qgep.od_water_course_segment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN algae_growth  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.algae_growth IS 'Coverage with algae / Bewuchs mit Algen / Couverture végétale par des algues';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN altitudinal_zone  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.altitudinal_zone IS 'Alltiduinal zone of a water course / Höhenstufentypen eines Gewässers / Type d''étage d''altitude des cours d''eau';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN bed_with  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_water_course_segment.bed_with IS 'Average bed with / mittlere Sohlenbreite / Largeur moyenne du lit';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN dead_wood  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.dead_wood IS 'Accumulations of dead wood in water course section / Ansammlungen von Totholz im Gewässerabschnitt / Amas de bois mort dans le cours d''eau';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN depth_variability  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.depth_variability IS 'Variability of depth of water course / Variabilität der Gewässertiefe / Variabilité de la profondeur d''eau';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN discharge_regime  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.discharge_regime IS 'yyy_Grad der antropogenen Beeinflussung des charakteristischen Ganges des Abflusses. / Grad der antropogenen Beeinflussung des charakteristischen Ganges des Abflusses. / Degré d''intervention anthropogène sur le régime hydraulique';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN ecom_classification  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.ecom_classification IS 'Summary attribut of ecomorphological classification of level F / Summenattribut aus der ökomorphologischen Klassifizierung nach Stufe F / Attribut issu de la classification écomorphologique du niveau R';
SELECT AddGeometryColumn('qgep', 'od_water_course_segment', 'from_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_water_course_segment_from_geometry ON qgep.od_water_course_segment USING gist (from_geometry );
COMMENT ON COLUMN qgep.od_water_course_segment.from_geometry IS 'Position of segment start point in water course / Lage des Abschnittanfangs  im Gewässerverlauf / Situation du début du tronçon';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_water_course_segment.identifier IS '';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.kind IS '';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN length_profile  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.length_profile IS 'Character of length profile / Charakterisierung des Gewässerlängsprofil / Caractérisation du profil en long';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN macrophyte_coverage  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.macrophyte_coverage IS 'Coverage with macrophytes / Bewuchs mit Makrophyten / Couverture végétale par des macrophytes (végétation aquatique (macroscopique))';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_water_course_segment.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN section_morphology  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.section_morphology IS 'yyy_Linienführung eines Gewässerabschnittes / Linienführung eines Gewässerabschnittes / Tracé d''un cours d''eau';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN size  smallint ;
COMMENT ON COLUMN qgep.od_water_course_segment.size IS 'Classification by Strahler / Ordnungszahl nach Strahler / Classification selon Strahler';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN slope  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.slope IS 'Average slope of water course segment / Mittleres Gefälle des Gewässerabschnittes / Pente moyenne du fond du tronçon cours d''eau';
SELECT AddGeometryColumn('qgep', 'od_water_course_segment', 'to_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_water_course_segment_to_geometry ON qgep.od_water_course_segment USING gist (to_geometry );
COMMENT ON COLUMN qgep.od_water_course_segment.to_geometry IS 'Position of segment end point in water course / Lage Abschnitt-Ende im Gewässerverlauf / Situation de la fin du tronçon';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN utilisation  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.utilisation IS 'Primary utilisation of water course segment / Primäre Nutzung des Gewässerabschnittes / Utilisation primaire du tronçon de cours d''eau';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN water_hardness  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.water_hardness IS 'Chemical water hardness / Chemische Wasserhärte / Dureté chimique de l''eau';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN width_variability  integer ;
COMMENT ON COLUMN qgep.od_water_course_segment.width_variability IS 'yyy_Breitenvariabilität des Wasserspiegels bei niedrigem bis mittlerem Abfluss / Breitenvariabilität des Wasserspiegels bei niedrigem bis mittlerem Abfluss / Variabilité de la largeur du lit mouillé par basses et moyennes eaux';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_water_course_segment.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_water_course_segment.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_water_course_segment.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_water_course_segment.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_water_course_segment ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_water_course_segment.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_water_course_segment
BEFORE UPDATE OR INSERT ON
 qgep.od_water_course_segment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_surface_water_bodies
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_surface_water_bodies_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_surface_water_bodies_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_surface_water_bodies ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_surface_water_bodies');
COMMENT ON COLUMN qgep.od_surface_water_bodies.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_surface_water_bodies.identifier IS '';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_surface_water_bodies.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_surface_water_bodies.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_surface_water_bodies.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_surface_water_bodies.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_surface_water_bodies.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_surface_water_bodies ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_surface_water_bodies.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_surface_water_bodies
BEFORE UPDATE OR INSERT ON
 qgep.od_surface_water_bodies
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_aquifier
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_aquifier_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_aquifier_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_aquifier ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_aquifier');
COMMENT ON COLUMN qgep.od_aquifier.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_aquifier ADD COLUMN average_groundwater_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_aquifier.average_groundwater_level IS 'Average level of groundwater table / Höhe des mittleren Grundwasserspiegels / Niveau moyen de la nappe';
 ALTER TABLE qgep.od_aquifier ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_aquifier.identifier IS '';
 ALTER TABLE qgep.od_aquifier ADD COLUMN maximal_groundwater_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_aquifier.maximal_groundwater_level IS 'Maximal level of ground water table / Maximale Lage des Grundwasserspiegels / Niveau maximal de la nappe';
 ALTER TABLE qgep.od_aquifier ADD COLUMN minimal_groundwater_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_aquifier.minimal_groundwater_level IS 'Minimal level of groundwater table / Minimale Lage des Grundwasserspiegels / Niveau minimal de la nappe';
SELECT AddGeometryColumn('qgep', 'od_aquifier', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_aquifier_perimeter_geometry ON qgep.od_aquifier USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_aquifier.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
 ALTER TABLE qgep.od_aquifier ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_aquifier.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_aquifier ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_aquifier.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_aquifier ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_aquifier.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_aquifier ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_aquifier.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_aquifier ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_aquifier.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_aquifier ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_aquifier.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_aquifier
BEFORE UPDATE OR INSERT ON
 qgep.od_aquifier
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_bathing_area
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_bathing_area_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_bathing_area_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_bathing_area ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_bathing_area');
COMMENT ON COLUMN qgep.od_bathing_area.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_bathing_area.identifier IS '';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_bathing_area.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
SELECT AddGeometryColumn('qgep', 'od_bathing_area', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_bathing_area_situation_geometry ON qgep.od_bathing_area USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_bathing_area.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_bathing_area.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_bathing_area.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_bathing_area.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_bathing_area.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_bathing_area ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_bathing_area.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_bathing_area
BEFORE UPDATE OR INSERT ON
 qgep.od_bathing_area
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_water_control_structure
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_water_control_structure_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_water_control_structure_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_water_control_structure ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_water_control_structure');
COMMENT ON COLUMN qgep.od_water_control_structure.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_water_control_structure.identifier IS '';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_water_control_structure.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
SELECT AddGeometryColumn('qgep', 'od_water_control_structure', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_water_control_structure_situation_geometry ON qgep.od_water_control_structure USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_water_control_structure.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_water_control_structure.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_water_control_structure.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_water_control_structure.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_water_control_structure.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_water_control_structure ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_water_control_structure.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_water_control_structure
BEFORE UPDATE OR INSERT ON
 qgep.od_water_control_structure
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_water_catchment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_water_catchment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_water_catchment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_water_catchment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_water_catchment');
COMMENT ON COLUMN qgep.od_water_catchment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_water_catchment.identifier IS '';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_water_catchment.kind IS 'Type of water catchment / Art der Trinkwasserfassung / Genre de prise d''eau';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_water_catchment.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
SELECT AddGeometryColumn('qgep', 'od_water_catchment', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_water_catchment_situation_geometry ON qgep.od_water_catchment USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_water_catchment.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_water_catchment.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_water_catchment.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_water_catchment.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_water_catchment.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_water_catchment ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_water_catchment.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_water_catchment
BEFORE UPDATE OR INSERT ON
 qgep.od_water_catchment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_fish_pass
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_fish_pass_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_fish_pass_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_fish_pass ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_fish_pass');
COMMENT ON COLUMN qgep.od_fish_pass.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_fish_pass.identifier IS '';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_fish_pass.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN vertical_drop  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_fish_pass.vertical_drop IS 'Vertical difference of water level before and after fishpass / Differenz des Wasserspiegels vor und nach dem Fischpass / Différence de la hauteur du plan d''eau avant et après l''échelle à poisson';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_fish_pass.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_fish_pass.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_fish_pass.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_fish_pass.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_fish_pass ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_fish_pass.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_fish_pass
BEFORE UPDATE OR INSERT ON
 qgep.od_fish_pass
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_river_bank
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_river_bank_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_river_bank_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_river_bank ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_river_bank');
COMMENT ON COLUMN qgep.od_river_bank.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_river_bank ADD COLUMN control_grade_of_river  integer ;
COMMENT ON COLUMN qgep.od_river_bank.control_grade_of_river IS 'yyy_Flächenhafter Verbauungsgrad des Böschungsfusses in %. Aufteilung in Klassen. / Flächenhafter Verbauungsgrad des Böschungsfusses in %. Aufteilung in Klassen. / Degré d''aménagement du pied du talus du cours d''eau';
 ALTER TABLE qgep.od_river_bank ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_river_bank.identifier IS '';
 ALTER TABLE qgep.od_river_bank ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_river_bank.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_river_bank ADD COLUMN river_control_type  integer ;
COMMENT ON COLUMN qgep.od_river_bank.river_control_type IS 'yyy_Verbauungsart des Böschungsfusses / Verbauungsart des Böschungsfusses / Genre d''aménagement du pied de la berge du cours d''eau';
 ALTER TABLE qgep.od_river_bank ADD COLUMN shores  integer ;
COMMENT ON COLUMN qgep.od_river_bank.shores IS 'yyy_Beschaffenheit des Bereiches oberhalb des Böschungsfusses / Beschaffenheit des Bereiches oberhalb des Böschungsfusses / Nature de la zone en dessus du pied de la berge du cours d''eau';
 ALTER TABLE qgep.od_river_bank ADD COLUMN side  integer ;
COMMENT ON COLUMN qgep.od_river_bank.side IS 'yyy_Linke oder rechte Uferseite in Fliessrichtung / Linke oder rechte Uferseite in Fliessrichtung / Berges sur le côté gauche ou droite du cours d''eau par rapport au sens d''écoulement';
 ALTER TABLE qgep.od_river_bank ADD COLUMN utilisation_of_shore_surroundings  integer ;
COMMENT ON COLUMN qgep.od_river_bank.utilisation_of_shore_surroundings IS 'yyy_Nutzung des Gewässerumlandes / Nutzung des Gewässerumlandes / Utilisation du sol des environs';
 ALTER TABLE qgep.od_river_bank ADD COLUMN vegetation  integer ;
COMMENT ON COLUMN qgep.od_river_bank.vegetation IS '';
 ALTER TABLE qgep.od_river_bank ADD COLUMN width  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_river_bank.width IS 'yyy_Breite des Bereiches oberhalb des Böschungsfusses bis zum Gebiet mit "intensiver Landnutzung" / Breite des Bereiches oberhalb des Böschungsfusses bis zum Gebiet mit "intensiver Landnutzung" / Distance horizontale de la zone comprise entre le pied de la berge et la zone d''utilisation intensive du sol';
 ALTER TABLE qgep.od_river_bank ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_river_bank.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_river_bank ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_river_bank.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_river_bank ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_river_bank.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_river_bank ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_river_bank.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_river_bank ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_river_bank.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_river_bank
BEFORE UPDATE OR INSERT ON
 qgep.od_river_bank
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_damage
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_damage_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_damage_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_damage ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_damage');
COMMENT ON COLUMN qgep.od_damage.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_damage ADD COLUMN comments  varchar(100) ;
COMMENT ON COLUMN qgep.od_damage.comments IS 'yyy_Freie Bemerkungen zu einer Feststellung / Freie Bemerkungen zu einer Feststellung / Remarques libres concernant une observation';
 ALTER TABLE qgep.od_damage ADD COLUMN single_damage_class  integer ;
COMMENT ON COLUMN qgep.od_damage.single_damage_class IS 'yyy_Definiert die Schadensklasse eines Einzelschadens. Die Einteilung in die Zustandsklassen erfolgt aufgrund des Schadenbilds und des Schadensausmasses. Dabei kann ein Abwasserbauwerk direkt einer Klasse zugeteilt werden oder zuerst jeder Schaden einzeln / Definiert die Schadensklasse eines Einzelschadens. Die Einteilung in die Zustandsklassen erfolgt aufgrund des Schadenbilds und des Schadensausmasses. Dabei kann ein Abwasserbauwerk direkt einer Klasse zugeteilt werden oder zuerst jeder Schaden einzeln kla / Définit la classe de dommages d’un dommage unique. La répartition en classes d’état s’effectue sur la base de la nature et de l’étendue des dommages. Un ouvrage d''assainissement peut être classé directement ou chaque dommage peut d’abord être classé sépar';
 ALTER TABLE qgep.od_damage ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_damage.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_damage ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_damage.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_damage ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_damage.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_damage ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_damage.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_damage ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_damage.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_damage
BEFORE UPDATE OR INSERT ON
 qgep.od_damage
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_hydr_geometry
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_hydr_geometry_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_hydr_geometry_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_hydr_geometry ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_hydr_geometry');
COMMENT ON COLUMN qgep.od_hydr_geometry.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.identifier IS '';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN storage_volume  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.storage_volume IS 'yyy_Speicherinhalt im Becken und im Zulauf zwischen Wehrkrone und dem Wasserspiegel bei Qan. Bei Regenbeckenüberlaufbecken im Nebenschluss ist der Stauraum beim vorgelagerten Trennbauwerk bzw. Regenüberlauf zu erfassen (vgl. Erläuterungen Inhalt_Fangteil  / Speicherinhalt im Becken und im Zulauf zwischen Wehrkrone und dem Wasserspiegel bei Qan. Bei Regenbeckenüberlaufbecken im Nebenschluss ist der Stauraum beim vorgelagerten Trennbauwerk bzw. Regenüberlauf zu erfassen (vgl. Erläuterungen Inhalt_Fangteil reps / Volume de stockage dans un bassin et dans la canalisation d’amenée entre la crête et le niveau d’eau de Qdim (débit conservé). Lors de bassins d’eaux pluviales en connexion latérale, le volume de stockage est à saisir à l’ouvrage de répartition, resp. dév';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN usable_capacity_storage  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.usable_capacity_storage IS 'yyy_Inhalt der Kammer unterhalb der Wehrkrone ohne Stauraum im Zulaufkanal. Letzterer wird unter dem Attribut Stauraum erfasst (bei Anordnung im Hauptschluss auf der Stammkarte des Hauptbauwerkes, bei Anordnung im Nebenschluss auf der Stammkarte des vorge / Inhalt der Kammer unterhalb der Wehrkrone ohne Stauraum im Zulaufkanal. Letzterer wird unter dem Attribut Stauraum erfasst (bei Anordnung im Hauptschluss auf der Stammkarte des Hauptbauwerkes, bei Anordnung im Nebenschluss auf der Stammkarte des vorgelage / Volume de la chambre sous la crête, sans volume de stockage de la canalisation d’amenée. Ce dernier est saisi par l’attribut volume de stockage (lors de disposition en connexion directe ceci se fait dans la fiche technique de l’ouvrage principal, lors de ';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN usable_capacity_treatment  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.usable_capacity_treatment IS 'yyy_Inhalt der Kammer unterhalb der Wehrkrone inkl. Einlaufbereich, Auslaufbereich und Sedimentationsbereich, ohne Stauraum im Zulaufkanal.  Letzterer wird unter dem Attribut Stauraum erfasst (bei Anordnung im Hauptschluss auf der Stammkarte des Hauptbauw / Inhalt der Kammer unterhalb der Wehrkrone inkl. Einlaufbereich, Auslaufbereich und Sedimentationsbereich, ohne Stauraum im Zulaufkanal. Letzterer wird unter dem Attribut Stauraum erfasst (bei Anordnung im Hauptschluss auf der Stammkarte des Hauptbauwerkes / Volume de la chambre sous la crête, incl. l’entrée, la sortie et la partie de sédimentation, sans volume de stockage de la canalisation d’amenée. Ce dernier est saisi par l’attribut volume de stockage (lors de disposition en connexion directe ceci se fait';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN utilisable_capacity  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.utilisable_capacity IS 'yyy_Inhalt der Kammer unterhalb Notüberlauf oder Bypass (maximal mobilisierbares Volumen, inkl. Stauraum im Zulaufkanal). Für RRB und RRK. Für RÜB Nutzinhalt_Fangteil und Nutzinhalt_Klaerteil benutzen. Zusätzlich auch Stauraum erfassen. / Inhalt der Kammer unterhalb Notüberlauf oder Bypass (maximal mobilisierbares Volumen, inkl. Stauraum im Zulaufkanal). Für RRB und RRK. Für RÜB Nutzinhalt_Fangteil und Nutzinhalt_Klaerteil benutzen. Zusätzlich auch Stauraum erfassen. / Pour les bassins et canalisations d’accumulation : Volume de la chambre sous la surverse de secours ou bypass (volume mobilisable maximum, incl. le volume de stockage de la canalisation d’amenée). Pour les BEP il s’agit du VOLUME_UTILE_STOCKAGE et du VOLU';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN volume_pump_sump  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.volume_pump_sump IS 'yyy_Volumen des Pumpensumpfs von der Sohle bis zur maximal möglichen Wasserspiegellage (inkl. Kanalspeichervolumen im Zulaufkanal). / Volumen des Pumpensumpfs von der Sohle bis zur maximal möglichen Wasserspiegellage (inkl. Kanalspeichervolumen im Zulaufkanal). / Volume du puisard calculée à partir du radier jusqu’au niveau d’eau maximum possible (incl. le volume de stockage de la canalisation d’amenée).';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_hydr_geometry.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_hydr_geometry.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_hydr_geometry.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hydr_geometry ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_hydr_geometry.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_hydr_geometry
BEFORE UPDATE OR INSERT ON
 qgep.od_hydr_geometry
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_hydr_geom_relation
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_hydr_geom_relation_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_hydr_geom_relation_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_hydr_geom_relation ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_hydr_geom_relation');
COMMENT ON COLUMN qgep.od_hydr_geom_relation.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN water_depth  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_hydr_geom_relation.water_depth IS 'yyy_Massgebende Wassertiefe / Massgebende Wassertiefe / Profondeur d''eau déterminante';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN water_surface  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_hydr_geom_relation.water_surface IS 'yyy_Freie Wasserspiegelfläche; für Speicherfunktionen massgebend / Freie Wasserspiegelfläche; für Speicherfunktionen massgebend / Surface du plan d''eau; déterminant pour les fonctions d''accumulation';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN wet_cross_section_area  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_hydr_geom_relation.wet_cross_section_area IS 'yyy_Hydraulisch wirksamer Querschnitt für Verlustberechnungen / Hydraulisch wirksamer Querschnitt für Verlustberechnungen / Section hydrauliquement active pour les calculs des pertes de charge';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_hydr_geom_relation.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_hydr_geom_relation.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_hydr_geom_relation.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_hydr_geom_relation.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_hydr_geom_relation.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_hydr_geom_relation
BEFORE UPDATE OR INSERT ON
 qgep.od_hydr_geom_relation
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_pipe_profile
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_pipe_profile_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_pipe_profile_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_pipe_profile ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_pipe_profile');
COMMENT ON COLUMN qgep.od_pipe_profile.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN height_width_ratio  decimal(5,2) ;
COMMENT ON COLUMN qgep.od_pipe_profile.height_width_ratio IS 'height-width ratio / Verhältnis der Höhe zur Breite / Rapport entre la hauteur et la largeur';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_pipe_profile.identifier IS '';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN profile_type  integer ;
COMMENT ON COLUMN qgep.od_pipe_profile.profile_type IS 'Type of profile / Typ des Profils / Type du profil';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_pipe_profile.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_pipe_profile.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_pipe_profile.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_pipe_profile.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_pipe_profile.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_pipe_profile ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_pipe_profile.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_pipe_profile
BEFORE UPDATE OR INSERT ON
 qgep.od_pipe_profile
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_wastewater_networkelement
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wastewater_networkelement_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wastewater_networkelement_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wastewater_networkelement ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wastewater_networkelement');
COMMENT ON COLUMN qgep.od_wastewater_networkelement.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_wastewater_networkelement.identifier IS '';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_networkelement.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_wastewater_networkelement.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_networkelement.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_networkelement.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_wastewater_networkelement.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_wastewater_networkelement.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_wastewater_networkelement
BEFORE UPDATE OR INSERT ON
 qgep.od_wastewater_networkelement
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_hq_relation
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_hq_relation_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_hq_relation_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_hq_relation ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_hq_relation');
COMMENT ON COLUMN qgep.od_hq_relation.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN altitude  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_hq_relation.altitude IS 'yyy_Zum Abfluss (Q2) korrelierender Wasserspiegel (h) / Zum Abfluss (Q2) korrelierender Wasserspiegel (h) / Niveau d''eau correspondant (h) au débit (Q2)';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN flow  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_hq_relation.flow IS 'Flow (Q2) in direction of WWTP / Abflussmenge (Q2) Richtung ARA / Débit d''eau (Q2) en direction de la STEP';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN flow_from  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_hq_relation.flow_from IS 'yyy_Zufluss (Q1) / Zufluss (Q1) / Débit d’entrée  (Q1)';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_hq_relation.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_hq_relation.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_hq_relation.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_hq_relation.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hq_relation ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_hq_relation.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_hq_relation
BEFORE UPDATE OR INSERT ON
 qgep.od_hq_relation
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_accident
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_accident_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_accident_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_accident ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_accident');
COMMENT ON COLUMN qgep.od_accident.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_accident ADD COLUMN date  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_accident.date IS 'Date of accident / Datum des Ereignisses / Date de l''événement';
 ALTER TABLE qgep.od_accident ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_accident.identifier IS '';
 ALTER TABLE qgep.od_accident ADD COLUMN place  varchar(50) ;
COMMENT ON COLUMN qgep.od_accident.place IS 'Adress of the location of accident / Adresse der Unfallstelle / Adresse du lieu de l''accident';
 ALTER TABLE qgep.od_accident ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_accident.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_accident ADD COLUMN responsible  varchar(50) ;
COMMENT ON COLUMN qgep.od_accident.responsible IS 'Name of the responsible of the accident / Name Adresse des Verursachers / Nom et adresse de l''auteur';
SELECT AddGeometryColumn('qgep', 'od_accident', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_accident_situation_geometry ON qgep.od_accident USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_accident.situation_geometry IS 'National position coordinates (North, East) of accident / Landeskoordinate Ost/Nord des Unfallortes / Coordonnées nationales Est/Nord du lieu d''accident';
 ALTER TABLE qgep.od_accident ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_accident.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_accident ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_accident.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_accident ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_accident.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_accident ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_accident.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_accident ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_accident.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_accident
BEFORE UPDATE OR INSERT ON
 qgep.od_accident
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_log_card
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_log_card_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_log_card_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_log_card ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_log_card');
COMMENT ON COLUMN qgep.od_log_card.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_log_card ADD COLUMN agency  varchar(80) ;
COMMENT ON COLUMN qgep.od_log_card.agency IS 'yyy_Name of agency that compiled the Stammkarte / Name des Ingenieurbüros, welches die Stammkarte erstellt hat / Nom du bureau d’ingénieur qui a établi la fiche technique';
 ALTER TABLE qgep.od_log_card ADD COLUMN information_source  integer ;
COMMENT ON COLUMN qgep.od_log_card.information_source IS 'yyy_Für die Quellen stehen die angegebenen Möglichkeiten zur Verfügung. / Für die Quellen stehen die angegebenen Möglichkeiten zur Verfügung. / Valeurs à disposition pour les sources d’information sur une liste à choix';
 ALTER TABLE qgep.od_log_card ADD COLUMN person_in_charge  varchar(50) ;
COMMENT ON COLUMN qgep.od_log_card.person_in_charge IS 'yyy_Sachbearbeiter, der die Stammkarte erstellt hat. / Sachbearbeiter, der die Stammkarte erstellt hat. / Technicien ayant remplir la fiche technique.';
 ALTER TABLE qgep.od_log_card ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_log_card.remark IS '';
 ALTER TABLE qgep.od_log_card ADD COLUMN wwtp_number  integer ;
COMMENT ON COLUMN qgep.od_log_card.wwtp_number IS 'yyy_An ARA „Beispiel“ angeschlossen (WWTP Number from Federal Office for the Environment (FOEN)). Anlagenummer / An ARA „Beispiel“ angeschlossen (ARA Nummer des BAFU). Anlagenummer / Raccordé à la STEP « exemple » (n° STEP de l’OFEV), numéro de l‘ouvrage';
 ALTER TABLE qgep.od_log_card ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_log_card.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_log_card ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_log_card.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_log_card ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_log_card.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_log_card ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_log_card.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_log_card ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_log_card.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_log_card
BEFORE UPDATE OR INSERT ON
 qgep.od_log_card
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_overflow_characteristic
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_overflow_characteristic_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_overflow_characteristic_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_overflow_characteristic ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_overflow_characteristic');
COMMENT ON COLUMN qgep.od_overflow_characteristic.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_overflow_characteristic.identifier IS '';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN kind_overflow_characteristic  integer ;
COMMENT ON COLUMN qgep.od_overflow_characteristic.kind_overflow_characteristic IS 'yyy_Die Kennlinie ist als Q /Q- (bei Bodenöffnungen) oder als H/Q-Tabelle (bei Streichwehren) zu dokumentieren. Bei einer freien Aufteilung muss die Kennlinie nicht dokumentiert werden. Bei Abflussverhältnissen in Einstaubereichen ist die Funktion separat / Die Kennlinie ist als Q /Q- (bei Bodenöffnungen) oder als H/Q-Tabelle (bei Streichwehren) zu dokumentieren. Bei einer freien Aufteilung muss die Kennlinie nicht dokumentiert werden. Bei Abflussverhältnissen in Einstaubereichen ist die Funktion separat in  / La courbe est à documenter sous forme de rapport Q/Q (Leaping weir) ou H/Q (déversoir latéral). Les conditions d’écoulement dans la chambre d’accumulation sont à fournir en annexe.';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN overflow_characteristic_digital  integer ;
COMMENT ON COLUMN qgep.od_overflow_characteristic.overflow_characteristic_digital IS 'yyy_Falls Kennlinie_digital = ja müssen die Attribute für die Q-Q oder H-Q Beziehung  in Ueberlaufcharakteristik ausgefüllt sein in HQ_Relation. / Falls Kennlinie_digital = ja müssen die Attribute für die Q-Q oder H-Q Beziehung in HQ_Relation ausgefüllt sein. / Si courbe de fonctionnement numérique = oui, les attributs pour les relations Q-Q et H-Q doivent être saisis dans la classe RELATION_HQ.';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_overflow_characteristic.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_overflow_characteristic.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_overflow_characteristic.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_overflow_characteristic.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_overflow_characteristic.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_overflow_characteristic ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_overflow_characteristic.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_overflow_characteristic
BEFORE UPDATE OR INSERT ON
 qgep.od_overflow_characteristic
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_data_media
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_data_media_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_data_media_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_data_media ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_data_media');
COMMENT ON COLUMN qgep.od_data_media.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_data_media ADD COLUMN identifier  varchar(40) ;
COMMENT ON COLUMN qgep.od_data_media.identifier IS 'yyy_Name des Datenträgers. Bei elektronischen Datenträgern normalerweise das Volume-Label. Bei einem Server der Servername. Bei analogen Videobändern die Bandnummer. / Name des Datenträgers. Bei elektronischen Datenträgern normalerweise das Volume-Label. Bei einem Server der Servername. Bei analogen Videobändern die Bandnummer. / Nom du support de données. Pour les supports de données électroniques, normalement le label volume. Pour un serveur, le nom du serveur. Pour des bandes vidéo analogiques, les numéros de bandes.';
 ALTER TABLE qgep.od_data_media ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_data_media.kind IS 'yyy_Beschreibt die Art des Datenträgers / Beschreibt die Art des Datenträgers / Décrit le genre de support de données';
 ALTER TABLE qgep.od_data_media ADD COLUMN location  varchar(50) ;
COMMENT ON COLUMN qgep.od_data_media.location IS 'Where is the / Wo befindet sich der Datenträger / Où se trouve le support de données';
 ALTER TABLE qgep.od_data_media ADD COLUMN path  varchar(100) ;
COMMENT ON COLUMN qgep.od_data_media.path IS 'yyy_Zugriffspfad zum Datenträger. z.B. DVD-Laufwerk -> D: , Server -> \\server\videos, Harddisk -> c:\videos . Kann auch eine URL sein. Bei einem analogen Videoband leer / Zugriffspfad zum Datenträger. z.B. DVD-Laufwerk -> D: , Server -> \\server\videos, Harddisk -> c:\videos . Kann auch eine URL sein. Bei einem analogen Videoband leer / Chemin d’accès au support de données, p. ex. lecteur DVD -> D: , - serveur -> \\ server\videos , disque dur -> c:\videos , Peut aussi être une URL. Pour une bande vidéo analogique: vide';
 ALTER TABLE qgep.od_data_media ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_data_media.remark IS 'General remarks / Bemerkungen zum Datenträger / Remarques concernant le support de données';
 ALTER TABLE qgep.od_data_media ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_data_media.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_data_media ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_data_media.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_data_media ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_data_media.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_data_media ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_data_media.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_data_media ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_data_media.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_data_media
BEFORE UPDATE OR INSERT ON
 qgep.od_data_media
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_structure_part
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_structure_part_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_structure_part_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_structure_part ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_structure_part');
COMMENT ON COLUMN qgep.od_structure_part.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_structure_part ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_structure_part.identifier IS '';
 ALTER TABLE qgep.od_structure_part ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_structure_part.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_structure_part ADD COLUMN renovation_demand  integer ;
COMMENT ON COLUMN qgep.od_structure_part.renovation_demand IS 'yyy_Zustandsinformation zum structure_part / Zustandsinformation zum Bauwerksteil / Information sur l''état de l''élément de l''ouvrage';
 ALTER TABLE qgep.od_structure_part ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_structure_part.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_structure_part ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_structure_part.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_structure_part ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_structure_part.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_structure_part ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_structure_part.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_structure_part ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_structure_part.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_structure_part
BEFORE UPDATE OR INSERT ON
 qgep.od_structure_part
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_wastewater_structure
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wastewater_structure_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wastewater_structure_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wastewater_structure ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wastewater_structure');
COMMENT ON COLUMN qgep.od_wastewater_structure.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN accessibility  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure.accessibility IS 'yyy_Möglichkeit der Zugänglichkeit ins Innere eines Abwasserbauwerks für eine Person (nicht für ein Fahrzeug) / Möglichkeit der Zugänglichkeit ins Innere eines Abwasserbauwerks für eine Person (nicht für ein Fahrzeug) / Possibilités d’accès à l’ouvrage d’assainissement pour une personne (non pour un véhicule)';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN contract_section  varchar(50) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.contract_section IS 'Number of contract section / Nummer des Bauloses / Numéro du lot de construction';
SELECT AddGeometryColumn('qgep', 'od_wastewater_structure', 'detail_geometry_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_wastewater_structure_detail_geometry_geometry ON qgep.od_wastewater_structure USING gist (detail_geometry_geometry );
COMMENT ON COLUMN qgep.od_wastewater_structure.detail_geometry_geometry IS 'Detail geometry especially with special structures. For manhole usually use dimension1 and 2. Also with normed infiltratin structures.  Channels usually do not have a detail_geometry. / Detaillierte Geometrie insbesondere bei Spezialbauwerken. Für Normschächte i.d. R.  Dimension1 und 2 verwenden. Dito bei normierten Versickerungsanlagen.  Kanäle haben normalerweise keine Detailgeometrie. / Géométrie détaillée particulièrement pour un OUVRAGE_SPECIAL. Pour l’attribut CHAMBRE_STANDARD utilisez Dimension1 et 2, de même pour une INSTALLATION_INFILTRATION normée.  Les canalisations n’ont en général pas de géométrie détaillée.';
SELECT AddGeometryColumn('qgep', 'od_wastewater_structure', 'detail_geometry_3d_geometry', 21781, 'POLYGON', 3, true);
CREATE INDEX in_qgep_od_wastewater_structure_detail_geometry_3d_geometry ON qgep.od_wastewater_structure USING gist (detail_geometry_3d_geometry );
COMMENT ON COLUMN qgep.od_wastewater_structure.detail_geometry_3d_geometry IS 'Detail geometry (3D) especially with special structures. For manhole usually use dimension1 and 2. Also with normed infiltratin structures.  Channels usually do not have a detail_geometry. / Detaillierte Geometrie (3D) insbesondere bei Spezialbauwerken. Bei Normschächten mit Dimension1 und 2 arbeiten. Dito bei normierten Versickerungsanlagen. Kanäle haben normalerweise keine Detailgeometrie. / Géométrie détaillée (3D) particulièrement pour un OUVRAGE_SPECIAL. Pour l’attribut CHAMBRE_STANDARD utilisez Dimension1 et 2, de même pour une INSTALLATION_INFILTRATION normée.Les canalisations n’ont en général pas de géométrie détaillée.';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN financing  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure.financing IS ' Method of financing  (Financing based on GschG Art. 60a). / Finanzierungart (Finanzierung gemäss GschG Art. 60a). / Type de financement (financement selon LEaux Art. 60a)';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.gross_costs IS 'Gross costs of construction / Brutto Erstellungskosten / Coûts bruts des travaux de construction';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.identifier IS 'yyy_Pro Datenherr eindeutige Bezeichnung / Pro Datenherr eindeutige Bezeichnung / Désignation unique pour chaque maître des données';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN inspection_interval  decimal(4,2) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.inspection_interval IS 'yyy_Abstände, in welchen das Abwasserbauwerk inspiziert werden sollte (Jahre) / Abstände, in welchen das Abwasserbauwerk inspiziert werden sollte (Jahre) / Fréquence à laquelle un ouvrage du réseau d‘assainissement devrait subir une inspection (années)';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN location_name  varchar(50) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.location_name IS 'Street name or name of the location of the structure / Strassenname oder Ortsbezeichnung  zum Bauwerk / Nom de la route ou du lieu de l''ouvrage';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN records  varchar(255) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.records IS 'yyy_Plan Nr. der Ausführungsdokumentation. Kurzbeschrieb weiterer Akten (Betriebsanleitung vom …, etc.) / Plan Nr. der Ausführungsdokumentation. Kurzbeschrieb weiterer Akten (Betriebsanleitung vom …, etc.) / N° de plan de la documentation d’exécution, description de dossiers, manuels, etc.';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN renovation_necessity  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure.renovation_necessity IS 'yyy_Dringlichkeitsstufen und Zeithorizont für bauliche Massnahmen gemäss VSA-Richtline "Erhaltung von Kanalisationen" / Dringlichkeitsstufen und Zeithorizont für bauliche Massnahmen gemäss VSA-Richtline "Erhaltung von Kanalisationen" / 	Degrés d’urgence et délai de réalisation des mesures constructives selon la directive VSA "Maintien des canalisations"';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN replacement_value  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.replacement_value IS 'yyy_Wiederbeschaffungswert des Bauwerks. Zusätzlich muss auch das Attribut WBW_Basisjahr erfasst werden / Wiederbeschaffungswert des Bauwerks. Zusätzlich muss auch das Attribut WBW_Basisjahr erfasst werden / Valeur de remplacement de l''OUVRAGE_RESEAU_AS. On à besoin aussi de saisir l''attribut VR_ANNEE_REFERENCE';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN rv_base_year  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure.rv_base_year IS 'yyy_Basisjahr für die Kalkulation des Wiederbeschaffungswerts (siehe auch Wiederbeschaffungswert) / Basisjahr für die Kalkulation des Wiederbeschaffungswerts (siehe auch Attribut Wiederbeschaffungswert) / Année de référence pour le calcul de la valeur de remplacement (cf. valeur de remplacement)';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN rv_construction_type  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure.rv_construction_type IS 'yyy_Grobe Einteilung der Bauart des Abwasserbauwerks als Inputwert für die Berechnung des Wiederbeschaffungswerts. / Grobe Einteilung der Bauart des Abwasserbauwerks als Inputwert für die Berechnung des Wiederbeschaffungswerts. / Valeur de remplacement du type de construction';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN status  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure.status IS 'Operating and planning status of the structure / Betriebs- bzw. Planungszustand des Bauwerks / Etat de fonctionnement et de planification de l’ouvrage';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN structure_condition  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure.structure_condition IS 'yyy_Zustandsklassen. Beschreibung des baulichen Zustands des Kanals. Nicht zu verwechseln mit den Sanierungsstufen, welche die Prioritäten der Massnahmen bezeichnen (Attribut Sanierungsbedarf). / Zustandsklassen 0 bis 4 gemäss VSA-Richtline "Erhaltung von Kanalisationen". Beschreibung des baulichen Zustands des Abwasserbauwerks. Nicht zu verwechseln mit den Sanierungsstufen, welche die Prioritäten der Massnahmen bezeichnen (Attribut Sanierungsbeda / Classes d''état. Description de l''état constructif selon la directive VSA "Maintien des canalisations" (2007/2009). Ne pas confondre avec les degrés de remise en état (attribut NECESSITE_ASSAINIR)';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN subsidies  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.subsidies IS 'yyy_Staats- und Bundesbeiträge / Staats- und Bundesbeiträge / Contributions des cantons et de la Confédération';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN year_of_construction  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure.year_of_construction IS 'yyy_Jahr der Inbetriebsetzung (Schlussabnahme). Falls unbekannt = 1800 setzen (tiefster Wert des Wertebereiches) / Jahr der Inbetriebsetzung (Schlussabnahme). Falls unbekannt = 1800 setzen (tiefster Wert des Wertebereichs) / Année de mise en service (réception finale)';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure.year_of_replacement IS 'yyy_Jahr, in dem die Lebensdauer des Bauwerks voraussichtlich abläuft / Jahr, in dem die Lebensdauer des Bauwerks voraussichtlich abläuft / Année pour laquelle on prévoit que la durée de vie de l''ouvrage soit écoulée';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_wastewater_structure.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_wastewater_structure.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_structure ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_wastewater_structure.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_wastewater_structure
BEFORE UPDATE OR INSERT ON
 qgep.od_wastewater_structure
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_maintenance_event
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_maintenance_event_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_maintenance_event_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_maintenance_event ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_maintenance_event');
COMMENT ON COLUMN qgep.od_maintenance_event.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN base_data  varchar(50) ;
COMMENT ON COLUMN qgep.od_maintenance_event.base_data IS 'e.g. damage protocol / Z.B. Schadensprotokoll / par ex. protocole de dommages';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN cost  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_maintenance_event.cost IS '';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN data_details  varchar(50) ;
COMMENT ON COLUMN qgep.od_maintenance_event.data_details IS 'yyy_Ort, wo sich weitere Detailinformationen zum Ereignis finden (z.B. Nr. eines Videobandes) / Ort, wo sich weitere Detailinformationen zum Ereignis finden (z.B. Nr. eines Videobandes) / Lieu où se trouvent les données détaillées (par ex. n° d''une bande vidéo)';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN duration  smallint ;
COMMENT ON COLUMN qgep.od_maintenance_event.duration IS 'Duration of event in days / Dauer des Ereignisses in Tagen / Durée de l''événement en jours';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_maintenance_event.identifier IS '';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_maintenance_event.kind IS 'Type of event / Art des Ereignisses / Genre d''événement';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN operator  varchar(50) ;
COMMENT ON COLUMN qgep.od_maintenance_event.operator IS 'Operator of operating company or administration / Sachbearbeiter Firma oder Verwaltung / Responsable de saisie du bureau';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN reason  varchar(50) ;
COMMENT ON COLUMN qgep.od_maintenance_event.reason IS 'Reason for this event / Ursache für das Ereignis / Cause de l''événement';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_maintenance_event.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN result  varchar(50) ;
COMMENT ON COLUMN qgep.od_maintenance_event.result IS 'Result or important comments for this event / Resultat oder wichtige Bemerkungen aus Sicht des Bearbeiters / Résultat ou commentaire importante de l''événement';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN status  integer ;
COMMENT ON COLUMN qgep.od_maintenance_event.status IS 'Disposition state of the maintenance event / Phase in der sich das Erhaltungsereignis befindet / Phase dans laquelle se trouve l''événement de maintenance';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN time_point  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_maintenance_event.time_point IS 'Date and time of the event / Zeitpunkt des Ereignisses / Date et heure de l''événement';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_maintenance_event.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_maintenance_event.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_maintenance_event.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_maintenance_event.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_maintenance_event ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_maintenance_event.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_maintenance_event
BEFORE UPDATE OR INSERT ON
 qgep.od_maintenance_event
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_hydraulic_characteristic_data
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_hydraulic_characteristic_data_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_hydraulic_characteristic_data_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_hydraulic_characteristic_data ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_hydraulic_characteristic_data');
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN aggregate_number  smallint ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.aggregate_number IS '';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN delivery_height_geodaetic  decimal(6,2) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.delivery_height_geodaetic IS '';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.identifier IS '';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN is_overflowing  integer ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.is_overflowing IS 'yyy_Angabe, ob die Entlastung beim Dimensionierungsereignis anspringt / Angabe, ob die Entlastung beim Dimensionierungsereignis anspringt / Indication, si le déversoir déverse lors des événements pour lesquels il a été dimensionné.';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN main_weir_kind  integer ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.main_weir_kind IS 'yyy_Art des Hauptwehrs am Knoten, falls mehrere Überläufe / Art des Hauptwehrs am Knoten, falls mehrere Überläufe / Genre du déversoir principal du noeud concerné s''il y a plusieurs déversoirs.';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN overcharge  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.overcharge IS 'yyy_Optimale Mehrbelastung nach der Umsetzung der Massnahmen. / Ist: Mehrbelastung der untenliegenden Kanäle beim Dimensionierungsereignis = 100 * (Qab – Qan) / Qan 	[%]. Verhältnis zwischen der abgeleiteten Abwassermengen Richtung ARA beim Anspringen des Entlastungsbauwerkes (Qan) und Qab (Abwassermenge, welche beim  / Etat actuel: Surcharge optimale à l’état actuel avant la réalisation d’éventuelles mesures;  actuel optimisé: Surcharge optimale à l’état actuel avant la réalisation d’éventuelles mesures; prévu: Optimale Mehrbelastung nach der Umsetzung der Massnahmen.';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN overflow_duration  decimal(6,1) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.overflow_duration IS 'yyy_Mittlere Überlaufdauer pro Jahr. Bei Ist_Zustand: Berechnung mit geplanten Massnahmen. Bei Ist_optimiert:  Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von allfälligen weiteren Massnahmen. Planungszustand: Berechnung mit g / Mittlere Überlaufdauer pro Jahr. Bei Ist_Zustand: Berechnung mit geplanten Massnahmen. Bei Ist_optimiert:  Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von allfälligen weiteren Massnahmen. Planungszustand: Berechnung mit gepla / Durée moyenne de déversement par an.  Actuel: Durée moyenne de déversement par an selon des simulations pour de longs temps de retour (z > 10). Actuel optimizé: Calcul en mode optimal à l’état actuel avant la réalisation d’éventuelles mesures. Prévu: Calc';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN overflow_freight  integer ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.overflow_freight IS 'yyy_Mittlere Ueberlaufschmutzfracht pro Jahr / Mittlere Ueberlaufschmutzfracht pro Jahr / Charge polluante moyenne déversée par année';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN overflow_frequency  decimal(3,1) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.overflow_frequency IS 'yyy_Mittlere Überlaufhäufigkeit pro Jahr. Ist Zustand: Durchschnittliche Überlaufhäufigkeit pro Jahr von Entlastungsanlagen gemäss Langzeitsimulation (Dauer mindestens 10 Jahre). Ist optimiert: Berechnung mit optimierten Einstellungen im Ist-Zustand vor d / Mittlere Überlaufhäufigkeit pro Jahr. Ist Zustand: Durchschnittliche Überlaufhäufigkeit pro Jahr von Entlastungsanlagen gemäss Langzeitsimulation (Dauer mindestens 10 Jahre). Ist optimiert: Berechnung mit optimierten Einstellungen im Ist-Zustand vor der U / Fréquence moyenne de déversement par an. Fréquence moyenne de déversement par an selon des simulations pour de longs temps de retour (z > 10). Actuel optimizé: Calcul en mode optimal à l’état actuel avant la réalisation d’éventuelles mesures. Prévu: Calcu';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN overflow_volume  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.overflow_volume IS 'yyy_Mittlere Überlaufwassermenge pro Jahr. Durchschnittliche Überlaufmenge pro Jahr von Entlastungsanlagen gemäss Langzeitsimulation (Dauer mindestens 10 Jahre). Ist optimiert: Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von  / Mittlere Überlaufwassermenge pro Jahr. Durchschnittliche Überlaufmenge pro Jahr von Entlastungsanlagen gemäss Langzeitsimulation (Dauer mindestens 10 Jahre). Ist optimiert: Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von allf / Volume moyen déversé par an. Volume moyen déversé par an selon des simulations pour de longs temps de retour (z > 10). Actuel optimizé: Calcul en mode optimal à l’état actuel avant la réalisation d’éventuelles mesures. Prévu: Calcul après la réalisation d';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN pump_characteristics  integer ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.pump_characteristics IS 'yyy_Bei speziellen Betriebsarten ist die Funktion separat zu dokumentieren und der Stammkarte beizulegen. / Bei speziellen Betriebsarten ist die Funktion separat zu dokumentieren und der Stammkarte beizulegen. / Pour de régime de fonctionnement spéciaux, cette fonction doit être documentée séparément et annexée à la fiche technique';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN pump_flow_max  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.pump_flow_max IS 'yyy_Maximaler Förderstrom der Pumpen (gesamtes Bauwerk). Tritt in der Regel bei der minimalen Förderhöhe ein. / Maximaler Förderstrom der Pumpen (gesamtes Bauwerk). Tritt in der Regel bei der minimalen Förderhöhe ein. / Débit de refoulement maximal de toutes les pompes de l’ouvrage. Survient normalement à la hauteur min de refoulement.';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN pump_flow_min  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.pump_flow_min IS 'yyy_Minimaler Förderstrom der Pumpen zusammen (gesamtes Bauwerk). Tritt in der Regel bei der maximalen Förderhöhe ein. / Minimaler Förderstrom der Pumpen zusammen (gesamtes Bauwerk). Tritt in der Regel bei der maximalen Förderhöhe ein. / Débit de refoulement minimal de toutes les pompes de l’ouvrage. Survient normalement à la hauteur max de refoulement.';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN pump_usage_current  integer ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.pump_usage_current IS 'yyy_Nutzungsart_Ist des gepumpten Abwassers. / Nutzungsart_Ist des gepumpten Abwassers. / Genre d''utilisation actuel de l''eau usée pompée';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN q_discharge  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.q_discharge IS 'yyy_Qab gemäss GEP / Qab gemäss GEP / Qeff selon PGEE';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN qon  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.qon IS 'yyy_Wassermenge, bei welcher der Überlauf anspringt / Wassermenge, bei welcher der Überlauf anspringt / Débit à partir duquel le déversoir devrait être fonctionnel';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.remark IS ' / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN status  integer ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.status IS 'yyy_Planungszustand der Hydraulischen Kennwerte (zwingend). Ueberlaufcharakteristik und Gesamteinzugsgebiet kann für verschiedene Stati gebildet werden und leitet sich aus dem Status der Hydr_Kennwerte ab. / Planungszustand der Hydraulischen Kennwerte (zwingend). Ueberlaufcharakteristik und Gesamteinzugsgebiet kann für verschiedene Stati gebildet werden und leitet sich aus dem Status der Hydr_Kennwerte ab. / Etat prévu des caractéristiques hydrauliques (obligatoire). Les caractéristiques de déversement et le bassin versant global peuvent être représentés à différents états et se laissent déduire à partir de l’attribut PARAMETRES_HYDR';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_hydraulic_characteristic_data.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_hydraulic_characteristic_data
BEFORE UPDATE OR INSERT ON
 qgep.od_hydraulic_characteristic_data
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_retention_body
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_retention_body_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_retention_body_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_retention_body ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_retention_body');
COMMENT ON COLUMN qgep.od_retention_body.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_retention_body ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_retention_body.identifier IS '';
 ALTER TABLE qgep.od_retention_body ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_retention_body.kind IS 'Type of retention / Arten der Retention / Genre de rétention';
 ALTER TABLE qgep.od_retention_body ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_retention_body.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_retention_body ADD COLUMN volume  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_retention_body.volume IS 'yyy_Nutzbares Volumen des Retentionskörpers / Nutzbares Volumen des Retentionskörpers / Volume effectif du volume de rétention';
 ALTER TABLE qgep.od_retention_body ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_retention_body.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_retention_body ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_retention_body.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_retention_body ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_retention_body.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_retention_body ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_retention_body.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_retention_body ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_retention_body.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_retention_body
BEFORE UPDATE OR INSERT ON
 qgep.od_retention_body
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_throttle_shut_off_unit
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_throttle_shut_off_unit_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_throttle_shut_off_unit_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_throttle_shut_off_unit ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_throttle_shut_off_unit');
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN actuation  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.actuation IS 'Actuation of the throttle or shut-off unit / Antrieb der Einbaute / Entraînement des installations';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN adjustability  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.adjustability IS 'Possibility to adjust the position / Möglichkeit zur Verstellung / Possibilité de modifier la position';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN control  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.control IS 'Open or closed loop control unit for the installation / Steuer- und Regelorgan für die Einbaute / Dispositifs de commande et de régulation des installations';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN cross_section  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.cross_section IS 'Cross section (geometric area) of throttle or shut-off unit / Geometrischer Drosselquerschnitt: Fgeom / Section géométrique de l''élément régulateur';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN effective_cross_section  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.effective_cross_section IS 'Effective cross section (area) / Wirksamer Drosselquerschnitt : Fid / Section du limiteur hydrauliquement active';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.gross_costs IS 'Gross costs / Brutto Erstellungskosten / Coûts bruts de réalisation';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.identifier IS '';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.kind IS 'Type of flow control / Art der Durchflussregulierung / Genre de régulation du débit';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN manufacturer  varchar(50) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.manufacturer IS 'Manufacturer of the electro-mechaninc equipment or installation / Hersteller der elektro-mech. Ausrüstung oder Einrichtung / Fabricant d''équipement électromécanique ou d''installations';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN signal_transmission  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.signal_transmission IS 'Signal or data transfer from or to a telecommunication station sending_receiving / Signalübermittlung von und zu einer Fernwirkanlage / Transmission des signaux de et vers une station de télécommande';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN subsidies  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.subsidies IS 'yyy_Staats- und Bundesbeiträge / Staats- und Bundesbeiträge / Contributions des cantons et de la confédération';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN throttle_unit_opening_current  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.throttle_unit_opening_current IS 'yyy_Folgende Werte sind anzugeben: Leapingwehr: Schrägdistanz der Blech- resp. Bodenöffnung. Drosselstrecke: keine zusätzlichen Angaben. Schieber / Schütz: lichte Höhe der Öffnung (ab Sohle bis UK Schieberplatte, tiefster Punkt). Abflussregulator: keine z / Folgende Werte sind anzugeben: Leapingwehr: Schrägdistanz der Blech- resp. Bodenöffnung. Drosselstrecke: keine zusätzlichen Angaben. Schieber / Schütz: lichte Höhe der Öffnung (ab Sohle bis UK Schieberplatte, tiefster Punkt). Abflussregulator: keine zusät / Les valeurs suivantes doivent être indiquées: Leaping weir: Longueur ouverture de fond, Cond. d’étranglement : aucune indication suppl., Vanne : hauteur max de l’ouverture (du radier jusqu’au bord inférieur plaque, point le plus bas), Régulateur de débit ';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN throttle_unit_opening_current_optimized  integer ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.throttle_unit_opening_current_optimized IS 'yyy_Folgende Werte sind anzugeben: Leapingwehr: Schrägdistanz der Blech- resp. Bodenöffnung. Drosselstrecke: keine zusätzlichen Angaben. Schieber / Schütz: lichte Höhe der Öffnung (ab Sohle bis UK Schieberplatte, tiefster Punkt). Abflussregulator: keine z / Folgende Werte sind anzugeben: Leapingwehr: Schrägdistanz der Blech- resp. Bodenöffnung. Drosselstrecke: keine zusätzlichen Angaben. Schieber / Schütz: lichte Höhe der Öffnung (ab Sohle bis UK Schieberplatte, tiefster Punkt). Abflussregulator: keine zusät / Les valeurs suivantes doivent être indiquées: Leaping weir: Longueur ouverture de fond, Cond. d’étranglement : aucune indication suppl., Vanne : hauteur max de l’ouverture (du radier jusqu’au bord inférieur plaque, point le plus bas), Régulateur de débit ';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_throttle_shut_off_unit.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_throttle_shut_off_unit
BEFORE UPDATE OR INSERT ON
 qgep.od_throttle_shut_off_unit
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_reach_point
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_reach_point_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_reach_point_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_reach_point ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_reach_point');
COMMENT ON COLUMN qgep.od_reach_point.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_reach_point ADD COLUMN elevation_accuracy  integer ;
COMMENT ON COLUMN qgep.od_reach_point.elevation_accuracy IS 'yyy_Quantifizierung der Genauigkeit der Höhenlage der Kote in Relation zum Höhenfixpunktnetz (z.B. Grundbuchvermessung oder Landesnivellement). / Quantifizierung der Genauigkeit der Höhenlage der Kote in Relation zum Höhenfixpunktnetz (z.B. Grundbuchvermessung oder Landesnivellement). / Plage de précision des coordonnées altimétriques du point de tronçon';
 ALTER TABLE qgep.od_reach_point ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_reach_point.identifier IS '';
 ALTER TABLE qgep.od_reach_point ADD COLUMN level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_reach_point.level IS 'yyy_Sohlenhöhe des Haltungsendes / Sohlenhöhe des Haltungsendes / Cote du radier de la fin du tronçon';
 ALTER TABLE qgep.od_reach_point ADD COLUMN outlet_shape  integer ;
COMMENT ON COLUMN qgep.od_reach_point.outlet_shape IS 'Kind of outlet shape / Art des Auslaufs / Types de sortie';
 ALTER TABLE qgep.od_reach_point ADD COLUMN position_of_connection  smallint ;
COMMENT ON COLUMN qgep.od_reach_point.position_of_connection IS 'yyy_Anschlussstelle bezogen auf Querschnitt im Kanal; in Fliessrichtung  (für Haus- und Strassenanschlüsse) / Anschlussstelle bezogen auf Querschnitt im Kanal; in Fliessrichtung  (für Haus- und Strassenanschlüsse) / Emplacement de raccordement Référence à la section transversale dans le canal dans le sens d’écoulement (pour les raccordements domestiques et de rue).';
 ALTER TABLE qgep.od_reach_point ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_reach_point.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
SELECT AddGeometryColumn('qgep', 'od_reach_point', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_reach_point_situation_geometry ON qgep.od_reach_point USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_reach_point.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_reach_point ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_reach_point.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_reach_point ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_reach_point.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_reach_point ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_reach_point.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_reach_point ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_reach_point.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_reach_point ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_reach_point.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_reach_point
BEFORE UPDATE OR INSERT ON
 qgep.od_reach_point
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_mechanical_pretreatment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_mechanical_pretreatment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_mechanical_pretreatment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_mechanical_pretreatment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_mechanical_pretreatment');
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.identifier IS '';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.kind IS 'yyy_Arten der mechanischen Vorreinigung / Behandlung (gemäss VSA Richtlinie Regenwasserentsorgung (2002)) / Arten der mechanischen Vorreinigung / Behandlung (gemäss VSA Richtlinie Regenwasserentsorgung (2002)) / Genre de pré-épuration mécanique (selon directive VSA "Evacuation des eaux pluviales, édition 2002)';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_mechanical_pretreatment.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_mechanical_pretreatment
BEFORE UPDATE OR INSERT ON
 qgep.od_mechanical_pretreatment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.re_maintenance_event_wastewater_structure
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_re_maintenance_event_wastewater_structure_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_re_maintenance_event_wastewater_structure_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.re_maintenance_event_wastewater_structure ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('re_maintenance_event_wastewater_structure');
COMMENT ON COLUMN qgep.re_maintenance_event_wastewater_structure.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
-------
CREATE TABLE qgep.od_profile_geometry
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_profile_geometry_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_profile_geometry_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_profile_geometry ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_profile_geometry');
COMMENT ON COLUMN qgep.od_profile_geometry.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN position  smallint ;
COMMENT ON COLUMN qgep.od_profile_geometry.position IS 'yyy_Position der Detailpunkte der Geometrie / Position der Detailpunkte der Geometrie / Position des points d''appui de la géométrie';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN x  real ;
COMMENT ON COLUMN qgep.od_profile_geometry.x IS 'x';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN y  real ;
COMMENT ON COLUMN qgep.od_profile_geometry.y IS 'y';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_profile_geometry.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_profile_geometry.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_profile_geometry.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_profile_geometry.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_profile_geometry ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_profile_geometry.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_profile_geometry
BEFORE UPDATE OR INSERT ON
 qgep.od_profile_geometry
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_file
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_file_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_file_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_file ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_file');
COMMENT ON COLUMN qgep.od_file.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_file ADD COLUMN class  integer ;
COMMENT ON COLUMN qgep.od_file.class IS 'yyy_Gibt an, zu welcher Klasse des VSA-DSS-Datenmodells die Datei gehört. Grundsätzlich alle Klassen möglich. Im Rahmen der Kanalfernsehaufnahmen hauptsächlich Kanal, Normschachtschaden, Kanalschaden und Untersuchung. / Gibt an, zu welcher Klasse des VSA-DSS-Datenmodells die Datei gehört. Grundsätzlich alle Klassen möglich. Im Rahmen der Kanalfernsehaufnahmen hauptsächlich Kanal, Normschachtschaden, Kanalschaden und Untersuchung. / Indique à quelle classe du modèle de données de VSA-SDEE appartient le fichier. Toutes les classes sont possible. Surtout CANALISATION, DOMMAGE_CHAMBRE_STANDARD, DOMMAGE_CANALISATION, INSPECTION.';
 ALTER TABLE qgep.od_file ADD COLUMN identifier  varchar(40) ;
COMMENT ON COLUMN qgep.od_file.identifier IS 'yyy_Name der Datei mit Dateiendung. Z.B video_01.mpg oder haltung_01.ipf / Name der Datei mit Dateiendung. Z.B video_01.mpg oder haltung_01.ipf / Nom du fichier avec terminaison du fichier. P. ex. video_01.mpg ou canalisation_01.ipf';
 ALTER TABLE qgep.od_file ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_file.kind IS 'yyy_Beschreibt die Art der Datei. Für analoge Videos auf Bändern ist der Typ "Video" einzusetzen. Die Bezeichnung wird dann gleich gesetzt wie die Bezeichnung des Videobandes. / Beschreibt die Art der Datei. Für analoge Videos auf Bändern ist der Typ "Video" einzusetzen. Die Bezeichnung wird dann gleich gesetzt wie die Bezeichnung des Videobandes. / Décrit le type de fichier. Pour les vidéos analo-giques sur bandes, le type « vidéo » doit être entré. La désignation sera ensuite la même que celle de la bande vidéo.';
 ALTER TABLE qgep.od_file ADD COLUMN object  varchar(41) ;
COMMENT ON COLUMN qgep.od_file.object IS 'yyy_Objekt-ID (OBJ_ID) des Datensatzes zu dem die Datei gehört / Objekt-ID (OBJ_ID) des Datensatzes zu dem die Datei gehört / Identification de l’ensemble de données auquel le fichier appartient (OBJ_ID)';
 ALTER TABLE qgep.od_file ADD COLUMN relativ_path  varchar(200) ;
COMMENT ON COLUMN qgep.od_file.relativ_path IS 'yyy_Zusätzlicher Relativer Pfad, wo die Datei auf dem Datenträger zu finden ist. Z.B. DVD_01. / Zusätzlicher Relativer Pfad, wo die Datei auf dem Datenträger zu finden ist. Z.B. DVD_01. / Accès relatif supplémentaire à l’emplacement du fichier sur le support de données. P. ex. DVD_01';
 ALTER TABLE qgep.od_file ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_file.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_file ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_file.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_file ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_file.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_file ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_file.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_file ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_file.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_file ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_file.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_file
BEFORE UPDATE OR INSERT ON
 qgep.od_file
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_overflow
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_overflow_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_overflow_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_overflow ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_overflow');
COMMENT ON COLUMN qgep.od_overflow.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_overflow ADD COLUMN actuation  integer ;
COMMENT ON COLUMN qgep.od_overflow.actuation IS 'Actuation of installation / Antrieb der Einbaute / Entraînement des installations';
 ALTER TABLE qgep.od_overflow ADD COLUMN adjustability  integer ;
COMMENT ON COLUMN qgep.od_overflow.adjustability IS 'yyy_Möglichkeit zur Verstellung / Möglichkeit zur Verstellung / Possibilité de modifier la position';
 ALTER TABLE qgep.od_overflow ADD COLUMN brand  varchar(50) ;
COMMENT ON COLUMN qgep.od_overflow.brand IS 'Manufacturer of the electro-mechaninc equipment or installation / Hersteller der elektro-mechanischen Ausrüstung oder Einrichtung / Fabricant d''équipement électromécanique ou d''installations';
 ALTER TABLE qgep.od_overflow ADD COLUMN control  integer ;
COMMENT ON COLUMN qgep.od_overflow.control IS 'yyy_Steuer- und Regelorgan für die Einbaute / Steuer- und Regelorgan für die Einbaute / Dispositifs de commande et de régulation des installations';
 ALTER TABLE qgep.od_overflow ADD COLUMN discharge_point  varchar(41) ;
COMMENT ON COLUMN qgep.od_overflow.discharge_point IS 'Identifier of discharge_point in which the overflow is discharging (redundant attribute with network follow up or result of that). Is only needed if overflow is discharging into a river (directly or via a rainwater drainage). / Bezeichnung der Einleitstelle in die der Ueberlauf entlastet (redundantes Attribut zur Netzverfolgung oder Resultat davon). Muss nur erfasst werden, wenn das Abwasser vom Notüberlauf in ein Gewässer eingeleitet wird (direkt oder über eine Regenabwasserlei / Désignation de l''exutoire: A indiquer uniquement lorsque l’eau déversée est rejetée dans un cours d’eau (directement ou indirectement via une conduite d’eaux pluviales).';
 ALTER TABLE qgep.od_overflow ADD COLUMN function  integer ;
COMMENT ON COLUMN qgep.od_overflow.function IS 'yyy_Teil des Mischwasserabflusses, der aus einem Überlauf in einen Vorfluter oder in ein Abwasserbauwerk abgeleitet wird / Teil des Mischwasserabflusses, der aus einem Überlauf in einen Vorfluter oder in ein Abwasserbauwerk abgeleitet wird / Type de déversoir';
 ALTER TABLE qgep.od_overflow ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_overflow.gross_costs IS 'Gross costs / Brutto Erstellungskosten / Coûts bruts de réalisation';
 ALTER TABLE qgep.od_overflow ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_overflow.identifier IS '';
 ALTER TABLE qgep.od_overflow ADD COLUMN qon_dim  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_overflow.qon_dim IS 'yyy_Wassermenge, bei welcher der Überlauf gemäss Dimensionierung anspringt / Wassermenge, bei welcher der Überlauf gemäss Dimensionierung anspringt / Débit à partir duquel le déversoir devrait être fonctionnel (selon dimensionnement)';
 ALTER TABLE qgep.od_overflow ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_overflow.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_overflow ADD COLUMN signal_transmission  integer ;
COMMENT ON COLUMN qgep.od_overflow.signal_transmission IS 'Signal or data transfer from or to a telecommunication station / Signalübermittlung von und zu einer Fernwirkanlage / Transmission des signaux de et vers une station de télécommande';
 ALTER TABLE qgep.od_overflow ADD COLUMN subsidies  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_overflow.subsidies IS 'yyy_Staats- und Bundesbeiträge / Staats- und Bundesbeiträge / Contributions des cantons et de la confédération';
 ALTER TABLE qgep.od_overflow ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_overflow.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_overflow ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_overflow.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_overflow ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_overflow.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_overflow ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_overflow.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_overflow ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_overflow.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_overflow
BEFORE UPDATE OR INSERT ON
 qgep.od_overflow
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_catchment_area
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_catchment_area_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_catchment_area_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_catchment_area ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_catchment_area');
COMMENT ON COLUMN qgep.od_catchment_area.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN direct_discharge_current  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.direct_discharge_current IS 'The rain water is currently fully or partially discharged into a water body / Das Regenabwasser wird ganz oder teilweise über eine SAA-Leitung in ein Gewässer eingeleitet / Les eaux pluviales sont rejetées complètement ou partiellement via une conduite OAS dans un cours d’eau';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN direct_discharge_planned  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.direct_discharge_planned IS 'The rain water will be discharged fully or partially over a SAA pipe into a water body / Das Regenabwasser wird in Zukunft ganz oder teilweise über eine SAA-Leitung in ein Gewässer eingeleitet / Les eaux pluviales seront rejetées complètement ou partiellement via une conduite OAS dans un cours d’eau';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN discharge_coefficient_rw_current  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.discharge_coefficient_rw_current IS 'yyy_Abflussbeiwert für den Regenabwasseranschluss im Ist-Zustand / Abflussbeiwert für den Regenabwasseranschluss im Ist-Zustand / Coefficient de ruissellement pour le raccordement actuel des eaux pluviales';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN discharge_coefficient_rw_planned  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.discharge_coefficient_rw_planned IS 'yyy_Abflussbeiwert für den Regenabwasseranschluss im Planungszustand / Abflussbeiwert für den Regenabwasseranschluss im Planungszustand / Coefficient de ruissellement prévu pour le raccordement des eaux pluviales';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN discharge_coefficient_ww_current  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.discharge_coefficient_ww_current IS 'yy_Abflussbeiwert für den Schmutz- oder Mischabwasseranschluss im Ist-Zustand / Abflussbeiwert für den Schmutz- oder Mischabwasseranschluss im Ist-Zustand / Coefficient de ruissellement pour les raccordements eaux usées et eaux mixtes actuels';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN discharge_coefficient_ww_planned  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.discharge_coefficient_ww_planned IS 'yyy_Abflussbeiwert für den Schmutz- oder Mischabwasseranschluss im Planungszustand / Abflussbeiwert für den Schmutz- oder Mischabwasseranschluss im Planungszustand / Coefficient de ruissellement pour le raccordement prévu des eaux usées ou mixtes';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN drainage_system_current  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.drainage_system_current IS 'yyy_Effektive Entwässerungsart im Ist-Zustand / Effektive Entwässerungsart im Ist-Zustand / Genre d’évacuation des eaux réel à l’état actuel';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN drainage_system_planned  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.drainage_system_planned IS 'yyy_Entwässerungsart im Planungszustand (nach Umsetzung des Entwässerungskonzepts). Dieses Attribut hat Auflagecharakter. Es ist verbindlich für die Beurteilung von Baugesuchen / Entwässerungsart im Planungszustand (nach Umsetzung des Entwässerungskonzepts). Dieses Attribut hat Auflagecharakter. Es ist verbindlich für die Beurteilung von Baugesuchen / Genre d’évacuation des eaux à l’état de planification (mise en œuvre du concept d’évacuation). Cet attribut est exigé. Il est obligatoire pour l’examen des demandes de permit de construire';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_catchment_area.identifier IS '';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN infiltration_current  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.infiltration_current IS 'yyy_Das Regenabwasser wird ganz oder teilweise einer Versickerungsanlage zugeführt / Das Regenabwasser wird ganz oder teilweise einer Versickerungsanlage zugeführt / Les eaux pluviales sont amenées complètement ou partiellement à une installation d’infiltration';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN infiltration_planned  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.infiltration_planned IS 'In the future the rain water will  be completly or partially infiltrated in a infiltration unit. / Das Regenabwasser wird in Zukunft ganz oder teilweise einer Versickerungsanlage zugeführt / Les eaux pluviales seront amenées complètement ou partiellement à une installation d’infiltration';
SELECT AddGeometryColumn('qgep', 'od_catchment_area', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_catchment_area_perimeter_geometry ON qgep.od_catchment_area USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_catchment_area.perimeter_geometry IS 'Boundary points of the perimeter sub catchement area / Begrenzungspunkte des Teileinzugsgebiets / Points de délimitation du bassin versant partiel';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN population_density_current  smallint ;
COMMENT ON COLUMN qgep.od_catchment_area.population_density_current IS 'yyy_Dichte der (physischen) Einwohner im Ist-Zustand / Dichte der (physischen) Einwohner im Ist-Zustand / Densité (physique) de la population actuelle';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN population_density_planned  smallint ;
COMMENT ON COLUMN qgep.od_catchment_area.population_density_planned IS 'yyy_Dichte der (physischen) Einwohner im Planungszustand / Dichte der (physischen) Einwohner im Planungszustand / Densité (physique) de la population prévue';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_catchment_area.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN retention_current  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.retention_current IS 'yyy_Das Regen- oder Mischabwasser wird über Rückhalteeinrichtungen verzögert ins Kanalnetz eingeleitet. / Das Regen- oder Mischabwasser wird über Rückhalteeinrichtungen verzögert ins Kanalnetz eingeleitet. / Les eaux pluviales et mixtes sont rejetées de manière régulée dans le réseau des canalisations par un ouvrage de rétention.';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN retention_planned  integer ;
COMMENT ON COLUMN qgep.od_catchment_area.retention_planned IS 'yyy_Das Regen- oder Mischabwasser wird in Zukunft über Rückhalteeinrichtungen verzögert ins Kanalnetz eingeleitet. / Das Regen- oder Mischabwasser wird in Zukunft über Rückhalteeinrichtungen verzögert ins Kanalnetz eingeleitet. / Les eaux pluviales et mixtes seront rejetées de manière régulée dans le réseau des canalisations par un ouvrage de rétention.';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN runoff_limit_current  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_catchment_area.runoff_limit_current IS 'yyy_Abflussbegrenzung, falls eine entsprechende Auflage bereits umgesetzt ist. / Abflussbegrenzung, falls eine entsprechende Auflage bereits umgesetzt ist. / Restriction de débit, si une exigence est déjà mise en œuvre';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN runoff_limit_planned  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_catchment_area.runoff_limit_planned IS 'yyy_Abflussbegrenzung, falls eine entsprechende Auflage aus dem Entwässerungskonzept vorliegt. Dieses Attribut hat Auflagecharakter. Es ist verbindlich für die Beurteilung von Baugesuchen / Abflussbegrenzung, falls eine entsprechende Auflage aus dem Entwässerungskonzept vorliegt. Dieses Attribut hat Auflagecharakter. Es ist verbindlich für die Beurteilung von Baugesuchen / Restriction de débit, si une exigence correspondante existe dans le concept d’évacuation des eaux. Cet attribut est une exigence et obligatoire pour l’examen de demandes de permit de construire';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN seal_factor_rw_current  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.seal_factor_rw_current IS 'yyy_Befestigungsgrad für den Regenabwasseranschluss im Ist-Zustand / Befestigungsgrad für den Regenabwasseranschluss im Ist-Zustand / Taux d''imperméabilisation pour le raccordement eaux pluviales actuel';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN seal_factor_rw_planned  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.seal_factor_rw_planned IS 'yyy_Befestigungsgrad für den Regenabwasseranschluss im Planungszustand / Befestigungsgrad für den Regenabwasseranschluss im Planungszustand / Taux d''imperméabilisation pour le raccordement eaux pluviales prévu';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN seal_factor_ww_current  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.seal_factor_ww_current IS 'yyy_Befestigungsgrad für den Schmutz- oder Mischabwasseranschluss im Ist-Zustand / Befestigungsgrad für den Schmutz- oder Mischabwasseranschluss im Ist-Zustand / Taux d''imperméabilisation pour les raccordements eaux usées et eaux mixtes actuels';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN seal_factor_ww_planned  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.seal_factor_ww_planned IS 'yyy_Befestigungsgrad für den Schmutz- oder Mischabwasseranschluss im Planungszustand / Befestigungsgrad für den Schmutz- oder Mischabwasseranschluss im Planungszustand / Taux d''imperméabilisation pour les raccordements eaux usées et eaux mixtes prévus';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN sewer_infiltration_water_production_current  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_catchment_area.sewer_infiltration_water_production_current IS 'yyy_Mittlerer Fremdwasseranfall, der im Ist-Zustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird / Mittlerer Fremdwasseranfall, der im Ist-Zustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird / Débit  d''eaux claires parasites (ECP) moyen actuel, rejeté dans les canalisation d’eaux usées ou mixtes';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN sewer_infiltration_water_production_planned  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_catchment_area.sewer_infiltration_water_production_planned IS 'yyy_Mittlerer Fremdwasseranfall, der im Planungszustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird. / Mittlerer Fremdwasseranfall, der im Planungszustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird. / Débit  d''eaux claires parasites (ECP) moyen prévu, rejeté dans les canalisation d’eaux usées ou mixtes';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN surface_area  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchment_area.surface_area IS 'yyy_redundantes Attribut Flaeche, welches die aus dem Perimeter errechnete Flaeche [ha] enthält / Redundantes Attribut Flaeche, welches die aus dem Perimeter errechnete Flaeche [ha] enthält / Attribut redondant indiquant la surface calculée à partir du périmètre en ha';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN waste_water_production_current  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_catchment_area.waste_water_production_current IS 'yyy_Mittlerer Schmutzabwasseranfall, der im Ist-Zustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird / Mittlerer Schmutzabwasseranfall, der im Ist-Zustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird / Débit moyen actuel des eaux usées rejetées dans les canalisations d’eaux usées ou d''eaux mixtes';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN waste_water_production_planned  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_catchment_area.waste_water_production_planned IS 'yyy_Mittlerer Schmutzabwasseranfall, der im Planungszustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird. / Mittlerer Schmutzabwasseranfall, der im Planungszustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird. / Débit moyen prévu des eaux usées rejetées dans les canalisations d’eaux usées ou d''eaux mixtes.';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_catchment_area.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_catchment_area.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_catchment_area.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_catchment_area.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_catchment_area ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_catchment_area.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_catchment_area
BEFORE UPDATE OR INSERT ON
 qgep.od_catchment_area
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_hazard_source
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_hazard_source_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_hazard_source_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_hazard_source ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_hazard_source');
COMMENT ON COLUMN qgep.od_hazard_source.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_hazard_source.identifier IS '';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_hazard_source.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
SELECT AddGeometryColumn('qgep', 'od_hazard_source', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_hazard_source_situation_geometry ON qgep.od_hazard_source USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_hazard_source.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_hazard_source.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_hazard_source.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_hazard_source.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_hazard_source.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_hazard_source ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_hazard_source.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_hazard_source
BEFORE UPDATE OR INSERT ON
 qgep.od_hazard_source
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_connection_object
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_connection_object_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_connection_object_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_connection_object ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_connection_object');
COMMENT ON COLUMN qgep.od_connection_object.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_connection_object ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_connection_object.identifier IS '';
 ALTER TABLE qgep.od_connection_object ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_connection_object.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_connection_object ADD COLUMN sewer_infiltration_water_production  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_connection_object.sewer_infiltration_water_production IS 'yyy_Durchschnittlicher Fremdwasseranfall für Fremdwasserquellen wie Laufbrunnen oder Reservoirüberlauf / Durchschnittlicher Fremdwasseranfall für Fremdwasserquellen wie Laufbrunnen oder Reservoirüberlauf / Apport moyen d''eaux claires parasites (ECP) par des sources d''ECP, telles que fontaines ou trops-plein de réservoirs';
 ALTER TABLE qgep.od_connection_object ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_connection_object.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_connection_object ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_connection_object.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_connection_object ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_connection_object.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_connection_object ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_connection_object.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_connection_object ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_connection_object.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_connection_object
BEFORE UPDATE OR INSERT ON
 qgep.od_connection_object
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_surface_runoff_parameters
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_surface_runoff_parameters_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_surface_runoff_parameters_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_surface_runoff_parameters ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_surface_runoff_parameters');
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN evaporation_loss  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.evaporation_loss IS 'Loss by evaporation / Verlust durch Verdunstung / Pertes par évaporation au sol';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.identifier IS '';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN infiltration_loss  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.infiltration_loss IS 'Loss by infiltration / Verlust durch Infiltration / Pertes par infiltration';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN surface_storage  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.surface_storage IS 'Loss by filing depressions in the surface / Verlust durch Muldenfüllung / Pertes par remplissage de dépressions';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN wetting_loss  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.wetting_loss IS 'Loss of wetting plantes and surface during rainfall / Verlust durch Haftung des Niederschlages an Pflanzen- und andere Oberfläche / Pertes par rétention des précipitations sur la végétation et autres surfaces';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_surface_runoff_parameters.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_surface_runoff_parameters
BEFORE UPDATE OR INSERT ON
 qgep.od_surface_runoff_parameters
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_catchement_area_totals
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_catchement_area_totals_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_catchement_area_totals_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_catchement_area_totals ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_catchement_area_totals');
COMMENT ON COLUMN qgep.od_catchement_area_totals.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN population  integer ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.population IS 'yyy_Anzahl Einwohner im direkten Einzugsgebiet als informativer Wert. Der massgebende Schmutzabwasseranfall ist im gleichnamigen entsprechenden Attribut anzugeben. / Anzahl Einwohner im direkten Einzugsgebiet als informativer Wert. Der massgebende Schmutzabwasseranfall ist im gleichnamigen entsprechenden Attribut anzugeben. / Nombre d''habitants dans le bassin versant direct, valeur à titre indicatif. Le débit d''eaux usées déterminant est spécifié dans l''attribut correspondant.';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN population_dim  integer ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.population_dim IS 'yyy_Anzahl Einwohner im direkten Einzugsgebiet (Dimensionierung) als informativer Wert. Der massgebende Schmutzabwasseranfall ist im gleichnamigen entsprechenden Attribut anzugeben. / Anzahl Einwohner im direkten Einzugsgebiet (Dimensionierung) als informativer Wert. Der massgebende Schmutzabwasseranfall ist im gleichnamigen entsprechenden Attribut anzugeben. / Nombre d’habitants dans le bassin versant direct (dimensionnement), valeur indicative. Le débit des eaux usées doit être indiqué dans l’attribut du même nom.';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN sewer_infiltration_water  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.sewer_infiltration_water IS 'yyy_Totaler Fremdwasseranfall beim Bauwerk inkl. aller obenliegenden Gebiete. Angabe Jahresmittelwert (24 Std.-Mittel) in l/s. / Totaler Fremdwasseranfall beim Bauwerk inkl. aller obenliegenden Gebiete. Angabe Jahresmittelwert (24 Std.-Mittel) in l/s. / Débit total d’eaux claires parasites à l’ouvrage, incluant les surfaces en amont. Moyenne annuelle sur 24 h en l/s.';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN surface_area  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.surface_area IS 'yyy_Bruttofläche des direkten Einzugsgebietes im Misch- resp. Trennsystem gemäss Abbildung. / Bruttofläche des direkten Einzugsgebietes im Misch- resp. Trennsystem gemäss Abbildung. / Surface brute du bassin versant direct en système unitaire, resp. séparatif, selon illustration.';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN surface_dim  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.surface_dim IS 'yyy_Bruttofläche des Einzugsgebiets Dimensionierung. Dieses Einzugsgebiet umfasst in der Regel alle obenliegenden Flächen des Regenbeckenüberlaufbeckens (inkl. denjenigen von Regenüberläufen, Pumpwerken, etc.) oder alle obenliegenden Flächen bis zum nächs / Bruttofläche des Einzugsgebiets Dimensionierung. Dieses Einzugsgebiet umfasst in der Regel alle obenliegenden Flächen des Regenbeckenüberlaufbeckens (inkl. denjenigen von Regenüberläufen, Pumpwerken, etc.) oder alle obenliegenden Flächen bis zum nächsten  / Surface brute du bassin versant de dimensionnement. Lors de la saisie des bassins d’eaux pluviales, il faut également indiquer le bassin versant de dimensionnement. Ce bassin versant contient toutes les surfaces en amont du BEP (incl. en amont les déverso';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN surface_imp_dim  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.surface_imp_dim IS 'yyy_Befestigte Fläche des Einzugsgebiets Dimensionierung im Misch- resp. Trennsystem (nur Regenüberlaufbecken). Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser angeschlossene befestigte Fläche anzugeben. Es muss mindestens eine Fläche (be / Befestigte Fläche des Einzugsgebiets Dimensionierung im Misch- resp. Trennsystem (nur Regenüberlaufbecken). Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser angeschlossene befestigte Fläche anzugeben. Es muss mindestens eine Fläche (befest / Surface imperméabilisée du bassin versant de dimensionnement dans le système unitaire, resp. séparatif (BEP uniquement). Dans un système séparatif, il faut saisir dans la fiche technique la surface imperméabilisée raccordée aux eaux usées. Au minimum une ';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN surface_imp_red  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.surface_imp_red IS 'yyy_Impermeable suface des direkten Einzugsgebiets im Misch- resp. Trennsystem gemäss Abbildung. Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser ange-schlossene befestigte Fläche anzugeben. Es muss mindestens eine Fläche (befestigt oder r / Befestigte Fläche des direkten Einzugsgebiets im Misch- resp. Trennsystem gemäss Abbildung. Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser ange-schlossene befestigte Fläche anzugeben. Es muss mindestens eine Fläche (befestigt oder reduzi / Surface imperméabilisée du bassin versant  direct pour un système unitaire, resp. séparatif selon illustration. Dans un système séparatif, il faut saisir dans la fiche technique la surface réduite raccordée aux eaux usées. Au minimum une surface (imperméa';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN surface_red  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.surface_red IS 'yyy_Reduzierte Fläche des direkten Einzugsgebiets im Misch- resp. Trennsystem gemäss Abbildung. Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser ange-schlossene reduzierte Fläche anzugeben. Es muss mindestens eine Fläche (befestigt oder re / Reduzierte Fläche des direkten Einzugsgebiets im Misch- resp. Trennsystem gemäss Abbildung. Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser ange-schlossene reduzierte Fläche anzugeben. Es muss mindestens eine Fläche (befestigt oder reduzi / Surface réduite du bassin versant direct pour un système unitaire, resp. séparatif selon illustration. Dans un système séparatif, il faut saisir la surface réduite raccordée aux eaux usées. Au minimum une surface (imperméabilisée ou réduite) doit être ind';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN surface_red_dim  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.surface_red_dim IS 'yyy_Reduzierte Fläche des Einzugsgebiets Dimensionierung im Misch- resp. Trennsystem (nur Regenüberlaufbecken). Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser angeschlossene reduzierte Fläche anzugeben. Es muss mindestens eine Fläche (be / Reduzierte Fläche des Einzugsgebiets Dimensionierung im Misch- resp. Trennsystem (nur Regenüberlaufbecken). Im Trennsystem ist für die Stammkarte die an das Schmutzabwasser angeschlossene reduzierte Fläche anzugeben. Es muss mindestens eine Fläche (befest / Surface réduite du bassin versant de dimensionnement dans le système unitaire, resp. séparatif. Dans un système séparatif, il faut saisir la surface réduite raccordée aux eaux usées. Au minimum une surface (imperméabilisée ou réduite) doit être indiquée.';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN waste_water_production  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.waste_water_production IS 'yyy_Totaler Schmutzabwasseranfall beim Bauwerk inkl. aller obenliegenden Gebiete. Angabe Jahresmittelwert (24 Std.-Mittel) in l/s. / Totaler Schmutzabwasseranfall beim Bauwerk inkl. aller obenliegenden Gebiete. Angabe Jahresmittelwert (24 Std.-Mittel) in l/s. / Débit total d’eaux usées à l’ouvrage, incluant les surfaces en amont. Moyenne annuelle sur 24 h en l/s.';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_catchement_area_totals.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_catchement_area_totals.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_catchement_area_totals.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_catchement_area_totals.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_catchement_area_totals
BEFORE UPDATE OR INSERT ON
 qgep.od_catchement_area_totals
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_substance
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_substance_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_substance_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_substance ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_substance');
COMMENT ON COLUMN qgep.od_substance.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_substance ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_substance.identifier IS '';
 ALTER TABLE qgep.od_substance ADD COLUMN kind  varchar(50) ;
COMMENT ON COLUMN qgep.od_substance.kind IS 'yyy_Liste der wassergefährdenden Stoffe / Liste der wassergefährdenden Stoffe / Liste des substances de nature à polluer les eaux';
 ALTER TABLE qgep.od_substance ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_substance.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_substance ADD COLUMN stockage  varchar(50) ;
COMMENT ON COLUMN qgep.od_substance.stockage IS 'yyy_Art der Lagerung der abwassergefährdenden Stoffe / Art der Lagerung der abwassergefährdenden Stoffe / Genre de stockage des substances dangereuses';
 ALTER TABLE qgep.od_substance ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_substance.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_substance ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_substance.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_substance ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_substance.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_substance ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_substance.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_substance ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_substance.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_substance
BEFORE UPDATE OR INSERT ON
 qgep.od_substance
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_measure
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_measure_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_measure_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_measure ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_measure');
COMMENT ON COLUMN qgep.od_measure.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_measure ADD COLUMN category  integer ;
COMMENT ON COLUMN qgep.od_measure.category IS 'Category of measure (mandatory) / Massnahmenkategorie (obligatorisch) / Catégorie de la mesure (obligatoire)';
 ALTER TABLE qgep.od_measure ADD COLUMN date_entry  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_measure.date_entry IS 'Entry date, when the measure was added to the list of measures / Datum, an welchem die Massnahme in die Massnahmenliste aufgenommen wurde / Date d''entrée de la mesure dans le plan d''actions';
 ALTER TABLE qgep.od_measure ADD COLUMN description  varchar(100) ;
COMMENT ON COLUMN qgep.od_measure.description IS '';
 ALTER TABLE qgep.od_measure ADD COLUMN identifier  varchar(50) ;
COMMENT ON COLUMN qgep.od_measure.identifier IS 'Identifier of the measure. The identification follows certain rules (see Wegleitung GEP-Daten) / Bezeichnung der Massnahme. Die Bezeichnung erfolgt nach bestimmten Regeln (siehe Wegleitung GEP-Daten) / Désignation de la mesure. La désignation suit des règles précises (cf. guide des données PGEE)';
 ALTER TABLE qgep.od_measure ADD COLUMN intervention_demand  varchar(255) ;
COMMENT ON COLUMN qgep.od_measure.intervention_demand IS 'Short description of need of action / Kurzbeschreibung des Handlungsbedarfs / Description courte du besoin d''intervention';
 ALTER TABLE qgep.od_measure ADD COLUMN link  varchar(255) ;
COMMENT ON COLUMN qgep.od_measure.link IS 'Reference to other measure (identifier)  or works done. Reference to documents, that specify details of the measure, e.g. GEP reports or documents or project papers. / Verweis auf andere Massnahmen (Bezeichnung)  oder Arbeiten, Hinweis auf Grundlagen in denen die Massnahmen näher erläutert werden, wie z.B. auf die entsprechenden GEP-Teilprojekte / Référence à d’autres mesures ou travaux, documents explicatifs concernant la mesure, par exemple les projets partiels PGEE ou rapports d’état';
SELECT AddGeometryColumn('qgep', 'od_measure', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_measure_perimeter_geometry ON qgep.od_measure USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_measure.perimeter_geometry IS 'Perimeter, for visualisation and geometrical relation (OPTIONAL) / Für Visualisierung und Darstellung des räumlichen Bezugs (OPTIONAL) / Pour la visualisation et l’illustration dans l’espace (OPTIONAL)';
 ALTER TABLE qgep.od_measure ADD COLUMN priority  integer ;
COMMENT ON COLUMN qgep.od_measure.priority IS 'Priority of measure / Priorität der Massnahme / Priorité de la mesure.';
 ALTER TABLE qgep.od_measure ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_measure.remark IS 'General remarks of project designer or controlling institution / Bemerkungen des Projektverfassers oder der Aufsichtsbehörde / Remarques du gestionnaire du projet ou de l''autorité de surveillance';
 ALTER TABLE qgep.od_measure ADD COLUMN responsible_entity  varchar(80) ;
COMMENT ON COLUMN qgep.od_measure.responsible_entity IS 'Identifier of responsible entity (name, number, WWTP number, ...) / Bezeichnung der Trägerschaft der Massnahme (Name, Gemeindenummer, ARANr, ...) / Entité responsable de la mesure (nom, numéro de commune, STEP, etc)';
 ALTER TABLE qgep.od_measure ADD COLUMN responsible_start  varchar(80) ;
COMMENT ON COLUMN qgep.od_measure.responsible_start IS 'yyy_Responsible body for YYY / Verantwortliche Stelle für die Auslösung / Office responsable du déclenchement de la mesure.';
 ALTER TABLE qgep.od_measure ADD COLUMN status  integer ;
COMMENT ON COLUMN qgep.od_measure.status IS 'Disposition state of measure / Status der Massnahme / Etat de la mesure';
SELECT AddGeometryColumn('qgep', 'od_measure', 'symbolpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_measure_symbolpos_geometry ON qgep.od_measure USING gist (symbolpos_geometry );
COMMENT ON COLUMN qgep.od_measure.symbolpos_geometry IS 'For the visualisation (without geometric relation) / Für die Visualisierung (ohne räumlichen Bezug) / Pour la visualisation (sans relation géométrique)';
 ALTER TABLE qgep.od_measure ADD COLUMN total_cost  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_measure.total_cost IS 'Sum of own and cost of third parties. Eventually they can be listed also seperately. / Summe der Eigenleistung und Kosten Dritter. Allenfalls können diese zusätzlich auch separat ausgewiesen werden / Somme des contributions propres et des coûts de parties tiers. Ils peuvent également être justifiés séparément';
 ALTER TABLE qgep.od_measure ADD COLUMN year_implementation_effectiv  smallint ;
COMMENT ON COLUMN qgep.od_measure.year_implementation_effectiv IS 'Year the measure was actually implemented / Jahr, in dem die Massnahme effektiv umgesetzt wurde / Année à laquelle la mesure a effectivement été mise en œuvre';
 ALTER TABLE qgep.od_measure ADD COLUMN year_implementation_planned  smallint ;
COMMENT ON COLUMN qgep.od_measure.year_implementation_planned IS 'Planned year of implementation / Jahr bis die Massnahme umgesetzt sein soll / Année à laquelle la mesure devrait être mise en œuvre';
 ALTER TABLE qgep.od_measure ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_measure.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_measure ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_measure.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measure ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_measure.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_measure ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_measure.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measure ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_measure.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_measure
BEFORE UPDATE OR INSERT ON
 qgep.od_measure
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_measuring_device
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_measuring_device_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_measuring_device_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_measuring_device ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_measuring_device');
COMMENT ON COLUMN qgep.od_measuring_device.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN brand  varchar(50) ;
COMMENT ON COLUMN qgep.od_measuring_device.brand IS 'Brand / Name of producer / Name des Herstellers / Nom du fabricant';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_measuring_device.identifier IS '';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_measuring_device.kind IS 'Type of measuring device / Typ des Messgerätes / Type de l''appareil de mesure';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_measuring_device.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN serial_number  varchar(50) ;
COMMENT ON COLUMN qgep.od_measuring_device.serial_number IS '';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_measuring_device.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_measuring_device.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_measuring_device.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_measuring_device.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measuring_device ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_measuring_device.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_measuring_device
BEFORE UPDATE OR INSERT ON
 qgep.od_measuring_device
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_measuring_point
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_measuring_point_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_measuring_point_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_measuring_point ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_measuring_point');
COMMENT ON COLUMN qgep.od_measuring_point.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN damming_device  integer ;
COMMENT ON COLUMN qgep.od_measuring_point.damming_device IS '';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_measuring_point.identifier IS '';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN kind  varchar(50) ;
COMMENT ON COLUMN qgep.od_measuring_point.kind IS 'yyy_Art der Untersuchungsstelle ( Regenmessungen, Abflussmessungen, etc.) / Art der Untersuchungsstelle ( Regenmessungen, Abflussmessungen, etc.) / Genre de mesure (mesures de pluviométrie, mesures de débit, etc.)';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN purpose  integer ;
COMMENT ON COLUMN qgep.od_measuring_point.purpose IS 'Purpose of measurement / Zweck der Messung / Objet de la mesure';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_measuring_point.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
SELECT AddGeometryColumn('qgep', 'od_measuring_point', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_measuring_point_situation_geometry ON qgep.od_measuring_point USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_measuring_point.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_measuring_point.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_measuring_point.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_measuring_point.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_measuring_point.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_measuring_point.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_measuring_point
BEFORE UPDATE OR INSERT ON
 qgep.od_measuring_point
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_measurement_series
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_measurement_series_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_measurement_series_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_measurement_series ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_measurement_series');
COMMENT ON COLUMN qgep.od_measurement_series.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN dimension  varchar(50) ;
COMMENT ON COLUMN qgep.od_measurement_series.dimension IS 'yyy_Messtypen (Einheit) / Messtypen (Einheit) / Types de mesures';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_measurement_series.identifier IS '';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_measurement_series.kind IS 'Type of measurment series / Art der Messreihe / Genre de série de mesures';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_measurement_series.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_measurement_series.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_measurement_series.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_measurement_series.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_measurement_series.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measurement_series ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_measurement_series.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_measurement_series
BEFORE UPDATE OR INSERT ON
 qgep.od_measurement_series
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_measurement_result
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_measurement_result_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_measurement_result_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_measurement_result ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_measurement_result');
COMMENT ON COLUMN qgep.od_measurement_result.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_measurement_result.identifier IS '';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN measurement_type  integer ;
COMMENT ON COLUMN qgep.od_measurement_result.measurement_type IS 'Type of measurment, e.g. proportional to time or volume / Art der Messung, z.B zeit- oder mengenproportional / Type de mesure, par ex. proportionnel au temps ou au débit';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN measuring_duration  decimal(7,0) ;
COMMENT ON COLUMN qgep.od_measurement_result.measuring_duration IS 'Duration of measurment in seconds / Dauer der Messung in Sekunden / Durée de la mesure';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_measurement_result.remark IS 'General remarks / Allgemeine Bemerkungen / Remarques générales';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN time  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_measurement_result.time IS 'Date and time at beginning of measurment / Zeitpunkt des Messbeginns / Date et heure du début de la mesure';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN value  real ;
COMMENT ON COLUMN qgep.od_measurement_result.value IS 'yyy_Gemessene Grösse / Gemessene Grösse / Valeur mesurée';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_measurement_result.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_measurement_result.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_measurement_result.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_measurement_result.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_measurement_result ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_measurement_result.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_measurement_result
BEFORE UPDATE OR INSERT ON
 qgep.od_measurement_result
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_groundwater_protection_zone
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_groundwater_protection_zone_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_groundwater_protection_zone_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_groundwater_protection_zone ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_groundwater_protection_zone');
COMMENT ON COLUMN qgep.od_groundwater_protection_zone.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_groundwater_protection_zone ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_groundwater_protection_zone.kind IS 'yyy_Zonenarten. Grundwasserschutzzonen bestehen aus dem Fassungsbereich (Zone S1), der Engeren Schutzzone (Zone S2) und der Weiteren Schutzzone (Zone S3). / Zonenarten. Grundwasserschutzzonen bestehen aus dem Fassungsbereich (Zone S1), der Engeren Schutzzone (Zone S2) und der Weiteren Schutzzone (Zone S3). / Genre de zones';
SELECT AddGeometryColumn('qgep', 'od_groundwater_protection_zone', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_groundwater_protection_zone_perimeter_geometry ON qgep.od_groundwater_protection_zone USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_groundwater_protection_zone.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_groundwater_protection_zone
BEFORE UPDATE OR INSERT ON
 qgep.od_groundwater_protection_zone
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('zone');

-------
-------
CREATE TABLE qgep.od_drainage_system
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_drainage_system_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_drainage_system_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_drainage_system ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_drainage_system');
COMMENT ON COLUMN qgep.od_drainage_system.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_drainage_system ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_drainage_system.kind IS 'yyy_Art des Entwässerungssystems in dem ein bestimmtes Gebiet entwässert werden soll (SOLL Zustand) / Art des Entwässerungssystems in dem ein bestimmtes Gebiet entwässert werden soll (SOLL Zustand) / Genre de système d''évacuation choisi pour une région déterminée (Etat prévu)';
SELECT AddGeometryColumn('qgep', 'od_drainage_system', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_drainage_system_perimeter_geometry ON qgep.od_drainage_system USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_drainage_system.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_drainage_system
BEFORE UPDATE OR INSERT ON
 qgep.od_drainage_system
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('zone');

-------
-------
CREATE TABLE qgep.od_water_body_protection_sector
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_water_body_protection_sector_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_water_body_protection_sector_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_water_body_protection_sector ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_water_body_protection_sector');
COMMENT ON COLUMN qgep.od_water_body_protection_sector.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_water_body_protection_sector ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_water_body_protection_sector.kind IS 'yyy_Art des Schutzbereiches für  oberflächliches Gewässer und Grundwasser bezüglich Gefährdung / Art des Schutzbereiches für  oberflächliches Gewässer und Grundwasser bezüglich Gefährdung / Type de zones de protection des eaux superficielles et souterraines';
SELECT AddGeometryColumn('qgep', 'od_water_body_protection_sector', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_water_body_protection_sector_perimeter_geometry ON qgep.od_water_body_protection_sector USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_water_body_protection_sector.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_water_body_protection_sector
BEFORE UPDATE OR INSERT ON
 qgep.od_water_body_protection_sector
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('zone');

-------
-------
CREATE TABLE qgep.od_ground_water_protection_perimeter
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_ground_water_protection_perimeter_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_ground_water_protection_perimeter_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_ground_water_protection_perimeter ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_ground_water_protection_perimeter');
COMMENT ON COLUMN qgep.od_ground_water_protection_perimeter.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
SELECT AddGeometryColumn('qgep', 'od_ground_water_protection_perimeter', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_ground_water_protection_perimeter_perimeter_geometry ON qgep.od_ground_water_protection_perimeter USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_ground_water_protection_perimeter.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_ground_water_protection_perimeter
BEFORE UPDATE OR INSERT ON
 qgep.od_ground_water_protection_perimeter
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('zone');

-------
-------
CREATE TABLE qgep.od_planning_zone
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_planning_zone_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_planning_zone_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_planning_zone ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_planning_zone');
COMMENT ON COLUMN qgep.od_planning_zone.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_planning_zone ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_planning_zone.kind IS 'Type of planning zone / Art der Bauzone / Genre de zones à bâtir';
SELECT AddGeometryColumn('qgep', 'od_planning_zone', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_planning_zone_perimeter_geometry ON qgep.od_planning_zone USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_planning_zone.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_planning_zone
BEFORE UPDATE OR INSERT ON
 qgep.od_planning_zone
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('zone');

-------
-------
CREATE TABLE qgep.od_infiltration_zone
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_infiltration_zone_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_infiltration_zone_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_infiltration_zone ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_infiltration_zone');
COMMENT ON COLUMN qgep.od_infiltration_zone.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_infiltration_zone ADD COLUMN infiltration_capacity  integer ;
COMMENT ON COLUMN qgep.od_infiltration_zone.infiltration_capacity IS 'yyy_Versickerungsmöglichkeit im Bereich / Versickerungsmöglichkeit im Bereich / Potentiel d''infiltration de la zone';
SELECT AddGeometryColumn('qgep', 'od_infiltration_zone', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_infiltration_zone_perimeter_geometry ON qgep.od_infiltration_zone USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_infiltration_zone.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_infiltration_zone
BEFORE UPDATE OR INSERT ON
 qgep.od_infiltration_zone
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('zone');

-------
-------
CREATE TABLE qgep.od_bio_ecol_overall_assessment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_bio_ecol_overall_assessment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_bio_ecol_overall_assessment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_bio_ecol_overall_assessment');
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN aq_invertebrates_discharge_point  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.aq_invertebrates_discharge_point IS 'yyy_Beeinträchtigung des Gewässers durch die Einleitung:  aquatic invertebrates / Beeinträchtigung des Gewässers durch die Einleitung:  Wasserwirbellose / atteinte éco-biologique des eaux par l’exutoire: Invertébrés';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN aq_invertebrates_downstream  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.aq_invertebrates_downstream IS 'yyy_Gewässerzustand unterhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): aquatic invertebrates (GSchV Anhang 1). / Gewässerzustand unterhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Wasserwirbellose (GSchV Anhang 1). / Etat des eaux en aval de l’exutoire selon OEaux annexe 1 et 2, Invertébrés (OEaux annexe 1)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN aq_invertebrates_upstream  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.aq_invertebrates_upstream IS 'yyy_Gewässerzustand oberhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): aquatic invertebrates (GSchV Anhang 1). / Gewässerzustand oberhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Wasserwirbellose (GSchV Anhang 1). / Etat des eaux en amont de l’exutoire selon OEaux annexe 1 et 2, Invertébrés (OEaux annexe 1)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN comparison_last_examination  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.comparison_last_examination IS 'yyy_Die Veränderung der Gesamtbeurteilung und eventuelle massgebende veränderte Untersuchungs-resultate gegenüber der letzten Untersuchung müssen dokumentiert werden. / Die Veränderung der Gesamtbeurteilung und eventuelle massgebende veränderte Untersuchungsresultate gegenüber der letzten Untersuchung müssen dokumentiert werden. / Les variations de l’examen générale éco-biologique et des résultats déterminants ayant changés doivent être indiquées par rapport à la dernière inspection.';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN date_last_examen  timestamp without time zone ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.date_last_examen IS 'yyy_Datum der letzten Untersuchung, falls vorhanden. Das Datum der aktuellen Untersuchung wird Attribut "Datum_Untersuchung (VSA-DSS-Mini) bzw. Zeitpunkt (VSA-DSS) erfasst. / Datum der letzten Untersuchung, falls vorhanden. Das Datum der aktuellen Untersuchung wird Attribut "Datum_Untersuchung (VSA-DSS-Mini) bzw. Zeitpunkt (VSA-DSS) erfasst. / Date de l''examen précedent. La date de l’examen actuel est saisie dans l''attribut DATE_EXAMEN (VSA-SDEE-MINI) ou xxx (VSA-DSS)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN immission_oriented_calculation  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.immission_oriented_calculation IS 'yyy_Immissionsorientierte Berechnung vorhanden. / Immissionsorientierte Berechnung vorhanden. / calcul de performance de type immission disponible';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN intervention_demand  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.intervention_demand IS 'yyy_Handlungsbedarf resultierend aus der Beeinträchtigung der Einleitstelle auf das Gewässer, der zu einer Massnahme im Massnahmenplan führt. / Handlungsbedarf resultierend aus der Beeinträchtigung der Einleitstelle auf das Gewässer, der zu einer Massnahme im Massnahmenplan führt. / Un besoin d’intervention résulte de l’atteinte du rejet sur les eaux qui mène à une mesure dans le plan d’action du PGEE.';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN q347  decimal(8,3) ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.q347 IS 'yyy_Menge aus hydrologischen Jahrbüchern. Fehlt diese Angabe in den Jahrbüchern, ist eine Menge zu bestimmen. / Menge aus hydrologischen Jahrbüchern. Fehlt diese Angabe in den Jahrbüchern, ist eine Menge zu bestimmen. / Valeur issue des annuaires hydrologique de Suisse. Si elle manque, il faut désigner une valeur.';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN relevance_matrix  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.relevance_matrix IS 'yyy_Relevanzmatrix gemäss den Vorgaben in der Richtlinie STORM vorhanden. / Relevanzmatrix gemäss den Vorgaben in der Richtlinie STORM vorhanden. / Matrice d’évaluation selon les indications de la directive STORM';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN relevant_slope  smallint ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.relevant_slope IS 'zzz_Relevantes Gefälle [%] bei der Einleitstelle (für STORM Berechnung). Falls unbekannt muss das Gefälle im Feld oder aufgrund von Plangrundlagen bestimmt werden. / Relevantes Gefälle [%] bei der Einleitstelle (für STORM Berechnung). Falls unbekannt muss das Gefälle im Feld oder aufgrund von Plangrundlagen bestimmt werden / Pente déterminante [%] de l’exutoire (pour le calcul STORM). Si inconnue, la pente doit être déterminée sur la base de plans ou par une visite de terrain';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN surface_water_bodies  varchar(41) ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.surface_water_bodies IS 'yyy_Gewässername gemäss kantonalen Vorgaben / Gewässername gemäss kantonalen Vorgaben / Nom du cours d’eau selon indications cantonales';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN total_impairment  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.total_impairment IS 'yyy_Gesamtbeeinträchtigung des Gewässers durch die Einleitung / Gesamtbeeinträchtigung des Gewässers durch die Einleitung / Atteinte globale du cours d’eau due à l’exutoire';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN type_water_body  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.type_water_body IS 'based on table 2.1 of STORM directive (2007) / gemäss Tabelle 2.1 STORM Richtlinie des VSA (2007) / selon table 2.1 directive VSA STORM (2007)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN vegetation_grow_discharge_point  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.vegetation_grow_discharge_point IS 'yyy_Beeinträchtigung des Gewässers durch die Einleitung:  Pflanzlicher Bewuchs / Beeinträchtigung des Gewässers durch die Einleitung:  Pflanzlicher Bewuchs / atteinte éco-biologique des eaux par l’exutoire: Couverture végétale';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN vegetation_grow_downstream  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.vegetation_grow_downstream IS 'yyy_Gewässerzustand unterhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Pflanzlicher Bewuchs (GSchV Anhang 2). / Gewässerzustand unterhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Pflanzlicher Bewuchs (GSchV Anhang 2). / Etat des eaux en aval de l’exutoire selon OEaux annexe 1 et 2, Couverture végétale (OEaux annexe 2)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN vegetation_grow_upstream  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.vegetation_grow_upstream IS 'yyy_Gewässerzustand oberhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Pflanzlicher Bewuchs (GSchV Anhang 2). / Gewässerzustand oberhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Pflanzlicher Bewuchs (GSchV Anhang 2). / Etat des eaux en amont de l’exutoire selon OEaux annexe 1 et 2, Couverture végétale (OEaux annexe 2)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN visual_aspect_discharge_point  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.visual_aspect_discharge_point IS 'yyy_Beeinträchtigung des Gewässers durch die Einleitung: Äusserer Aspekt / Beeinträchtigung des Gewässers durch die Einleitung:  Äusserer Aspekt / Influence du rejet sur le cours d''eau: Aspect visuel';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN visual_aspect_downstream  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.visual_aspect_downstream IS 'yyy_Gewässerzustand unterhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Äusserer Aspekt (GSchV Anhang 2). / Gewässerzustand unterhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Äusserer Aspekt (GSchV Anhang 2). / Etat des eaux en amont de l’exutoire selon OEaux annexe 1 et 2, Aspect visuel (OEaux annexe 2)';
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD COLUMN visual_aspect_upstream  integer ;
COMMENT ON COLUMN qgep.od_bio_ecol_overall_assessment.visual_aspect_upstream IS 'yyy_Gewässerzustand oberhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Äusserer Aspekt (GSchV Anhang 2). / Gewässerzustand oberhalb der Einleitstelle gemäss GSchV Anhang 1 und 2 (Vorbelastung): Äusserer Aspekt (GSchV Anhang 2). / Etat des eaux en amont de l’exutoire selon OEaux annexe 1 et 2, Aspect visuel (OEaux annexe 2)';
-------
CREATE TRIGGER
update_last_modified_bio_ecol_overall_assessment
BEFORE UPDATE OR INSERT ON
 qgep.od_bio_ecol_overall_assessment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('maintenance_event');

-------
-------
CREATE TABLE qgep.od_examination
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_examination_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_examination_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_examination ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_examination');
COMMENT ON COLUMN qgep.od_examination.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_examination ADD COLUMN equipment  varchar(50) ;
COMMENT ON COLUMN qgep.od_examination.equipment IS 'Name of used camera / Eingesetztes Aufnahmegeräte (Kamera) / Appareil de prise de vues (caméra) employé';
 ALTER TABLE qgep.od_examination ADD COLUMN from_point_identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_examination.from_point_identifier IS 'yyy_Bezeichnung des "von Punktes" einer Untersuchung, so wie sie auf dem Plan erscheint. Alternative zum Foreign key Haltungspunkt, wenn Topologie noch nicht definiert ist (Ersterfassung). Die vonPunktBezeichnung wird später vom Hydrauliker für den Aufbau / Bezeichnung des "von Punktes" einer Untersuchung, so wie sie auf dem Plan erscheint. Alternative zum Fremdschlüssel Haltungspunkt, wenn Topologie noch nicht definiert ist (Ersterfassung). Die vonPunktBezeichnung wird später vom Hydrauliker für den Aufbau  / point (chambre ou nœud) auquel l’inspection termine. Désignation du « point départ » d’une inspection comme elle figure sur le plan. Elle sert d’alternative à la clé externe POINT_TRONCON, lorsque la topologie n’est pas encore définie (saisie initiale). L';
 ALTER TABLE qgep.od_examination ADD COLUMN inspected_lenght  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_examination.inspected_lenght IS 'yyy_Total untersuchte Länge in Metern mit zwei Nachkommastellen / Total untersuchte Länge in Metern mit zwei Nachkommastellen / Longueur totale examinée en mètres avec deux chiffres après la virgule';
 ALTER TABLE qgep.od_examination ADD COLUMN operator  varchar(50) ;
COMMENT ON COLUMN qgep.od_examination.operator IS 'name of / Name des Operateurs / Nom de l’opérateur';
 ALTER TABLE qgep.od_examination ADD COLUMN recording_type  integer ;
COMMENT ON COLUMN qgep.od_examination.recording_type IS 'yyy_Aufnahmetechnik, beschreibt die Art der Aufnahme / Aufnahmetechnik, beschreibt die Art der Aufnahme / Technique de prise de vues, décrit le type de prise de vues';
 ALTER TABLE qgep.od_examination ADD COLUMN to_point_identifier  varchar(41) ;
COMMENT ON COLUMN qgep.od_examination.to_point_identifier IS 'yyy_Bezeichnung des "bis Punktes" einer Untersuchung, so wie sie auf dem Plan erscheint. Alternative zum Foreign key Abwasserbauwerk, wenn Topologie noch nicht definiert ist (Ersterfassung). Die vonPunktBezeichnung wird später vom Hydrauliker für den Aufb / Bezeichnung des "bis Punktes" einer Untersuchung, so wie sie auf dem Plan erscheint. Alternative zum Fremdschlüssel Abwasserbauwerk, wenn Topologie noch nicht definiert ist (Ersterfassung). Die vonPunktBezeichnung wird später vom Hydrauliker für den Aufba / point (chambre ou noeud) d’où l’inspection commence. Désignation du « point d’arrivée » d’une inspection comme elle figure sur le plan. Elle sert d’alternative à la clé externe OUVRAGE_RESEAU_AS lorsque la topologie n’est pas encore définie (saisie initia';
 ALTER TABLE qgep.od_examination ADD COLUMN vehicle  varchar(50) ;
COMMENT ON COLUMN qgep.od_examination.vehicle IS 'yyy_Eingesetztes Inspektionsfahrzeug / Eingesetztes Inspektionsfahrzeug / Véhicule d’inspection employé';
 ALTER TABLE qgep.od_examination ADD COLUMN videonumber  varchar(41) ;
COMMENT ON COLUMN qgep.od_examination.videonumber IS 'yyy_Bei Videobändern steht hier die Bandnummer (z.B. 1/99). Bei elektronischen Datenträgern ist dies die Datenträgerbezeichnung (z.B. SG001). Falls pro Untersuchung eine einzelne Datei zur Verfügung steht, dann wird diese aus der Klasse Datei referenziert / Bei Videobändern steht hier die Bandnummer (z.B. 1/99). Bei elektronischen Datenträgern ist dies die Datenträgerbezeichnung (z.B. SG001). Falls pro Untersuchung eine einzelne Datei zur Verfügung steht, dann wird diese aus der Klasse Datei referenziert und / Pour les bandes vidéo figure ici le numéro de la bande (p. ex. 1/99) et, pour les supports de don-nées électroniques, sa désignation (p. ex. SG001). S’il n’existe qu’un fichier par examen, ce fichier est référencé par la classe Fichier et cet attribut peu';
 ALTER TABLE qgep.od_examination ADD COLUMN weather  integer ;
COMMENT ON COLUMN qgep.od_examination.weather IS 'Wheather conditions during inspection / Wetterverhältnisse während der Inspektion / Conditions météorologiques pendant l’inspection';
-------
CREATE TRIGGER
update_last_modified_examination
BEFORE UPDATE OR INSERT ON
 qgep.od_examination
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('maintenance_event');

-------
-------
CREATE TABLE qgep.od_dryweather_downspout
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_dryweather_downspout_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_dryweather_downspout_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_dryweather_downspout ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_dryweather_downspout');
COMMENT ON COLUMN qgep.od_dryweather_downspout.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_dryweather_downspout ADD COLUMN diameter  smallint ;
COMMENT ON COLUMN qgep.od_dryweather_downspout.diameter IS 'yyy_Abmessung des Deckels (bei eckigen Deckeln minimale Abmessung) / Abmessung des Deckels (bei eckigen Deckeln minimale Abmessung) / Dimension du couvercle (dimension minimale pour couvercle anguleux)';
-------
CREATE TRIGGER
update_last_modified_dryweather_downspout
BEFORE UPDATE OR INSERT ON
 qgep.od_dryweather_downspout
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_cover
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_cover_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_cover_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_cover ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_cover');
COMMENT ON COLUMN qgep.od_cover.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_cover ADD COLUMN brand  varchar(50) ;
COMMENT ON COLUMN qgep.od_cover.brand IS 'Name of manufacturer / Name der Herstellerfirma / Nom de l''entreprise de fabrication';
 ALTER TABLE qgep.od_cover ADD COLUMN cover_shape  integer ;
COMMENT ON COLUMN qgep.od_cover.cover_shape IS 'shape of cover / Form des Deckels / Forme du couvercle';
 ALTER TABLE qgep.od_cover ADD COLUMN depth  smallint ;
COMMENT ON COLUMN qgep.od_cover.depth IS 'yyy_redundantes Funktionsattribut Maechtigkeit. Numerisch [mm]. Funktion (berechneter Wert) = zugehöriger Deckel.Kote minus Abwasserknoten.Sohlenkote.(falls die Sohlenkote nicht separat erfasst, dann ist es die tiefer liegende Hal-tungspunkt.Kote) / redundantes Funktionsattribut Maechtigkeit. Numerisch [mm]. Funktion (berechneter Wert) = zugehöriger Deckel.Kote minus Abwasserknoten.Sohlenkote.(falls die Sohlenkote nicht separat erfasst, dann ist es die tiefer liegende Haltungspunkt.Kote) / Attribut de fonction EPAISSEUR redondant, numérique [mm]. Fonction (valeur calculée) = COUVERCLE.COTE correspondant moins NŒUD_RESEAU.COTE_RADIER (si la cote radier ne peut pas être saisie séparément, prendre la POINT_TRONCON.COTE la plus basse.';
 ALTER TABLE qgep.od_cover ADD COLUMN diameter  smallint ;
COMMENT ON COLUMN qgep.od_cover.diameter IS 'yyy_Abmessung des Deckels (bei eckigen Deckeln minimale Abmessung) / Abmessung des Deckels (bei eckigen Deckeln minimale Abmessung) / Dimension du couvercle (dimension minimale pour couvercle anguleux)';
 ALTER TABLE qgep.od_cover ADD COLUMN fastening  integer ;
COMMENT ON COLUMN qgep.od_cover.fastening IS 'yyy_Befestigungsart des Deckels / Befestigungsart des Deckels / Genre de fixation du couvercle';
 ALTER TABLE qgep.od_cover ADD COLUMN level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_cover.level IS 'Height of cover / Deckelhöhe / Cote du couvercle';
 ALTER TABLE qgep.od_cover ADD COLUMN material  integer ;
COMMENT ON COLUMN qgep.od_cover.material IS 'Material of cover / Deckelmaterial / Matériau du couvercle';
 ALTER TABLE qgep.od_cover ADD COLUMN positional_accuracy  integer ;
COMMENT ON COLUMN qgep.od_cover.positional_accuracy IS 'Quantfication of accuarcy of position of cover (center hole) / Quantifizierung der Genauigkeit der Lage des Deckels (Pickelloch) / Plage de précision des coordonnées planimétriques du couvercle.';
SELECT AddGeometryColumn('qgep', 'od_cover', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_cover_situation_geometry ON qgep.od_cover USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_cover.situation_geometry IS 'Situation of cover (cover hole), National position coordinates (East, North) / Lage des Deckels (Pickelloch) / Positionnement du couvercle (milieu du couvercle)';
 ALTER TABLE qgep.od_cover ADD COLUMN sludge_bucket  integer ;
COMMENT ON COLUMN qgep.od_cover.sludge_bucket IS 'yyy_Angabe, ob der Deckel mit einem Schlammeimer versehen ist oder nicht / Angabe, ob der Deckel mit einem Schlammeimer versehen ist oder nicht / Indication si le couvercle est pourvu ou non d''un ramasse-boues';
 ALTER TABLE qgep.od_cover ADD COLUMN venting  integer ;
COMMENT ON COLUMN qgep.od_cover.venting IS 'venting with wholes for aeration / Deckel mit Lüftungslöchern versehen / Couvercle pourvu de trous d''aération';
-------
CREATE TRIGGER
update_last_modified_cover
BEFORE UPDATE OR INSERT ON
 qgep.od_cover
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_access_aid
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_access_aid_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_access_aid_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_access_aid ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_access_aid');
COMMENT ON COLUMN qgep.od_access_aid.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_access_aid ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_access_aid.kind IS 'yyy_Art des Einstiegs in das Bauwerk / Art des Einstiegs in das Bauwerk / Genre d''accès à l''ouvrage';
-------
CREATE TRIGGER
update_last_modified_access_aid
BEFORE UPDATE OR INSERT ON
 qgep.od_access_aid
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_electric_equipment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_electric_equipment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_electric_equipment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_electric_equipment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_electric_equipment');
COMMENT ON COLUMN qgep.od_electric_equipment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_electric_equipment ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_electric_equipment.gross_costs IS 'Gross costs of electromechanical equipment / Brutto Erstellungskosten der elektromechanischen Ausrüstung / Coûts bruts des équipements électromécaniques';
 ALTER TABLE qgep.od_electric_equipment ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_electric_equipment.kind IS 'yyy_Elektrische Installationen und Geräte / Elektrische Installationen und Geräte / Installations et appareils électriques';
 ALTER TABLE qgep.od_electric_equipment ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_electric_equipment.year_of_replacement IS 'yyy_Jahr, in dem die Lebensdauer der elektrischen Einrichtung voraussichtlich ausläuft / Jahr, in dem die Lebensdauer der elektrischen Einrichtung voraussichtlich ausläuft / Année pour laquelle on prévoit que la durée de vie de l''équipement soit écoulée';
-------
CREATE TRIGGER
update_last_modified_electric_equipment
BEFORE UPDATE OR INSERT ON
 qgep.od_electric_equipment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_backflow_prevention
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_backflow_prevention_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_backflow_prevention_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_backflow_prevention ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_backflow_prevention');
COMMENT ON COLUMN qgep.od_backflow_prevention.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_backflow_prevention ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_backflow_prevention.gross_costs IS 'Gross costs / Brutto Erstellungskosten / Coûts bruts de réalisation';
 ALTER TABLE qgep.od_backflow_prevention ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_backflow_prevention.kind IS 'Ist keine Rückstausicherung vorhanden, wird keine Rueckstausicherung erfasst. /  Ist keine Rückstausicherung vorhanden, wird keine Rueckstausicherung erfasst / En absence de protection, laisser la composante vide';
 ALTER TABLE qgep.od_backflow_prevention ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_backflow_prevention.year_of_replacement IS 'yyy_Jahr in dem die Lebensdauer der Rückstausicherung voraussichtlich abläuft / Jahr in dem die Lebensdauer der Rückstausicherung voraussichtlich abläuft / Année pour laquelle on prévoit que la durée de vie de l''équipement soit écoulée';
-------
CREATE TRIGGER
update_last_modified_backflow_prevention
BEFORE UPDATE OR INSERT ON
 qgep.od_backflow_prevention
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_tank_cleaning
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_tank_cleaning_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_tank_cleaning_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_tank_cleaning ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_tank_cleaning');
COMMENT ON COLUMN qgep.od_tank_cleaning.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_tank_cleaning ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_tank_cleaning.gross_costs IS 'Gross costs of electromechanical equipment of tank cleaning / Brutto Erstellungskosten der elektromechnischen Ausrüstung für die Beckenreinigung / Coûts bruts des équipements électromécaniques nettoyage de bassins';
 ALTER TABLE qgep.od_tank_cleaning ADD COLUMN type  integer ;
COMMENT ON COLUMN qgep.od_tank_cleaning.type IS '';
 ALTER TABLE qgep.od_tank_cleaning ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_tank_cleaning.year_of_replacement IS 'yyy_Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Année pour laquelle on prévoit que la durée de vie de l''équipement soit écoulée';
-------
CREATE TRIGGER
update_last_modified_tank_cleaning
BEFORE UPDATE OR INSERT ON
 qgep.od_tank_cleaning
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_benching
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_benching_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_benching_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_benching ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_benching');
COMMENT ON COLUMN qgep.od_benching.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_benching ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_benching.kind IS '';
-------
CREATE TRIGGER
update_last_modified_benching
BEFORE UPDATE OR INSERT ON
 qgep.od_benching
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_solids_retention
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_solids_retention_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_solids_retention_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_solids_retention ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_solids_retention');
COMMENT ON COLUMN qgep.od_solids_retention.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_solids_retention ADD COLUMN dimensioning_value  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_solids_retention.dimensioning_value IS 'yyy_Wassermenge, Dimensionierungswert des Feststoffrückhaltes / Wassermenge, Dimensionierungswert des Feststoffrückhaltes / Volume, débit de dimensionnement';
 ALTER TABLE qgep.od_solids_retention ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_solids_retention.gross_costs IS 'Gross costs of electromechanical equipment / Brutto Erstellungskosten der elektromechnischen Ausrüstung für die Beckenentleerung / Coûts bruts des équipements électromécaniques';
 ALTER TABLE qgep.od_solids_retention ADD COLUMN overflow_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_solids_retention.overflow_level IS 'Overflow level of solids retention in in m.a.sl. / Anspringkote Feststoffrückhalt in m.ü.M. / Cote du début du déversement de la retenue de matières solides en m.s.m.';
 ALTER TABLE qgep.od_solids_retention ADD COLUMN type  integer ;
COMMENT ON COLUMN qgep.od_solids_retention.type IS 'yyy_(Elektromechanische) Teile zum Feststoffrückhalt eines Bauwerks / (Elektromechanische) Teile zum Feststoffrückhalt eines Bauwerks / Eléments (électromécaniques) pour la retenue de matières solides d’un ouvrage';
 ALTER TABLE qgep.od_solids_retention ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_solids_retention.year_of_replacement IS 'yyy_Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Année pour laquelle on prévoit que la durée de vie de l''équipement soit écoulée';
-------
CREATE TRIGGER
update_last_modified_solids_retention
BEFORE UPDATE OR INSERT ON
 qgep.od_solids_retention
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_dryweather_flume
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_dryweather_flume_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_dryweather_flume_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_dryweather_flume ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_dryweather_flume');
COMMENT ON COLUMN qgep.od_dryweather_flume.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_dryweather_flume ADD COLUMN material  integer ;
COMMENT ON COLUMN qgep.od_dryweather_flume.material IS 'yyy_Material der Ausbildung oder Auskleidung der Trockenwetterrinne / Material der Ausbildung oder Auskleidung der Trockenwetterrinne / Matériau de fabrication ou de revêtement de la cunette de débit temps sec';
-------
CREATE TRIGGER
update_last_modified_dryweather_flume
BEFORE UPDATE OR INSERT ON
 qgep.od_dryweather_flume
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_electromechanical_equipment
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_electromechanical_equipment_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_electromechanical_equipment_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_electromechanical_equipment ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_electromechanical_equipment');
COMMENT ON COLUMN qgep.od_electromechanical_equipment.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_electromechanical_equipment ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_electromechanical_equipment.gross_costs IS 'Gross costs of electromechanical equipment / Brutto Erstellungskosten der elektromechanischen Ausrüstung / Coûts bruts des équipements électromécaniques';
 ALTER TABLE qgep.od_electromechanical_equipment ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_electromechanical_equipment.kind IS 'yyy_Elektromechanische Teile eines Bauwerks / Elektromechanische Teile eines Bauwerks / Eléments électromécaniques d''un ouvrage';
 ALTER TABLE qgep.od_electromechanical_equipment ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_electromechanical_equipment.year_of_replacement IS 'yyy_Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Année pour laquelle on prévoit que la durée de vie de l''équipement soit écoulée';
-------
CREATE TRIGGER
update_last_modified_electromechanical_equipment
BEFORE UPDATE OR INSERT ON
 qgep.od_electromechanical_equipment
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_tank_emptying
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_tank_emptying_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_tank_emptying_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_tank_emptying ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_tank_emptying');
COMMENT ON COLUMN qgep.od_tank_emptying.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_tank_emptying ADD COLUMN flow  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_tank_emptying.flow IS 'yyy_Bei mehreren Pumpen / Schiebern muss die maximale Gesamtmenge erfasst werden. / Bei mehreren Pumpen / Schiebern muss die maximale Gesamtmenge erfasst werden. / Lors de présence de plusieurs pompes/vannes, indiquer le débit total.';
 ALTER TABLE qgep.od_tank_emptying ADD COLUMN gross_costs  decimal(10,2) ;
COMMENT ON COLUMN qgep.od_tank_emptying.gross_costs IS 'Gross costs of electromechanical equipment of tank emptying / Brutto Erstellungskosten der elektromechnischen Ausrüstung für die Beckenentleerung / Coûts bruts des équipements électromécaniques vidange de bassins';
 ALTER TABLE qgep.od_tank_emptying ADD COLUMN type  integer ;
COMMENT ON COLUMN qgep.od_tank_emptying.type IS '';
 ALTER TABLE qgep.od_tank_emptying ADD COLUMN year_of_replacement  smallint ;
COMMENT ON COLUMN qgep.od_tank_emptying.year_of_replacement IS 'yyy_Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Jahr in dem die Lebensdauer der elektromechanischen Ausrüstung voraussichtlich abläuft / Année pour laquelle on prévoit que la durée de vie de l''équipement soit écoulée';
-------
CREATE TRIGGER
update_last_modified_tank_emptying
BEFORE UPDATE OR INSERT ON
 qgep.od_tank_emptying
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('structure_part');

-------
-------
CREATE TABLE qgep.od_toilet
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_toilet_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_toilet_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_toilet ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_toilet');
COMMENT ON COLUMN qgep.od_toilet.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_toilet ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_toilet.kind IS '';
-------
CREATE TRIGGER
update_last_modified_toilet
BEFORE UPDATE OR INSERT ON
 qgep.od_toilet
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_small_treatment_plant
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_small_treatment_plant_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_small_treatment_plant_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_small_treatment_plant ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_small_treatment_plant');
COMMENT ON COLUMN qgep.od_small_treatment_plant.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_small_treatment_plant ADD COLUMN approval_number  varchar(50) ;
COMMENT ON COLUMN qgep.od_small_treatment_plant.approval_number IS 'yyy_Bewilligungsnummer der Aufsichtsbehörde / Bewilligungsnummer der Aufsichtsbehörde / Numéro d''autorisation de l''autorité de surveillance';
 ALTER TABLE qgep.od_small_treatment_plant ADD COLUMN function  integer ;
COMMENT ON COLUMN qgep.od_small_treatment_plant.function IS 'yyy_Art des Verfahrens / Art des Verfahrens / Genre de procédé';
 ALTER TABLE qgep.od_small_treatment_plant ADD COLUMN installation_number  integer ;
COMMENT ON COLUMN qgep.od_small_treatment_plant.installation_number IS 'yyy_ARA-Nummer gemäss BUWAL / ARA-Nummer gemäss BAFU / Numéro de la STEP selon l''OFEV';
 ALTER TABLE qgep.od_small_treatment_plant ADD COLUMN remote_monitoring  integer ;
COMMENT ON COLUMN qgep.od_small_treatment_plant.remote_monitoring IS '';
-------
CREATE TRIGGER
update_last_modified_small_treatment_plant
BEFORE UPDATE OR INSERT ON
 qgep.od_small_treatment_plant
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_wwtp_structure
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wwtp_structure_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wwtp_structure_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wwtp_structure ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wwtp_structure');
COMMENT ON COLUMN qgep.od_wwtp_structure.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wwtp_structure ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_wwtp_structure.kind IS 'yyy_Art des Beckens oder Verfahrens im ARA Bauwerk / Art des Beckens oder Verfahrens im ARA Bauwerk / Genre de l''l’ouvrage ou genre de traitement dans l''ouvrage STEP';
-------
CREATE TRIGGER
update_last_modified_wwtp_structure
BEFORE UPDATE OR INSERT ON
 qgep.od_wwtp_structure
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_infiltration_installation
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_infiltration_installation_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_infiltration_installation_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_infiltration_installation ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_infiltration_installation');
COMMENT ON COLUMN qgep.od_infiltration_installation.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN absorption_capacity  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_infiltration_installation.absorption_capacity IS 'yyy_Schluckvermögen des Bodens. / Schluckvermögen des Bodens. / Capacité d''absorption du sol';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN defects  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.defects IS 'yyy_Gibt die aktuellen Mängel der Versickerungsanlage an (IST-Zustand). / Gibt die aktuellen Mängel der Versickerungsanlage an (IST-Zustand). / Indique les défauts actuels de l''installation d''infiltration (etat_actuel).';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN depth  smallint ;
COMMENT ON COLUMN qgep.od_infiltration_installation.depth IS 'yyy_Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Fonction (valeur calculée) = NOEUD_RESEAU.COTE_RADIER représentatif moins COTE_PLAFOND de l’ouvrage correspondant si la géométrie détaillée est disponible, sinon fonction (valeur calculée) = NŒUD_RESEAU.COT_RADIER moins COUVERCLE.COTE de l’ouvrage corresp';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN dimension1  smallint ;
COMMENT ON COLUMN qgep.od_infiltration_installation.dimension1 IS 'Dimension1 of infiltration installations (largest inside dimension) if used with norm elements. Else leave empty.. / Dimension1 der Versickerungsanlage (grösstes Innenmass) bei der Verwendung von Normbauteilen. Sonst leer lassen und mit Detailgeometrie beschreiben. / Dimension1 de l’installation d’infiltration (plus grande mesure intérieure) lorsqu’elle est utilisée pour des éléments d’ouvrage normés. Sinon, à laisser libre et prendre la description de la géométrie détaillée.';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN dimension2  smallint ;
COMMENT ON COLUMN qgep.od_infiltration_installation.dimension2 IS 'Dimension2 of infiltration installations (smallest inside dimension). With circle shaped installations leave dimension2 empty, with ovoid shaped ones fill it in. With rectangular shaped manholes use detailled_geometry to describe further. / Dimension2 der Versickerungsanlage (kleinstes Innenmass) bei der Verwendung von Normbauteilen. Sonst leer lassen und mit Detailgeometrie beschreiben. / Dimension2 de la chambre (plus petite mesure intérieure). La dimension2 est à saisir pour des chambres ovales et à laisser libre pour des chambres circulaires. Pour les chambres rectangulaires il faut utiliser la géométrie détaillée.';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN distance_to_aquifer  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_infiltration_installation.distance_to_aquifer IS 'yyy_Flurabstand (Vertikale Distanz Terrainoberfläche zum Grundwasserleiter). / Flurabstand (Vertikale Distanz Terrainoberfläche zum Grundwasserleiter). / Distance à l''aquifère (distance verticale de la surface du terrain à l''aquifère)';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN effective_area  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_infiltration_installation.effective_area IS 'yyy_Für den Abfluss wirksame Fläche / Für den Abfluss wirksame Fläche / Surface qui participe à l''écoulement';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN emergency_spillway  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.emergency_spillway IS 'yyy_Endpunkt allfälliger Verrohrung des Notüberlaufes der Versickerungsanlage / Endpunkt allfälliger Verrohrung des Notüberlaufes der Versickerungsanlage / Point cumulant des conduites du trop plein d''une installation d''infiltration';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN filling_material  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.filling_material IS 'yyy_Beschreibung des oberliegenden Materials bei Sickerschlitzen. Für Modellierung Sickerschlitze siehe Hinweise Titelblatt. / Beschreibung des oberliegenden Materials bei Sickerschlitzen. Für Modellierung Sickerschlitze siehe Hinweise Titelblatt. / Description du matériau de remplissage sur les fentes d''infiltration. Les fentes d''infiltration de sont pas modélisées par des tronçons, mais par des installations d''infiltration (voyez commentaires en couverture)';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.kind IS 'yyy_Arten von Versickerungsmethoden. / Arten von Versickerungsmethoden. / Genre de méthode d''infiltration.';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN labeling  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.labeling IS 'yyy_Kennzeichnung der Schachtdeckel der Anlage als Versickerungsanlage.  Nur bei Anlagen mit Schächten. / Kennzeichnung der Schachtdeckel der Anlage als Versickerungsanlage.  Nur bei Anlagen mit Schächten. / Désignation inscrite du couvercle de l''installation d''infiltration. Uniquement pour des installations avec couvercle';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN seepage_utilization  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.seepage_utilization IS 'yyy_Arten des zu versickernden Wassers. / Arten des zu versickernden Wassers. / Genre d''eau à infiltrer';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN upper_elevation  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_infiltration_installation.upper_elevation IS 'Highest point of structure (ceiling), outside / Höchster Punkt des Bauwerks (Decke), aussen / Point le plus élevé de la construction';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN vehicle_access  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.vehicle_access IS 'yyy_Zugänglichkeit für Saugwagen. Sie bezieht sich auf die gesamte Versickerungsanlage / Vorbehandlungsanlagen und kann in den Bemerkungen weiter spezifiziert werden / Zugänglichkeit für Saugwagen. Sie bezieht sich auf die gesamte Versickerungsanlage / Vorbehandlungsanlagen und kann in den Bemerkungen weiter spezifiziert werden / Accessibilité pour des camions de vidange. Se réfère à toute l''installation d''infiltration / de prétraitement et peut être spécifiée sous REMARQUE';
 ALTER TABLE qgep.od_infiltration_installation ADD COLUMN watertightness  integer ;
COMMENT ON COLUMN qgep.od_infiltration_installation.watertightness IS 'yyy_Wasserdichtheit gegen Oberflächenwasser.  Nur bei Anlagen mit Schächten. / Wasserdichtheit gegen Oberflächenwasser.  Nur bei Anlagen mit Schächten. / Etanchéité contre des eaux superficielles. Uniquement pour des installations avec chambres';
-------
CREATE TRIGGER
update_last_modified_infiltration_installation
BEFORE UPDATE OR INSERT ON
 qgep.od_infiltration_installation
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_channel
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_channel_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_channel_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_channel ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_channel');
COMMENT ON COLUMN qgep.od_channel.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_channel ADD COLUMN bedding_encasement  integer ;
COMMENT ON COLUMN qgep.od_channel.bedding_encasement IS 'yyy_Art und Weise der unmittelbaren Rohrumgebung im Boden: Bettungsschicht (Unterlage der Leitung),  Verdämmung (seitliche Auffüllung), Schutzschicht / Art und Weise der unmittelbaren Rohrumgebung im Boden: Bettungsschicht (Unterlage der Leitung),  Verdämmung (seitliche Auffüllung), Schutzschicht / Lit de pose (assise de la conduite), bourrage latéral (remblai latéral), couche de protection';
 ALTER TABLE qgep.od_channel ADD COLUMN connection_type  integer ;
COMMENT ON COLUMN qgep.od_channel.connection_type IS 'Types of connection / Verbindungstypen / Types de raccordement';
 ALTER TABLE qgep.od_channel ADD COLUMN function_amelioration  integer ;
COMMENT ON COLUMN qgep.od_channel.function_amelioration IS 'yyy_Zur Unterscheidung der Funktion einer Leitung bei Meliorationen (Entwässerungen) / Zur Unterscheidung der Funktion einer Leitung bei Meliorationen (Entwässerungen) / Afin de distinguer la fonction d’une conduite d’améliorations foncières (drainage)';
 ALTER TABLE qgep.od_channel ADD COLUMN function_hierarchic  integer ;
COMMENT ON COLUMN qgep.od_channel.function_hierarchic IS 'yyy_Art des Kanals hinsichtlich Bedeutung im Entwässerungssystem / Art des Kanals hinsichtlich Bedeutung im Entwässerungssystem / Genre de canalisation par rapport à sa fonction dans le système d''évacuation';
-- see end of table CREATE INDEX in_od_channel_function_hierarchic_usage_current ON qgep.od_channel USING btree (function_hierarchic, usage_current);
 ALTER TABLE qgep.od_channel ADD COLUMN function_hydraulic  integer ;
COMMENT ON COLUMN qgep.od_channel.function_hydraulic IS 'yyy_Art des Kanals hinsichtlich hydraulischer Ausführung / Art des Kanals hinsichtlich hydraulischer Ausführung / Genre de canalisation par rapport à sa fonction hydraulique';
 ALTER TABLE qgep.od_channel ADD COLUMN jetting_interval  decimal(4,2) ;
COMMENT ON COLUMN qgep.od_channel.jetting_interval IS 'yyy_Abstände in welchen der Kanal gespült werden sollte / Abstände in welchen der Kanal gespült werden sollte / Fréquence à laquelle une canalisation devrait subir un curage (années)';
 ALTER TABLE qgep.od_channel ADD COLUMN pipe_length  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_channel.pipe_length IS 'yyy_Baulänge der Einzelrohre oder Fugenabstände bei Ortsbetonkanälen / Baulänge der Einzelrohre oder Fugenabstände bei Ortsbetonkanälen / Longueur de chaque tuyau ou distance des joints pour les canalisations en béton coulé sur place';
 ALTER TABLE qgep.od_channel ADD COLUMN seepage  integer ;
COMMENT ON COLUMN qgep.od_channel.seepage IS 'yyy Beschreibung des oberliegenden Materials bei Saugern / Beschreibung des oberliegenden Materials bei Saugern / Description du matériau de remplissage';
 ALTER TABLE qgep.od_channel ADD COLUMN usage_current  integer ;
COMMENT ON COLUMN qgep.od_channel.usage_current IS 'yyy_Für Primäre Abwasseranlagen gilt: heute zulässige Nutzung. Für Sekundäre Abwasseranlagen gilt: heute tatsächliche Nutzung / Für primäre Abwasseranlagen gilt: Heute zulässige Nutzung. Für sekundäre Abwasseranlagen gilt: Heute tatsächliche Nutzung / Pour les ouvrages du réseau primaire: utilisation actuelle autorisée pour les ouvrages du réseau secondaire: utilisation actuelle réelle';
 ALTER TABLE qgep.od_channel ADD COLUMN usage_planned  integer ;
COMMENT ON COLUMN qgep.od_channel.usage_planned IS 'yyy_Durch das Konzept vorgesehene Nutzung (vergleiche auch Nutzungsart_Ist) / Durch das Konzept vorgesehene Nutzung (vergleiche auch Nutzungsart_Ist) / Utilisation prévue par le concept d''assainissement (voir aussi GENRE_UTILISATION_ACTUELLE)';
 CREATE INDEX in_od_channel_function_hierarchic_usage_current ON qgep.od_channel USING btree (function_hierarchic, usage_current);
-------
CREATE TRIGGER
update_last_modified_channel
BEFORE UPDATE OR INSERT ON
 qgep.od_channel
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_special_structure
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_special_structure_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_special_structure_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_special_structure ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_special_structure');
COMMENT ON COLUMN qgep.od_special_structure.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_special_structure ADD COLUMN bypass  integer ;
COMMENT ON COLUMN qgep.od_special_structure.bypass IS 'yyy_Bypass zur Umleitung des Wassers (z.B. während Unterhalt oder  im Havariefall) / Bypass zur Umleitung des Wassers (z.B. während Unterhalt oder  im Havariefall) / Bypass pour détourner les eaux (par exemple durant des opérations de maintenance ou en cas d’avaries)';
 ALTER TABLE qgep.od_special_structure ADD COLUMN depth  smallint ;
COMMENT ON COLUMN qgep.od_special_structure.depth IS 'yyy_Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Fonction (valeur calculée) = NOEUD_RESEAU.COTE_RADIER représentatif moins COTE_PLAFOND de l’ouvrage correspondant si la géométrie détaillée est disponible, sinon fonction (valeur calculée) = NŒUD_RESEAU.COT_RADIER moins COUVERCLE.COTE de l’ouvrage corresp';
 ALTER TABLE qgep.od_special_structure ADD COLUMN emergency_spillway  integer ;
COMMENT ON COLUMN qgep.od_special_structure.emergency_spillway IS 'zzz_Das Attribut beschreibt, wohin die das Volumen übersteigende Menge abgeleitet wird (bei Regenrückhaltebecken / Regenrückhaltekanal). / Das Attribut beschreibt, wohin die das Volumen übersteigende Menge abgeleitet wird (bei Regenrückhaltebecken / Regenrückhaltekanal). / L’attribut décrit vers où le débit déversé s’écoule. (bassin d’accumulation / canal d’accumulation)';
 ALTER TABLE qgep.od_special_structure ADD COLUMN function  integer ;
COMMENT ON COLUMN qgep.od_special_structure.function IS 'Kind of function / Art der Nutzung / Genre d''utilisation';
 CREATE INDEX in_od_special_structure_function ON qgep.od_special_structure USING btree (function);
 ALTER TABLE qgep.od_special_structure ADD COLUMN stormwater_tank_arrangement  integer ;
COMMENT ON COLUMN qgep.od_special_structure.stormwater_tank_arrangement IS 'yyy_Anordnung des Regenbeckens im System. Zusätzlich zu erfassen falls Spezialbauwerk.Funktion = Regenbecken_* / Anordnung des Regenbeckens im System. Zusätzlich zu erfassen falls Spezialbauwerk.Funktion = Regenbecken_* / Disposition d''un bassin d''eaux pluviales dans le réseau d''assainissement. Attribut additionnel pour les valeurs BEP_* de OUVRAGE_SPECIAL.FONCTION.';
 ALTER TABLE qgep.od_special_structure ADD COLUMN upper_elevation  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_special_structure.upper_elevation IS 'Highest point of structure (ceiling), outside / Höchster Punkt des Bauwerks (Decke), aussen / Point le plus élevé de la construction';
-------
CREATE TRIGGER
update_last_modified_special_structure
BEFORE UPDATE OR INSERT ON
 qgep.od_special_structure
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_discharge_point
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_discharge_point_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_discharge_point_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_discharge_point ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_discharge_point');
COMMENT ON COLUMN qgep.od_discharge_point.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_discharge_point ADD COLUMN depth  smallint ;
COMMENT ON COLUMN qgep.od_discharge_point.depth IS 'yyy_Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Funktion (berechneter Wert) = repräsentative Abwasserknoten.Sohlenkote minus zugehörige Deckenkote des Bauwerks falls Detailgeometrie vorhanden, sonst Funktion (berechneter Wert) = Abwasserknoten.Sohlenkote minus zugehörige Deckel.Kote des Bauwerks / Fonction (valeur calculée) = NOEUD_RESEAU.COTE_RADIER représentatif moins COTE_PLAFOND de l’ouvrage correspondant si la géométrie détaillée est disponible, sinon fonction (valeur calculée) = NŒUD_RESEAU.COT_RADIER moins COUVERCLE.COTE de l’ouvrage corresp';
 ALTER TABLE qgep.od_discharge_point ADD COLUMN highwater_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_discharge_point.highwater_level IS 'yyy_Massgebliche Hochwasserkote der Einleitstelle. Diese ist in der Regel grösser als der Wasserspiegel_Hydraulik. / Massgebliche Hochwasserkote der Einleitstelle. Diese ist in der Regel grösser als der Wasserspiegel_Hydraulik. / Cote de crue déterminante au point de rejet. Diese ist in der Regel grösser als der Wasserspiegel_Hydraulik.';
 ALTER TABLE qgep.od_discharge_point ADD COLUMN relevance  integer ;
COMMENT ON COLUMN qgep.od_discharge_point.relevance IS 'Relevance of discharge point for water course / Gewässerrelevanz der Einleitstelle / Il est conseillé d’utiliser des noms réels, tels qSignifiance pour milieu récepteur';
 ALTER TABLE qgep.od_discharge_point ADD COLUMN terrain_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_discharge_point.terrain_level IS 'Terrain level if there is no cover at the discharge point (structure), e.g. just pipe ending / Terrainkote, falls kein Deckel vorhanden bei Einleitstelle (Kanalende ohne Bauwerk oder Bauwerk ohne Deckel) / Cote terrain s''il n''y a pas de couvercle à l''exutoire par example seulement fin du conduite';
 ALTER TABLE qgep.od_discharge_point ADD COLUMN upper_elevation  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_discharge_point.upper_elevation IS 'Highest point of structure (ceiling), outside / Höchster Punkt des Bauwerks (Decke), aussen / Point le plus élevé de l''ouvrage';
 ALTER TABLE qgep.od_discharge_point ADD COLUMN waterlevel_hydraulic  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_discharge_point.waterlevel_hydraulic IS 'yyy_Wasserspiegelkote für die hydraulische Berechnung (IST-Zustand). Berechneter Wasserspiegel bei der Einleitstelle. Wo nichts anders gefordert, ist der Wasserspiegel bei einem HQ30 einzusetzen. / Wasserspiegelkote für die hydraulische Berechnung (IST-Zustand). Berechneter Wasserspiegel bei der Einleitstelle. Wo nichts anders gefordert, ist der Wasserspiegel bei einem HQ30 einzusetzen. / Niveau d’eau calculé à l’exutoire. Si aucun exigence est demandée, indiquer le niveau d’eau pour un HQ30.';
-------
CREATE TRIGGER
update_last_modified_discharge_point
BEFORE UPDATE OR INSERT ON
 qgep.od_discharge_point
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_manhole
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_manhole_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_manhole_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_manhole ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_manhole');
COMMENT ON COLUMN qgep.od_manhole.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_manhole ADD COLUMN depth  smallint ;
COMMENT ON COLUMN qgep.od_manhole.depth IS 'yyy_Funktion (berechneter Wert) = zugehöriger Abwasserknoten.Sohlenkote minus Deckel.Kote (falls Sohlenkote nicht separat erfasst, dann ist es die tiefer liegende Haltungspunkt.Kote). Siehe auch SIA 405 2015 4.3.4. / Funktion (berechneter Wert) = zugehöriger Abwasserknoten.Sohlenkote minus Deckel.Kote (falls Sohlenkote nicht separat erfasst, dann ist es die tiefer liegende Haltungspunkt.Kote). Siehe auch SIA 405 2015 4.3.4. / Fonction (valeur calculée) = NOEUD_RESEAU.COTE_RADIER correspondant moins COUVERCLE.COTE (si le radier n’est pas saisi séparément, c’est la POINT_TRONCON.COTE le plus bas). Cf. SIA 405 cahier technique 2015 4.3.4.';
 ALTER TABLE qgep.od_manhole ADD COLUMN dimension1  smallint ;
COMMENT ON COLUMN qgep.od_manhole.dimension1 IS 'Dimension2 of infiltration installations (largest inside dimension). / Dimension1 des Schachtes (grösstes Innenmass). / Dimension1 de la chambre (plus grande mesure intérieure).';
 ALTER TABLE qgep.od_manhole ADD COLUMN dimension2  smallint ;
COMMENT ON COLUMN qgep.od_manhole.dimension2 IS 'Dimension2 of manhole (smallest inside dimension). With circle shaped manholes leave dimension2 empty, with ovoid manholes fill it in. With rectangular shaped manholes use detailled_geometry to describe further. / Dimension2 des Schachtes (kleinstes Innenmass). Bei runden Schächten wird Dimension2 leer gelassen, bei ovalen abgefüllt. Für eckige Schächte Detailgeometrie verwenden. / Dimension2 de la chambre (plus petite mesure intérieure)';
 ALTER TABLE qgep.od_manhole ADD COLUMN function  integer ;
COMMENT ON COLUMN qgep.od_manhole.function IS 'Kind of function / Art der Nutzung / Genre d''utilisation';
 CREATE INDEX in_od_manhole_function ON qgep.od_manhole USING btree (function);
 ALTER TABLE qgep.od_manhole ADD COLUMN material  integer ;
COMMENT ON COLUMN qgep.od_manhole.material IS 'yyy_Hauptmaterial aus dem das Bauwerk besteht zur groben Klassifizierung. / Hauptmaterial aus dem das Bauwerk besteht zur groben Klassifizierung. / Matériau dont est construit l''ouvrage, pour une classification sommaire';
 ALTER TABLE qgep.od_manhole ADD COLUMN surface_inflow  integer ;
COMMENT ON COLUMN qgep.od_manhole.surface_inflow IS 'yyy_Zuflussmöglichkeit  von Oberflächenwasser direkt in den Schacht / Zuflussmöglichkeit  von Oberflächenwasser direkt in den Schacht / Arrivée directe d''eaux superficielles dans la chambre';
-------
CREATE TRIGGER
update_last_modified_manhole
BEFORE UPDATE OR INSERT ON
 qgep.od_manhole
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_structure');

-------
-------
CREATE TABLE qgep.od_lake
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_lake_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_lake_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_lake ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_lake');
COMMENT ON COLUMN qgep.od_lake.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
SELECT AddGeometryColumn('qgep', 'od_lake', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_lake_perimeter_geometry ON qgep.od_lake USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_lake.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_lake
BEFORE UPDATE OR INSERT ON
 qgep.od_lake
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('surface_water_bodies');

-------
-------
CREATE TABLE qgep.od_river
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_river_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_river_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_river ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_river');
COMMENT ON COLUMN qgep.od_river.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_river ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_river.kind IS 'yyy_Art des Fliessgewässers. Klassifizierung nach GEWISS / Art des Fliessgewässers. Klassifizierung nach GEWISS / Type de cours d''eau. Classification selon GEWISS';
-------
CREATE TRIGGER
update_last_modified_river
BEFORE UPDATE OR INSERT ON
 qgep.od_river
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('surface_water_bodies');

-------
-------
CREATE TABLE qgep.od_chute
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_chute_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_chute_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_chute ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_chute');
COMMENT ON COLUMN qgep.od_chute.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_chute ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_chute.kind IS 'Type of chute / Art des Absturzes / Type de seuil';
 ALTER TABLE qgep.od_chute ADD COLUMN material  integer ;
COMMENT ON COLUMN qgep.od_chute.material IS 'Construction material of chute / Material aus welchem der Absturz besteht / Matériau de construction du seuil';
 ALTER TABLE qgep.od_chute ADD COLUMN vertical_drop  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_chute.vertical_drop IS 'Vertical difference of water level before and after chute / Differenz des Wasserspiegels vor und nach dem Absturz / Différence de la hauteur du plan d''eau avant et après la chute';
-------
CREATE TRIGGER
update_last_modified_chute
BEFORE UPDATE OR INSERT ON
 qgep.od_chute
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_blocking_debris
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_blocking_debris_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_blocking_debris_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_blocking_debris ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_blocking_debris');
COMMENT ON COLUMN qgep.od_blocking_debris.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_blocking_debris ADD COLUMN vertical_drop  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_blocking_debris.vertical_drop IS 'yyy_Vertical difference of water level before and after Sperre / Differenz des Wasserspiegels vor und nach der Sperre / Différence de la hauteur du plan d''eau avant et après le barrage';
-------
CREATE TRIGGER
update_last_modified_blocking_debris
BEFORE UPDATE OR INSERT ON
 qgep.od_blocking_debris
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_lock
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_lock_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_lock_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_lock ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_lock');
COMMENT ON COLUMN qgep.od_lock.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_lock ADD COLUMN vertical_drop  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_lock.vertical_drop IS 'yyy_Vertical difference of water level before and after Schleuse / Differenz im Wasserspiegel oberhalb und unterhalb der Schleuse / Différence des plans d''eau entre l''amont et l''aval de l''écluse';
-------
CREATE TRIGGER
update_last_modified_lock
BEFORE UPDATE OR INSERT ON
 qgep.od_lock
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_dam
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_dam_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_dam_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_dam ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_dam');
COMMENT ON COLUMN qgep.od_dam.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_dam ADD COLUMN kind  integer ;
COMMENT ON COLUMN qgep.od_dam.kind IS 'Type of dam or weir / Art des Wehres / Genre d''ouvrage de retenue';
 ALTER TABLE qgep.od_dam ADD COLUMN vertical_drop  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_dam.vertical_drop IS 'Vertical difference of water level before and after chute / Differenz des Wasserspiegels vor und nach dem Absturz / Différence de la hauteur du plan d''eau avant et après la chute';
-------
CREATE TRIGGER
update_last_modified_dam
BEFORE UPDATE OR INSERT ON
 qgep.od_dam
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_ford
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_ford_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_ford_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_ford ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_ford');
COMMENT ON COLUMN qgep.od_ford.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
-------
CREATE TRIGGER
update_last_modified_ford
BEFORE UPDATE OR INSERT ON
 qgep.od_ford
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_rock_ramp
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_rock_ramp_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_rock_ramp_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_rock_ramp ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_rock_ramp');
COMMENT ON COLUMN qgep.od_rock_ramp.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_rock_ramp ADD COLUMN stabilisation  integer ;
COMMENT ON COLUMN qgep.od_rock_ramp.stabilisation IS 'Type of stabilisation of rock ramp / Befestigungsart der Sohlrampe / Genre de consolidation de la rampe';
 ALTER TABLE qgep.od_rock_ramp ADD COLUMN vertical_drop  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_rock_ramp.vertical_drop IS 'Vertical difference of water level before and after chute / Differenz des Wasserspiegels vor und nach dem Absturz / Différence de la hauteur du plan d''eau avant et après la chute';
-------
CREATE TRIGGER
update_last_modified_rock_ramp
BEFORE UPDATE OR INSERT ON
 qgep.od_rock_ramp
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_passage
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_passage_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_passage_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_passage ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_passage');
COMMENT ON COLUMN qgep.od_passage.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
-------
CREATE TRIGGER
update_last_modified_passage
BEFORE UPDATE OR INSERT ON
 qgep.od_passage
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('water_control_structure');

-------
-------
CREATE TABLE qgep.od_damage_manhole
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_damage_manhole_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_damage_manhole_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_damage_manhole ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_damage_manhole');
COMMENT ON COLUMN qgep.od_damage_manhole.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN connection  integer ;
COMMENT ON COLUMN qgep.od_damage_manhole.connection IS 'yyy_Feststellung bei zwei aneinandergrenzenden Schachtelementen gemäss 3.1.7). Entspricht in SN EN 13508 ja = "A", nein = leer / Feststellung bei zwei aneinandergrenzenden Schachtelementen gemäss 3.1.7). Entspricht in SN EN 13508 ja = "A", nein = leer / Observation entre deux éléments de regard de visite adjacents (3.1.7). Correspond dans la SN EN 13508 à oui = « A », non = vide';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN damage_begin  smallint ;
COMMENT ON COLUMN qgep.od_damage_manhole.damage_begin IS 'yyy_Lage am Umfang: Beginn des Schadens. Werte und Vorgehen sind unter Absatz 3.1.6 genau beschrieben. / Lage am Umfang: Beginn des Schadens. Werte und Vorgehen sind unter Absatz 3.1.6 genau beschrieben. / Emplacement circonférentiel: Début du dommage. Valeurs et procédure sont décrites en détail dans le paragraphe 3.1.6.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN damage_code_manhole  integer ;
COMMENT ON COLUMN qgep.od_damage_manhole.damage_code_manhole IS 'yyy_Vorgegebener Wertebereich: Gültiger Code auf der Grundlage von SN EN 13508-2. Alle gültigen Codes sind in Kapitel 3 der Richtlinie "Schadencodierung" abschliessend aufgeführt. / Vorgegebener Wertebereich: Gültiger Code auf der Grundlage von SN EN 13508-2. Alle gültigen Codes sind in Kapitel 3 der Richtlinie "Schadencodierung" abschliessend aufgeführt. / Domaine de valeur prédéfini: Code valide sur la base de la SN EN 13508-2. Tous les codes valides sont mentionnés dans le chapitre 3 de la directive.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN damage_end  smallint ;
COMMENT ON COLUMN qgep.od_damage_manhole.damage_end IS 'yyy_Lage am Umfang: Ende des Schadens. Werte und Vorgehen sind unter Absatz 3.1.6 genau beschrieben. / Lage am Umfang: Ende des Schadens. Werte und Vorgehen sind unter Absatz 3.1.6 genau beschrieben. / Emplacement circonférentiel: Fin du dommage. Valeurs et procédure sont décrites en détail dans le paragraphe 3.1.6.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN damage_reach  varchar(3) ;
COMMENT ON COLUMN qgep.od_damage_manhole.damage_reach IS 'yyy_Codes für den Anfang und das Ende eines Streckenschadens. Genaue Angaben unter 3.1.2 / Codes für den Anfang und das Ende eines Streckenschadens. Genaue Angaben unter 3.1.2 / Codes pour le début et la fin d’un dommage à un tronçon. Indications exactes sous 3.1.2.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN distance  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_damage_manhole.distance IS 'yyy_Länge ab Oberkante Deckel bis zur Feststellung (siehe Absatz 3.1.1) in m mit zwei Nachkommastellen. / Länge ab Oberkante Deckel bis zur Feststellung (siehe Absatz 3.1.1) in m mit zwei Nachkommastellen. / Longueur entre le bord supérieur du couvercle et l’observation (cf. paragraphe 3.1.1) en m avec deux chiffres après la virgule.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN manhole_shaft_area  integer ;
COMMENT ON COLUMN qgep.od_damage_manhole.manhole_shaft_area IS 'yyy_Bereich in dem eine Feststellung auftritt. Die Werte sind unter 3.1.9 abschliessend beschrieben. / Bereich in dem eine Feststellung auftritt. Die Werte sind unter 3.1.9 abschliessend beschrieben. / Domaine où une observation est faite. Les valeurs sont décrites dans 3.1.9.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN quantification1  varchar(20) ;
COMMENT ON COLUMN qgep.od_damage_manhole.quantification1 IS 'yyy_Quantifizierung 1 gemäss SN EN 13508. Zulässige Eingaben sind in Kapitel 3.1.5 beschrieben. Als Textattribut umgesetzt. / Quantifizierung 1 gemäss SN EN 13508. Zulässige Eingaben sind in Kapitel 3.1.5 beschrieben. Als Textattribut umgesetzt. / Quantification 1 selon la SN EN 13508. Les entrées autorisées sont décrites dans le chapitre 3.1.5. Type texte.';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN quantification2  varchar(20) ;
COMMENT ON COLUMN qgep.od_damage_manhole.quantification2 IS 'yyy_Quantifizierung 2 gemäss SN EN 13508. Zulässige Eingaben sind in Kapitel 3.1.5 beschrieben. Als Textattribut umgesetzt. / Quantifizierung 2 gemäss SN EN 13508. Zulässige Eingaben sind in Kapitel 3.1.5 beschrieben. Als Textattribut umgesetzt. / Quantification 2 selon la SN EN 13508. Les entrées autorisées sont décrites dans le chapitre 3.1.5. Type texte';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN video_counter  varchar(11) ;
COMMENT ON COLUMN qgep.od_damage_manhole.video_counter IS 'yyy_Zählerstand auf einem analogen Videoband oder in einer digitalen Videodatei, in Echtzeit / Zählerstand auf einem analogen Videoband oder in einer digitalen Videodatei, in Echtzeit / Relevé du compteur sur une bande vidéo analogique ou dans un fichier vidéo numérique, en temps réel';
 ALTER TABLE qgep.od_damage_manhole ADD COLUMN view_parameters  varchar(200) ;
COMMENT ON COLUMN qgep.od_damage_manhole.view_parameters IS 'yyy_Spezielle Ansichtsparameter für die Positionierung innerhalb einer Filmdatei für Scanner- oder digitale Videotechnik / Spezielle Ansichtsparameter für die Positionierung innerhalb einer Filmdatei für Scanner- oder digitale Videotechnik / Paramètres de projection spéciaux pour le positionnement à l’intérieur d’un fichier de film pour la technique vidéo scanner ou numérique.';
-------
CREATE TRIGGER
update_last_modified_damage_manhole
BEFORE UPDATE OR INSERT ON
 qgep.od_damage_manhole
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('damage');

-------
-------
CREATE TABLE qgep.od_damage_channel
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_damage_channel_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_damage_channel_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_damage_channel ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_damage_channel');
COMMENT ON COLUMN qgep.od_damage_channel.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN channel_damage_code  integer ;
COMMENT ON COLUMN qgep.od_damage_channel.channel_damage_code IS 'yyy_Vorgegebener Wertebereich: Gültiger Code auf der Grundlage von SN EN 13508-2. Alle gültigen Codes sind in Kapitel 2 der Richtlinie "Schadencodierung" abschliessend aufgeführt. / Vorgegebener Wertebereich: Gültiger Code auf der Grundlage von SN EN 13508-2. Alle gültigen Codes sind in Kapitel 2 der Richtlinie "Schadencodierung" abschliessend aufgeführt. / Domaine de valeur prédéfini: Code valide sur la base de la SN EN 13508-2. Tous les codes valides sont mentionnés dans le chapitre 2 de la directive.';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN connection  integer ;
COMMENT ON COLUMN qgep.od_damage_channel.connection IS 'yyy_Kennzeichen für eine Feststellung an einer Rohrverbindung (2.1.7). Entspricht in SN EN 13508 ja = "A", nein = leer. / Kennzeichen für eine Feststellung an einer Rohrverbindung (2.1.7). Entspricht in SN EN 13508 ja = "A", nein = leer. / Indication d’une observation au niveau d’un assemblage (2.1.7). Correspond dans la SN EN 13508 à oui = « A », non = vide';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN damage_begin  smallint ;
COMMENT ON COLUMN qgep.od_damage_channel.damage_begin IS 'yyy_Lage am Umfang: Ende des Schadens. Werte und Vorgehen sind in Absatz 2.1.6 genau beschrieben / Lage am Umfang: Beginn des Schadens. Werte und Vorgehen sind in Absatz 2.1.6 genau beschrieben. / Emplacement circonférentiel: Début du dommage. Valeurs et procédure sont décrites en détail dans le paragraphe 2.1.6.';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN damage_end  smallint ;
COMMENT ON COLUMN qgep.od_damage_channel.damage_end IS 'yyy_Lage am Umfang: Ende des Schadens. Werte und Vorgehen sind in Absatz 2.1.6 genau beschrieben / Lage am Umfang: Ende des Schadens. Werte und Vorgehen sind in Absatz 2.1.6 genau beschrieben / Emplacement circonférentiel: Fin du dommage. Valeurs et procédure sont décrites en détail dans le paragraphe 2.1.6.';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN damage_reach  varchar(3) ;
COMMENT ON COLUMN qgep.od_damage_channel.damage_reach IS 'yyy_Codes für den Anfang und das Ende eines Streckenschadens. Genaue Angaben unter 2.1.2 / Codes für den Anfang und das Ende eines Streckenschadens. Genaue Angaben unter 2.1.2 / Codes pour le début et la fin d’un dommage à un tronçon. Indications exactes sous 2.1.2.';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN distance  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_damage_channel.distance IS 'yyy_Länge von Rohranfang bis zur Feststellung (siehe Richtlinie Optische Inspektion von Entwässerungsanlagen: Schadencodierung und Datentransfer, Absatz 2.1.1) in m mit zwei Nachkommastellen / Länge von Rohranfang bis zur Feststellung (siehe Richtlinie Optische Inspektion von Entwässerungsanlagen: Schadencodierung und Datentransfer, Absatz 2.1.1) in m mit zwei Nachkommastellen / Longueur entre le début de la canalisation et l’observation (cf. paragraphe 2.1.1) en m avec deux chiffres après la virgule.';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN quantification1  integer ;
COMMENT ON COLUMN qgep.od_damage_channel.quantification1 IS 'yyy_Quantifizierung 1 gemäss SN EN 13508-2. Zulässige Eingaben sind in Kapitel 2.3 - 2.6 beschrieben / Quantifizierung 1 gemäss SN EN 13508-2. Zulässige Eingaben sind in Kapitel 2.3 - 2.6 beschrieben / Quantification 1 selon la SN EN 13508-2. Les entrées autorisées sont décrites dans les chapitres 2.3 - 2.6';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN quantification2  integer ;
COMMENT ON COLUMN qgep.od_damage_channel.quantification2 IS 'yyy_Quantifizierung 2 gemäss SN EN 13508. Zulässige Eingaben sind in Kapitel 2.3 - 2.6  beschrieben / Quantifizierung 2 gemäss SN EN 13508. Zulässige Eingaben sind in Kapitel 2.3 - 2.6  beschrieben / Quantification 2 selon la SN EN 13508. Les entrées autorisées sont décrites dans le chapitre 2.3 - 2.6';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN video_counter  varchar(11) ;
COMMENT ON COLUMN qgep.od_damage_channel.video_counter IS 'yyy_Zählerstand auf einem analogen Videoband oder in einer digitalen Videodatei, in Echtzeit (siehe auch 2.1.9). / Zählerstand auf einem analogen Videoband oder in einer digitalen Videodatei, in Echtzeit (siehe auch 2.1.9). / Relevé du compteur sur une bande vidéo analogique ou dans un fichier vidéo numérique, en temps réel (cf. aussi 2.1.9).';
 ALTER TABLE qgep.od_damage_channel ADD COLUMN view_parameters  varchar(200) ;
COMMENT ON COLUMN qgep.od_damage_channel.view_parameters IS 'yyy_Spezielle Ansichtsparameter für die Positionierung innerhalb einer Filmdatei für Scanner- oder digitale Videotechnik / Spezielle Ansichtsparameter für die Positionierung innerhalb einer Filmdatei für Scanner- oder digitale Videotechnik / Paramètres de projection spéciaux pour le positionnement à l’intérieur d’un fichier de film pour la technique vidéo scanner ou numérique.';
-------
CREATE TRIGGER
update_last_modified_damage_channel
BEFORE UPDATE OR INSERT ON
 qgep.od_damage_channel
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('damage');

-------
-------
CREATE TABLE qgep.od_param_ca_general
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_param_ca_general_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_param_ca_general_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_param_ca_general ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_param_ca_general');
COMMENT ON COLUMN qgep.od_param_ca_general.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_param_ca_general ADD COLUMN dry_wheather_flow  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_param_ca_general.dry_wheather_flow IS 'Dry wheather flow / Débit temps sec';
 ALTER TABLE qgep.od_param_ca_general ADD COLUMN flow_path_length  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_param_ca_general.flow_path_length IS 'Length of flow path / Fliessweglänge / longueur de la ligne d''écoulement';
 ALTER TABLE qgep.od_param_ca_general ADD COLUMN flow_path_slope  smallint ;
COMMENT ON COLUMN qgep.od_param_ca_general.flow_path_slope IS 'Slope of flow path [%o] / Fliessweggefälle [%o] / Pente de la ligne d''écoulement [%o]';
 ALTER TABLE qgep.od_param_ca_general ADD COLUMN population_equivalent  integer ;
COMMENT ON COLUMN qgep.od_param_ca_general.population_equivalent IS '';
 ALTER TABLE qgep.od_param_ca_general ADD COLUMN surface_ca  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_param_ca_general.surface_ca IS 'yyy_Surface bassin versant MOUSE1 / Fläche des Einzugsgebietes für MOUSE1 / Surface bassin versant MOUSE1';
-------
CREATE TRIGGER
update_last_modified_param_ca_general
BEFORE UPDATE OR INSERT ON
 qgep.od_param_ca_general
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('surface_runoff_parameters');

-------
-------
CREATE TABLE qgep.od_param_ca_mouse1
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_param_ca_mouse1_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_param_ca_mouse1_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_param_ca_mouse1 ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_param_ca_mouse1');
COMMENT ON COLUMN qgep.od_param_ca_mouse1.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_param_ca_mouse1 ADD COLUMN dry_wheather_flow  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_param_ca_mouse1.dry_wheather_flow IS 'Parameter for calculation of surface runoff for surface runoff modell A1 / Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE / Paramètre pour calculer l''écoulement superficiel selon le modèle A1 de MOUSE';
 ALTER TABLE qgep.od_param_ca_mouse1 ADD COLUMN flow_path_length  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_param_ca_mouse1.flow_path_length IS 'yyy_Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE / Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE / Paramètre pour calculer l''écoulement superficiel selon le modèle A1 de MOUSE';
 ALTER TABLE qgep.od_param_ca_mouse1 ADD COLUMN flow_path_slope  smallint ;
COMMENT ON COLUMN qgep.od_param_ca_mouse1.flow_path_slope IS 'yyy_Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE [%o] / Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE [%o] / Paramètre pour calculer l''écoulement superficiel selon le modèle A1 de MOUSE [%o]';
 ALTER TABLE qgep.od_param_ca_mouse1 ADD COLUMN population_equivalent  integer ;
COMMENT ON COLUMN qgep.od_param_ca_mouse1.population_equivalent IS '';
 ALTER TABLE qgep.od_param_ca_mouse1 ADD COLUMN surface_ca_mouse  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_param_ca_mouse1.surface_ca_mouse IS 'yyy_Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE / Parameter zur Bestimmung des Oberflächenabflusses für das Oberflächenabflussmodell A1 von MOUSE / Paramètre pour calculer l''écoulement superficiel selon le modèle A1 de MOUSE';
 ALTER TABLE qgep.od_param_ca_mouse1 ADD COLUMN usage  varchar(50) ;
COMMENT ON COLUMN qgep.od_param_ca_mouse1.usage IS 'Classification based on surface runoff modell MOUSE 2000/2001 / Klassifikation gemäss Oberflächenabflussmodell von MOUSE 2000/2001 / Classification selon le modèle surface de MOUSE 2000/2001';
-------
CREATE TRIGGER
update_last_modified_param_ca_mouse1
BEFORE UPDATE OR INSERT ON
 qgep.od_param_ca_mouse1
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('surface_runoff_parameters');

-------
-------
CREATE TABLE qgep.od_private
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_private_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_private_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_private ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_private');
COMMENT ON COLUMN qgep.od_private.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_private ADD COLUMN kind  varchar(50) ;
COMMENT ON COLUMN qgep.od_private.kind IS '';
-------
CREATE TRIGGER
update_last_modified_private
BEFORE UPDATE OR INSERT ON
 qgep.od_private
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_administrative_office
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_administrative_office_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_administrative_office_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_administrative_office ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_administrative_office');
COMMENT ON COLUMN qgep.od_administrative_office.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
-------
CREATE TRIGGER
update_last_modified_administrative_office
BEFORE UPDATE OR INSERT ON
 qgep.od_administrative_office
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_canton
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_canton_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_canton_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_canton ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_canton');
COMMENT ON COLUMN qgep.od_canton.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
SELECT AddGeometryColumn('qgep', 'od_canton', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_canton_perimeter_geometry ON qgep.od_canton USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_canton.perimeter_geometry IS 'Border of canton / Kantonsgrenze / Limites cantonales';
-------
CREATE TRIGGER
update_last_modified_canton
BEFORE UPDATE OR INSERT ON
 qgep.od_canton
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_cooperative
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_cooperative_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_cooperative_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_cooperative ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_cooperative');
COMMENT ON COLUMN qgep.od_cooperative.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
-------
CREATE TRIGGER
update_last_modified_cooperative
BEFORE UPDATE OR INSERT ON
 qgep.od_cooperative
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_municipality
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_municipality_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_municipality_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_municipality ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_municipality');
COMMENT ON COLUMN qgep.od_municipality.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_municipality ADD COLUMN altitude  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_municipality.altitude IS 'Average altitude of settlement area / Mittlere Höhe des Siedlungsgebietes / Altitude moyenne de l''agglomération';
 ALTER TABLE qgep.od_municipality ADD COLUMN gwdp_year  smallint ;
COMMENT ON COLUMN qgep.od_municipality.gwdp_year IS 'Year of legal validity of General Water Drainage Planning (GWDP) / Rechtsgültiges GEP aus dem Jahr / PGEE en vigueur depuis';
 ALTER TABLE qgep.od_municipality ADD COLUMN municipality_number  smallint ;
COMMENT ON COLUMN qgep.od_municipality.municipality_number IS 'Official number of federal office for statistics / Offizielle Nummer gemäss Bundesamt für Statistik / Numéro officiel de la commune selon l''Office fédéral de la statistique';
SELECT AddGeometryColumn('qgep', 'od_municipality', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_municipality_perimeter_geometry ON qgep.od_municipality USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_municipality.perimeter_geometry IS 'Border of the municipality / Gemeindegrenze / Limites communales';
 ALTER TABLE qgep.od_municipality ADD COLUMN population  integer ;
COMMENT ON COLUMN qgep.od_municipality.population IS 'Permanent opulation (based on statistics of the municipality) / Ständige Einwohner (laut Einwohnerkontrolle der Gemeinde) / Habitants permanents (selon le contrôle des habitants de la commune)';
 ALTER TABLE qgep.od_municipality ADD COLUMN total_surface  decimal(8,2) ;
COMMENT ON COLUMN qgep.od_municipality.total_surface IS 'Total surface without lakes / Fläche ohne Seeanteil / Surface sans partie de lac';
-------
CREATE TRIGGER
update_last_modified_municipality
BEFORE UPDATE OR INSERT ON
 qgep.od_municipality
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_waste_water_association
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_waste_water_association_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_waste_water_association_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_waste_water_association ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_waste_water_association');
COMMENT ON COLUMN qgep.od_waste_water_association.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
-------
CREATE TRIGGER
update_last_modified_waste_water_association
BEFORE UPDATE OR INSERT ON
 qgep.od_waste_water_association
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_waste_water_treatment_plant
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_waste_water_treatment_plant_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_waste_water_treatment_plant_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_waste_water_treatment_plant ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_waste_water_treatment_plant');
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN bod5  smallint ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.bod5 IS '5 day biochemical oxygen demand measured at a temperatur of 20 degree celsius. YYY / Biochemischer Sauerstoffbedarf nach 5 Tagen Messzeit und bei einer Temperatur vom 20 Grad Celsius. Er stellt den Verbrauch an gelöstem Sauerstoff durch die Lebensvorgänge der im Wasser oder Abwasser enthaltenen Mikroorganismen (Bakterienprotozoen) beim  A / Elle représente la quantité d’oxygène dépensée par les phénomènes d’oxydation chimique, d’une part, et, d’autre part, la dégradation des matières organiques par voie aérobie, nécessaire à la destruction des composés organiques. Elle s’exprime en milligram';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN cod  smallint ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.cod IS 'Abbreviation for chemical oxygen demand (COD). / Abkürzung für den chemischen Sauerstoffbedarf. Die englische Abkürzung lautet COD. Mit einem starken Oxydationsmittel wird mehr oder weniger erfolgreich versucht, die organischen Verbindungen der Abwasserprobe zu CO2 und H2O zu oxydieren. Als Oxydationsmi / Elle représente la teneur totale de l’eau en matières organiques, qu’elles soient ou non biodégradables. Le principe repose sur la recherche d’un besoin d’oxygène de l’échantillon pour dégrader la matière organique. Mais dans ce cas, l’oxygène est fourni ';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN elimination_cod  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.elimination_cod IS 'Dimensioning value elimination rate in percent / Dimensionierungswert Eliminationsrate in % / Valeur de dimensionnement, taux d''élimination en %';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN elimination_n  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.elimination_n IS 'Denitrification at at waster water temperature of below 10 degree celsius / Denitrifikation bei einer Abwassertemperatur von > 10 Grad / Dénitrification à une température des eaux supérieure à 10°C';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN elimination_nh4  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.elimination_nh4 IS 'Dimensioning value elimination rate in percent / Dimensionierungswert: Eliminationsrate in % / Valeur de dimensionnement, taux d''élimination en %';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN elimination_p  decimal (5,2) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.elimination_p IS 'Dimensioning value elimination rate in percent / Dimensionierungswert Eliminationsrate in % / Valeur de dimensionnement, taux d''élimination en %';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN installation_number  integer ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.installation_number IS 'WWTP Number from Federal Office for the Environment (FOEN) / ARA-Nummer gemäss Bundesamt für Umwelt (BAFU) / Numéro de la STEP selon l''Office fédéral de l''environnement (OFEV)';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN kind  varchar(50) ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.kind IS '';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN nh4  smallint ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.nh4 IS 'yyy_Dimensioning value Ablauf Vorklärung. NH4 [gNH4/m3] / Dimensionierungswert Ablauf Vorklärung. NH4 [gNH4/m3] / Valeur de dimensionnement, NH4 à la sortie du décanteur primaire. NH4 [gNH4/m3]';
 ALTER TABLE qgep.od_waste_water_treatment_plant ADD COLUMN start_year  smallint ;
COMMENT ON COLUMN qgep.od_waste_water_treatment_plant.start_year IS 'Start of operation (year) / Jahr der Inbetriebnahme / Année de la mise en exploitation';
-------
CREATE TRIGGER
update_last_modified_waste_water_treatment_plant
BEFORE UPDATE OR INSERT ON
 qgep.od_waste_water_treatment_plant
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('organisation');

-------
-------
CREATE TABLE qgep.od_reach
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_reach_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_reach_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_reach ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_reach');
COMMENT ON COLUMN qgep.od_reach.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_reach ADD COLUMN clear_height  integer ;
COMMENT ON COLUMN qgep.od_reach.clear_height IS 'Maximal height (inside) of profile / Maximale Innenhöhe des Kanalprofiles / Hauteur intérieure maximale du profil';
 ALTER TABLE qgep.od_reach ADD COLUMN coefficient_of_friction  smallint ;
COMMENT ON COLUMN qgep.od_reach.coefficient_of_friction IS 'yyy http://www.linguee.com/english-german/search?source=auto&query=reibungsbeiwert / Hydraulische Kenngrösse zur Beschreibung der Beschaffenheit der Kanalwandung. Beiwert für die Formeln nach Manning-Strickler (K oder kstr) / Constante de rugosité selon Manning-Strickler (K ou kstr)';
 ALTER TABLE qgep.od_reach ADD COLUMN elevation_determination  integer ;
COMMENT ON COLUMN qgep.od_reach.elevation_determination IS 'yyy_Definiert die Hoehenbestimmung einer Haltung. / Definiert die Hoehenbestimmung einer Haltung. / Définition de la détermination altimétrique d''un tronçon.';
 ALTER TABLE qgep.od_reach ADD COLUMN horizontal_positioning  integer ;
COMMENT ON COLUMN qgep.od_reach.horizontal_positioning IS 'yyy_Definiert die Lagegenauigkeit der Verlaufspunkte. / Definiert die Lagegenauigkeit der Verlaufspunkte. / Définit la précision de la détermination du tracé.';
 ALTER TABLE qgep.od_reach ADD COLUMN inside_coating  integer ;
COMMENT ON COLUMN qgep.od_reach.inside_coating IS 'yyy_Schutz der Innenwände des Kanals / Schutz der Innenwände des Kanals / Protection de la paroi intérieur de la canalisation';
 ALTER TABLE qgep.od_reach ADD COLUMN length_effective  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_reach.length_effective IS 'yyy_Tatsächliche schräge Länge (d.h. nicht in horizontale Ebene projiziert)  inklusive Kanalkrümmungen / Tatsächliche schräge Länge (d.h. nicht in horizontale Ebene projiziert)  inklusive Kanalkrümmungen / Longueur effective (non projetée) incluant les parties incurvées';
 ALTER TABLE qgep.od_reach ADD COLUMN material  integer ;
COMMENT ON COLUMN qgep.od_reach.material IS 'Material of reach / pipe / Rohrmaterial / Matériau du tuyau';
SELECT AddGeometryColumn('qgep', 'od_reach', 'progression_geometry', 21781, 'LINESTRING', 2, true);
CREATE INDEX in_qgep_od_reach_progression_geometry ON qgep.od_reach USING gist (progression_geometry );
COMMENT ON COLUMN qgep.od_reach.progression_geometry IS 'Start, inflextion and endpoints of a pipe / Anfangs-, Knick- und Endpunkte der Leitung / Points de départ, intermédiaires et d’arrivée de la conduite.';
SELECT AddGeometryColumn('qgep', 'od_reach', 'progression_3d_geometry', 21781, 'LINESTRING', 3, true);
CREATE INDEX in_qgep_od_reach_progression_3d_geometry ON qgep.od_reach USING gist (progression_3d_geometry );
COMMENT ON COLUMN qgep.od_reach.progression_3d_geometry IS 'Start, inflextion and endpoints of a pipe (3D coordinates) / Anfangs-, Knick- und Endpunkte der Leitung (3D Koordinaten) / Points de départ, intermédiaires et d’arrivée de la conduite (coordonnées 3D)';
 ALTER TABLE qgep.od_reach ADD COLUMN reliner_material  integer ;
COMMENT ON COLUMN qgep.od_reach.reliner_material IS 'Material of reliner / Material des Reliners / Materiaux du relining';
 ALTER TABLE qgep.od_reach ADD COLUMN reliner_nominal_size  integer ;
COMMENT ON COLUMN qgep.od_reach.reliner_nominal_size IS 'yyy_Profilhöhe des Inliners (innen). Beim Export in Hydrauliksoftware müsste dieser Wert statt Haltung.Lichte_Hoehe übernommen werden um korrekt zu simulieren. / Profilhöhe des Inliners (innen). Beim Export in Hydrauliksoftware müsste dieser Wert statt Haltung.Lichte_Hoehe übernommen werden um korrekt zu simulieren. / Hauteur intérieure maximale du profil de l''inliner. A l''export dans le software hydraulique il faut utiliser cette attribut au lieu de HAUTEUR_MAX_PROFIL';
 ALTER TABLE qgep.od_reach ADD COLUMN relining_construction  integer ;
COMMENT ON COLUMN qgep.od_reach.relining_construction IS 'yyy_Bautechnik für das Relining. Zusätzlich wird der Einbau des Reliners als  Erhaltungsereignis abgebildet: Erhaltungsereignis.Art = Reparatur für Partieller_Liner, sonst Renovierung. / Bautechnik für das Relining. Zusätzlich wird der Einbau des Reliners als  Erhaltungsereignis abgebildet: Erhaltungsereignis.Art = Reparatur für Partieller_Liner, sonst Renovierung. / Relining technique de construction. En addition la construction du reliner doit être modeler comme événement maintenance: Genre = reparation pour liner_partiel, autrement genre = renovation.';
 ALTER TABLE qgep.od_reach ADD COLUMN relining_kind  integer ;
COMMENT ON COLUMN qgep.od_reach.relining_kind IS 'Kind of relining / Art des Relinings / Genre du relining';
 ALTER TABLE qgep.od_reach ADD COLUMN ring_stiffness  smallint ;
COMMENT ON COLUMN qgep.od_reach.ring_stiffness IS 'yyy Ringsteifigkeitsklasse - Druckfestigkeit gegen Belastungen von aussen (gemäss ISO 13966 ) / Ringsteifigkeitsklasse - Druckfestigkeit gegen Belastungen von aussen (gemäss ISO 13966 ) / Rigidité annulaire pour des pressions extérieures (selon ISO 13966)';
 ALTER TABLE qgep.od_reach ADD COLUMN slope_building_plan  smallint ;
COMMENT ON COLUMN qgep.od_reach.slope_building_plan IS 'yyy_Auf dem alten Plan eingezeichnetes Plangefälle [%o]. Nicht kontrolliert im Feld. Kann nicht für die hydraulische Berechnungen übernommen werden. Für Liegenschaftsentwässerung und Meliorationsleitungen. Darstellung als z.B. 3.5%oP auf Plänen. / Auf dem alten Plan eingezeichnetes Plangefälle [%o]. Nicht kontrolliert im Feld. Kann nicht für die hydraulische Berechnungen übernommen werden. Für Liegenschaftsentwässerung und Meliorationsleitungen. Darstellung als z.B. 3.5%oP auf Plänen. / Pente indiquée sur d''anciens plans non contrôlée [%o]. Ne peut pas être reprise pour des calculs hydrauliques. Indication pour des canalisations de biens-fonds ou d''amélioration foncière. Représentation sur de plan: 3.5‰ p';
 ALTER TABLE qgep.od_reach ADD COLUMN wall_roughness  decimal(5,2) ;
COMMENT ON COLUMN qgep.od_reach.wall_roughness IS 'yyy Hydraulische Kenngrösse zur Beschreibung der Beschaffenheit der Kanalwandung. Beiwert für die Formeln nach Prandtl-Colebrook (ks oder kb) / Hydraulische Kenngrösse zur Beschreibung der Beschaffenheit der Kanalwandung. Beiwert für die Formeln nach Prandtl-Colebrook (ks oder kb) / Coefficient de rugosité d''après Prandtl Colebrook (ks ou kb)';
-------
CREATE TRIGGER
update_last_modified_reach
BEFORE UPDATE OR INSERT ON
 qgep.od_reach
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_networkelement');

-------
-------
CREATE TABLE qgep.od_wastewater_node
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wastewater_node_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wastewater_node_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wastewater_node ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wastewater_node');
COMMENT ON COLUMN qgep.od_wastewater_node.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wastewater_node ADD COLUMN backflow_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_wastewater_node.backflow_level IS 'yyy_1. Massgebende Rückstaukote bezogen auf den Berechnungsregen (dss)  2. Höhe, unter der innerhalb der Grundstücksentwässerung besondere Massnahmen gegen Rückstau zu treffen sind. (DIN 4045) / 1. Massgebende Rückstaukote bezogen auf den Berechnungsregen (dss)  2. Höhe, unter der innerhalb der Grundstücksentwässerung besondere Massnahmen gegen Rückstau zu treffen sind. (DIN 4045) / Cote de refoulement déterminante calculée à partir des pluies de projet';
 ALTER TABLE qgep.od_wastewater_node ADD COLUMN bottom_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_wastewater_node.bottom_level IS 'yyy_Tiefster Punkt des Abwasserbauwerks / Tiefster Punkt des Abwasserbauwerks / Point le plus bas du noeud';
SELECT AddGeometryColumn('qgep', 'od_wastewater_node', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_wastewater_node_situation_geometry ON qgep.od_wastewater_node USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_wastewater_node.situation_geometry IS 'yyy Situation of node. Decisive reference point for sewer network simulation  (In der Regel Lage des Pickellochs oder Lage des Trockenwetterauslauf) / Lage des Knotens, massgebender Bezugspunkt für die Kanalnetzberechnung. (In der Regel Lage des Pickellochs oder Lage des Trockenwetterauslaufs) / Positionnement du nœud. Point de référence déterminant pour le calcul de réseau de canalisations (en règle générale positionnement du milieu du couvercle ou de la sortie temps sec)';
-------
CREATE TRIGGER
update_last_modified_wastewater_node
BEFORE UPDATE OR INSERT ON
 qgep.od_wastewater_node
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('wastewater_networkelement');

-------
-------
CREATE TABLE qgep.od_pump
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_pump_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_pump_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_pump ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_pump');
COMMENT ON COLUMN qgep.od_pump.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_pump ADD COLUMN contruction_type  integer ;
COMMENT ON COLUMN qgep.od_pump.contruction_type IS 'Types of pumps / Pumpenarten / Types de pompe';
 ALTER TABLE qgep.od_pump ADD COLUMN operating_point  decimal(9,2) ;
COMMENT ON COLUMN qgep.od_pump.operating_point IS 'Flow for pumps with fixed operating point / Fördermenge für Pumpen mit fixem Arbeitspunkt / Débit refoulé par la pompe avec point de travail fixe';
 ALTER TABLE qgep.od_pump ADD COLUMN placement_of_actuation  integer ;
COMMENT ON COLUMN qgep.od_pump.placement_of_actuation IS 'Type of placement of the actuation / Art der Aufstellung des Motors / Genre de montage';
 ALTER TABLE qgep.od_pump ADD COLUMN placement_of_pump  integer ;
COMMENT ON COLUMN qgep.od_pump.placement_of_pump IS 'Type of placement of the pomp / Art der Aufstellung der Pumpe / Genre de montage de la pompe';
 ALTER TABLE qgep.od_pump ADD COLUMN pump_flow_max_single  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_pump.pump_flow_max_single IS 'yyy_Maximaler Förderstrom der Pumpen (einzeln als Bauwerkskomponente). Tritt in der Regel bei der minimalen Förderhöhe ein. / Maximaler Förderstrom der Pumpe (einzeln als Bauwerkskomponente). Tritt in der Regel bei der minimalen Förderhöhe ein. / Débit de refoulement maximal des pompes individuelles en tant que composante d’ouvrage. Survient normalement à la hauteur min de refoulement.';
 ALTER TABLE qgep.od_pump ADD COLUMN pump_flow_min_single  decimal(9,3) ;
COMMENT ON COLUMN qgep.od_pump.pump_flow_min_single IS 'yyy_Minimaler Förderstrom der Pumpe (einzeln als Bauwerkskomponente). Tritt in der Regel bei der maximalen Förderhöhe ein. / Minimaler Förderstrom der Pumpe (einzeln als Bauwerkskomponente). Tritt in der Regel bei der maximalen Förderhöhe ein. / Débit de refoulement maximal de toutes les pompes de l’ouvrage (STAP) ou des pompes individuelles en tant que composante d’ouvrage. Survient normalement à la hauteur min de refoulement.';
 ALTER TABLE qgep.od_pump ADD COLUMN start_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_pump.start_level IS 'yyy_Kote des Wasserspiegels im Pumpensumpf, bei der die Pumpe eingeschaltet wird (Einschaltkote) / Kote des Wasserspiegels im Pumpensumpf, bei der die Pumpe eingeschaltet wird (Einschaltkote) / Cote du niveau d''eau dans le puisard à laquelle s''enclenche la pompe';
 ALTER TABLE qgep.od_pump ADD COLUMN stop_level  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_pump.stop_level IS 'yyy_Kote des Wasserspiegels im Pumpensumpf, bei der die Pumpe ausgeschaltet wird (Ausschaltkote) / Kote des Wasserspiegels im Pumpensumpf, bei der die Pumpe ausgeschaltet wird (Ausschaltkote) / Cote du niveau d''eau dans le puisard à laquelle s''arrête la pompe';
 ALTER TABLE qgep.od_pump ADD COLUMN usage_current  integer ;
COMMENT ON COLUMN qgep.od_pump.usage_current IS 'yyy_Nutzungsart_Ist des gepumpten Abwassers. / Nutzungsart_Ist des gepumpten Abwassers. / Genre d''utilisation actuel de l''eau usée pompée';
-------
CREATE TRIGGER
update_last_modified_pump
BEFORE UPDATE OR INSERT ON
 qgep.od_pump
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('overflow');

-------
-------
CREATE TABLE qgep.od_leapingweir
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_leapingweir_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_leapingweir_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_leapingweir ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_leapingweir');
COMMENT ON COLUMN qgep.od_leapingweir.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_leapingweir ADD COLUMN length  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_leapingweir.length IS 'yyy_Maximale Abmessung der Bodenöffnung in Fliessrichtung / Maximale Abmessung der Bodenöffnung in Fliessrichtung / Dimension maximale de l''ouverture de fond parallèlement au courant';
 ALTER TABLE qgep.od_leapingweir ADD COLUMN opening_shape  integer ;
COMMENT ON COLUMN qgep.od_leapingweir.opening_shape IS 'Shape of opening in the floor / Form der  Bodenöffnung / Forme de l''ouverture de fond';
 ALTER TABLE qgep.od_leapingweir ADD COLUMN width  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_leapingweir.width IS 'yyy_Maximale Abmessung der Bodenöffnung quer zur Fliessrichtung / Maximale Abmessung der Bodenöffnung quer zur Fliessrichtung / Dimension maximale de l''ouverture de fond perpendiculairement à la direction d''écoulement';
-------
CREATE TRIGGER
update_last_modified_leapingweir
BEFORE UPDATE OR INSERT ON
 qgep.od_leapingweir
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('overflow');

-------
-------
CREATE TABLE qgep.od_prank_weir
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_prank_weir_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_prank_weir_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_prank_weir ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_prank_weir');
COMMENT ON COLUMN qgep.od_prank_weir.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_prank_weir ADD COLUMN hydraulic_overflow_length  decimal(7,2) ;
COMMENT ON COLUMN qgep.od_prank_weir.hydraulic_overflow_length IS 'yyy_Hydraulisch wirksame Wehrlänge / Hydraulisch wirksame Wehrlänge / Longueur du déversoir hydrauliquement active';
 ALTER TABLE qgep.od_prank_weir ADD COLUMN level_max  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_prank_weir.level_max IS 'yyy_Höhe des höchsten Punktes der Überfallkante / Höhe des höchsten Punktes der Überfallkante / Niveau max. de la crête déversante';
 ALTER TABLE qgep.od_prank_weir ADD COLUMN level_min  decimal(7,3) ;
COMMENT ON COLUMN qgep.od_prank_weir.level_min IS 'yyy_Höhe des tiefsten Punktes der Überfallkante / Höhe des tiefsten Punktes der Überfallkante / Niveau min. de la crête déversante';
 ALTER TABLE qgep.od_prank_weir ADD COLUMN weir_edge  integer ;
COMMENT ON COLUMN qgep.od_prank_weir.weir_edge IS 'yyy_Ausbildung der Überfallkante / Ausbildung der Überfallkante / Forme de la crête';
 ALTER TABLE qgep.od_prank_weir ADD COLUMN weir_kind  integer ;
COMMENT ON COLUMN qgep.od_prank_weir.weir_kind IS 'yyy_Art der Wehrschweille des Streichwehrs / Art der Wehrschwelle des Streichwehrs / Genre de surverse du déversoir latéral';
-------
CREATE TRIGGER
update_last_modified_prank_weir
BEFORE UPDATE OR INSERT ON
 qgep.od_prank_weir
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('overflow');

-------
-------
CREATE TABLE qgep.od_individual_surface
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_individual_surface_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_individual_surface_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_individual_surface ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_individual_surface');
COMMENT ON COLUMN qgep.od_individual_surface.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_individual_surface ADD COLUMN function  integer ;
COMMENT ON COLUMN qgep.od_individual_surface.function IS 'Type of usage of surface / Art der Nutzung der Fläche / Genre d''utilisation de la surface';
 ALTER TABLE qgep.od_individual_surface ADD COLUMN inclination  smallint ;
COMMENT ON COLUMN qgep.od_individual_surface.inclination IS 'yyy_Mittlere Neigung der Oberfläche in Promill / Mittlere Neigung der Oberfläche in Promill / Pente moyenne de la surface en promille';
 ALTER TABLE qgep.od_individual_surface ADD COLUMN pavement  integer ;
COMMENT ON COLUMN qgep.od_individual_surface.pavement IS 'Type of pavement / Art der Befestigung / Genre de couverture du sol';
SELECT AddGeometryColumn('qgep', 'od_individual_surface', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_individual_surface_perimeter_geometry ON qgep.od_individual_surface USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_individual_surface.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
-------
CREATE TRIGGER
update_last_modified_individual_surface
BEFORE UPDATE OR INSERT ON
 qgep.od_individual_surface
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('connection_object');

-------
-------
CREATE TABLE qgep.od_building
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_building_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_building_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_building ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_building');
COMMENT ON COLUMN qgep.od_building.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_building ADD COLUMN house_number  varchar(50) ;
COMMENT ON COLUMN qgep.od_building.house_number IS 'House number based on cadastral register / Hausnummer gemäss Grundbuch / Numéro de bâtiment selon le registre foncier';
 ALTER TABLE qgep.od_building ADD COLUMN location_name  varchar(50) ;
COMMENT ON COLUMN qgep.od_building.location_name IS 'Street name or name of the location / Strassenname oder Ortsbezeichnung / Nom de la route ou du lieu';
SELECT AddGeometryColumn('qgep', 'od_building', 'perimeter_geometry', 21781, 'POLYGON', 2, true);
CREATE INDEX in_qgep_od_building_perimeter_geometry ON qgep.od_building USING gist (perimeter_geometry );
COMMENT ON COLUMN qgep.od_building.perimeter_geometry IS 'Boundary points of the perimeter / Begrenzungspunkte der Fläche / Points de délimitation de la surface';
SELECT AddGeometryColumn('qgep', 'od_building', 'reference_point_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_building_reference_point_geometry ON qgep.od_building USING gist (reference_point_geometry );
COMMENT ON COLUMN qgep.od_building.reference_point_geometry IS 'National position coordinates (East, North) (relevant point for e.g. address) / Landeskoordinate Ost/Nord (massgebender Bezugspunkt für z.B. Adressdaten ) / Coordonnées nationales Est/Nord (Point de référence pour la détermination de l''adresse par exemple)';
-------
CREATE TRIGGER
update_last_modified_building
BEFORE UPDATE OR INSERT ON
 qgep.od_building
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('connection_object');

-------
-------
CREATE TABLE qgep.od_reservoir
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_reservoir_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_reservoir_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_reservoir ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_reservoir');
COMMENT ON COLUMN qgep.od_reservoir.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_reservoir ADD COLUMN location_name  varchar(50) ;
COMMENT ON COLUMN qgep.od_reservoir.location_name IS 'Street name or name of the location / Strassenname oder Ortsbezeichnung / Nom de la route ou du lieu';
SELECT AddGeometryColumn('qgep', 'od_reservoir', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_reservoir_situation_geometry ON qgep.od_reservoir USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_reservoir.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
-------
CREATE TRIGGER
update_last_modified_reservoir
BEFORE UPDATE OR INSERT ON
 qgep.od_reservoir
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('connection_object');

-------
-------
CREATE TABLE qgep.od_fountain
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_fountain_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_fountain_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_fountain ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_fountain');
COMMENT ON COLUMN qgep.od_fountain.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_fountain ADD COLUMN location_name  varchar(50) ;
COMMENT ON COLUMN qgep.od_fountain.location_name IS 'Street name or name of the location / Strassenname oder Ortsbezeichnung / Nom de la route ou du lieu';
SELECT AddGeometryColumn('qgep', 'od_fountain', 'situation_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_fountain_situation_geometry ON qgep.od_fountain USING gist (situation_geometry );
COMMENT ON COLUMN qgep.od_fountain.situation_geometry IS 'National position coordinates (East, North) / Landeskoordinate Ost/Nord / Coordonnées nationales Est/Nord';
-------
CREATE TRIGGER
update_last_modified_fountain
BEFORE UPDATE OR INSERT ON
 qgep.od_fountain
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified_parent('connection_object');

-------
------------ Relationships and Value Tables ----------- ;
CREATE TABLE qgep.vl_symbol_plantype () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_symbol_plantype ADD CONSTRAINT pkey_qgep_vl_symbol_plantype_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7874,7874,'pipeline_registry','Leitungskataster','cadastre_des_conduites_souterraines', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7876,7876,'overviewmap.om10','Uebersichtsplan.UeP10','plan_d_ensemble.pe10', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7877,7877,'overviewmap.om2','Uebersichtsplan.UeP2','plan_d_ensemble.pe5', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7878,7878,'overviewmap.om5','Uebersichtsplan.UeP5','plan_d_ensemble.pe2', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7875,7875,'network_plan','Werkplan','plan_de_reseau', '', '', '', 'true');
 ALTER TABLE qgep.txt_symbol ADD CONSTRAINT fkey_vl_symbol_plantype FOREIGN KEY (plantype)
 REFERENCES qgep.vl_symbol_plantype (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_symbol_symbolhali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_symbol_symbolhali ADD CONSTRAINT pkey_qgep_vl_symbol_symbolhali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_symbol_symbolhali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7880,7880,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_symbolhali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7881,7881,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_symbolhali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7882,7882,'2','2','2', '', '', '', 'true');
 ALTER TABLE qgep.txt_symbol ADD CONSTRAINT fkey_vl_symbol_symbolhali FOREIGN KEY (symbolhali)
 REFERENCES qgep.vl_symbol_symbolhali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_symbol_symbolvali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_symbol_symbolvali ADD CONSTRAINT pkey_qgep_vl_symbol_symbolvali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7883,7883,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7884,7884,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7885,7885,'2','2','2', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7886,7886,'3','3','3', '', '', '', 'true');
 INSERT INTO qgep.vl_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7887,7887,'4','4','4', '', '', '', 'true');
 ALTER TABLE qgep.txt_symbol ADD CONSTRAINT fkey_vl_symbol_symbolvali FOREIGN KEY (symbolvali)
 REFERENCES qgep.vl_symbol_symbolvali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_text_plantype () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_text_plantype ADD CONSTRAINT pkey_qgep_vl_text_plantype_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7844,7844,'pipeline_registry','Leitungskataster','cadastre_des_conduites_souterraines', '', '', '', 'true');
 INSERT INTO qgep.vl_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7846,7846,'overviewmap.om10','Uebersichtsplan.UeP10','plan_d_ensemble.pe10', '', '', '', 'true');
 INSERT INTO qgep.vl_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7847,7847,'overviewmap.om2','Uebersichtsplan.UeP2','plan_d_ensemble.pe5', '', '', '', 'true');
 INSERT INTO qgep.vl_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7848,7848,'overviewmap.om5','Uebersichtsplan.UeP5','plan_d_ensemble.pe2', '', '', '', 'true');
 INSERT INTO qgep.vl_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7845,7845,'network_plan','Werkplan','plan_de_reseau', '', '', '', 'true');
 ALTER TABLE qgep.txt_text ADD CONSTRAINT fkey_vl_text_plantype FOREIGN KEY (plantype)
 REFERENCES qgep.vl_text_plantype (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_text_texthali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_text_texthali ADD CONSTRAINT pkey_qgep_vl_text_texthali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7850,7850,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7851,7851,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7852,7852,'2','2','2', '', '', '', 'true');
 ALTER TABLE qgep.txt_text ADD CONSTRAINT fkey_vl_text_texthali FOREIGN KEY (texthali)
 REFERENCES qgep.vl_text_texthali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_text_textvali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_text_textvali ADD CONSTRAINT pkey_qgep_vl_text_textvali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7853,7853,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7854,7854,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7855,7855,'2','2','2', '', '', '', 'true');
 INSERT INTO qgep.vl_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7856,7856,'3','3','3', '', '', '', 'true');
 INSERT INTO qgep.vl_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7857,7857,'4','4','4', '', '', '', 'true');
 ALTER TABLE qgep.txt_text ADD CONSTRAINT fkey_vl_text_textvali FOREIGN KEY (textvali)
 REFERENCES qgep.vl_text_textvali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_mutation_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_mutation_kind ADD CONSTRAINT pkey_qgep_vl_mutation_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_mutation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5523,5523,'created','erstellt','cree', '', '', '', 'true');
 INSERT INTO qgep.vl_mutation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5582,5582,'changed','geaendert','changee', '', '', '', 'true');
 INSERT INTO qgep.vl_mutation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5583,5583,'deleted','geloescht','effacee', '', '', '', 'true');
 ALTER TABLE qgep.od_mutation ADD CONSTRAINT fkey_vl_mutation_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_mutation_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_farm_cesspit_volume () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_farm_cesspit_volume ADD CONSTRAINT pkey_qgep_vl_farm_cesspit_volume_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_farm_cesspit_volume (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5490,5490,'own_and_third_part_operation','Eigen_und_Fremdbetrieb','exploitation_propre_et_externe', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_cesspit_volume (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5488,5488,'own_operation','Eigenbetrieb','exploitation_propre', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_cesspit_volume (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5489,5489,'third_party_operation','Fremdbetrieb','exploitation_externe', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_cesspit_volume (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5491,5491,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_farm ADD CONSTRAINT fkey_vl_farm_cesspit_volume FOREIGN KEY (cesspit_volume)
 REFERENCES qgep.vl_farm_cesspit_volume (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_farm_conformity () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_farm_conformity ADD CONSTRAINT pkey_qgep_vl_farm_conformity_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_farm_conformity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4896,4896,'conform','konform','conforme', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_conformity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4898,4898,'restoration_postponed','Sanierung_aufgeschoben','differee', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_conformity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4897,4897,'restoration_pending','Sanierung_bevorstehend','imminente', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_conformity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4895,4895,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_farm ADD CONSTRAINT fkey_vl_farm_conformity FOREIGN KEY (conformity)
 REFERENCES qgep.vl_farm_conformity (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_farm_continuance () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_farm_continuance ADD CONSTRAINT pkey_qgep_vl_farm_continuance_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_farm_continuance (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4890,4890,'not_defined','nicht_definiert','non_definie', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_continuance (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4892,4892,'improble','unwahrscheinlich','improbable', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_continuance (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4891,4891,'probable','wahrscheinlich','probable', '', '', '', 'true');
 ALTER TABLE qgep.od_farm ADD CONSTRAINT fkey_vl_farm_continuance FOREIGN KEY (continuance)
 REFERENCES qgep.vl_farm_continuance (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_farm_shepherds_hut_wastewater () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_farm_shepherds_hut_wastewater ADD CONSTRAINT pkey_qgep_vl_farm_shepherds_hut_wastewater_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_farm_shepherds_hut_wastewater (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4869,4869,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_shepherds_hut_wastewater (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4870,4870,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_shepherds_hut_wastewater (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4871,4871,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_farm ADD CONSTRAINT fkey_vl_farm_shepherds_hut_wastewater FOREIGN KEY (shepherds_hut_wastewater)
 REFERENCES qgep.vl_farm_shepherds_hut_wastewater (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_farm_stable_cattle () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_farm_stable_cattle ADD CONSTRAINT pkey_qgep_vl_farm_stable_cattle_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_farm_stable_cattle (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4875,4875,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_stable_cattle (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4876,4876,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_farm_stable_cattle (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4877,4877,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_farm ADD CONSTRAINT fkey_vl_farm_stable_cattle FOREIGN KEY (stable_cattle)
 REFERENCES qgep.vl_farm_stable_cattle (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_farm ADD COLUMN fk_building_group varchar (16);
ALTER TABLE qgep.od_farm ADD CONSTRAINT rel_farm_building_group FOREIGN KEY (fk_building_group) REFERENCES qgep.od_building_group(obj_id);
CREATE TABLE qgep.vl_building_group_connecting_obligation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_connecting_obligation ADD CONSTRAINT pkey_qgep_vl_building_group_connecting_obligation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_connecting_obligation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5484,5484,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_connecting_obligation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5485,5485,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_connecting_obligation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5486,5486,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_connecting_obligation FOREIGN KEY (connecting_obligation)
 REFERENCES qgep.vl_building_group_connecting_obligation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_building_group_connection_wwtp () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_connection_wwtp ADD CONSTRAINT pkey_qgep_vl_building_group_connection_wwtp_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_connection_wwtp (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5095,5095,'connected','angeschlossen','raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_connection_wwtp (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5096,5096,'not_connected','nicht_angeschlossen','non_raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_connection_wwtp (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5097,5097,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_connection_wwtp FOREIGN KEY (connection_wwtp)
 REFERENCES qgep.vl_building_group_connection_wwtp (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_building_group_drainage_map () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_drainage_map ADD CONSTRAINT pkey_qgep_vl_building_group_drainage_map_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_drainage_map (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4840,4840,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drainage_map (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4841,4841,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drainage_map (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4839,4839,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_drainage_map FOREIGN KEY (drainage_map)
 REFERENCES qgep.vl_building_group_drainage_map (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_building_group_drinking_water_network () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_drinking_water_network ADD CONSTRAINT pkey_qgep_vl_building_group_drinking_water_network_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_drinking_water_network (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4826,4826,'connected','angeschlossen','raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drinking_water_network (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4827,4827,'not_connected','nicht_angeschlossen','non_raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drinking_water_network (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4825,4825,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_drinking_water_network FOREIGN KEY (drinking_water_network)
 REFERENCES qgep.vl_building_group_drinking_water_network (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_building_group_drinking_water_others () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_drinking_water_others ADD CONSTRAINT pkey_qgep_vl_building_group_drinking_water_others_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_drinking_water_others (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4833,4833,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drinking_water_others (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4830,4830,'none','keine','aucune', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drinking_water_others (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4831,4831,'source','Quelle','source', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drinking_water_others (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4829,4829,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_drinking_water_others (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4832,4832,'cistern','Zisterne','citerne', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_drinking_water_others FOREIGN KEY (drinking_water_others)
 REFERENCES qgep.vl_building_group_drinking_water_others (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_building_group_electric_connection () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_electric_connection ADD CONSTRAINT pkey_qgep_vl_building_group_electric_connection_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_electric_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4836,4836,'connected','angeschlossen','raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_electric_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4837,4837,'not_connected','nicht_angeschlossen','non_raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_electric_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4835,4835,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_electric_connection FOREIGN KEY (electric_connection)
 REFERENCES qgep.vl_building_group_electric_connection (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_building_group_function () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_building_group_function ADD CONSTRAINT pkey_qgep_vl_building_group_function_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_building_group_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4823,4823,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4820,4820,'holiday_building','Feriengebaeude','uniquement_vacances', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4821,4821,'industry_craft','IndustrieGewerbe','entreprise', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4822,4822,'farm','Landwirtschaftsbetrieb','exploitation_agricole', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4818,4818,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_building_group_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4819,4819,'residential_building','Wohngebaeude','uniquement_habitation', '', '', '', 'true');
 ALTER TABLE qgep.od_building_group ADD CONSTRAINT fkey_vl_building_group_function FOREIGN KEY (function)
 REFERENCES qgep.vl_building_group_function (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_building_group ADD COLUMN fk_owner varchar (16);
ALTER TABLE qgep.od_building_group ADD CONSTRAINT rel_building_group_owner FOREIGN KEY (fk_owner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group ADD COLUMN fk_leaseholder varchar (16);
ALTER TABLE qgep.od_building_group ADD CONSTRAINT rel_building_group_leaseholder FOREIGN KEY (fk_leaseholder) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group ADD COLUMN fk_disposal varchar (16);
ALTER TABLE qgep.od_building_group ADD CONSTRAINT rel_building_group_disposal FOREIGN KEY (fk_disposal) REFERENCES qgep.od_disposal(obj_id);
ALTER TABLE qgep.od_building_group ADD COLUMN fk_leaser varchar (16);
ALTER TABLE qgep.od_building_group ADD CONSTRAINT rel_building_group_leaser FOREIGN KEY (fk_leaser) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group_baugwr ADD COLUMN fk_building_group varchar (16);
ALTER TABLE qgep.od_building_group_baugwr ADD CONSTRAINT rel_building_group_baugwr_building_group FOREIGN KEY (fk_building_group) REFERENCES qgep.od_building_group(obj_id);
CREATE TABLE qgep.vl_disposal_disposal_place_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_disposal_disposal_place_current ADD CONSTRAINT pkey_qgep_vl_disposal_disposal_place_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_disposal_disposal_place_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4949,4949,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4946,4946,'liquid_manure_application','Guelleaustrag','epandage', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6474,6474,'none','keiner','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4947,4947,'public_sewer','oeffentlicheKanalisation','canalisation_publique', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4945,4945,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4948,4948,'central_WWTP','zentraleARA','STEP_centrale', '', '', '', 'true');
 ALTER TABLE qgep.od_disposal ADD CONSTRAINT fkey_vl_disposal_disposal_place_current FOREIGN KEY (disposal_place_current)
 REFERENCES qgep.vl_disposal_disposal_place_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_disposal_disposal_place_planned () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_disposal_disposal_place_planned ADD CONSTRAINT pkey_qgep_vl_disposal_disposal_place_planned_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_disposal_disposal_place_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4954,4954,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4951,4951,'liquid_manure_application','Guelleaustrag','epandage', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6400,6400,'none','keiner','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4952,4952,'public_sewer','oeffentlicheKanalisation','canalisation_publique', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4950,4950,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_disposal_disposal_place_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4953,4953,'central_WWTP','zentraleARA','STEP_centrale', '', '', '', 'true');
 ALTER TABLE qgep.od_disposal ADD CONSTRAINT fkey_vl_disposal_disposal_place_planned FOREIGN KEY (disposal_place_planned)
 REFERENCES qgep.vl_disposal_disposal_place_planned (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_disposal ADD COLUMN fk_infiltration_installation varchar (16);
ALTER TABLE qgep.od_disposal ADD CONSTRAINT rel_disposal_infiltration_installation FOREIGN KEY (fk_infiltration_installation) REFERENCES qgep.od_infiltration_installation(obj_id);
ALTER TABLE qgep.od_disposal ADD COLUMN fk_discharge_point varchar (16);
ALTER TABLE qgep.od_disposal ADD CONSTRAINT rel_disposal_discharge_point FOREIGN KEY (fk_discharge_point) REFERENCES qgep.od_discharge_point(obj_id);
ALTER TABLE qgep.od_disposal ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_disposal ADD CONSTRAINT rel_disposal_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_sludge_treatment_stabilisation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_sludge_treatment_stabilisation ADD CONSTRAINT pkey_qgep_vl_sludge_treatment_stabilisation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (141,141,'aerob_cold','aerobkalt','aerobie_froid', '', '', '', 'true');
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (332,332,'aerobthermophil','aerobthermophil','aerobie_thermophile', '', '', '', 'true');
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (333,333,'anaerob_cold','anaerobkalt','anaerobie_froid', '', '', '', 'true');
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (334,334,'anaerob_mesophil','anaerobmesophil','anaerobie_mesophile', '', '', '', 'true');
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (335,335,'anaerob_thermophil','anaerobthermophil','anaerobie_thermophile', '', '', '', 'true');
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2994,2994,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_sludge_treatment_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3004,3004,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_sludge_treatment ADD CONSTRAINT fkey_vl_sludge_treatment_stabilisation FOREIGN KEY (stabilisation)
 REFERENCES qgep.vl_sludge_treatment_stabilisation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_sludge_treatment ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_sludge_treatment ADD CONSTRAINT rel_sludge_treatment_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id);
CREATE TABLE qgep.vl_waste_water_treatment_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_waste_water_treatment_kind ADD CONSTRAINT pkey_qgep_vl_waste_water_treatment_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_waste_water_treatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3210,3210,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_waste_water_treatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (387,387,'biological','biologisch','biologique', '', '', '', 'true');
 INSERT INTO qgep.vl_waste_water_treatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (388,388,'chemical','chemisch','chimique', '', '', '', 'true');
 INSERT INTO qgep.vl_waste_water_treatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (389,389,'filtration','Filtration','filtration', '', '', '', 'true');
 INSERT INTO qgep.vl_waste_water_treatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (366,366,'mechanical','mechanisch','mecanique', '', '', '', 'true');
 INSERT INTO qgep.vl_waste_water_treatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3076,3076,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_waste_water_treatment ADD CONSTRAINT fkey_vl_waste_water_treatment_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_waste_water_treatment_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_waste_water_treatment ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_waste_water_treatment ADD CONSTRAINT rel_waste_water_treatment_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id);
ALTER TABLE qgep.od_wwtp_energy_use ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_wwtp_energy_use ADD CONSTRAINT rel_wwtp_energy_use_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id);
CREATE TABLE qgep.vl_sector_water_body_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_sector_water_body_kind ADD CONSTRAINT pkey_qgep_vl_sector_water_body_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_sector_water_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2657,2657,'waterbody','Gewaesser','lac_ou_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_sector_water_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2729,2729,'parallel_section','ParallelerAbschnitt','troncon_parallele', '', '', '', 'true');
 INSERT INTO qgep.vl_sector_water_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2728,2728,'lake_traversal','Seetraverse','element_traversant_un_lac', '', '', '', 'true');
 INSERT INTO qgep.vl_sector_water_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2656,2656,'shore','Ufer','rives', '', '', '', 'true');
 INSERT INTO qgep.vl_sector_water_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3054,3054,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_sector_water_body ADD CONSTRAINT fkey_vl_sector_water_body_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_sector_water_body_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_sector_water_body ADD COLUMN fk_chute varchar (16);
ALTER TABLE qgep.od_sector_water_body ADD CONSTRAINT rel_sector_water_body_chute FOREIGN KEY (fk_chute) REFERENCES qgep.od_surface_water_bodies(obj_id);
CREATE TABLE qgep.vl_river_bed_control_grade_of_river () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bed_control_grade_of_river ADD CONSTRAINT pkey_qgep_vl_river_bed_control_grade_of_river_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (142,142,'none','keine','nul', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2607,2607,'moderate','maessig','moyen', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2608,2608,'heavily','stark','fort', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2609,2609,'predominantly','ueberwiegend','preponderant', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3085,3085,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2606,2606,'sporadic','vereinzelt','localise', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2610,2610,'complete','vollstaendig','total', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bed ADD CONSTRAINT fkey_vl_river_bed_control_grade_of_river FOREIGN KEY (control_grade_of_river)
 REFERENCES qgep.vl_river_bed_control_grade_of_river (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bed_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bed_kind ADD CONSTRAINT pkey_qgep_vl_river_bed_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bed_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (290,290,'hard','hart','dur', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3089,3089,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (289,289,'soft','weich','tendre', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bed ADD CONSTRAINT fkey_vl_river_bed_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_river_bed_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bed_river_control_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bed_river_control_type ADD CONSTRAINT pkey_qgep_vl_river_bed_river_control_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bed_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3481,3481,'other_impermeable','andere_dicht','autres_impermeables', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (338,338,'concrete_chequer_brick','Betongittersteine','briques_perforees_en_beton', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3479,3479,'wood','Holz','bois', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3477,3477,'no_control_structure','keine_Verbauung','aucun_amenagement', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3478,3478,'rock_fill_or_loose_boulders','Steinschuettung_Blockwurf','pierres_naturelles', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bed_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3079,3079,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bed ADD CONSTRAINT fkey_vl_river_bed_river_control_type FOREIGN KEY (river_control_type)
 REFERENCES qgep.vl_river_bed_river_control_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_river_bed ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_river_bed ADD CONSTRAINT rel_river_bed_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id);
CREATE TABLE qgep.vl_water_course_segment_algae_growth () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_algae_growth ADD CONSTRAINT pkey_qgep_vl_water_course_segment_algae_growth_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_algae_growth (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2623,2623,'none_or_marginal','kein_gering','absent_faible', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_algae_growth (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2624,2624,'moderate_to_strong','maessig_stark','moyen_fort', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_algae_growth (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2625,2625,'excessive_rampant','uebermaessig_wuchernd','tres_fort_proliferation', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_algae_growth (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3050,3050,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_algae_growth FOREIGN KEY (algae_growth)
 REFERENCES qgep.vl_water_course_segment_algae_growth (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_altitudinal_zone () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_altitudinal_zone ADD CONSTRAINT pkey_qgep_vl_water_course_segment_altitudinal_zone_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_altitudinal_zone (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (320,320,'alpine','alpin','alpin', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_altitudinal_zone (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (294,294,'foothill_zone','kollin','des_collines', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_altitudinal_zone (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (295,295,'montane','montan','montagnard', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_altitudinal_zone (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (319,319,'subalpine','subalpin','subalpin', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_altitudinal_zone (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3020,3020,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_altitudinal_zone FOREIGN KEY (altitudinal_zone)
 REFERENCES qgep.vl_water_course_segment_altitudinal_zone (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_dead_wood () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_dead_wood ADD CONSTRAINT pkey_qgep_vl_water_course_segment_dead_wood_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_dead_wood (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2629,2629,'accumulations','Ansammlungen','amas', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_dead_wood (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2631,2631,'none_or_sporadic','kein_vereinzelt','absent_localise', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_dead_wood (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3052,3052,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_dead_wood (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2630,2630,'scattered','zerstreut','dissemine', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_dead_wood FOREIGN KEY (dead_wood)
 REFERENCES qgep.vl_water_course_segment_dead_wood (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_depth_variability () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_depth_variability ADD CONSTRAINT pkey_qgep_vl_water_course_segment_depth_variability_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_depth_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2617,2617,'pronounced','ausgepraegt','prononcee', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_depth_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2619,2619,'none','keine','aucune', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_depth_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2618,2618,'moderate','maessig','moyenne', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_depth_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3049,3049,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_depth_variability FOREIGN KEY (depth_variability)
 REFERENCES qgep.vl_water_course_segment_depth_variability (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_discharge_regime () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_discharge_regime ADD CONSTRAINT pkey_qgep_vl_water_course_segment_discharge_regime_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_discharge_regime (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (297,297,'compromised','beeintraechtigt','modifie', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_discharge_regime (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (428,428,'artificial','kuenstlich','artificiel', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_discharge_regime (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (427,427,'hardly_natural','naturfern','peu_naturel', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_discharge_regime (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (296,296,'close_to_natural','naturnah','presque_naturel', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_discharge_regime (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3091,3091,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_discharge_regime FOREIGN KEY (discharge_regime)
 REFERENCES qgep.vl_water_course_segment_discharge_regime (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_ecom_classification () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_ecom_classification ADD CONSTRAINT pkey_qgep_vl_water_course_segment_ecom_classification_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_ecom_classification (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3496,3496,'covered','eingedolt','mis_sous_terre', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_ecom_classification (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3495,3495,'artificial','kuenstlich_naturfremd','artificiel_peu_naturel', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_ecom_classification (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3492,3492,'natural_or_seminatural','natuerlich_naturnah','naturel_presque_naturel', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_ecom_classification (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3491,3491,'not_classified','nicht_klassiert','pas_classifie', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_ecom_classification (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3494,3494,'heavily_compromised','stark_beeintraechtigt','fortement_modifie', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_ecom_classification (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3493,3493,'partially_compromised','wenig_beeintraechtigt','peu_modifie', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_ecom_classification FOREIGN KEY (ecom_classification)
 REFERENCES qgep.vl_water_course_segment_ecom_classification (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_kind ADD CONSTRAINT pkey_qgep_vl_water_course_segment_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2710,2710,'covered','eingedolt','mis_sous_terre', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2709,2709,'open','offen','ouvert', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3058,3058,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_water_course_segment_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_length_profile () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_length_profile ADD CONSTRAINT pkey_qgep_vl_water_course_segment_length_profile_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_length_profile (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (97,97,'downwelling','kaskadenartig','avec_des_cascades', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_length_profile (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3602,3602,'rapids_or_potholes','Schnellen_Kolke','avec_rapides_marmites', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_length_profile (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (99,99,'continuous','stetig','continu', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_length_profile (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3035,3035,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_length_profile FOREIGN KEY (length_profile)
 REFERENCES qgep.vl_water_course_segment_length_profile (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_macrophyte_coverage () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_macrophyte_coverage ADD CONSTRAINT pkey_qgep_vl_water_course_segment_macrophyte_coverage_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_macrophyte_coverage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2626,2626,'none_or_marginal','kein_gering','absent_faible', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_macrophyte_coverage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2627,2627,'moderate_to_strong','maessig_stark','moyen_fort', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_macrophyte_coverage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2628,2628,'excessive_rampant','uebermaessig_wuchernd','tres_fort_proliferation', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_macrophyte_coverage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3051,3051,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_macrophyte_coverage FOREIGN KEY (macrophyte_coverage)
 REFERENCES qgep.vl_water_course_segment_macrophyte_coverage (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_section_morphology () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_section_morphology ADD CONSTRAINT pkey_qgep_vl_water_course_segment_section_morphology_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_section_morphology (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4575,4575,'straight','gerade','rectiligne', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_section_morphology (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4580,4580,'moderately_bent','leichtbogig','legerement_incurve', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_section_morphology (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4579,4579,'meandering','maeandrierend','en_meandres', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_section_morphology (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4578,4578,'heavily_bent','starkbogig','fortement_incurve', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_section_morphology (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4576,4576,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_section_morphology FOREIGN KEY (section_morphology)
 REFERENCES qgep.vl_water_course_segment_section_morphology (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_slope () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_slope ADD CONSTRAINT pkey_qgep_vl_water_course_segment_slope_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_slope (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (291,291,'shallow_dipping','flach','plat', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_slope (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (292,292,'moderate_slope','mittel','moyen', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_slope (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (293,293,'steep','steil','raide', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_slope (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3019,3019,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_slope FOREIGN KEY (slope)
 REFERENCES qgep.vl_water_course_segment_slope (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_utilisation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_utilisation ADD CONSTRAINT pkey_qgep_vl_water_course_segment_utilisation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_utilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (384,384,'recreation','Erholung','detente', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_utilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (429,429,'fishing','Fischerei','peche', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_utilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (385,385,'dam','Stauanlage','installation_de_retenue', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_utilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3039,3039,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_utilisation FOREIGN KEY (utilisation)
 REFERENCES qgep.vl_water_course_segment_utilisation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_water_hardness () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_water_hardness ADD CONSTRAINT pkey_qgep_vl_water_course_segment_water_hardness_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_water_hardness (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (321,321,'limestone','Kalk','calcaire', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_water_hardness (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (322,322,'silicate','Silikat','silicieuse', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_water_hardness (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3024,3024,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_water_hardness FOREIGN KEY (water_hardness)
 REFERENCES qgep.vl_water_course_segment_water_hardness (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_water_course_segment_width_variability () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_course_segment_width_variability ADD CONSTRAINT pkey_qgep_vl_water_course_segment_width_variability_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_course_segment_width_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (176,176,'pronounced','ausgepraegt','prononcee', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_width_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (177,177,'limited','eingeschraenkt','limitee', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_width_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (178,178,'none','keine','nulle', '', '', '', 'true');
 INSERT INTO qgep.vl_water_course_segment_width_variability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3078,3078,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT fkey_vl_water_course_segment_width_variability FOREIGN KEY (width_variability)
 REFERENCES qgep.vl_water_course_segment_width_variability (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_water_course_segment ADD COLUMN fk_watercourse varchar (16);
ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT rel_water_course_segment_watercourse FOREIGN KEY (fk_watercourse) REFERENCES qgep.od_river(obj_id);
ALTER TABLE qgep.od_bathing_area ADD COLUMN fk_chute varchar (16);
ALTER TABLE qgep.od_bathing_area ADD CONSTRAINT rel_bathing_area_chute FOREIGN KEY (fk_chute) REFERENCES qgep.od_surface_water_bodies(obj_id);
ALTER TABLE qgep.od_water_control_structure ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_water_control_structure ADD CONSTRAINT rel_water_control_structure_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id);
CREATE TABLE qgep.vl_water_catchment_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_catchment_kind ADD CONSTRAINT pkey_qgep_vl_water_catchment_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_catchment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (24,24,'process_water','Brauchwasser','eau_industrielle', '', '', '', 'true');
 INSERT INTO qgep.vl_water_catchment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (25,25,'drinking_water','Trinkwasser','eau_potable', '', '', '', 'true');
 INSERT INTO qgep.vl_water_catchment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3075,3075,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT fkey_vl_water_catchment_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_water_catchment_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_water_catchment ADD COLUMN fk_aquifier varchar (16);
ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT rel_water_catchment_aquifier FOREIGN KEY (fk_aquifier) REFERENCES qgep.od_aquifier(obj_id);
ALTER TABLE qgep.od_water_catchment ADD COLUMN fk_chute varchar (16);
ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT rel_water_catchment_chute FOREIGN KEY (fk_chute) REFERENCES qgep.od_surface_water_bodies(obj_id);
ALTER TABLE qgep.od_fish_pass ADD COLUMN fk_water_control_structure varchar (16);
ALTER TABLE qgep.od_fish_pass ADD CONSTRAINT rel_fish_pass_water_control_structure FOREIGN KEY (fk_water_control_structure) REFERENCES qgep.od_water_control_structure(obj_id);
CREATE TABLE qgep.vl_river_bank_control_grade_of_river () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bank_control_grade_of_river ADD CONSTRAINT pkey_qgep_vl_river_bank_control_grade_of_river_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (341,341,'none','keine','nul', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2612,2612,'moderate','maessig','moyen', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2613,2613,'strong','stark','fort', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2614,2614,'predominantly','ueberwiegend','preponderant', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3026,3026,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2611,2611,'sporadic','vereinzelt','localise', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_control_grade_of_river (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2615,2615,'complete','vollstaendig','total', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bank ADD CONSTRAINT fkey_vl_river_bank_control_grade_of_river FOREIGN KEY (control_grade_of_river)
 REFERENCES qgep.vl_river_bank_control_grade_of_river (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bank_river_control_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bank_river_control_type ADD CONSTRAINT pkey_qgep_vl_river_bank_river_control_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3489,3489,'other_impermeable','andere_dicht','autres_impermeables', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3486,3486,'concrete_chequer_brick_impermeable','Betongitterstein_dicht','brique_perforee_en_beton_impermeable', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3485,3485,'wood_permeable','Holz_durchlaessig','bois_permeable', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3482,3482,'no_control_structure','keine_Verbauung','aucun_amenagement', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3483,3483,'living_control_structure_permeable','Lebendverbau_durchlaessig','materiau_vegetal_permeable', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3488,3488,'wall_impermeable','Mauer_dicht','mur_impermeable', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3487,3487,'natural_stone_impermeable','Naturstein_dicht','pierre_naturelle_impermeable', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3484,3484,'loose_natural_stone_permeable','Naturstein_locker_durchlaessig','pierre_naturelle_lache', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_river_control_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3080,3080,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bank ADD CONSTRAINT fkey_vl_river_bank_river_control_type FOREIGN KEY (river_control_type)
 REFERENCES qgep.vl_river_bank_river_control_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bank_shores () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bank_shores ADD CONSTRAINT pkey_qgep_vl_river_bank_shores_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bank_shores (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (404,404,'inappropriate_to_river','gewaesserfremd','atypique_d_un_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_shores (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (403,403,'appropriate_to_river','gewaessergerecht','typique_d_un_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_shores (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (405,405,'artificial','kuenstlich','artificielle', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_shores (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3081,3081,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bank ADD CONSTRAINT fkey_vl_river_bank_shores FOREIGN KEY (shores)
 REFERENCES qgep.vl_river_bank_shores (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bank_side () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bank_side ADD CONSTRAINT pkey_qgep_vl_river_bank_side_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bank_side (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (420,420,'left','links','gauche', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_side (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (421,421,'right','rechts','droite', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_side (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3065,3065,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bank ADD CONSTRAINT fkey_vl_river_bank_side FOREIGN KEY (side)
 REFERENCES qgep.vl_river_bank_side (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bank_utilisation_of_shore_surroundings () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bank_utilisation_of_shore_surroundings ADD CONSTRAINT pkey_qgep_vl_river_bank_utilisation_of_shore_surroundings_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bank_utilisation_of_shore_surroundings (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (424,424,'developed_area','Bebauungen','constructions', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_utilisation_of_shore_surroundings (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (425,425,'grassland','Gruenland','espaces_verts', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_utilisation_of_shore_surroundings (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3068,3068,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_utilisation_of_shore_surroundings (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (426,426,'forest','Wald','foret', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bank ADD CONSTRAINT fkey_vl_river_bank_utilisation_of_shore_surroundings FOREIGN KEY (utilisation_of_shore_surroundings)
 REFERENCES qgep.vl_river_bank_utilisation_of_shore_surroundings (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_river_bank_vegetation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_bank_vegetation ADD CONSTRAINT pkey_qgep_vl_river_bank_vegetation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_bank_vegetation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (325,325,'missing','fehlend','absente', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_vegetation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (323,323,'typical_for_habitat','standorttypisch','typique_du_lieu', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_vegetation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (324,324,'atypical_for_habitat','standortuntypisch','non_typique_du_lieu', '', '', '', 'true');
 INSERT INTO qgep.vl_river_bank_vegetation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3025,3025,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_river_bank ADD CONSTRAINT fkey_vl_river_bank_vegetation FOREIGN KEY (vegetation)
 REFERENCES qgep.vl_river_bank_vegetation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_river_bank ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_river_bank ADD CONSTRAINT rel_river_bank_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id);
CREATE TABLE qgep.vl_damage_single_damage_class () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_damage_single_damage_class ADD CONSTRAINT pkey_qgep_vl_damage_single_damage_class_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_damage_single_damage_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3707,3707,'EZ0','EZ0','EZ0', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_single_damage_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3708,3708,'EZ1','EZ1','EZ1', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_single_damage_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3709,3709,'EZ2','EZ2','EZ2', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_single_damage_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3710,3710,'EZ3','EZ3','EZ3', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_single_damage_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3711,3711,'EZ4','EZ4','EZ4', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_single_damage_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4561,4561,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_damage ADD CONSTRAINT fkey_vl_damage_single_damage_class FOREIGN KEY (single_damage_class)
 REFERENCES qgep.vl_damage_single_damage_class (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_damage ADD COLUMN fk_examination varchar (16);
ALTER TABLE qgep.od_damage ADD CONSTRAINT rel_damage_examination FOREIGN KEY (fk_examination) REFERENCES qgep.od_examination(obj_id);
ALTER TABLE qgep.od_hydr_geom_relation ADD COLUMN fk_hydr_geometry varchar (16);
ALTER TABLE qgep.od_hydr_geom_relation ADD CONSTRAINT rel_hydr_geom_relation_hydr_geometry FOREIGN KEY (fk_hydr_geometry) REFERENCES qgep.od_hydr_geometry(obj_id);
CREATE TABLE qgep.vl_pipe_profile_profile_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_pipe_profile_profile_type ADD CONSTRAINT pkey_qgep_vl_pipe_profile_profile_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3351,3351,'egg','Eiprofil','ovoide', 'E', 'E', 'OV', 'true');
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3350,3350,'circle','Kreisprofil','circulaire', 'CI', 'K', 'CI', 'true');
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3352,3352,'mouth','Maulprofil','profil_en_voute', 'M', 'M', 'V', 'true');
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3354,3354,'open','offenes_Profil','profil_ouvert', 'OP', 'OP', 'PO', 'true');
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3353,3353,'rectangular','Rechteckprofil','rectangulaire', 'R', 'R', 'R', 'true');
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3355,3355,'special','Spezialprofil','profil_special', 'S', 'S', 'PS', 'true');
 INSERT INTO qgep.vl_pipe_profile_profile_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3357,3357,'unknown','unbekannt','inconnu', 'U', 'U', 'I', 'true');
 ALTER TABLE qgep.od_pipe_profile ADD CONSTRAINT fkey_vl_pipe_profile_profile_type FOREIGN KEY (profile_type)
 REFERENCES qgep.vl_pipe_profile_profile_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_wastewater_networkelement ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_wastewater_networkelement ADD CONSTRAINT rel_wastewater_networkelement_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
ALTER TABLE qgep.od_hq_relation ADD COLUMN fk_overflow_characteristic varchar (16);
ALTER TABLE qgep.od_hq_relation ADD CONSTRAINT rel_hq_relation_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id);
ALTER TABLE qgep.od_accident ADD COLUMN fk_hazard_source varchar (16);
ALTER TABLE qgep.od_accident ADD CONSTRAINT rel_accident_hazard_source FOREIGN KEY (fk_hazard_source) REFERENCES qgep.od_hazard_source(obj_id);
CREATE TABLE qgep.vl_log_card_information_source () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_log_card_information_source ADD CONSTRAINT pkey_qgep_vl_log_card_information_source_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_log_card_information_source (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5601,5601,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_log_card_information_source (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5604,5604,'gwdp_wwtp_catchment_area','GEP_ARA_Einzugsgebiet','bassin_versant_STEP', '', '', '', 'true');
 INSERT INTO qgep.vl_log_card_information_source (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5602,5602,'gwdp_responsible_body','GEP_Traegerschaft','entite_responsable_PGEE', '', '', '', 'true');
 INSERT INTO qgep.vl_log_card_information_source (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5603,5603,'unknown','unbekannt','inconnue', '', '', '', 'true');
 ALTER TABLE qgep.od_log_card ADD CONSTRAINT fkey_vl_log_card_information_source FOREIGN KEY (information_source)
 REFERENCES qgep.vl_log_card_information_source (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_log_card ADD COLUMN fk_pwwf_wasterwater_node varchar (16);
ALTER TABLE qgep.od_log_card ADD CONSTRAINT rel_log_card_pwwf_wasterwater_node FOREIGN KEY (fk_pwwf_wasterwater_node) REFERENCES qgep.od_wastewater_node(obj_id);
ALTER TABLE qgep.od_log_card ADD COLUMN fk_main_structure varchar (16);
ALTER TABLE qgep.od_log_card ADD CONSTRAINT rel_log_card_main_structure FOREIGN KEY (fk_main_structure) REFERENCES qgep.od_wastewater_node(obj_id);
ALTER TABLE qgep.od_log_card ADD COLUMN fk_main_cover varchar (16);
ALTER TABLE qgep.od_log_card ADD CONSTRAINT rel_log_card_main_cover FOREIGN KEY (fk_main_cover) REFERENCES qgep.od_cover(obj_id);
ALTER TABLE qgep.od_log_card ADD COLUMN fk_company varchar (16);
ALTER TABLE qgep.od_log_card ADD CONSTRAINT rel_log_card_company FOREIGN KEY (fk_company) REFERENCES qgep.od_organisation(obj_id);
CREATE TABLE qgep.vl_overflow_characteristic_kind_overflow_characteristic () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_characteristic_kind_overflow_characteristic ADD CONSTRAINT pkey_qgep_vl_overflow_characteristic_kind_overflow_characteristic_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_characteristic_kind_overflow_characteristic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6220,6220,'hq','HQ','HQ', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_characteristic_kind_overflow_characteristic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6221,6221,'qq','QQ','QQ', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_characteristic_kind_overflow_characteristic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6228,6228,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow_characteristic ADD CONSTRAINT fkey_vl_overflow_characteristic_kind_overflow_characteristic FOREIGN KEY (kind_overflow_characteristic)
 REFERENCES qgep.vl_overflow_characteristic_kind_overflow_characteristic (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_overflow_characteristic_overflow_characteristic_digital () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_characteristic_overflow_characteristic_digital ADD CONSTRAINT pkey_qgep_vl_overflow_characteristic_overflow_characteristic_digital_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_characteristic_overflow_characteristic_digital (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6223,6223,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_characteristic_overflow_characteristic_digital (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6224,6224,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_characteristic_overflow_characteristic_digital (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6225,6225,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow_characteristic ADD CONSTRAINT fkey_vl_overflow_characteristic_overflow_characteristic_digital FOREIGN KEY (overflow_characteristic_digital)
 REFERENCES qgep.vl_overflow_characteristic_overflow_characteristic_digital (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_data_media_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_data_media_kind ADD CONSTRAINT pkey_qgep_vl_data_media_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3784,3784,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3785,3785,'CD','CD','CD', '', '', '', 'true');
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3786,3786,'floppy_disc','Diskette','disquette', '', '', '', 'true');
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3787,3787,'dvd','DVD','DVD', '', '', '', 'true');
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3788,3788,'harddisc','Festplatte','disque_dur', '', '', '', 'true');
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3789,3789,'server','Server','serveur', '', '', '', 'true');
 INSERT INTO qgep.vl_data_media_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3790,3790,'videotape','Videoband','bande_video', '', '', '', 'true');
 ALTER TABLE qgep.od_data_media ADD CONSTRAINT fkey_vl_data_media_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_data_media_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_structure_part_renovation_demand () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_structure_part_renovation_demand ADD CONSTRAINT pkey_qgep_vl_structure_part_renovation_demand_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_structure_part_renovation_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (138,138,'not_necessary','nicht_notwendig','pas_necessaire', 'NN', 'NN', 'PN', 'true');
 INSERT INTO qgep.vl_structure_part_renovation_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (137,137,'necessary','notwendig','necessaire', 'N', 'N', 'N', 'true');
 INSERT INTO qgep.vl_structure_part_renovation_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5358,5358,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_structure_part ADD CONSTRAINT fkey_vl_structure_part_renovation_demand FOREIGN KEY (renovation_demand)
 REFERENCES qgep.vl_structure_part_renovation_demand (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_structure_part ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_structure_part ADD CONSTRAINT rel_structure_part_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_wastewater_structure_accessibility () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_accessibility ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_accessibility_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_accessibility (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3444,3444,'covered','ueberdeckt','couvert', '', 'UED', 'CO', 'true');
 INSERT INTO qgep.vl_wastewater_structure_accessibility (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3447,3447,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_wastewater_structure_accessibility (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3446,3446,'inaccessible','unzugaenglich','inaccessible', '', 'UZG', 'NA', 'true');
 INSERT INTO qgep.vl_wastewater_structure_accessibility (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3445,3445,'accessible','zugaenglich','accessible', '', 'ZG', 'A', 'true');
 ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT fkey_vl_wastewater_structure_accessibility FOREIGN KEY (accessibility)
 REFERENCES qgep.vl_wastewater_structure_accessibility (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_financing () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_financing ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_financing_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_financing (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5510,5510,'public','oeffentlich','public', 'PU', 'OE', 'PU', 'true');
 INSERT INTO qgep.vl_wastewater_structure_financing (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5511,5511,'private','privat','prive', 'PR', 'PR', 'PR', 'true');
 INSERT INTO qgep.vl_wastewater_structure_financing (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5512,5512,'unknown','unbekannt','inconnu', 'U', 'U', 'I', 'true');
 ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT fkey_vl_wastewater_structure_financing FOREIGN KEY (financing)
 REFERENCES qgep.vl_wastewater_structure_financing (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_renovation_necessity () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_renovation_necessity ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_renovation_necessity_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_renovation_necessity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5370,5370,'urgent','dringend','urgente', 'UR', 'DR', 'UR', 'true');
 INSERT INTO qgep.vl_wastewater_structure_renovation_necessity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5368,5368,'none','keiner','aucune', 'N', 'K', 'AN', 'true');
 INSERT INTO qgep.vl_wastewater_structure_renovation_necessity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2,2,'short_term','kurzfristig','a_court_terme', 'ST', 'KF', 'CT', 'true');
 INSERT INTO qgep.vl_wastewater_structure_renovation_necessity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4,4,'long_term','langfristig','a_long_terme', 'LT', 'LF', 'LT', 'true');
 INSERT INTO qgep.vl_wastewater_structure_renovation_necessity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3,3,'medium_term','mittelfristig','a_moyen_terme', '', 'MF', 'MT', 'true');
 INSERT INTO qgep.vl_wastewater_structure_renovation_necessity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5369,5369,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT fkey_vl_wastewater_structure_renovation_necessity FOREIGN KEY (renovation_necessity)
 REFERENCES qgep.vl_wastewater_structure_renovation_necessity (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_rv_construction_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_rv_construction_type ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_rv_construction_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_rv_construction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4602,4602,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_rv_construction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4603,4603,'field','Feld','dans_les_champs', 'FI', 'FE', 'FE', 'true');
 INSERT INTO qgep.vl_wastewater_structure_rv_construction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4606,4606,'renovation_conduction_excavator','Sanierungsleitung_Bagger','conduite_d_assainissement_retro', 'RCE', 'SBA', 'CAR', 'true');
 INSERT INTO qgep.vl_wastewater_structure_rv_construction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4605,4605,'renovation_conduction_ditch_cutter','Sanierungsleitung_Grabenfraese','conduite_d_assainissement_trancheuse', 'RCD', 'SGF', 'CAT', 'true');
 INSERT INTO qgep.vl_wastewater_structure_rv_construction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4604,4604,'road','Strasse','sous_route', 'ST', 'ST', 'ST', 'true');
 INSERT INTO qgep.vl_wastewater_structure_rv_construction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4601,4601,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT fkey_vl_wastewater_structure_rv_construction_type FOREIGN KEY (rv_construction_type)
 REFERENCES qgep.vl_wastewater_structure_rv_construction_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_status () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_status ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_status_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3633,3633,'inoperative','ausser_Betrieb','hors_service', 'NO', 'AB', 'H', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (8493,8493,'operational','in_Betrieb','en_service', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6530,6530,'operational.tentative','in_Betrieb.provisorisch','en_service.provisoire', 'T', 'T', 'P', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6533,6533,'operational.will_be_suspended','in_Betrieb.wird_aufgehoben','en_service.sera_supprime', '', 'WA', 'SS', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6523,6523,'abanndoned.suspended_not_filled','tot.aufgehoben_nicht_verfuellt','abandonne.supprime_non_demoli', 'SN', 'AN', 'S', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6524,6524,'abanndoned.suspended_unknown','tot.aufgehoben_unbekannt','abandonne.supprime_inconnu', 'SU', 'AU', 'AI', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6532,6532,'abanndoned.filled','tot.verfuellt','abandonne.demoli', '', 'V', 'D', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3027,3027,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6526,6526,'other.calculation_alternative','weitere.Berechnungsvariante','autre.variante_de_calcul', 'CA', 'B', 'C', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7959,7959,'other.planned','weitere.geplant','autre.planifie', '', 'G', 'PL', 'true');
 INSERT INTO qgep.vl_wastewater_structure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6529,6529,'other.project','weitere.Projekt','autre.projet', '', 'N', 'PR', 'true');
 ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT fkey_vl_wastewater_structure_status FOREIGN KEY (status)
 REFERENCES qgep.vl_wastewater_structure_status (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_structure_condition () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_structure_condition ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_structure_condition_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_structure_condition (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3037,3037,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_wastewater_structure_structure_condition (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3363,3363,'Z0','Z0','Z0', '', 'Z0', 'Z0', 'true');
 INSERT INTO qgep.vl_wastewater_structure_structure_condition (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3359,3359,'Z1','Z1','Z1', '', 'Z1', 'Z1', 'true');
 INSERT INTO qgep.vl_wastewater_structure_structure_condition (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3360,3360,'Z2','Z2','Z2', '', 'Z2', 'Z2', 'true');
 INSERT INTO qgep.vl_wastewater_structure_structure_condition (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3361,3361,'Z3','Z3','Z3', '', 'Z3', 'Z3', 'true');
 INSERT INTO qgep.vl_wastewater_structure_structure_condition (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3362,3362,'Z4','Z4','Z4', '', 'Z4', 'Z4', 'true');
 ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT fkey_vl_wastewater_structure_structure_condition FOREIGN KEY (structure_condition)
 REFERENCES qgep.vl_wastewater_structure_structure_condition (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_wastewater_structure ADD COLUMN fk_owner varchar (16);
ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT rel_wastewater_structure_owner FOREIGN KEY (fk_owner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_structure ADD COLUMN fk_operator varchar (16);
ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT rel_wastewater_structure_operator FOREIGN KEY (fk_operator) REFERENCES qgep.od_organisation(obj_id);
CREATE TABLE qgep.vl_maintenance_event_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_maintenance_event_kind ADD CONSTRAINT pkey_qgep_vl_maintenance_event_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2982,2982,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (120,120,'replacement','Erneuerung','renouvellement', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (28,28,'cleaning','Reinigung','nettoyage', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4529,4529,'renovation','Renovierung','renovation', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4528,4528,'repair','Reparatur','reparation', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4530,4530,'restoration','Sanierung','rehabilitation', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3045,3045,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4564,4564,'inspection','Untersuchung','examen', '', '', '', 'true');
 ALTER TABLE qgep.od_maintenance_event ADD CONSTRAINT fkey_vl_maintenance_event_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_maintenance_event_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_maintenance_event_status () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_maintenance_event_status ADD CONSTRAINT pkey_qgep_vl_maintenance_event_status_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_maintenance_event_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2550,2550,'accomplished','ausgefuehrt','execute', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2549,2549,'planned','geplant','prevu', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3678,3678,'not_possible','nicht_moeglich','impossible', '', '', '', 'true');
 INSERT INTO qgep.vl_maintenance_event_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3047,3047,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_maintenance_event ADD CONSTRAINT fkey_vl_maintenance_event_status FOREIGN KEY (status)
 REFERENCES qgep.vl_maintenance_event_status (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_maintenance_event ADD COLUMN fk_operator_company varchar (16);
ALTER TABLE qgep.od_maintenance_event ADD CONSTRAINT rel_maintenance_event_operator_company FOREIGN KEY (fk_operator_company) REFERENCES qgep.od_organisation(obj_id);
CREATE TABLE qgep.vl_hydraulic_characteristic_data_is_overflowing () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_hydraulic_characteristic_data_is_overflowing ADD CONSTRAINT pkey_qgep_vl_hydraulic_characteristic_data_is_overflowing_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_hydraulic_characteristic_data_is_overflowing (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5774,5774,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_is_overflowing (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5775,5775,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_is_overflowing (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5778,5778,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT fkey_vl_hydraulic_characteristic_data_is_overflowing FOREIGN KEY (is_overflowing)
 REFERENCES qgep.vl_hydraulic_characteristic_data_is_overflowing (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_hydraulic_characteristic_data_main_weir_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_hydraulic_characteristic_data_main_weir_kind ADD CONSTRAINT pkey_qgep_vl_hydraulic_characteristic_data_main_weir_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_hydraulic_characteristic_data_main_weir_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6422,6422,'leapingweir','Leapingwehr','LEAPING_WEIR', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_main_weir_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6420,6420,'spillway_raised','Streichwehr_hochgezogen','deversoir_lateral_a_seuil_sureleve', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_main_weir_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6421,6421,'spillway_low','Streichwehr_niedrig','deversoir_lateral_a_seuil_abaisse', '', '', '', 'true');
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT fkey_vl_hydraulic_characteristic_data_main_weir_kind FOREIGN KEY (main_weir_kind)
 REFERENCES qgep.vl_hydraulic_characteristic_data_main_weir_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_hydraulic_characteristic_data_pump_characteristics () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_hydraulic_characteristic_data_pump_characteristics ADD CONSTRAINT pkey_qgep_vl_hydraulic_characteristic_data_pump_characteristics_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_characteristics (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6374,6374,'alternating','alternierend','alterne', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_characteristics (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6375,6375,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_characteristics (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6376,6376,'single','einzeln','individuel', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_characteristics (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6377,6377,'parallel','parallel','parallele', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_characteristics (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6378,6378,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT fkey_vl_hydraulic_characteristic_data_pump_characteristics FOREIGN KEY (pump_characteristics)
 REFERENCES qgep.vl_hydraulic_characteristic_data_pump_characteristics (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_hydraulic_characteristic_data_pump_usage_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_hydraulic_characteristic_data_pump_usage_current ADD CONSTRAINT pkey_qgep_vl_hydraulic_characteristic_data_pump_usage_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6361,6361,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6362,6362,'creek_water','Bachwasser','eaux_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6363,6363,'discharged_combined_wastewater','entlastetes_Mischabwasser','eaux_mixtes_deversees', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6364,6364,'industrial_wastewater','Industrieabwasser','eaux_industrielles', '', 'CW', 'EUC', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6365,6365,'combined_wastewater','Mischabwasser','eaux_mixtes', '', 'MW', 'EUM', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6366,6366,'rain_wastewater','Regenabwasser','eaux_pluviales', '', 'RW', 'EUP', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6367,6367,'clean_wastewater','Reinabwasser','eaux_claires', '', 'KW', 'EUR', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6368,6368,'wastewater','Schmutzabwasser','eaux_usees', '', 'SW', 'EU', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6369,6369,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT fkey_vl_hydraulic_characteristic_data_pump_usage_current FOREIGN KEY (pump_usage_current)
 REFERENCES qgep.vl_hydraulic_characteristic_data_pump_usage_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_hydraulic_characteristic_data_status () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_hydraulic_characteristic_data_status ADD CONSTRAINT pkey_qgep_vl_hydraulic_characteristic_data_status_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_hydraulic_characteristic_data_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6371,6371,'planned','geplant','prevu', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6372,6372,'current','Ist','actuel', '', '', '', 'true');
 INSERT INTO qgep.vl_hydraulic_characteristic_data_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6373,6373,'current_optimized','Ist_optimiert','actuel_opt', '', '', '', 'true');
 ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT fkey_vl_hydraulic_characteristic_data_status FOREIGN KEY (status)
 REFERENCES qgep.vl_hydraulic_characteristic_data_status (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN fk_wastewater_node varchar (16);
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT rel_hydraulic_characteristic_data_wastewater_node FOREIGN KEY (fk_wastewater_node) REFERENCES qgep.od_wastewater_node(obj_id);
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD COLUMN fk_overflow_characteristic varchar (16);
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT rel_hydraulic_characteristic_data_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id);
CREATE TABLE qgep.vl_retention_body_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_retention_body_kind ADD CONSTRAINT pkey_qgep_vl_retention_body_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_retention_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2992,2992,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_retention_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (346,346,'retention_in_habitat','Biotop','retention_dans_bassins_et_depressions', '', '', '', 'true');
 INSERT INTO qgep.vl_retention_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (345,345,'roof_retention','Dachretention','retention_sur_toits', '', '', '', 'true');
 INSERT INTO qgep.vl_retention_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (348,348,'parking_lot','Parkplatz','retention_sur_routes_et_places', '', '', '', 'true');
 INSERT INTO qgep.vl_retention_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (347,347,'accumulation_channel','Staukanal','retention_dans_canalisations_stockage', '', '', '', 'true');
 INSERT INTO qgep.vl_retention_body_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3031,3031,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_retention_body ADD CONSTRAINT fkey_vl_retention_body_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_retention_body_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_retention_body ADD COLUMN fk_infiltration_installation varchar (16);
ALTER TABLE qgep.od_retention_body ADD CONSTRAINT rel_retention_body_infiltration_installation FOREIGN KEY (fk_infiltration_installation) REFERENCES qgep.od_infiltration_installation(obj_id);
CREATE TABLE qgep.vl_throttle_shut_off_unit_actuation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_throttle_shut_off_unit_actuation ADD CONSTRAINT pkey_qgep_vl_throttle_shut_off_unit_actuation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3213,3213,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3154,3154,'gaz_engine','Benzinmotor','moteur_a_essence', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3155,3155,'diesel_engine','Dieselmotor','moteur_diesel', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3156,3156,'electric_engine','Elektromotor','moteur_electrique', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3152,3152,'hydraulic','hydraulisch','hydraulique', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3153,3153,'none','keiner','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3157,3157,'manual','manuell','manuel', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3158,3158,'pneumatic','pneumatisch','pneumatique', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3151,3151,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT fkey_vl_throttle_shut_off_unit_actuation FOREIGN KEY (actuation)
 REFERENCES qgep.vl_throttle_shut_off_unit_actuation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_throttle_shut_off_unit_adjustability () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_throttle_shut_off_unit_adjustability ADD CONSTRAINT pkey_qgep_vl_throttle_shut_off_unit_adjustability_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_throttle_shut_off_unit_adjustability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3159,3159,'fixed','fest','fixe', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_adjustability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3161,3161,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_adjustability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3160,3160,'adjustable','verstellbar','reglable', '', '', '', 'true');
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT fkey_vl_throttle_shut_off_unit_adjustability FOREIGN KEY (adjustability)
 REFERENCES qgep.vl_throttle_shut_off_unit_adjustability (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_throttle_shut_off_unit_control () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_throttle_shut_off_unit_control ADD CONSTRAINT pkey_qgep_vl_throttle_shut_off_unit_control_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_throttle_shut_off_unit_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3162,3162,'closed_loop_control','geregelt','avec_regulation', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3163,3163,'open_loop_control','gesteuert','avec_commande', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3165,3165,'none','keine','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3164,3164,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT fkey_vl_throttle_shut_off_unit_control FOREIGN KEY (control)
 REFERENCES qgep.vl_throttle_shut_off_unit_control (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_throttle_shut_off_unit_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_throttle_shut_off_unit_kind ADD CONSTRAINT pkey_qgep_vl_throttle_shut_off_unit_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2973,2973,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2746,2746,'orifice','Blende','diaphragme_ou_seuil', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2691,2691,'stop_log','Dammbalken','batardeau', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (252,252,'throttle_flap','Drosselklappe','clapet_de_limitation', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (135,135,'throttle_valve','Drosselschieber','vanne_de_limitation', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6490,6490,'throttle_section','Drosselstrecke','conduite_d_etranglement', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6491,6491,'leapingweir','Leapingwehr','leaping_weir', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6492,6492,'pomp','Pumpe','pompe', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2690,2690,'backflow_flap','Rueckstauklappe','clapet_de_non_retour_a_battant', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2688,2688,'valve','Schieber','vanne', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (134,134,'tube_throttle','Schlauchdrossel','limiteur_a_membrane', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2689,2689,'sliding_valve','Schuetze','vanne_ecluse', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5755,5755,'gate_shield','Stauschild','plaque_de_retenue', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3046,3046,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (133,133,'whirl_throttle','Wirbeldrossel','limiteur_a_vortex', '', '', '', 'true');
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT fkey_vl_throttle_shut_off_unit_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_throttle_shut_off_unit_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_throttle_shut_off_unit_signal_transmission () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_throttle_shut_off_unit_signal_transmission ADD CONSTRAINT pkey_qgep_vl_throttle_shut_off_unit_signal_transmission_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_throttle_shut_off_unit_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3171,3171,'receiving','empfangen','recevoir', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3172,3172,'sending','senden','emettre', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3169,3169,'sending_receiving','senden_empfangen','emettre_recevoir', '', '', '', 'true');
 INSERT INTO qgep.vl_throttle_shut_off_unit_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3170,3170,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT fkey_vl_throttle_shut_off_unit_signal_transmission FOREIGN KEY (signal_transmission)
 REFERENCES qgep.vl_throttle_shut_off_unit_signal_transmission (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_wastewater_node varchar (16);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_throttle_shut_off_unit_wastewater_node FOREIGN KEY (fk_wastewater_node) REFERENCES qgep.od_wastewater_node(obj_id);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_control_center varchar (16);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_throttle_shut_off_unit_control_center FOREIGN KEY (fk_control_center) REFERENCES qgep.od_control_center(obj_id);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD COLUMN fk_overflow varchar (16);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_throttle_shut_off_unit_overflow FOREIGN KEY (fk_overflow) REFERENCES qgep.od_overflow(obj_id);
CREATE TABLE qgep.vl_reach_point_elevation_accuracy () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_point_elevation_accuracy ADD CONSTRAINT pkey_qgep_vl_reach_point_elevation_accuracy_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_point_elevation_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3248,3248,'more_than_6cm','groesser_6cm','plusque_6cm', '', 'G06', 'S06', 'true');
 INSERT INTO qgep.vl_reach_point_elevation_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3245,3245,'plusminus_1cm','plusminus_1cm','plus_moins_1cm', '', 'P01', 'P01', 'true');
 INSERT INTO qgep.vl_reach_point_elevation_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3246,3246,'plusminus_3cm','plusminus_3cm','plus_moins_3cm', '', 'P03', 'P03', 'true');
 INSERT INTO qgep.vl_reach_point_elevation_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3247,3247,'plusminus_6cm','plusminus_6cm','plus_moins_6cm', '', 'P06', 'P06', 'true');
 INSERT INTO qgep.vl_reach_point_elevation_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5376,5376,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_reach_point ADD CONSTRAINT fkey_vl_reach_point_elevation_accuracy FOREIGN KEY (elevation_accuracy)
 REFERENCES qgep.vl_reach_point_elevation_accuracy (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_point_outlet_shape () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_point_outlet_shape ADD CONSTRAINT pkey_qgep_vl_reach_point_outlet_shape_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_point_outlet_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5374,5374,'round_edged','abgerundet','arrondie', 'RE', 'AR', 'AR', 'true');
 INSERT INTO qgep.vl_reach_point_outlet_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (298,298,'orifice','blendenfoermig','en_forme_de_seuil_ou_diaphragme', 'O', 'BF', 'FSD', 'true');
 INSERT INTO qgep.vl_reach_point_outlet_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3358,3358,'no_cross_section_change','keine_Querschnittsaenderung','pas_de_changement_de_section', '', 'KQ', 'PCS', 'true');
 INSERT INTO qgep.vl_reach_point_outlet_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (286,286,'sharp_edged','scharfkantig','aretes_vives', '', 'SK', 'AV', 'true');
 INSERT INTO qgep.vl_reach_point_outlet_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5375,5375,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_reach_point ADD CONSTRAINT fkey_vl_reach_point_outlet_shape FOREIGN KEY (outlet_shape)
 REFERENCES qgep.vl_reach_point_outlet_shape (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_reach_point ADD COLUMN fk_wastewater_networkelement varchar (16);
ALTER TABLE qgep.od_reach_point ADD CONSTRAINT rel_reach_point_wastewater_networkelement FOREIGN KEY (fk_wastewater_networkelement) REFERENCES qgep.od_wastewater_networkelement(obj_id);
CREATE TABLE qgep.vl_mechanical_pretreatment_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_mechanical_pretreatment_kind ADD CONSTRAINT pkey_qgep_vl_mechanical_pretreatment_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_mechanical_pretreatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3317,3317,'filter_bag','Filtersack','percolateur', '', '', '', 'true');
 INSERT INTO qgep.vl_mechanical_pretreatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3319,3319,'artificial_adsorber','KuenstlicherAdsorber','adsorbeur_artificiel', '', '', '', 'true');
 INSERT INTO qgep.vl_mechanical_pretreatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3318,3318,'swale_french_drain_system','MuldenRigolenSystem','systeme_cuvettes_rigoles', '', '', '', 'true');
 INSERT INTO qgep.vl_mechanical_pretreatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3320,3320,'slurry_collector','Schlammsammler','collecteur_de_boue', '', '', '', 'true');
 INSERT INTO qgep.vl_mechanical_pretreatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3321,3321,'floating_matter_separator','Schwimmstoffabscheider','separateur_materiaux_flottants', '', '', '', 'true');
 INSERT INTO qgep.vl_mechanical_pretreatment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3322,3322,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_mechanical_pretreatment ADD CONSTRAINT fkey_vl_mechanical_pretreatment_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_mechanical_pretreatment_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN fk_infiltration_installation varchar (16);
ALTER TABLE qgep.od_mechanical_pretreatment ADD CONSTRAINT rel_mechanical_pretreatment_infiltration_installation FOREIGN KEY (fk_infiltration_installation) REFERENCES qgep.od_infiltration_installation(obj_id);
ALTER TABLE qgep.od_mechanical_pretreatment ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_mechanical_pretreatment ADD CONSTRAINT rel_mechanical_pretreatment_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
ALTER TABLE qgep.re_maintenance_event_wastewater_structure ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.re_maintenance_event_wastewater_structure ADD CONSTRAINT rel_maintenance_event_wastewater_structure_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
ALTER TABLE qgep.re_maintenance_event_wastewater_structure ADD COLUMN fk_maintenance_event varchar (16);
ALTER TABLE qgep.re_maintenance_event_wastewater_structure ADD CONSTRAINT rel_maintenance_event_wastewater_structure_maintenance_event FOREIGN KEY (fk_maintenance_event) REFERENCES qgep.od_maintenance_event(obj_id);
ALTER TABLE qgep.od_profile_geometry ADD COLUMN fk_pipe_profile varchar (16);
ALTER TABLE qgep.od_profile_geometry ADD CONSTRAINT rel_profile_geometry_pipe_profile FOREIGN KEY (fk_pipe_profile) REFERENCES qgep.od_pipe_profile(obj_id);
CREATE TABLE qgep.vl_file_class () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_file_class ADD CONSTRAINT pkey_qgep_vl_file_class_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3800,3800,'throttle_shut_off_unit','Absperr_Drosselorgan','LIMITEUR_DEBIT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3801,3801,'wastewater_structure','Abwasserbauwerk','OUVRAGE_RESEAU_AS', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3802,3802,'waster_water_treatment','Abwasserbehandlung','TRAITEMENT_EAUX_USEES', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3803,3803,'wastewater_node','Abwasserknoten','NOEUD_RESEAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3804,3804,'wastewater_networkelement','Abwassernetzelement','ELEMENT_RESEAU_EVACUATION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3805,3805,'waste_water_treatment_plant','Abwasserreinigungsanlage','STATION_EPURATION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3806,3806,'waste_water_association','Abwasserverband','ASSOCIATION_EPURATION_EAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3807,3807,'administrative_office','Amt','OFFICE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3808,3808,'connection_object','Anschlussobjekt','OBJET_RACCORDE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3809,3809,'wwtp_structure','ARABauwerk','OUVRAGES_STEP', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3810,3810,'wwtp_energy_use','ARAEnergienutzung','CONSOMMATION_ENERGIE_STEP', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3811,3811,'bathing_area','Badestelle','LIEU_BAIGNADE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3812,3812,'benching','Bankett','BANQUETTE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3813,3813,'structure_part','BauwerksTeil','ELEMENT_OUVRAGE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3814,3814,'well','Brunnen','FONTAINE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3815,3815,'file','Datei','FICHIER', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3816,3816,'data_media','Datentraeger','SUPPORT_DONNEES', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3817,3817,'cover','Deckel','COUVERCLE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3818,3818,'passage','Durchlass','PASSAGE_SOUS_TUYAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5083,5083,'discharge_point','Einleitstelle','EXUTOIRE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3819,3819,'access_aid','Einstiegshilfe','DISPOSITIF_ACCES', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3820,3820,'individual_surface','Einzelflaeche','SURFACE_INDIVIDUELLE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3821,3821,'catchment_area','Einzugsgebiet','BASSIN_VERSANT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3822,3822,'electric_equipment','ElektrischeEinrichtung','EQUIPEMENT_ELECTRIQUE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3823,3823,'electromechanical_equipment','ElektromechanischeAusruestung','EQUIPEMENT_ELECTROMECA', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3824,3824,'drainage_system','Entwaesserungssystem','systeme_evacuation_eaux', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3825,3825,'maintenance_event','Erhaltungsereignis','EVENEMENT_MAINTENANCE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3826,3826,'fish_pass','Fischpass','ECHELLE_POISSONS', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3827,3827,'river','Fliessgewaesser','COURS_EAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3828,3828,'pump','FoerderAggregat','INSTALLATION_REFOULEMENT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3829,3829,'ford','Furt','PASSAGE_A_GUE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3830,3830,'building','Gebaeude','BATIMENT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3831,3831,'hazard_source','Gefahrenquelle','SOURCE_DANGER', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3832,3832,'municipality','Gemeinde','COMMUNE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3833,3833,'blocking_debris','Geschiebesperre','BARRAGE_ALLUVIONS', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3834,3834,'water_course_segment','Gewaesserabschnitt','TRONCON_COURS_EAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3835,3835,'chute','GewaesserAbsturz','SEUIL', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3836,3836,'water_body_protection_sector','Gewaesserschutzbereich','SECTEUR_PROTECTION_EAUX', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3837,3837,'sector_water_body','Gewaessersektor','SECTEUR_EAUX_SUP', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3838,3838,'river_bed','Gewaessersohle','FOND_COURS_EAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3839,3839,'water_control_structure','Gewaesserverbauung','AMENAGEMENT_COURS_EAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3840,3840,'dam','GewaesserWehr','OUVRAGE_RETENUE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3841,3841,'aquifier','Grundwasserleiter','AQUIFERE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3842,3842,'ground_water_protection_perimeter','Grundwasserschutzareal','PERIMETRE_PROT_EAUX_SOUT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3843,3843,'groundwater_protection_zone','Grundwasserschutzzone','ZONE_PROT_EAUX_SOUT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3844,3844,'reach','Haltung','TRONCON', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3845,3845,'reach_point','Haltungspunkt','POINT_TRONCON', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3846,3846,'hq_relation','HQ_Relation','RELATION_HQ', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3847,3847,'hydr_geometry','Hydr_Geometrie','GEOMETRIE_HYDR', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3848,3848,'hydr_geom_relation','Hydr_GeomRelation','RELATION_GEOM_HYDR', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3849,3849,'channel','Kanal','CANALISATION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3850,3850,'damage_channel','Kanalschaden','DOMMAGE_AUX_CANALISATIONS', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3851,3851,'canton','Kanton','CANTON', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3852,3852,'leapingweir','Leapingwehr','LEAPING_WEIR', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3853,3853,'mechanical_pretreatment','MechanischeVorreinigung','PRETRAITEMENT_MECANIQUE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3854,3854,'measurement_device','Messgeraet','APPAREIL_MESURE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3855,3855,'measurement_series','Messreihe','SERIE_MESURES', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3856,3856,'measurement_result','Messresultat','RESULTAT_MESURE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3857,3857,'measuring_point','Messstelle','STATION_MESURE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3858,3858,'manhole','Normschacht','CHAMBRE_STANDARD', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3859,3859,'damage_manhole','Normschachtschaden','DOMMAGE_CHAMBRE_STANDARD', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3861,3861,'surface_runoff_parameters','Oberflaechenabflussparameter','PARAM_ECOULEMENT_SUP', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3862,3862,'surface_water_bodies','Oberflaechengewaesser','EAUX_SUPERFICIELLES', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3863,3863,'organisation','Organisation','ORGANISATION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3864,3864,'planning_zone','Planungszone','ZONE_RESERVEE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3865,3865,'private','Privat','PRIVE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3866,3866,'cleaning_device','Reinigungseinrichtung','DISPOSITIF_NETTOYAGE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3867,3867,'reservoir','Reservoir','RESERVOIR', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3868,3868,'retention_body','Retentionskoerper','VOLUME_RETENTION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3869,3869,'pipe_profile','Rohrprofil','PROFIL_TUYAU', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3870,3870,'profile_geometry','Rohrprofil_Geometrie','PROFIL_TUYAU_GEOM', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3871,3871,'damage','Schaden','DOMMAGE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3872,3872,'sludge_treatment','Schlammbehandlung','TRAITEMENT_BOUES', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3873,3873,'lock','Schleuse','ECLUSE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3874,3874,'lake','See','LAC', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3875,3875,'rock_ramp','Sohlrampe','RAMPE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3876,3876,'special_structure','Spezialbauwerk','OUVRAGE_SPECIAL', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3877,3877,'control_center','Steuerungszentrale','CENTRALE_COMMANDE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3878,3878,'substance','Stoff','SUBSTANCE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3879,3879,'prank_weir','Streichwehr','DEVERSOIR_LATERAL', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3880,3880,'dryweather_downspout','Trockenwetterfallrohr','TUYAU_CHUTE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3881,3881,'dryweather_flume','Trockenwetterrinne','CUNETTE_DEBIT_TEMPS_SEC', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3882,3882,'overflow','Ueberlauf','DEVERSOIR', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3883,3883,'overflow_characteristic','Ueberlaufcharakteristik','CARACTERISTIQUES_DEVERSOIR', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3884,3884,'shore','Ufer','RIVE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3885,3885,'accident','Unfall','ACCIDENT', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3886,3886,'inspection','Untersuchung','EXAMEN', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3887,3887,'infiltration_installation','Versickerungsanlage','INSTALLATION_INFILTRATION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3888,3888,'infiltration_zone','Versickerungsbereich','ZONE_INFILTRATION', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3890,3890,'water_catchment','Wasserfassung','CAPTAGE', '', '', '', 'true');
 INSERT INTO qgep.vl_file_class (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3891,3891,'zone','Zone','ZONE', '', '', '', 'true');
 ALTER TABLE qgep.od_file ADD CONSTRAINT fkey_vl_file_class FOREIGN KEY (class)
 REFERENCES qgep.vl_file_class (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_file_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_file_kind ADD CONSTRAINT pkey_qgep_vl_file_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_file_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3770,3770,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_file_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3771,3771,'digital_vidoe','digitalesVideo','video_numerique', '', '', '', 'true');
 INSERT INTO qgep.vl_file_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3772,3772,'photo','Foto','photo', '', '', '', 'true');
 INSERT INTO qgep.vl_file_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3773,3773,'panoramo_film','Panoramofilm','film_panoramique', '', '', '', 'true');
 INSERT INTO qgep.vl_file_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3774,3774,'textfile','Textdatei','fichier_texte', '', '', '', 'true');
 INSERT INTO qgep.vl_file_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3775,3775,'video','Video','video', '', '', '', 'true');
 ALTER TABLE qgep.od_file ADD CONSTRAINT fkey_vl_file_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_file_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_file ADD COLUMN fk_volume varchar (16);
ALTER TABLE qgep.od_file ADD CONSTRAINT rel_file_volume FOREIGN KEY (fk_volume) REFERENCES qgep.od_data_media(obj_id);
CREATE TABLE qgep.vl_overflow_actuation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_actuation ADD CONSTRAINT pkey_qgep_vl_overflow_actuation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3667,3667,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (301,301,'gaz_engine','Benzinmotor','moteur_a_essence', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (302,302,'diesel_engine','Dieselmotor','moteur_diesel', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (303,303,'electric_engine','Elektromotor','moteur_electrique', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (433,433,'hydraulic','hydraulisch','hydraulique', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (300,300,'none','keiner','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (305,305,'manual','manuell','manuel', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (304,304,'pneumatic','pneumatisch','pneumatique', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3005,3005,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow ADD CONSTRAINT fkey_vl_overflow_actuation FOREIGN KEY (actuation)
 REFERENCES qgep.vl_overflow_actuation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_overflow_adjustability () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_adjustability ADD CONSTRAINT pkey_qgep_vl_overflow_adjustability_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_adjustability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (355,355,'fixed','fest','fixe', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_adjustability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3021,3021,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_adjustability (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (356,356,'adjustable','verstellbar','reglable', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow ADD CONSTRAINT fkey_vl_overflow_adjustability FOREIGN KEY (adjustability)
 REFERENCES qgep.vl_overflow_adjustability (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_overflow_control () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_control ADD CONSTRAINT pkey_qgep_vl_overflow_control_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (308,308,'closed_loop_control','geregelt','avec_regulation', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (307,307,'open_loop_control','gesteuert','avec_commande', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (306,306,'none','keine','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_control (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3028,3028,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow ADD CONSTRAINT fkey_vl_overflow_control FOREIGN KEY (control)
 REFERENCES qgep.vl_overflow_control (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_overflow_function () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_function ADD CONSTRAINT pkey_qgep_vl_overflow_function_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3228,3228,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3384,3384,'internal','intern','interne', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (217,217,'emergency_overflow','Notentlastung','deversoir_de_secours', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5544,5544,'stormwater_overflow','Regenueberlauf','deversoir_d_orage', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5546,5546,'internal_overflow','Trennueberlauf','deversoir_interne', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3010,3010,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow ADD CONSTRAINT fkey_vl_overflow_function FOREIGN KEY (function)
 REFERENCES qgep.vl_overflow_function (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_overflow_signal_transmission () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_overflow_signal_transmission ADD CONSTRAINT pkey_qgep_vl_overflow_signal_transmission_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_overflow_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2694,2694,'receiving','empfangen','recevoir', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2693,2693,'sending','senden','emettre', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2695,2695,'sending_receiving','senden_empfangen','emettre_recevoir', '', '', '', 'true');
 INSERT INTO qgep.vl_overflow_signal_transmission (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3056,3056,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_overflow ADD CONSTRAINT fkey_vl_overflow_signal_transmission FOREIGN KEY (signal_transmission)
 REFERENCES qgep.vl_overflow_signal_transmission (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_overflow ADD COLUMN fk_wastewater_node varchar (16);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_wastewater_node FOREIGN KEY (fk_wastewater_node) REFERENCES qgep.od_wastewater_node(obj_id);
ALTER TABLE qgep.od_overflow ADD COLUMN fk_overflow_to varchar (16);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_overflow_to FOREIGN KEY (fk_overflow_to) REFERENCES qgep.od_wastewater_node(obj_id);
ALTER TABLE qgep.od_overflow ADD COLUMN fk_overflow_characteristic varchar (16);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_overflow_characteristic FOREIGN KEY (fk_overflow_characteristic) REFERENCES qgep.od_overflow_characteristic(obj_id);
ALTER TABLE qgep.od_overflow ADD COLUMN fk_control_center varchar (16);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_overflow_control_center FOREIGN KEY (fk_control_center) REFERENCES qgep.od_control_center(obj_id);
CREATE TABLE qgep.vl_catchment_area_direct_discharge_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_direct_discharge_current ADD CONSTRAINT pkey_qgep_vl_catchment_area_direct_discharge_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_direct_discharge_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5457,5457,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_direct_discharge_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5458,5458,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_direct_discharge_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5463,5463,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_direct_discharge_current FOREIGN KEY (direct_discharge_current)
 REFERENCES qgep.vl_catchment_area_direct_discharge_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_direct_discharge_planned () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_direct_discharge_planned ADD CONSTRAINT pkey_qgep_vl_catchment_area_direct_discharge_planned_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_direct_discharge_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5459,5459,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_direct_discharge_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5460,5460,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_direct_discharge_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5464,5464,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_direct_discharge_planned FOREIGN KEY (direct_discharge_planned)
 REFERENCES qgep.vl_catchment_area_direct_discharge_planned (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_drainage_system_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_drainage_system_current ADD CONSTRAINT pkey_qgep_vl_catchment_area_drainage_system_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_drainage_system_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5186,5186,'mixed_system','Mischsystem','systeme_unitaire', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5188,5188,'modified_system','ModifiziertesSystem','systeme_modifie', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5185,5185,'not_connected','nicht_angeschlossen','non_raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5537,5537,'not_drained','nicht_entwaessert','non_evacue', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5187,5187,'separated_system','Trennsystem','systeme_separatif', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5189,5189,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_drainage_system_current FOREIGN KEY (drainage_system_current)
 REFERENCES qgep.vl_catchment_area_drainage_system_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_drainage_system_planned () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_drainage_system_planned ADD CONSTRAINT pkey_qgep_vl_catchment_area_drainage_system_planned_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_drainage_system_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5191,5191,'mixed_system','Mischsystem','systeme_unitaire', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5193,5193,'modified_system','ModifiziertesSystem','systeme_modifie', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5194,5194,'not_connected','nicht_angeschlossen','non_raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5536,5536,'not_drained','nicht_entwaessert','non_evacue', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5192,5192,'separated_system','Trennsystem','systeme_separatif', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_drainage_system_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5195,5195,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_drainage_system_planned FOREIGN KEY (drainage_system_planned)
 REFERENCES qgep.vl_catchment_area_drainage_system_planned (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_infiltration_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_infiltration_current ADD CONSTRAINT pkey_qgep_vl_catchment_area_infiltration_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_infiltration_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5452,5452,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_infiltration_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5453,5453,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_infiltration_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5165,5165,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_infiltration_current FOREIGN KEY (infiltration_current)
 REFERENCES qgep.vl_catchment_area_infiltration_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_infiltration_planned () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_infiltration_planned ADD CONSTRAINT pkey_qgep_vl_catchment_area_infiltration_planned_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_infiltration_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5461,5461,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_infiltration_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5462,5462,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_infiltration_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5170,5170,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_infiltration_planned FOREIGN KEY (infiltration_planned)
 REFERENCES qgep.vl_catchment_area_infiltration_planned (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_retention_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_retention_current ADD CONSTRAINT pkey_qgep_vl_catchment_area_retention_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_retention_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5467,5467,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_retention_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5468,5468,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_retention_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5469,5469,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_retention_current FOREIGN KEY (retention_current)
 REFERENCES qgep.vl_catchment_area_retention_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_retention_planned () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_retention_planned ADD CONSTRAINT pkey_qgep_vl_catchment_area_retention_planned_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_retention_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5470,5470,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_retention_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5471,5471,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_retention_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5472,5472,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT fkey_vl_catchment_area_retention_planned FOREIGN KEY (retention_planned)
 REFERENCES qgep.vl_catchment_area_retention_planned (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_catchment_area ADD COLUMN fk_wastewater_networkelement_rw_current varchar (16);
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_current FOREIGN KEY (fk_wastewater_networkelement_rw_current) REFERENCES qgep.od_wastewater_networkelement(obj_id);
ALTER TABLE qgep.od_catchment_area ADD COLUMN fk_wastewater_networkelement_rw_planned varchar (16);
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_catchment_area_wastewater_networkelement_rw_planned FOREIGN KEY (fk_wastewater_networkelement_rw_planned) REFERENCES qgep.od_wastewater_networkelement(obj_id);
ALTER TABLE qgep.od_catchment_area ADD COLUMN fk_wastewater_networkelement_ww_planned varchar (16);
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_planned FOREIGN KEY (fk_wastewater_networkelement_ww_planned) REFERENCES qgep.od_wastewater_networkelement(obj_id);
ALTER TABLE qgep.od_catchment_area ADD COLUMN fk_wastewater_networkelement_ww_current varchar (16);
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_catchment_area_wastewater_networkelement_ww_current FOREIGN KEY (fk_wastewater_networkelement_ww_current) REFERENCES qgep.od_wastewater_networkelement(obj_id);
ALTER TABLE qgep.od_hazard_source ADD COLUMN fk_connection_object varchar (16);
ALTER TABLE qgep.od_hazard_source ADD CONSTRAINT rel_hazard_source_connection_object FOREIGN KEY (fk_connection_object) REFERENCES qgep.od_connection_object(obj_id);
ALTER TABLE qgep.od_hazard_source ADD COLUMN fk_owner varchar (16);
ALTER TABLE qgep.od_hazard_source ADD CONSTRAINT rel_hazard_source_owner FOREIGN KEY (fk_owner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_connection_object ADD COLUMN fk_wastewater_networkelement varchar (16);
ALTER TABLE qgep.od_connection_object ADD CONSTRAINT rel_connection_object_wastewater_networkelement FOREIGN KEY (fk_wastewater_networkelement) REFERENCES qgep.od_wastewater_networkelement(obj_id);
ALTER TABLE qgep.od_connection_object ADD COLUMN fk_owner varchar (16);
ALTER TABLE qgep.od_connection_object ADD CONSTRAINT rel_connection_object_owner FOREIGN KEY (fk_owner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_connection_object ADD COLUMN fk_operator varchar (16);
ALTER TABLE qgep.od_connection_object ADD CONSTRAINT rel_connection_object_operator FOREIGN KEY (fk_operator) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_surface_runoff_parameters ADD COLUMN fk_catchment_area varchar (16);
ALTER TABLE qgep.od_surface_runoff_parameters ADD CONSTRAINT rel_surface_runoff_parameters_catchment_area FOREIGN KEY (fk_catchment_area) REFERENCES qgep.od_catchment_area(obj_id);
ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN fk_discharge_point varchar (16);
ALTER TABLE qgep.od_catchement_area_totals ADD CONSTRAINT rel_catchement_area_totals_discharge_point FOREIGN KEY (fk_discharge_point) REFERENCES qgep.od_discharge_point(obj_id);
ALTER TABLE qgep.od_catchement_area_totals ADD COLUMN fk_hydraulic_characteristic_data varchar (16);
ALTER TABLE qgep.od_catchement_area_totals ADD CONSTRAINT rel_catchement_area_totals_hydraulic_characteristic_data FOREIGN KEY (fk_hydraulic_characteristic_data) REFERENCES qgep.od_hydraulic_characteristic_data(obj_id);
ALTER TABLE qgep.od_substance ADD COLUMN fk_hazard_source varchar (16);
ALTER TABLE qgep.od_substance ADD CONSTRAINT rel_substance_hazard_source FOREIGN KEY (fk_hazard_source) REFERENCES qgep.od_hazard_source(obj_id);
CREATE TABLE qgep.vl_measure_category () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measure_category ADD CONSTRAINT pkey_qgep_vl_measure_category_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4653,4653,'administrative_mesure','administrative_Massnahme','mesure_administrative', 'G', 'G', 'G', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5036,5036,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4654,4654,'abolishment','Aufhebung','suppression', 'G', 'G', 'G', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4655,4655,'creek_renaturation','Bachrenaturierung','renaturalisation_cours_d_eau', 'G', 'G', 'G', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5035,5035,'creek_restoration','Bachsanierung','assainissement_cours_d_eau', 'G', 'G', 'G', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4657,4657,'datamanagement','Datenmanagement','gestion_des_donnees', 'D', 'D', 'D', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4658,4658,'adjusting_hydraulic_regulation','Einstellung_anpassen_hydraulisch','adapter_reglage_hydraulique', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4659,4659,'sewer_infiltration_water_reduction','Fremdwasserreduktion','reduction_ecp', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4660,4660,'gwdp_elaboration','GEP_Bearbeitung','elaboration_PGEE', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4661,4661,'gwdp_preparation_work','GEP_Vorbereitungsarbeiten','travaux_preparatoires_PGEE', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4662,4662,'control_and_surveillance','Kontrolle_und_Ueberwachung','controle_et_surveillence', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4663,4663,'pipe_replacement_various_reasons','Leitungsersatz_diverse_Gruende','remplacement_conduite_autres_raisons', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4664,4664,'pipe_replacement_hydraulic','Leitungsersatz_hydraulisch','remplacement_conduite_hydraulique', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4665,4665,'pipe_replacement_condition','Leitungsersatz_Zustand','remplacement_conduite_etat', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4666,4666,'network_extension','Netzerweiterung','extension_reseau', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4667,4667,'restoration_channel_special_structure','Sanierung_Kanal_Sonderbauwerke','assainissement_canalisation_ouvrage_special', '', 'G', '', 'true');
 INSERT INTO qgep.vl_measure_category (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4652,4652,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_measure ADD CONSTRAINT fkey_vl_measure_category FOREIGN KEY (category)
 REFERENCES qgep.vl_measure_category (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_measure_priority () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measure_priority ADD CONSTRAINT pkey_qgep_vl_measure_priority_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measure_priority (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4759,4759,'M0','M0','M0', 'M0', 'M0', 'M0', 'true');
 INSERT INTO qgep.vl_measure_priority (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4760,4760,'M1','M1','M1', 'M1', 'M1', 'M1', 'true');
 INSERT INTO qgep.vl_measure_priority (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4761,4761,'M2','M2','M2', 'M2', 'M2', 'M2', 'true');
 INSERT INTO qgep.vl_measure_priority (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4762,4762,'M3','M3','M3', 'M3', 'M3', 'M3', 'true');
 INSERT INTO qgep.vl_measure_priority (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4763,4763,'M4','M4','M4', 'M4', 'M4', 'M4', 'true');
 INSERT INTO qgep.vl_measure_priority (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5584,5584,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_measure ADD CONSTRAINT fkey_vl_measure_priority FOREIGN KEY (priority)
 REFERENCES qgep.vl_measure_priority (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_measure_status () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measure_status ADD CONSTRAINT pkey_qgep_vl_measure_status_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4764,4764,'completed','erledigt','regle', '', '', '', 'true');
 INSERT INTO qgep.vl_measure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4765,4765,'in_preparation','in_Bearbeitung','en_preparation', '', '', '', 'true');
 INSERT INTO qgep.vl_measure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4766,4766,'pending','pendent','en_suspens', '', '', '', 'true');
 INSERT INTO qgep.vl_measure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4767,4767,'suspended','sistiert','supprime', '', '', '', 'true');
 INSERT INTO qgep.vl_measure_status (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4768,4768,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_measure ADD CONSTRAINT fkey_vl_measure_status FOREIGN KEY (status)
 REFERENCES qgep.vl_measure_status (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_measuring_device_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measuring_device_kind ADD CONSTRAINT pkey_qgep_vl_measuring_device_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5702,5702,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5703,5703,'static_sounding_stick','Drucksonde','sonde_de_pression', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5704,5704,'bubbler_system','Lufteinperlung','injection_bulles_d_air', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5705,5705,'EMF_partly_filled','MID_teilgefuellt','MID_partiellement_rempli', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5706,5706,'EMF_filled','MID_vollgefuellt','MID_rempli', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5707,5707,'radar','Radar','radar', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5708,5708,'float','Schwimmer','flotteur', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6322,6322,'ultrasound','Ultraschall','ultrason', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_device_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5709,5709,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_measuring_device ADD CONSTRAINT fkey_vl_measuring_device_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_measuring_device_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_measuring_device ADD COLUMN fk_measuring_point varchar (16);
ALTER TABLE qgep.od_measuring_device ADD CONSTRAINT rel_measuring_device_measuring_point FOREIGN KEY (fk_measuring_point) REFERENCES qgep.od_measuring_point(obj_id);
CREATE TABLE qgep.vl_measuring_point_damming_device () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measuring_point_damming_device ADD CONSTRAINT pkey_qgep_vl_measuring_point_damming_device_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measuring_point_damming_device (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5720,5720,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_damming_device (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5721,5721,'none','keiner','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_damming_device (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5722,5722,'overflow_weir','Ueberfallwehr','lame_deversante', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_damming_device (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5724,5724,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_damming_device (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5723,5723,'venturi_necking','Venturieinschnuerung','etranglement_venturi', '', '', '', 'true');
 ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT fkey_vl_measuring_point_damming_device FOREIGN KEY (damming_device)
 REFERENCES qgep.vl_measuring_point_damming_device (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_measuring_point_purpose () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measuring_point_purpose ADD CONSTRAINT pkey_qgep_vl_measuring_point_purpose_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measuring_point_purpose (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4595,4595,'both','beides','les_deux', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_purpose (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4593,4593,'cost_sharing','Kostenverteilung','repartition_des_couts', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_purpose (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4594,4594,'technical_purpose','technischer_Zweck','but_technique', '', '', '', 'true');
 INSERT INTO qgep.vl_measuring_point_purpose (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4592,4592,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT fkey_vl_measuring_point_purpose FOREIGN KEY (purpose)
 REFERENCES qgep.vl_measuring_point_purpose (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_operator varchar (16);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_measuring_point_operator FOREIGN KEY (fk_operator) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_waste_water_treatment_plant varchar (16);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_measuring_point_waste_water_treatment_plant FOREIGN KEY (fk_waste_water_treatment_plant) REFERENCES qgep.od_waste_water_treatment_plant(obj_id);
ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_measuring_point_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
ALTER TABLE qgep.od_measuring_point ADD COLUMN fk_water_course_segment varchar (16);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_measuring_point_water_course_segment FOREIGN KEY (fk_water_course_segment) REFERENCES qgep.od_water_course_segment(obj_id);
CREATE TABLE qgep.vl_measurement_series_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measurement_series_kind ADD CONSTRAINT pkey_qgep_vl_measurement_series_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measurement_series_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3217,3217,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_measurement_series_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2646,2646,'continuous','kontinuierlich','continu', '', '', '', 'true');
 INSERT INTO qgep.vl_measurement_series_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2647,2647,'rain_weather','Regenwetter','temps_de_pluie', '', '', '', 'true');
 INSERT INTO qgep.vl_measurement_series_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3053,3053,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_measurement_series ADD CONSTRAINT fkey_vl_measurement_series_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_measurement_series_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_measurement_series ADD COLUMN fk_measuring_point varchar (16);
ALTER TABLE qgep.od_measurement_series ADD CONSTRAINT rel_measurement_series_measuring_point FOREIGN KEY (fk_measuring_point) REFERENCES qgep.od_measuring_point(obj_id);
CREATE TABLE qgep.vl_measurement_result_measurement_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_measurement_result_measurement_type ADD CONSTRAINT pkey_qgep_vl_measurement_result_measurement_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_measurement_result_measurement_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5732,5732,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_measurement_result_measurement_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5733,5733,'flow','Durchfluss','debit', '', '', '', 'true');
 INSERT INTO qgep.vl_measurement_result_measurement_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5734,5734,'level','Niveau','niveau', '', '', '', 'true');
 INSERT INTO qgep.vl_measurement_result_measurement_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5735,5735,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT fkey_vl_measurement_result_measurement_type FOREIGN KEY (measurement_type)
 REFERENCES qgep.vl_measurement_result_measurement_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_measurement_result ADD COLUMN fk_measuring_device varchar (16);
ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT rel_measurement_result_measuring_device FOREIGN KEY (fk_measuring_device) REFERENCES qgep.od_measuring_device(obj_id);
ALTER TABLE qgep.od_measurement_result ADD COLUMN fk_measurement_series varchar (16);
ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT rel_measurement_result_measurement_series FOREIGN KEY (fk_measurement_series) REFERENCES qgep.od_measurement_series(obj_id);
ALTER TABLE qgep.od_groundwater_protection_zone ADD CONSTRAINT oorel_od_groundwater_protection_zone_zone FOREIGN KEY (obj_id) REFERENCES qgep.od_zone(obj_id);
CREATE TABLE qgep.vl_groundwater_protection_zone_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_groundwater_protection_zone_kind ADD CONSTRAINT pkey_qgep_vl_groundwater_protection_zone_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_groundwater_protection_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (440,440,'S1','S1','S1', '', '', '', 'true');
 INSERT INTO qgep.vl_groundwater_protection_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (441,441,'S2','S2','S2', '', '', '', 'true');
 INSERT INTO qgep.vl_groundwater_protection_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (442,442,'S3','S3','S3', '', '', '', 'true');
 INSERT INTO qgep.vl_groundwater_protection_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3040,3040,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_groundwater_protection_zone ADD CONSTRAINT fkey_vl_groundwater_protection_zone_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_groundwater_protection_zone_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_drainage_system ADD CONSTRAINT oorel_od_drainage_system_zone FOREIGN KEY (obj_id) REFERENCES qgep.od_zone(obj_id);
CREATE TABLE qgep.vl_drainage_system_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_drainage_system_kind ADD CONSTRAINT pkey_qgep_vl_drainage_system_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_drainage_system_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4783,4783,'amelioration','Melioration','melioration', '', '', '', 'true');
 INSERT INTO qgep.vl_drainage_system_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2722,2722,'mixed_system','Mischsystem','systeme_unitaire', '', '', '', 'true');
 INSERT INTO qgep.vl_drainage_system_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2724,2724,'modified_system','ModifiziertesSystem','systeme_modifie', '', '', '', 'true');
 INSERT INTO qgep.vl_drainage_system_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4544,4544,'not_connected','nicht_angeschlossen','non_raccorde', '', '', '', 'true');
 INSERT INTO qgep.vl_drainage_system_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2723,2723,'separated_system','Trennsystem','systeme_separatif', '', '', '', 'true');
 INSERT INTO qgep.vl_drainage_system_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3060,3060,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_drainage_system ADD CONSTRAINT fkey_vl_drainage_system_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_drainage_system_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_water_body_protection_sector ADD CONSTRAINT oorel_od_water_body_protection_sector_zone FOREIGN KEY (obj_id) REFERENCES qgep.od_zone(obj_id);
CREATE TABLE qgep.vl_water_body_protection_sector_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_water_body_protection_sector_kind ADD CONSTRAINT pkey_qgep_vl_water_body_protection_sector_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (430,430,'A','A','A', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3652,3652,'Ao','Ao','Ao', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3649,3649,'Au','Au','Au', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (431,431,'B','B','B', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (432,432,'C','C','C', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3069,3069,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3651,3651,'Zo','Zo','Zo', '', '', '', 'true');
 INSERT INTO qgep.vl_water_body_protection_sector_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3650,3650,'Zu','Zu','Zu', '', '', '', 'true');
 ALTER TABLE qgep.od_water_body_protection_sector ADD CONSTRAINT fkey_vl_water_body_protection_sector_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_water_body_protection_sector_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_ground_water_protection_perimeter ADD CONSTRAINT oorel_od_ground_water_protection_perimeter_zone FOREIGN KEY (obj_id) REFERENCES qgep.od_zone(obj_id);
ALTER TABLE qgep.od_planning_zone ADD CONSTRAINT oorel_od_planning_zone_zone FOREIGN KEY (obj_id) REFERENCES qgep.od_zone(obj_id);
CREATE TABLE qgep.vl_planning_zone_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_planning_zone_kind ADD CONSTRAINT pkey_qgep_vl_planning_zone_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_planning_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2990,2990,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_planning_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (31,31,'commercial_zone','Gewerbezone','zone_artisanale', '', '', '', 'true');
 INSERT INTO qgep.vl_planning_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (32,32,'industrial_zone','Industriezone','zone_industrielle', '', '', '', 'true');
 INSERT INTO qgep.vl_planning_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (30,30,'agricultural_zone','Landwirtschaftszone','zone_agricole', '', '', '', 'true');
 INSERT INTO qgep.vl_planning_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3077,3077,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_planning_zone_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (29,29,'residential_zone','Wohnzone','zone_d_habitations', '', '', '', 'true');
 ALTER TABLE qgep.od_planning_zone ADD CONSTRAINT fkey_vl_planning_zone_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_planning_zone_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_infiltration_zone ADD CONSTRAINT oorel_od_infiltration_zone_zone FOREIGN KEY (obj_id) REFERENCES qgep.od_zone(obj_id);
CREATE TABLE qgep.vl_infiltration_zone_infiltration_capacity () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_zone_infiltration_capacity ADD CONSTRAINT pkey_qgep_vl_infiltration_zone_infiltration_capacity_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_zone_infiltration_capacity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (371,371,'good','gut','bonnes', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_zone_infiltration_capacity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (374,374,'none','keine','aucune', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_zone_infiltration_capacity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (372,372,'moderate','maessig','moyennes', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_zone_infiltration_capacity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (373,373,'bad','schlecht','mauvaises', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_zone_infiltration_capacity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3073,3073,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_zone_infiltration_capacity (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2996,2996,'not_allowed','unzulaessig','non_admis', '', '', '', 'true');
 ALTER TABLE qgep.od_infiltration_zone ADD CONSTRAINT fkey_vl_infiltration_zone_infiltration_capacity FOREIGN KEY (infiltration_capacity)
 REFERENCES qgep.vl_infiltration_zone_infiltration_capacity (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT oorel_od_bio_ecol_overall_assessment_maintenance_event FOREIGN KEY (obj_id) REFERENCES qgep.od_maintenance_event(obj_id);
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6330,6330,'big_influence','grosser_Einfluss','grande_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5942,5942,'no_influence','kein_Einfluss','aucune_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5939,5939,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5940,5940,'small_influence','kleiner_Einfluss','petite_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6329,6329,'medium_influence','mittlerer_Einfluss','moyenne_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5941,5941,'unclear','unklar','pas_clair', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point FOREIGN KEY (aq_invertebrates_discharge_point)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_discharge_point (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_aq_invertebrates_downstream_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5929,5929,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5930,5930,'ecological_goals_fullfilled','oekologische_Ziele_erreicht','cibles_ecologiques_atteintes', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5931,5931,'ecological_goals_questionable','oekologische_Ziele_fraglich','cibles_ecologiques_sujet_a_caution', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5932,5932,'ecological_goals_not_fullfilled','oekologische_Ziele_nicht_erreicht','cibles_ecologiques_non_atteintes', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6442,6442,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_aq_invertebrates_downstream FOREIGN KEY (aq_invertebrates_downstream)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_downstream (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_aq_invertebrates_upstream_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5934,5934,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5935,5935,'ecological_goals_fullfilled','oekologische_Ziele_erreicht','cibles_ecologiques_atteintes', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5936,5936,'ecological_goals_questionable','oekologische_Ziele_fraglich','cibles_ecologiques_sujet_a_caution', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5937,5937,'ecological_goals_not_fullfilled','oekologische_Ziele_nicht_erreicht','cibles_ecologiques_non_atteintes', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6441,6441,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_aq_invertebrates_upstream FOREIGN KEY (aq_invertebrates_upstream)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_aq_invertebrates_upstream (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_comparison_last_examination () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_comparison_last_examination ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_comparison_last_examination_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_comparison_last_examination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5896,5896,'equal','gleich','egal', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_comparison_last_examination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6328,6328,'no_comparison_possible','kein_Vergleich_moeglich','aucune_comparaison_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_comparison_last_examination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6271,6271,'unclear','unklar','pas_clair', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_comparison_last_examination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6269,6269,'improvement','Verbesserung','amelioration', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_comparison_last_examination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6270,6270,'worsening','Verschlechterung','deterioration', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_comparison_last_examination FOREIGN KEY (comparison_last_examination)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_comparison_last_examination (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_immission_oriented_calculation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_immission_oriented_calculation ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_immission_oriented_calculation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_immission_oriented_calculation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5953,5953,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_immission_oriented_calculation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5952,5952,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_immission_oriented_calculation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5954,5954,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_immission_oriented_calculation FOREIGN KEY (immission_oriented_calculation)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_immission_oriented_calculation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_intervention_demand () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_intervention_demand ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_intervention_demand_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_intervention_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5945,5945,'yes_short_term','ja_kurzfristig','oui_a_court_terme', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_intervention_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6272,6272,'yes_long_term','ja_laengerfristig','oui_a_long_terme', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_intervention_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5944,5944,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_intervention_demand (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5946,5946,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_intervention_demand FOREIGN KEY (intervention_demand)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_intervention_demand (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_relevance_matrix () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_relevance_matrix ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_relevance_matrix_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_relevance_matrix (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5949,5949,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_relevance_matrix (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5948,5948,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_relevance_matrix (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5950,5950,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_relevance_matrix FOREIGN KEY (relevance_matrix)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_relevance_matrix (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_total_impairment () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_total_impairment ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_total_impairment_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_total_impairment (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6278,6278,'big_influence','grosser_Einfluss','grande_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_total_impairment (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6276,6276,'no_influence','kein_Einfluss','aucune_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_total_impairment (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6274,6274,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_total_impairment (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6275,6275,'small_influence','kleiner_Einfluss','petite_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_total_impairment (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6277,6277,'medium_influence','mittlerer_Einfluss','moyenne_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_total_impairment (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6279,6279,'unclear','unklar','pas_clair', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_total_impairment FOREIGN KEY (total_impairment)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_total_impairment (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_type_water_body () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_type_water_body ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_type_water_body_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (8492,8492,'river_backwater','Fluss_Stau','retention', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5884,5884,'large_river','Groesseres_Fliessgewaesser','gros_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5883,5883,'large_midland_creek','Grosser_Mittellandbach','gros_ruisseau_du_Plateau', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (8495,8495,'big_lake','Grosser_See','grand_lac', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5885,5885,'large_prealps_creek','Grosser_Voralpenbach','gros_ruisseau_des_Prealpes', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (8491,8491,'very_large_river','Grosses_Fliessgewaesser','tres_gros_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5886,5886,'small_midland_creek','Kleiner_Mittellandbach','petit_ruisseau_du_Plateau', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (8494,8494,'small_lake','Kleiner_See','petit_lac', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5887,5887,'small_prealps_creek','Kleiner_Voralpenbach','petit_ruisseau_des_Prealpes', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5888,5888,'spring_waters','Quellgewaesser','region_de_source', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_type_water_body (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5890,5890,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_type_water_body FOREIGN KEY (type_water_body)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_type_water_body (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6332,6332,'big_influence','grosser_Einfluss','grande_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5920,5920,'no_influence','kein_Einfluss','aucune_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5919,5919,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5922,5922,'small_influence','kleiner_Einfluss','petite_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6331,6331,'medium_influence','mittlerer_Einfluss','moyenne_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5921,5921,'unclear','unklar','pas_clair', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point FOREIGN KEY (vegetation_grow_discharge_point)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_vegetation_grow_discharge_point (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_vegetation_grow_downstream_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5915,5915,'exigence_fullfilled','Anforderungen_erfuellt','exigences_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5917,5917,'exigence_not_fullfilled','Anforderungen_nicht_erfuellt','exigences_non_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5916,5916,'exigence_questionable','Erfuellung_fraglich','exigences_sujet_a_caution', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5914,5914,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6439,6439,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_vegetation_grow_downstream FOREIGN KEY (vegetation_grow_downstream)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_vegetation_grow_downstream (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_vegetation_grow_upstream_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5910,5910,'exigence_fullfilled','Anforderungen_erfuellt','exigences_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5912,5912,'exigence_not_fullfilled','Anforderungen_nicht_erfuellt','exigences_non_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5911,5911,'exigence_questionable','Erfuellung_fraglich','exigences_sujet_a_caution', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5909,5909,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6438,6438,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_vegetation_grow_upstream FOREIGN KEY (vegetation_grow_upstream)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_vegetation_grow_upstream (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_visual_aspect_discharge_point_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6334,6334,'big_influence','grosser_Einfluss','grande_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5927,5927,'no_influence','kein_Einfluss','aucune_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5924,5924,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5925,5925,'small_influence','kleiner_Einfluss','petite_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6333,6333,'medium_influence','mittlerer_Einfluss','moyenne_influence', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5926,5926,'unclear','unklar','pas_clair', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_visual_aspect_discharge_point FOREIGN KEY (visual_aspect_discharge_point)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_visual_aspect_discharge_point (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_visual_aspect_downstream_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5905,5905,'exigence_fullfilled','Anforderungen_erfuellt','exigences_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5907,5907,'exigence_not_fullfilled','Anforderungen_nicht_erfuellt','exigences_non_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5906,5906,'exigence_questionable','Erfuellung_fraglich','exigences_sujet_a_caution', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5904,5904,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6436,6436,'unknown','unbekannnt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_visual_aspect_downstream FOREIGN KEY (visual_aspect_downstream)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_visual_aspect_downstream (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream ADD CONSTRAINT pkey_qgep_vl_bio_ecol_overall_assessment_visual_aspect_upstream_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5900,5900,'exigence_fullfilled','Anforderungen_erfuellt','exigences_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5902,5902,'exigence_not_fullfilled','Anforderungen_nicht_erfuellt','exigences_non_remplies', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5901,5901,'exigence_questionable','Erfuellung_fraglich','exigences_sujet_a_caution', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5899,5899,'no_conclusion_possible','keine_Aussage_moeglich','aucun_avis_possible', '', '', '', 'true');
 INSERT INTO qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6327,6327,'unknown','unbekannt','inconnue', '', '', '', 'true');
 ALTER TABLE qgep.od_bio_ecol_overall_assessment ADD CONSTRAINT fkey_vl_bio_ecol_overall_assessment_visual_aspect_upstream FOREIGN KEY (visual_aspect_upstream)
 REFERENCES qgep.vl_bio_ecol_overall_assessment_visual_aspect_upstream (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_examination ADD CONSTRAINT oorel_od_examination_maintenance_event FOREIGN KEY (obj_id) REFERENCES qgep.od_maintenance_event(obj_id);
CREATE TABLE qgep.vl_examination_recording_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_examination_recording_type ADD CONSTRAINT pkey_qgep_vl_examination_recording_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3681,3681,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3682,3682,'field_visit','Begehung','parcours', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3683,3683,'deformation_measurement','Deformationsmessung','mesure_deformation', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3684,3684,'leak_test','Dichtheitspruefung','examen_etancheite', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3685,3685,'georadar','Georadar','georadar', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3686,3686,'channel_TV','Kanalfernsehen','camera_canalisations', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_recording_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3687,3687,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_examination ADD CONSTRAINT fkey_vl_examination_recording_type FOREIGN KEY (recording_type)
 REFERENCES qgep.vl_examination_recording_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_examination_weather () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_examination_weather ADD CONSTRAINT pkey_qgep_vl_examination_weather_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_examination_weather (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3699,3699,'covered_rainy','bedeckt_regnerisch','couvert_pluvieux', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_weather (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3700,3700,'drizzle','Nieselregen','bruine', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_weather (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3701,3701,'rain','Regen','pluie', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_weather (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3702,3702,'snowfall','Schneefall','chute_neige', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_weather (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3703,3703,'nice_dry','schoen_trocken','beau_sec', '', '', '', 'true');
 INSERT INTO qgep.vl_examination_weather (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3704,3704,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_examination ADD CONSTRAINT fkey_vl_examination_weather FOREIGN KEY (weather)
 REFERENCES qgep.vl_examination_weather (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_examination ADD COLUMN fk_reach_point varchar (16);
ALTER TABLE qgep.od_examination ADD CONSTRAINT rel_examination_reach_point FOREIGN KEY (fk_reach_point) REFERENCES qgep.od_reach_point(obj_id);
ALTER TABLE qgep.od_dryweather_downspout ADD CONSTRAINT oorel_od_dryweather_downspout_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
ALTER TABLE qgep.od_cover ADD CONSTRAINT oorel_od_cover_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_cover_cover_shape () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_cover_cover_shape ADD CONSTRAINT pkey_qgep_vl_cover_cover_shape_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_cover_cover_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5353,5353,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_cover_cover_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3499,3499,'rectangular','eckig','anguleux', 'R', 'E', 'AX', 'true');
 INSERT INTO qgep.vl_cover_cover_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3498,3498,'round','rund','rond', '', 'R', 'R', 'true');
 INSERT INTO qgep.vl_cover_cover_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5354,5354,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_cover ADD CONSTRAINT fkey_vl_cover_cover_shape FOREIGN KEY (cover_shape)
 REFERENCES qgep.vl_cover_cover_shape (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_cover_fastening () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_cover_fastening ADD CONSTRAINT pkey_qgep_vl_cover_fastening_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_cover_fastening (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5350,5350,'not_bolted','nicht_verschraubt','non_vissee', '', 'NVS', 'NVS', 'true');
 INSERT INTO qgep.vl_cover_fastening (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5351,5351,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_cover_fastening (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5352,5352,'bolted','verschraubt','vissee', '', 'VS', 'VS', 'true');
 ALTER TABLE qgep.od_cover ADD CONSTRAINT fkey_vl_cover_fastening FOREIGN KEY (fastening)
 REFERENCES qgep.vl_cover_fastening (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_cover_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_cover_material ADD CONSTRAINT pkey_qgep_vl_cover_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_cover_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5355,5355,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_cover_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (234,234,'concrete','Beton','beton', 'C', 'B', 'B', 'true');
 INSERT INTO qgep.vl_cover_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (233,233,'cast_iron','Guss','fonte', '', 'G', 'F', 'true');
 INSERT INTO qgep.vl_cover_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5547,5547,'cast_iron_with_pavement_filling','Guss_mit_Belagsfuellung','fonte_avec_remplissage_en_robe', 'CIP', 'GBL', 'FRE', 'true');
 INSERT INTO qgep.vl_cover_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (235,235,'cast_iron_with_concrete_filling','Guss_mit_Betonfuellung','fonte_avec_remplissage_en_beton', '', 'GBT', 'FRB', 'true');
 INSERT INTO qgep.vl_cover_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3015,3015,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_cover ADD CONSTRAINT fkey_vl_cover_material FOREIGN KEY (material)
 REFERENCES qgep.vl_cover_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_cover_positional_accuracy () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_cover_positional_accuracy ADD CONSTRAINT pkey_qgep_vl_cover_positional_accuracy_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3243,3243,'more_than_50cm','groesser_50cm','plusque_50cm', '', 'G50', 'S50', 'true');
 INSERT INTO qgep.vl_cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3241,3241,'plusminus_10cm','plusminus_10cm','plus_moins_10cm', '', 'P10', 'P10', 'true');
 INSERT INTO qgep.vl_cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3236,3236,'plusminus_3cm','plusminus_3cm','plus_moins_3cm', '', 'P03', 'P03', 'true');
 INSERT INTO qgep.vl_cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3242,3242,'plusminus_50cm','plusminus_50cm','plus_moins_50cm', '', 'P50', 'P50', 'true');
 INSERT INTO qgep.vl_cover_positional_accuracy (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5349,5349,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_cover ADD CONSTRAINT fkey_vl_cover_positional_accuracy FOREIGN KEY (positional_accuracy)
 REFERENCES qgep.vl_cover_positional_accuracy (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_cover_sludge_bucket () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_cover_sludge_bucket ADD CONSTRAINT pkey_qgep_vl_cover_sludge_bucket_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_cover_sludge_bucket (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (423,423,'inexistent','nicht_vorhanden','inexistant', '', 'NV', 'IE', 'true');
 INSERT INTO qgep.vl_cover_sludge_bucket (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3066,3066,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_cover_sludge_bucket (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (422,422,'existent','vorhanden','existant', '', 'V', 'E', 'true');
 ALTER TABLE qgep.od_cover ADD CONSTRAINT fkey_vl_cover_sludge_bucket FOREIGN KEY (sludge_bucket)
 REFERENCES qgep.vl_cover_sludge_bucket (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_cover_venting () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_cover_venting ADD CONSTRAINT pkey_qgep_vl_cover_venting_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_cover_venting (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (229,229,'vented','entlueftet','aere', '', 'EL', 'AE', 'true');
 INSERT INTO qgep.vl_cover_venting (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (230,230,'not_vented','nicht_entlueftet','non_aere', '', 'NEL', 'NAE', 'true');
 INSERT INTO qgep.vl_cover_venting (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5348,5348,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_cover ADD CONSTRAINT fkey_vl_cover_venting FOREIGN KEY (venting)
 REFERENCES qgep.vl_cover_venting (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_access_aid ADD CONSTRAINT oorel_od_access_aid_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_access_aid_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_access_aid_kind ADD CONSTRAINT pkey_qgep_vl_access_aid_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5357,5357,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (243,243,'pressurized_door','Drucktuere','porte_etanche', 'PD', 'D', 'PE', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (92,92,'none','keine','aucun_equipement_d_acces', '', 'K', 'AN', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (240,240,'ladder','Leiter','echelle', '', 'L', 'EC', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (241,241,'step_iron','Steigeisen','echelons', '', 'S', 'ECO', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3473,3473,'staircase','Treppe','escalier', '', 'R', 'ES', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (91,91,'footstep_niches','Trittnischen','marchepieds', '', 'N', 'N', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3230,3230,'door','Tuere','porte', '', 'T', 'P', 'true');
 INSERT INTO qgep.vl_access_aid_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3048,3048,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_access_aid ADD CONSTRAINT fkey_vl_access_aid_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_access_aid_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_electric_equipment ADD CONSTRAINT oorel_od_electric_equipment_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_electric_equipment_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_electric_equipment_kind ADD CONSTRAINT pkey_qgep_vl_electric_equipment_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_electric_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2980,2980,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_electric_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (376,376,'illumination','Beleuchtung','eclairage', '', '', '', 'true');
 INSERT INTO qgep.vl_electric_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3255,3255,'remote_control_system','Fernwirkanlage','installation_de_telecommande', '', '', '', 'true');
 INSERT INTO qgep.vl_electric_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (378,378,'radio_unit','Funk','radio', '', '', '', 'true');
 INSERT INTO qgep.vl_electric_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (377,377,'phone','Telephon','telephone', '', '', '', 'true');
 INSERT INTO qgep.vl_electric_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3038,3038,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_electric_equipment ADD CONSTRAINT fkey_vl_electric_equipment_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_electric_equipment_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_backflow_prevention ADD CONSTRAINT oorel_od_backflow_prevention_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_backflow_prevention_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_backflow_prevention_kind ADD CONSTRAINT pkey_qgep_vl_backflow_prevention_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_backflow_prevention_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5760,5760,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_backflow_prevention_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5759,5759,'pump','Pumpe','pompe', '', '', '', 'true');
 INSERT INTO qgep.vl_backflow_prevention_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5757,5757,'backflow_flap','Rueckstauklappe','clapet_de_non_retour_a_battant', '', '', '', 'true');
 INSERT INTO qgep.vl_backflow_prevention_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5758,5758,'gate_shield','Stauschild','plaque_de_retenue', '', '', '', 'true');
 ALTER TABLE qgep.od_backflow_prevention ADD CONSTRAINT fkey_vl_backflow_prevention_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_backflow_prevention_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_backflow_prevention ADD COLUMN fk_throttle_shut_off_unit varchar (16);
ALTER TABLE qgep.od_backflow_prevention ADD CONSTRAINT rel_backflow_prevention_throttle_shut_off_unit FOREIGN KEY (fk_throttle_shut_off_unit) REFERENCES qgep.od_throttle_shut_off_unit(obj_id);
ALTER TABLE qgep.od_backflow_prevention ADD COLUMN fk_pomp varchar (16);
ALTER TABLE qgep.od_backflow_prevention ADD CONSTRAINT rel_backflow_prevention_pomp FOREIGN KEY (fk_pomp) REFERENCES qgep.od_pump(obj_id);
ALTER TABLE qgep.od_tank_cleaning ADD CONSTRAINT oorel_od_tank_cleaning_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_tank_cleaning_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_tank_cleaning_type ADD CONSTRAINT pkey_qgep_vl_tank_cleaning_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_tank_cleaning_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5621,5621,'airjet','Air_Jet','aeration_et_brassage', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_cleaning_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5620,5620,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_cleaning_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5622,5622,'none','keine','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_cleaning_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5623,5623,'surge_flushing','Schwallspuelung','rincage_en_cascade', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_cleaning_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5624,5624,'tipping_bucket','Spuelkippe','bac_de_rincage', '', '', '', 'true');
 ALTER TABLE qgep.od_tank_cleaning ADD CONSTRAINT fkey_vl_tank_cleaning_type FOREIGN KEY (type)
 REFERENCES qgep.vl_tank_cleaning_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_benching ADD CONSTRAINT oorel_od_benching_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_benching_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_benching_kind ADD CONSTRAINT pkey_qgep_vl_benching_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_benching_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5319,5319,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_benching_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (94,94,'double_sided','beidseitig','double', 'DS', 'BB', 'D', 'true');
 INSERT INTO qgep.vl_benching_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (93,93,'one_sided','einseitig','simple', 'OS', 'EB', 'S', 'true');
 INSERT INTO qgep.vl_benching_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3231,3231,'none','kein','aucun', '', 'KB', 'AN', 'true');
 INSERT INTO qgep.vl_benching_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3033,3033,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_benching ADD CONSTRAINT fkey_vl_benching_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_benching_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_solids_retention ADD CONSTRAINT oorel_od_solids_retention_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_solids_retention_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_solids_retention_type ADD CONSTRAINT pkey_qgep_vl_solids_retention_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_solids_retention_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5664,5664,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_solids_retention_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5665,5665,'fine_screen','Feinrechen','grille_fine', '', '', '', 'true');
 INSERT INTO qgep.vl_solids_retention_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5666,5666,'coarse_screen','Grobrechen','grille_grossiere', '', '', '', 'true');
 INSERT INTO qgep.vl_solids_retention_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5667,5667,'sieve','Sieb','tamis', '', '', '', 'true');
 INSERT INTO qgep.vl_solids_retention_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5668,5668,'scumboard','Tauchwand','paroi_plongeante', '', '', '', 'true');
 INSERT INTO qgep.vl_solids_retention_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5669,5669,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_solids_retention ADD CONSTRAINT fkey_vl_solids_retention_type FOREIGN KEY (type)
 REFERENCES qgep.vl_solids_retention_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_dryweather_flume ADD CONSTRAINT oorel_od_dryweather_flume_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_dryweather_flume_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_dryweather_flume_material ADD CONSTRAINT pkey_qgep_vl_dryweather_flume_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_dryweather_flume_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3221,3221,'other','andere','autres', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_dryweather_flume_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (354,354,'combined','kombiniert','combine', '', 'KOM', 'COM', 'true');
 INSERT INTO qgep.vl_dryweather_flume_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5356,5356,'plastic','Kunststoff','matiere_synthetique', '', 'KU', 'MS', 'true');
 INSERT INTO qgep.vl_dryweather_flume_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (238,238,'stoneware','Steinzeug','gres', '', 'STZ', 'GR', 'true');
 INSERT INTO qgep.vl_dryweather_flume_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3017,3017,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_dryweather_flume_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (237,237,'cement_mortar','Zementmoertel','mortier_de_ciment', '', 'ZM', 'MC', 'true');
 ALTER TABLE qgep.od_dryweather_flume ADD CONSTRAINT fkey_vl_dryweather_flume_material FOREIGN KEY (material)
 REFERENCES qgep.vl_dryweather_flume_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_electromechanical_equipment ADD CONSTRAINT oorel_od_electromechanical_equipment_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_electromechanical_equipment_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_electromechanical_equipment_kind ADD CONSTRAINT pkey_qgep_vl_electromechanical_equipment_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_electromechanical_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2981,2981,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_electromechanical_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (380,380,'leakage_water_pump','Leckwasserpumpe','pompe_d_epuisement', '', '', '', 'true');
 INSERT INTO qgep.vl_electromechanical_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (337,337,'air_dehumidifier','Luftentfeuchter','deshumidificateur', '', '', '', 'true');
 INSERT INTO qgep.vl_electromechanical_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (381,381,'scraper_installation','Raeumeinrichtung','dispositif_de_curage', '', '', '', 'true');
 INSERT INTO qgep.vl_electromechanical_equipment_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3072,3072,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_electromechanical_equipment ADD CONSTRAINT fkey_vl_electromechanical_equipment_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_electromechanical_equipment_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_tank_emptying ADD CONSTRAINT oorel_od_tank_emptying_structure_part FOREIGN KEY (obj_id) REFERENCES qgep.od_structure_part(obj_id);
CREATE TABLE qgep.vl_tank_emptying_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_tank_emptying_type ADD CONSTRAINT pkey_qgep_vl_tank_emptying_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_tank_emptying_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5626,5626,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_emptying_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5627,5627,'none','keine','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_emptying_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5628,5628,'pump','Pumpe','pompe', '', '', '', 'true');
 INSERT INTO qgep.vl_tank_emptying_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5629,5629,'valve','Schieber','vanne', '', '', '', 'true');
 ALTER TABLE qgep.od_tank_emptying ADD CONSTRAINT fkey_vl_tank_emptying_type FOREIGN KEY (type)
 REFERENCES qgep.vl_tank_emptying_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_tank_emptying ADD COLUMN fk_throttle_shut_off_unit varchar (16);
ALTER TABLE qgep.od_tank_emptying ADD CONSTRAINT rel_tank_emptying_throttle_shut_off_unit FOREIGN KEY (fk_throttle_shut_off_unit) REFERENCES qgep.od_throttle_shut_off_unit(obj_id);
ALTER TABLE qgep.od_tank_emptying ADD COLUMN fk_overflow varchar (16);
ALTER TABLE qgep.od_tank_emptying ADD CONSTRAINT rel_tank_emptying_overflow FOREIGN KEY (fk_overflow) REFERENCES qgep.od_pump(obj_id);
ALTER TABLE qgep.od_toilet ADD CONSTRAINT oorel_od_toilet_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_toilet_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_toilet_kind ADD CONSTRAINT pkey_qgep_vl_toilet_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_toilet_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6411,6411,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_toilet_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6408,6408,'chemical_toilet','chemischeToilette','toilette_chimique', '', '', '', 'true');
 INSERT INTO qgep.vl_toilet_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6410,6410,'compost_toilet','Komposttoilette','toilette_a_compost', '', '', '', 'true');
 INSERT INTO qgep.vl_toilet_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6412,6412,'unknown','unbekannt','inconu', '', '', '', 'true');
 INSERT INTO qgep.vl_toilet_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6409,6409,'incinerating_toilet','Verbrennungstoilette','toilette_d_incineration', '', '', '', 'true');
 ALTER TABLE qgep.od_toilet ADD CONSTRAINT fkey_vl_toilet_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_toilet_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_small_treatment_plant ADD CONSTRAINT oorel_od_small_treatment_plant_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_small_treatment_plant_function () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_small_treatment_plant_function ADD CONSTRAINT pkey_qgep_vl_small_treatment_plant_function_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5013,5013,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5014,5014,'activated_sludge_process','Belebtschlammverfahren','boues_activees', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5022,5022,'bed_process','Bettverfahren','lit_bacterien', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5023,5023,'membran_bioreactor','Membranbioreaktor','reacteur_a_biomasse_fixee', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5020,5020,'constructed_wetland','Pflanzenklaeranlage','filtration_par_plantes', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5019,5019,'sandfilter','Sandfilter','filtre_a_sable', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5015,5015,'sequencing_batch_reactor','SequencingBatchReactor','charge_sequentielle_SBR', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5016,5016,'immersion_trickle_filter','Tauchkoerper','disques_biologiques', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5021,5021,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_small_treatment_plant ADD CONSTRAINT fkey_vl_small_treatment_plant_function FOREIGN KEY (function)
 REFERENCES qgep.vl_small_treatment_plant_function (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_small_treatment_plant_remote_monitoring () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_small_treatment_plant_remote_monitoring ADD CONSTRAINT pkey_qgep_vl_small_treatment_plant_remote_monitoring_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_small_treatment_plant_remote_monitoring (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6414,6414,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_remote_monitoring (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6415,6415,'no','nein','non', '', '', '', 'true');
 INSERT INTO qgep.vl_small_treatment_plant_remote_monitoring (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6416,6416,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_small_treatment_plant ADD CONSTRAINT fkey_vl_small_treatment_plant_remote_monitoring FOREIGN KEY (remote_monitoring)
 REFERENCES qgep.vl_small_treatment_plant_remote_monitoring (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_wwtp_structure ADD CONSTRAINT oorel_od_wwtp_structure_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_wwtp_structure_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wwtp_structure_kind ADD CONSTRAINT pkey_qgep_vl_wwtp_structure_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (331,331,'sedimentation_basin','Absetzbecken','bassin_de_decantation', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2974,2974,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (327,327,'aeration_tank','Belebtschlammbecken','bassin_a_boues_activees', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (329,329,'fixed_bed_reactor','Festbettreaktor','reacteur_a_biomasse_fixee', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (330,330,'submerged_trickling_filter','Tauchtropfkoerper','disque_bacterien_immerge', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (328,328,'trickling_filter','Tropfkoerper','lit_bacterien', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3032,3032,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_wwtp_structure_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (326,326,'primary_clarifier','Vorklaerbecken','decanteurs_primaires', '', '', '', 'true');
 ALTER TABLE qgep.od_wwtp_structure ADD CONSTRAINT fkey_vl_wwtp_structure_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_wwtp_structure_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT oorel_od_infiltration_installation_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_infiltration_installation_defects () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_defects ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_defects_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_defects (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5361,5361,'none','keine','aucunes', '', 'K', 'AN', 'true');
 INSERT INTO qgep.vl_infiltration_installation_defects (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3276,3276,'marginal','unwesentliche','modestes', '', 'UW', 'MI', 'true');
 INSERT INTO qgep.vl_infiltration_installation_defects (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3275,3275,'substantial','wesentliche','importantes', '', 'W', 'MA', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_defects FOREIGN KEY (defects)
 REFERENCES qgep.vl_infiltration_installation_defects (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_emergency_spillway () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_emergency_spillway ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_emergency_spillway_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5365,5365,'in_combined_waste_water_drain','inMischwasserkanalisation','dans_canalisation_eaux_mixtes', '', 'IMK', 'CEM', 'true');
 INSERT INTO qgep.vl_infiltration_installation_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3307,3307,'in_rain_waste_water_drain','inRegenwasserkanalisation','dans_canalisation_eaux_pluviales', '', 'IRK', 'CEP', 'true');
 INSERT INTO qgep.vl_infiltration_installation_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3304,3304,'in_water_body','inVorfluter','au_cours_d_eau_recepteur', '', 'IV', 'CE', 'true');
 INSERT INTO qgep.vl_infiltration_installation_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3303,3303,'none','keiner','aucun', '', 'K', 'AN', 'true');
 INSERT INTO qgep.vl_infiltration_installation_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3305,3305,'surface_discharge','oberflaechlichausmuendend','deversement_en_surface', '', 'OA', 'DS', 'true');
 INSERT INTO qgep.vl_infiltration_installation_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3308,3308,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_emergency_spillway FOREIGN KEY (emergency_spillway)
 REFERENCES qgep.vl_infiltration_installation_emergency_spillway (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_filling_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_filling_material ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_filling_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_filling_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4785,4785,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_installation_filling_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4786,4786,'wood_chips','Holzschnitzel','copeaux_bois', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_installation_filling_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4787,4787,'soakaway_gravel','Sickerkies','gravier', '', '', '', 'true');
 INSERT INTO qgep.vl_infiltration_installation_filling_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4788,4788,'unknown','unbekannt','inconnue', '', '', '', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_filling_material FOREIGN KEY (filling_material)
 REFERENCES qgep.vl_infiltration_installation_filling_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_kind ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3282,3282,'with_soil_passage','andere_mit_Bodenpassage','autre_avec_passage_a_travers_sol', 'WSP', 'AMB', 'APC', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3285,3285,'without_soil_passage','andere_ohne_Bodenpassage','autre_sans_passage_a_travers_sol', 'WOP', 'AOB', 'ASC', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3279,3279,'surface_infiltration','Flaechenfoermige_Versickerung','infiltration_superficielle_sur_place', '', 'FV', 'IS', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (277,277,'gravel_formation','Kieskoerper','corps_de_gravier', '', 'KK', 'VG', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3284,3284,'combination_manhole_pipe','Kombination_Schacht_Strang','combinaison_puits_bande', '', 'KOM', 'CPT', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3281,3281,'swale_french_drain_infiltration','MuldenRigolenversickerung','cuvettes_rigoles_filtrantes', '', 'MRV', 'ICR', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3087,3087,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3280,3280,'percolation_over_the_shoulder','Versickerung_ueber_die_Schulter','infiltration_par_les_bas_cotes', '', 'VUS', 'IDB', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (276,276,'infiltration_basin','Versickerungsbecken','bassin_d_infiltration', '', 'VB', 'BI', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (278,278,'adsorbing_well','Versickerungsschacht','puits_d_infiltration', '', 'VS', 'PI', 'true');
 INSERT INTO qgep.vl_infiltration_installation_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3283,3283,'infiltration_pipe_sections_gallery','Versickerungsstrang_Galerie','bande_infiltration_galerie', '', 'VG', 'TIG', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_infiltration_installation_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_labeling () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_labeling ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_labeling_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_labeling (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5362,5362,'labeled','beschriftet','signalee', 'L', 'BS', 'SI', 'true');
 INSERT INTO qgep.vl_infiltration_installation_labeling (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5363,5363,'not_labeled','nichtbeschriftet','non_signalee', '', 'NBS', 'NSI', 'true');
 INSERT INTO qgep.vl_infiltration_installation_labeling (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5364,5364,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_labeling FOREIGN KEY (labeling)
 REFERENCES qgep.vl_infiltration_installation_labeling (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_seepage_utilization () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_seepage_utilization ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_seepage_utilization_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_seepage_utilization (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (274,274,'rain_water','Regenabwasser','eaux_pluviales', '', 'RW', 'EP', 'true');
 INSERT INTO qgep.vl_infiltration_installation_seepage_utilization (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (273,273,'clean_water','Reinabwasser','eaux_claires', '', 'KW', 'EC', 'true');
 INSERT INTO qgep.vl_infiltration_installation_seepage_utilization (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5359,5359,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_seepage_utilization FOREIGN KEY (seepage_utilization)
 REFERENCES qgep.vl_infiltration_installation_seepage_utilization (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_vehicle_access () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_vehicle_access ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_vehicle_access_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_vehicle_access (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3289,3289,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_infiltration_installation_vehicle_access (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3288,3288,'inaccessible','unzugaenglich','inaccessible', '', 'ZU', 'IAC', 'true');
 INSERT INTO qgep.vl_infiltration_installation_vehicle_access (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3287,3287,'accessible','zugaenglich','accessible', '', 'Z', 'AC', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_vehicle_access FOREIGN KEY (vehicle_access)
 REFERENCES qgep.vl_infiltration_installation_vehicle_access (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_infiltration_installation_watertightness () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_infiltration_installation_watertightness ADD CONSTRAINT pkey_qgep_vl_infiltration_installation_watertightness_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_infiltration_installation_watertightness (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3295,3295,'not_watertight','nichtwasserdicht','non_etanche', '', 'NWD', 'NE', 'true');
 INSERT INTO qgep.vl_infiltration_installation_watertightness (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5360,5360,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_infiltration_installation_watertightness (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3294,3294,'watertight','wasserdicht','etanche', '', 'WD', 'E', 'true');
 ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT fkey_vl_infiltration_installation_watertightness FOREIGN KEY (watertightness)
 REFERENCES qgep.vl_infiltration_installation_watertightness (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_infiltration_installation ADD COLUMN fk_aquifier varchar (16);
ALTER TABLE qgep.od_infiltration_installation ADD CONSTRAINT rel_infiltration_installation_aquifier FOREIGN KEY (fk_aquifier) REFERENCES qgep.od_aquifier(obj_id);
ALTER TABLE qgep.od_channel ADD CONSTRAINT oorel_od_channel_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_channel_bedding_encasement () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_bedding_encasement ADD CONSTRAINT pkey_qgep_vl_channel_bedding_encasement_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5325,5325,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5332,5332,'in_soil','erdverlegt','enterre', 'IS', 'EV', 'ET', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5328,5328,'in_channel_suspended','in_Kanal_aufgehaengt','suspendu_dans_le_canal', '', 'IKA', 'CS', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5339,5339,'in_channel_concrete_casted','in_Kanal_einbetoniert','betonne_dans_le_canal', '', 'IKB', 'CB', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5331,5331,'in_walk_in_passage','in_Leitungsgang','en_galerie', '', 'ILG', 'G', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5337,5337,'in_jacking_pipe_concrete','in_Vortriebsrohr_Beton','en_pousse_tube_en_beton', '', 'IVB', 'TB', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5336,5336,'in_jacking_pipe_steel','in_Vortriebsrohr_Stahl','en_pousse_tube_en_acier', '', 'IVS', 'TA', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5335,5335,'sand','Sand','sable', '', 'SA', 'SA', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5333,5333,'sia_type_1','SIA_Typ1','SIA_type_1', '', 'B1', 'B1', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5330,5330,'sia_type_2','SIA_Typ2','SIA_type_2', '', 'B2', 'B2', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5334,5334,'sia_type_3','SIA_Typ3','SIA_type_3', '', 'B3', 'B3', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5340,5340,'sia_type_4','SIA_Typ4','SIA_type_4', '', 'B4', 'B4', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5327,5327,'bed_plank','Sohlbrett','radier_en_planches', '', 'SB', 'RP', 'true');
 INSERT INTO qgep.vl_channel_bedding_encasement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5329,5329,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_bedding_encasement FOREIGN KEY (bedding_encasement)
 REFERENCES qgep.vl_channel_bedding_encasement (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_connection_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_connection_type ADD CONSTRAINT pkey_qgep_vl_channel_connection_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5341,5341,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (190,190,'electric_welded_sleeves','Elektroschweissmuffen','manchon_electrosoudable', 'EWS', 'EL', 'MSA', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (187,187,'flat_sleeves','Flachmuffen','manchon_plat', '', 'FM', 'MP', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (193,193,'flange','Flansch','bride', '', 'FL', 'B', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (185,185,'bell_shaped_sleeves','Glockenmuffen','emboitement_a_cloche', '', 'GL', 'EC', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (192,192,'coupling','Kupplung','raccord', '', 'KU', 'R', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (194,194,'screwed_sleeves','Schraubmuffen','manchon_visse', '', 'SC', 'MV', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (189,189,'butt_welded','spiegelgeschweisst','manchon_soude_au_miroir', '', 'SP', 'MSM', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (186,186,'beaked_sleeves','Spitzmuffen','emboitement_simple', '', 'SM', 'ES', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (191,191,'push_fit_sleeves','Steckmuffen','raccord_a_serrage', '', 'ST', 'RS', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (188,188,'slip_on_sleeves','Ueberschiebmuffen','manchon_coulissant', '', 'UE', 'MC', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3036,3036,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_channel_connection_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3666,3666,'jacking_pipe_coupling','Vortriebsrohrkupplung','raccord_pour_tube_de_pousse_tube', '', 'VK', 'RTD', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_connection_type FOREIGN KEY (connection_type)
 REFERENCES qgep.vl_channel_connection_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_function_amelioration () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_function_amelioration ADD CONSTRAINT pkey_qgep_vl_channel_function_amelioration_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_function_amelioration (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4582,4582,'main_sewer','Hauptkanal','collecteur_principal', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_amelioration (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4583,4583,'collector_sewer','Sammelkanal','collecteur', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_amelioration (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4584,4584,'suction_pipe','Sauger','drains', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_amelioration (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4585,4585,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_function_amelioration FOREIGN KEY (function_amelioration)
 REFERENCES qgep.vl_channel_function_amelioration (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_function_hierarchic () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_function_hierarchic ADD CONSTRAINT pkey_qgep_vl_channel_function_hierarchic_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5066,5066,'pwwf.other','PAA.andere','OAP.autre', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5068,5068,'pwwf.water_bodies','PAA.Gewaesser','OAP.cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5069,5069,'pwwf.main_drain','PAA.Hauptsammelkanal','OAP.collecteur_principal', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5070,5070,'pwwf.main_drain_regional','PAA.Hauptsammelkanal_regional','OAP.collecteur_principal_regional', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5064,5064,'pwwf.residential_drainage','PAA.Liegenschaftsentwaesserung','OAP.evacuation_bien_fonds', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5071,5071,'pwwf.collector_sewer','PAA.Sammelkanal','OAP.collecteur', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5062,5062,'pwwf.renovation_conduction','PAA.Sanierungsleitung','OAP.conduite_d_assainissement', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5072,5072,'pwwf.road_drainage','PAA.Strassenentwaesserung','OAP.evacuation_des_eaux_de_routes', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5074,5074,'pwwf.unknown','PAA.unbekannt','OAP.inconnue', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5067,5067,'swwf.other','SAA.andere','OAS.autre', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5065,5065,'swwf.residential_drainage','SAA.Liegenschaftsentwaesserung','OAS.evacuation_bien_fonds', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5063,5063,'swwf.renovation_conduction','SAA.Sanierungsleitung','OAS.conduite_d_assainissement', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5073,5073,'swwf.road_drainage','SAA.Strassenentwaesserung','OAS.evacuation_des_eaux_de_routes', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hierarchic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5075,5075,'swwf.unknown','SAA.unbekannt','OAS.inconnue', '', '', '', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_function_hierarchic FOREIGN KEY (function_hierarchic)
 REFERENCES qgep.vl_channel_function_hierarchic (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_function_hydraulic () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_function_hydraulic ADD CONSTRAINT pkey_qgep_vl_channel_function_hydraulic_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5320,5320,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2546,2546,'drainage_transportation_pipe','Drainagetransportleitung','conduite_de_transport_pour_le_drainage', 'DTP', 'DT', 'CTD', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (22,22,'restriction_pipe','Drosselleitung','conduite_d_etranglement', 'RP', 'DR', 'CE', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3610,3610,'inverted_syphon','Duekerleitung','siphon_inverse', 'IS', 'DU', 'S', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (367,367,'gravity_pipe','Freispiegelleitung','conduite_a_ecoulement_gravitaire', '', 'FL', 'CEL', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (23,23,'pump_pressure_pipe','Pumpendruckleitung','conduite_de_refoulement', '', 'DL', 'CR', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (145,145,'seepage_water_drain','Sickerleitung','conduite_de_drainage', 'SP', 'SI', 'CI', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (21,21,'retention_pipe','Speicherleitung','conduite_de_retention', '', 'SK', 'CA', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (144,144,'jetting_pipe','Spuelleitung','conduite_de_rincage', 'JP', 'SL', 'CC', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5321,5321,'unknown','unbekannt','inconnue', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_function_hydraulic (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3655,3655,'vacuum_pipe','Vakuumleitung','conduite_sous_vide', '', 'VL', 'CV', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_function_hydraulic FOREIGN KEY (function_hydraulic)
 REFERENCES qgep.vl_channel_function_hydraulic (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_seepage () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_seepage ADD CONSTRAINT pkey_qgep_vl_channel_seepage_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_seepage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4793,4793,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_seepage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4794,4794,'wood_chips','Holzschnitzel','copeaux_bois', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_seepage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4795,4795,'soakaway_gravel','Sickerkies','gravier', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_seepage (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4796,4796,'unknown','unbekannt','inconnue', '', '', '', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_seepage FOREIGN KEY (seepage)
 REFERENCES qgep.vl_channel_seepage (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_usage_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_usage_current ADD CONSTRAINT pkey_qgep_vl_channel_usage_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5322,5322,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4518,4518,'creek_water','Bachwasser','eaux_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4516,4516,'discharged_combined_wastewater','entlastetes_Mischabwasser','eaux_mixtes_deversees', 'DCW', 'EW', 'EUD', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4524,4524,'industrial_wastewater','Industrieabwasser','eaux_industrielles', '', 'CW', 'EUC', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4522,4522,'combined_wastewater','Mischabwasser','eaux_mixtes', '', 'MW', 'EUM', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4520,4520,'rain_wastewater','Regenabwasser','eaux_pluviales', '', 'RW', 'EUP', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4514,4514,'clean_wastewater','Reinabwasser','eaux_claires', '', 'KW', 'EUR', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4526,4526,'wastewater','Schmutzabwasser','eaux_usees', '', 'SW', 'EU', 'true');
 INSERT INTO qgep.vl_channel_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4571,4571,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_usage_current FOREIGN KEY (usage_current)
 REFERENCES qgep.vl_channel_usage_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_channel_usage_planned () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_channel_usage_planned ADD CONSTRAINT pkey_qgep_vl_channel_usage_planned_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5323,5323,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4519,4519,'creek_water','Bachwasser','eaux_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4517,4517,'discharged_combined_wastewater','entlastetes_Mischabwasser','eaux_mixtes_deversees', 'DCW', 'EW', 'EUD', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4525,4525,'industrial_wastewater','Industrieabwasser','eaux_industrielles', '', 'CW', 'EUC', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4523,4523,'combined_wastewater','Mischabwasser','eaux_mixtes', '', 'MW', 'EUM', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4521,4521,'rain_wastewater','Regenabwasser','eaux_pluviales', '', 'RW', 'EUP', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4515,4515,'clean_wastewater','Reinabwasser','eaux_claires', '', 'KW', 'EUR', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4527,4527,'wastewater','Schmutzabwasser','eaux_usees', '', 'SW', 'EU', 'true');
 INSERT INTO qgep.vl_channel_usage_planned (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4569,4569,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_channel ADD CONSTRAINT fkey_vl_channel_usage_planned FOREIGN KEY (usage_planned)
 REFERENCES qgep.vl_channel_usage_planned (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_special_structure ADD CONSTRAINT oorel_od_special_structure_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_special_structure_bypass () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_special_structure_bypass ADD CONSTRAINT pkey_qgep_vl_special_structure_bypass_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_special_structure_bypass (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2682,2682,'inexistent','nicht_vorhanden','inexistant', '', 'NV', 'IE', 'true');
 INSERT INTO qgep.vl_special_structure_bypass (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3055,3055,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_special_structure_bypass (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2681,2681,'existent','vorhanden','existant', '', 'V', 'E', 'true');
 ALTER TABLE qgep.od_special_structure ADD CONSTRAINT fkey_vl_special_structure_bypass FOREIGN KEY (bypass)
 REFERENCES qgep.vl_special_structure_bypass (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_special_structure_emergency_spillway () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_special_structure_emergency_spillway ADD CONSTRAINT pkey_qgep_vl_special_structure_emergency_spillway_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_special_structure_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5866,5866,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5864,5864,'in_combined_waste_water_drain','inMischabwasserkanalisation','dans_canalisation_eaux_mixtes', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5865,5865,'in_rain_waste_water_drain','inRegenabwasserkanalisation','dans_canalisation_eaux_pluviales', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5863,5863,'in_waste_water_drain','inSchmutzabwasserkanalisation','dans_canalisation_eaux_usees', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5878,5878,'none','keiner','aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_emergency_spillway (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5867,5867,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_special_structure ADD CONSTRAINT fkey_vl_special_structure_emergency_spillway FOREIGN KEY (emergency_spillway)
 REFERENCES qgep.vl_special_structure_emergency_spillway (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_special_structure_function () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_special_structure_function ADD CONSTRAINT pkey_qgep_vl_special_structure_function_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6397,6397,'pit_without_drain','abflussloseGrube','fosse_etanche', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (245,245,'drop_structure','Absturzbauwerk','ouvrage_de_chute', 'DS', 'AK', 'OC', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6398,6398,'hydrolizing_tank','Abwasserfaulraum','fosse_digestive', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5371,5371,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (386,386,'venting','Be_Entlueftung','aeration', 'VE', 'BE', 'AE', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3234,3234,'inverse_syphon_chamber','Duekerkammer','chambre_avec_siphon_inverse', 'ISC', 'DK', 'SI', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5091,5091,'syphon_head','Duekeroberhaupt','entree_de_siphon', 'SH', 'DO', 'ESI', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6399,6399,'septic_tank_two_chambers','Faulgrube','fosse_septique', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3348,3348,'terrain_depression','Gelaendemulde','depression_de_terrain', '', 'GM', 'DT', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (336,336,'bolders_bedload_catchement_dam','Geschiebefang','depotoir_pour_alluvions', '', 'GF', 'DA', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5494,5494,'cesspit','Guellegrube','fosse_a_purin', '', '', '', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6478,6478,'septic_tank','Klaergrube','fosse_de_decantation', '', 'KG', 'FD', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2998,2998,'manhole','Kontrollschacht','regard_de_visite', '', 'KS', 'RV', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2768,2768,'oil_separator','Oelabscheider','separateur_d_hydrocarbures', '', 'OA', 'SH', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (246,246,'pump_station','Pumpwerk','station_de_pompage', '', 'PW', 'SP', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3673,3673,'stormwater_tank_with_overflow','Regenbecken_Durchlaufbecken','BEP_decantation', '', 'DB', 'BDE', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3674,3674,'stormwater_tank_retaining_first_flush','Regenbecken_Fangbecken','BEP_retention', '', 'FB', 'BRE', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5574,5574,'stormwater_retaining_channel','Regenbecken_Fangkanal','BEP_canal_retention', 'TRE', 'FK', 'BCR', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3675,3675,'stormwater_sedimentation_tank','Regenbecken_Regenklaerbecken','BEP_clarification', '', 'RKB', 'BCL', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3676,3676,'stormwater_retention_tank','Regenbecken_Regenrueckhaltebecken','BEP_accumulation', '', 'RRB', 'BAC', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5575,5575,'stormwater_retention_channel','Regenbecken_Regenrueckhaltekanal','BEP_canal_accumulation', 'TRC', 'RRK', 'BCA', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5576,5576,'stormwater_storage_channel','Regenbecken_Stauraumkanal','BEP_canal_stockage', 'TSC', 'SRK', 'BCS', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3677,3677,'stormwater_composite_tank','Regenbecken_Verbundbecken','BEP_combine', '', 'VB', 'BCO', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5372,5372,'stormwater_overflow','Regenueberlauf','deversoir_d_orage', '', 'RU', 'DO', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5373,5373,'floating_material_separator','Schwimmstoffabscheider','separateur_de_materiaux_flottants', '', 'SW', 'SMF', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (383,383,'side_access','seitlicherZugang','acces_lateral', '', 'SZ', 'AL', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (227,227,'jetting_manhole','Spuelschacht','chambre_de_chasse', '', 'SS', 'CC', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4799,4799,'separating_structure','Trennbauwerk','ouvrage_de_repartition', '', 'TB', 'OR', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3008,3008,'unknown','unbekannt','inconnu', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_special_structure_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2745,2745,'vortex_manhole','Wirbelfallschacht','chambre_de_chute_a_vortex', '', 'WF', 'CT', 'true');
 ALTER TABLE qgep.od_special_structure ADD CONSTRAINT fkey_vl_special_structure_function FOREIGN KEY (function)
 REFERENCES qgep.vl_special_structure_function (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_special_structure_stormwater_tank_arrangement () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_special_structure_stormwater_tank_arrangement ADD CONSTRAINT pkey_qgep_vl_special_structure_stormwater_tank_arrangement_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_special_structure_stormwater_tank_arrangement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4608,4608,'main_connection','Hauptschluss','connexion_directe', '', 'HS', 'CD', 'true');
 INSERT INTO qgep.vl_special_structure_stormwater_tank_arrangement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4609,4609,'side_connection','Nebenschluss','connexion_laterale', '', 'NS', 'CL', 'true');
 INSERT INTO qgep.vl_special_structure_stormwater_tank_arrangement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4610,4610,'unknown','unbekannt','inconnue', '', '', '', 'true');
 ALTER TABLE qgep.od_special_structure ADD CONSTRAINT fkey_vl_special_structure_stormwater_tank_arrangement FOREIGN KEY (stormwater_tank_arrangement)
 REFERENCES qgep.vl_special_structure_stormwater_tank_arrangement (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_discharge_point ADD CONSTRAINT oorel_od_discharge_point_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_discharge_point_relevance () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_discharge_point_relevance ADD CONSTRAINT pkey_qgep_vl_discharge_point_relevance_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_discharge_point_relevance (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5580,5580,'relevant_for_water_course','gewaesserrelevant','pertinent_pour_milieu_recepteur', '', '', '', 'true');
 INSERT INTO qgep.vl_discharge_point_relevance (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5581,5581,'non_relevant_for_water_course','nicht_gewaesserrelevant','insignifiant_pour_milieu_recepteur', '', '', '', 'true');
 ALTER TABLE qgep.od_discharge_point ADD CONSTRAINT fkey_vl_discharge_point_relevance FOREIGN KEY (relevance)
 REFERENCES qgep.vl_discharge_point_relevance (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_discharge_point ADD COLUMN fk_sector_water_body varchar (16);
ALTER TABLE qgep.od_discharge_point ADD CONSTRAINT rel_discharge_point_sector_water_body FOREIGN KEY (fk_sector_water_body) REFERENCES qgep.od_sector_water_body(obj_id);
ALTER TABLE qgep.od_manhole ADD CONSTRAINT oorel_od_manhole_wastewater_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_structure(obj_id);
CREATE TABLE qgep.vl_manhole_function () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_manhole_function ADD CONSTRAINT pkey_qgep_vl_manhole_function_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4532,4532,'drop_structure','Absturzbauwerk','ouvrage_de_chute', 'DS', 'AK', 'OC', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5344,5344,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4533,4533,'venting','Be_Entlueftung','aeration', 'VE', 'BE', 'AE', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3267,3267,'rain_water_manhole','Dachwasserschacht','chambre_recolte_eaux_toitures', 'RWM', 'DS', 'CRT', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3266,3266,'gully','Einlaufschacht','chambre_avec_grille_d_entree', 'G', 'ES', 'CG', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3472,3472,'drainage_channel','Entwaesserungsrinne','rigole_de_drainage', '', 'ER', 'RD', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (228,228,'rail_track_gully','Geleiseschacht','evacuation_des_eaux_des_voies_ferrees', '', 'GL', 'EVF', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (204,204,'manhole','Kontrollschacht','regard_de_visite', '', 'KS', 'CC', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (1008,1008,'oil_separator','Oelabscheider','separateur_d_hydrocarbures', 'OS', 'OA', 'SH', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4536,4536,'pump_station','Pumpwerk','station_de_pompage', '', 'PW', 'SP', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5346,5346,'stormwater_overflow','Regenueberlauf','deversoir_d_orage', '', 'HE', 'DO', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2742,2742,'slurry_collector','Schlammsammler','depotoir', '', 'SA', 'D', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5347,5347,'floating_material_separator','Schwimmstoffabscheider','separateur_de_materiaux_flottants', '', 'SW', 'SMF', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4537,4537,'jetting_manhole','Spuelschacht','chambre_de_chasse', '', 'SS', 'CC', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4798,4798,'separating_structure','Trennbauwerk','ouvrage_de_repartition', '', 'TB', 'OR', 'true');
 INSERT INTO qgep.vl_manhole_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5345,5345,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 ALTER TABLE qgep.od_manhole ADD CONSTRAINT fkey_vl_manhole_function FOREIGN KEY (function)
 REFERENCES qgep.vl_manhole_function (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_manhole_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_manhole_material ADD CONSTRAINT pkey_qgep_vl_manhole_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_manhole_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4540,4540,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_manhole_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4541,4541,'concrete','Beton','beton', '', '', '', 'true');
 INSERT INTO qgep.vl_manhole_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4542,4542,'plastic','Kunststoff','matiere_plastique', '', '', '', 'true');
 INSERT INTO qgep.vl_manhole_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4543,4543,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_manhole ADD CONSTRAINT fkey_vl_manhole_material FOREIGN KEY (material)
 REFERENCES qgep.vl_manhole_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_manhole_surface_inflow () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_manhole_surface_inflow ADD CONSTRAINT pkey_qgep_vl_manhole_surface_inflow_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_manhole_surface_inflow (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5342,5342,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_manhole_surface_inflow (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2741,2741,'none','keiner','aucune', '', 'K', 'AN', 'true');
 INSERT INTO qgep.vl_manhole_surface_inflow (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2739,2739,'grid','Rost','grille_d_ecoulement', '', 'R', 'G', 'true');
 INSERT INTO qgep.vl_manhole_surface_inflow (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5343,5343,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_manhole_surface_inflow (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2740,2740,'intake_from_side','Zulauf_seitlich','arrivee_laterale', '', 'ZS', 'AL', 'true');
 ALTER TABLE qgep.od_manhole ADD CONSTRAINT fkey_vl_manhole_surface_inflow FOREIGN KEY (surface_inflow)
 REFERENCES qgep.vl_manhole_surface_inflow (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_lake ADD CONSTRAINT oorel_od_lake_surface_water_bodies FOREIGN KEY (obj_id) REFERENCES qgep.od_surface_water_bodies(obj_id);
ALTER TABLE qgep.od_river ADD CONSTRAINT oorel_od_river_surface_water_bodies FOREIGN KEY (obj_id) REFERENCES qgep.od_surface_water_bodies(obj_id);
CREATE TABLE qgep.vl_river_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_river_kind ADD CONSTRAINT pkey_qgep_vl_river_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_river_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3397,3397,'englacial_river','Gletscherbach','ruisseau_de_glacier', '', '', '', 'true');
 INSERT INTO qgep.vl_river_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3399,3399,'marsh_river','Moorbach','ruisseau_de_tourbiere', '', '', '', 'true');
 INSERT INTO qgep.vl_river_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3398,3398,'lake_outflow','Seeausfluss','effluent_d_un_lac', '', '', '', 'true');
 INSERT INTO qgep.vl_river_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3396,3396,'travertine_river','Travertinbach','ruisseau_sur_fond_tufcalcaire', '', '', '', 'true');
 INSERT INTO qgep.vl_river_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3400,3400,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_river ADD CONSTRAINT fkey_vl_river_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_river_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_chute ADD CONSTRAINT oorel_od_chute_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
CREATE TABLE qgep.vl_chute_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_chute_kind ADD CONSTRAINT pkey_qgep_vl_chute_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_chute_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3591,3591,'artificial','kuenstlich','artificiel', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3592,3592,'natural','natuerlich','naturel', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3593,3593,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_chute ADD CONSTRAINT fkey_vl_chute_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_chute_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_chute_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_chute_material ADD CONSTRAINT pkey_qgep_vl_chute_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_chute_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2633,2633,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (409,409,'concrete_or_rock_pavement','Beton_Steinpflaesterung','beton_pavage_de_pierres', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (411,411,'rocks_or_boulders','Fels_Steinbloecke','rocher_blocs_de_rocher', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (408,408,'wood','Holz','bois', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (410,410,'natural_none','natuerlich_kein','naturel_aucun', '', '', '', 'true');
 INSERT INTO qgep.vl_chute_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3061,3061,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_chute ADD CONSTRAINT fkey_vl_chute_material FOREIGN KEY (material)
 REFERENCES qgep.vl_chute_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_blocking_debris ADD CONSTRAINT oorel_od_blocking_debris_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
ALTER TABLE qgep.od_lock ADD CONSTRAINT oorel_od_lock_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
ALTER TABLE qgep.od_dam ADD CONSTRAINT oorel_od_dam_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
CREATE TABLE qgep.vl_dam_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_dam_kind ADD CONSTRAINT pkey_qgep_vl_dam_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_dam_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (416,416,'retaining_weir','Stauwehr','digue_reservoir', '', '', '', 'true');
 INSERT INTO qgep.vl_dam_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (417,417,'spillway','Streichwehr','deversoir_lateral', '', '', '', 'true');
 INSERT INTO qgep.vl_dam_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (419,419,'dam','Talsperre','barrage', '', '', '', 'true');
 INSERT INTO qgep.vl_dam_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (418,418,'tyrolean_weir','Tirolerwehr','prise_tyrolienne', '', '', '', 'true');
 INSERT INTO qgep.vl_dam_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3064,3064,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_dam ADD CONSTRAINT fkey_vl_dam_kind FOREIGN KEY (kind)
 REFERENCES qgep.vl_dam_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_ford ADD CONSTRAINT oorel_od_ford_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
ALTER TABLE qgep.od_rock_ramp ADD CONSTRAINT oorel_od_rock_ramp_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
CREATE TABLE qgep.vl_rock_ramp_stabilisation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_rock_ramp_stabilisation ADD CONSTRAINT pkey_qgep_vl_rock_ramp_stabilisation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2635,2635,'other_smooth','andere_glatt','autres_lisse', '', '', '', 'true');
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2634,2634,'other_rough','andere_rauh','autres_rugueux', '', '', '', 'true');
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (415,415,'concrete_channel','Betonrinne','lit_en_beton', '', '', '', 'true');
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (412,412,'rocks_or_boulders','Blockwurf','enrochement', '', '', '', 'true');
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (413,413,'paved','gepflaestert','pavement', '', '', '', 'true');
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (414,414,'wooden_beam','Holzbalken','poutres_en_bois', '', '', '', 'true');
 INSERT INTO qgep.vl_rock_ramp_stabilisation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3063,3063,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_rock_ramp ADD CONSTRAINT fkey_vl_rock_ramp_stabilisation FOREIGN KEY (stabilisation)
 REFERENCES qgep.vl_rock_ramp_stabilisation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_passage ADD CONSTRAINT oorel_od_passage_water_control_structure FOREIGN KEY (obj_id) REFERENCES qgep.od_water_control_structure(obj_id);
ALTER TABLE qgep.od_damage_manhole ADD CONSTRAINT oorel_od_damage_manhole_damage FOREIGN KEY (obj_id) REFERENCES qgep.od_damage(obj_id);
CREATE TABLE qgep.vl_damage_manhole_connection () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_damage_manhole_connection ADD CONSTRAINT pkey_qgep_vl_damage_manhole_connection_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_damage_manhole_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3740,3740,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3741,3741,'no','nein','non', '', '', '', 'true');
 ALTER TABLE qgep.od_damage_manhole ADD CONSTRAINT fkey_vl_damage_manhole_connection FOREIGN KEY (connection)
 REFERENCES qgep.vl_damage_manhole_connection (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_damage_manhole_damage_code_manhole () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_damage_manhole_damage_code_manhole ADD CONSTRAINT pkey_qgep_vl_damage_manhole_damage_code_manhole_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4148,4148,'DAAA','DAAA','DAAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4149,4149,'DAAB','DAAB','DAAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4150,4150,'DABAA','DABAA','DABAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4151,4151,'DABAB','DABAB','DABAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4152,4152,'DABAC','DABAC','DABAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4153,4153,'DABAD','DABAD','DABAD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4154,4154,'DABBA','DABBA','DABBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4155,4155,'DABBB','DABBB','DABBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4156,4156,'DABBC','DABBC','DABBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4157,4157,'DABBD','DABBD','DABBD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4158,4158,'DABCA','DABCA','DABCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4159,4159,'DABCB','DABCB','DABCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4160,4160,'DABCC','DABCC','DABCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4161,4161,'DABCD','DABCD','DABCD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4162,4162,'DACA','DACA','DACA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4163,4163,'DACB','DACB','DACB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4164,4164,'DACC','DACC','DACC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4165,4165,'DADA','DADA','DADA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4166,4166,'DADB','DADB','DADB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4167,4167,'DADC','DADC','DADC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4168,4168,'DAE','DAE','DAE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4169,4169,'DAFAA','DAFAA','DAFAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4170,4170,'DAFAB','DAFAB','DAFAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4171,4171,'DAFAC','DAFAC','DAFAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4172,4172,'DAFAD','DAFAD','DAFAD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4173,4173,'DAFAE','DAFAE','DAFAE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4174,4174,'DAFBA','DAFBA','DAFBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4175,4175,'DAFBE','DAFBE','DAFBE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4176,4176,'DAFCA','DAFCA','DAFCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4177,4177,'DAFCB','DAFCB','DAFCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4178,4178,'DAFCC','DAFCC','DAFCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4179,4179,'DAFCD','DAFCD','DAFCD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4180,4180,'DAFCE','DAFCE','DAFCE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4181,4181,'DAFDA','DAFDA','DAFDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4182,4182,'DAFDB','DAFDB','DAFDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4183,4183,'DAFDC','DAFDC','DAFDC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4184,4184,'DAFDD','DAFDD','DAFDD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4185,4185,'DAFDE','DAFDE','DAFDE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4186,4186,'DAFEA','DAFEA','DAFEA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4187,4187,'DAFEB','DAFEB','DAFEB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4188,4188,'DAFEC','DAFEC','DAFEC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4189,4189,'DAFED','DAFED','DAFED', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4190,4190,'DAFEE','DAFEE','DAFEE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4191,4191,'DAFFA','DAFFA','DAFFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4192,4192,'DAFFB','DAFFB','DAFFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4193,4193,'DAFFC','DAFFC','DAFFC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4194,4194,'DAFFD','DAFFD','DAFFD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4195,4195,'DAFFE','DAFFE','DAFFE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4196,4196,'DAFGA','DAFGA','DAFGA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4197,4197,'DAFGB','DAFGB','DAFGB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4198,4198,'DAFGC','DAFGC','DAFGC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4199,4199,'DAFGD','DAFGD','DAFGD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4200,4200,'DAFGE','DAFGE','DAFGE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4201,4201,'DAFHB','DAFHB','DAFHB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4202,4202,'DAFHC','DAFHC','DAFHC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4203,4203,'DAFHD','DAFHD','DAFHD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4204,4204,'DAFHE','DAFHE','DAFHE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4205,4205,'DAFIA','DAFIA','DAFIA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4206,4206,'DAFIB','DAFIB','DAFIB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4207,4207,'DAFIC','DAFIC','DAFIC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4208,4208,'DAFID','DAFID','DAFID', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4209,4209,'DAFIE','DAFIE','DAFIE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4210,4210,'DAFJB','DAFJB','DAFJB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4211,4211,'DAFJC','DAFJC','DAFJC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4212,4212,'DAFJD','DAFJD','DAFJD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4213,4213,'DAFJE','DAFJE','DAFJE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4214,4214,'DAFZA','DAFZA','DAFZA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4215,4215,'DAFZB','DAFZB','DAFZB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4216,4216,'DAFZC','DAFZC','DAFZC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4217,4217,'DAFZD','DAFZD','DAFZD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4218,4218,'DAFZE','DAFZE','DAFZE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4219,4219,'DAG','DAG','DAG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4220,4220,'DAHA','DAHA','DAHA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4221,4221,'DAHB','DAHB','DAHB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4222,4222,'DAHC','DAHC','DAHC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4223,4223,'DAHD','DAHD','DAHD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4224,4224,'DAHE','DAHE','DAHE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4225,4225,'DAHZ','DAHZ','DAHZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4226,4226,'DAIAA','DAIAA','DAIAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4227,4227,'DAIAB','DAIAB','DAIAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4228,4228,'DAIAC','DAIAC','DAIAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4229,4229,'DAIZ','DAIZ','DAIZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4230,4230,'DAJA','DAJA','DAJA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4231,4231,'DAJB','DAJB','DAJB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4232,4232,'DAJC','DAJC','DAJC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4233,4233,'DAKA','DAKA','DAKA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4234,4234,'DAKB','DAKB','DAKB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4235,4235,'DAKC','DAKC','DAKC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4236,4236,'DAKDA','DAKDA','DAKDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4237,4237,'DAKDB','DAKDB','DAKDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4238,4238,'DAKDC','DAKDC','DAKDC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4239,4239,'DAKE','DAKE','DAKE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4240,4240,'DAKZ','DAKZ','DAKZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4241,4241,'DALA','DALA','DALA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4242,4242,'DALB','DALB','DALB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4243,4243,'DALZ','DALZ','DALZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4244,4244,'DAMA','DAMA','DAMA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4245,4245,'DAMB','DAMB','DAMB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4246,4246,'DAMC','DAMC','DAMC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4247,4247,'DAN','DAN','DAN', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4248,4248,'DAO','DAO','DAO', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4249,4249,'DAP','DAP','DAP', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4250,4250,'DAQA','DAQA','DAQA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4251,4251,'DAQB','DAQB','DAQB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4252,4252,'DAQC','DAQC','DAQC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4253,4253,'DAQD','DAQD','DAQD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4254,4254,'DAQE','DAQE','DAQE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4255,4255,'DAQF','DAQF','DAQF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4256,4256,'DAQG','DAQG','DAQG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4257,4257,'DAQH','DAQH','DAQH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4258,4258,'DAQI','DAQI','DAQI', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4259,4259,'DAQJ','DAQJ','DAQJ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4260,4260,'DAQK','DAQK','DAQK', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4261,4261,'DAQZ','DAQZ','DAQZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4262,4262,'DARA','DARA','DARA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4263,4263,'DARB','DARB','DARB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4264,4264,'DARC','DARC','DARC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4265,4265,'DARD','DARD','DARD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4266,4266,'DARE','DARE','DARE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4267,4267,'DARF','DARF','DARF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4268,4268,'DARG','DARG','DARG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4269,4269,'DARH','DARH','DARH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4270,4270,'DARZ','DARZ','DARZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4271,4271,'DBAA','DBAA','DBAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4272,4272,'DBAB','DBAB','DBAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4273,4273,'DBAC','DBAC','DBAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4274,4274,'DBBA','DBBA','DBBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4275,4275,'DBBB','DBBB','DBBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4276,4276,'DBBC','DBBC','DBBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4277,4277,'DBBZ','DBBZ','DBBZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4278,4278,'DBCA','DBCA','DBCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4279,4279,'DBCB','DBCB','DBCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4280,4280,'DBCC','DBCC','DBCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4281,4281,'DBCZ','DBCZ','DBCZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4282,4282,'DBD','DBD','DBD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4283,4283,'DBEA','DBEA','DBEA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4284,4284,'DBEB','DBEB','DBEB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4285,4285,'DBEC','DBEC','DBEC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4286,4286,'DBED','DBED','DBED', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4287,4287,'DBEE','DBEE','DBEE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4288,4288,'DBEF','DBEF','DBEF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4289,4289,'DBEG','DBEG','DBEG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4290,4290,'DBEH','DBEH','DBEH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4291,4291,'DBEZ','DBEZ','DBEZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4292,4292,'DBFAA','DBFAA','DBFAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4293,4293,'DBFAB','DBFAB','DBFAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4294,4294,'DBFAC','DBFAC','DBFAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4295,4295,'DBFBA','DBFBA','DBFBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4296,4296,'DBFBB','DBFBB','DBFBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4297,4297,'DBFBC','DBFBC','DBFBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4298,4298,'DBFCA','DBFCA','DBFCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4299,4299,'DBFCB','DBFCB','DBFCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4300,4300,'DBFCC','DBFCC','DBFCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4301,4301,'DBFDA','DBFDA','DBFDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4302,4302,'DBFDB','DBFDB','DBFDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4303,4303,'DBFDC','DBFDC','DBFDC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4304,4304,'DBG','DBG','DBG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4305,4305,'DBHAA','DBHAA','DBHAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4306,4306,'DBHAB','DBHAB','DBHAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4307,4307,'DBHAC','DBHAC','DBHAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4308,4308,'DBHAZ','DBHAZ','DBHAZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4309,4309,'DBHBA','DBHBA','DBHBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4310,4310,'DBHBB','DBHBB','DBHBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4311,4311,'DBHBC','DBHBC','DBHBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4312,4312,'DBHBZ','DBHBZ','DBHBZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4313,4313,'DBHZA','DBHZA','DBHZA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4314,4314,'DBHZB','DBHZB','DBHZB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4315,4315,'DBHZC','DBHZC','DBHZC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4316,4316,'DBHZZ','DBHZZ','DBHZZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4317,4317,'DCAA','DCAA','DCAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4318,4318,'DCAB','DCAB','DCAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4319,4319,'DCAC','DCAC','DCAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4320,4320,'DCAD','DCAD','DCAD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4321,4321,'DCAE','DCAE','DCAE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4322,4322,'DCAF','DCAF','DCAF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4323,4323,'DCAZ','DCAZ','DCAZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4324,4324,'DCBA','DCBA','DCBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4325,4325,'DCBB','DCBB','DCBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4326,4326,'DCBC','DCBC','DCBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4327,4327,'DCBZ','DCBZ','DCBZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4328,4328,'DCFA','DCFA','DCFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4329,4329,'DCFB','DCFB','DCFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4330,4330,'DCFC','DCFC','DCFC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4331,4331,'DCFD','DCFD','DCFD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4332,4332,'DCFE','DCFE','DCFE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4333,4333,'DCFF','DCFF','DCFF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4334,4334,'DCFG','DCFG','DCFG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4335,4335,'DCFH','DCFH','DCFH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4336,4336,'DCFI','DCFI','DCFI', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4337,4337,'DCFJ','DCFJ','DCFJ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4338,4338,'DCFK','DCFK','DCFK', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4339,4339,'DCFL','DCFL','DCFL', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4340,4340,'DCFM','DCFM','DCFM', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4341,4341,'DCFN','DCFN','DCFN', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4342,4342,'DCFO','DCFO','DCFO', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4343,4343,'DCFP','DCFP','DCFP', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4344,4344,'DCFQ','DCFQ','DCFQ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4345,4345,'DCFR','DCFR','DCFR', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4346,4346,'DCFS','DCFS','DCFS', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4347,4347,'DCFT','DCFT','DCFT', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4348,4348,'DCFU','DCFU','DCFU', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4349,4349,'DCFV','DCFV','DCFV', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4350,4350,'DCFW','DCFW','DCFW', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4351,4351,'DCFX','DCFX','DCFX', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4352,4352,'DCGAA','DCGAA','DCGAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4353,4353,'DCGAB','DCGAB','DCGAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4354,4354,'DCGAC','DCGAC','DCGAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4355,4355,'DCGBA','DCGBA','DCGBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4356,4356,'DCGBB','DCGBB','DCGBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4357,4357,'DCGBC','DCGBC','DCGBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4358,4358,'DCGCA','DCGCA','DCGCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4359,4359,'DCGCB','DCGCB','DCGCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4360,4360,'DCGCC','DCGCC','DCGCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4361,4361,'DCGXA','DCGXA','DCGXA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4364,4364,'DCGXAA','DCGXAA','DCGXAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4365,4365,'DCGXAB','DCGXAB','DCGXAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4366,4366,'DCGXAC','DCGXAC','DCGXAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4362,4362,'DCGXB','DCGXB','DCGXB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4367,4367,'DCGXBA','DCGXBA','DCGXBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4368,4368,'DCGXBB','DCGXBB','DCGXBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4369,4369,'DCGXBC','DCGXBC','DCGXBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4363,4363,'DCGXC','DCGXC','DCGXC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4370,4370,'DCGXCA','DCGXCA','DCGXCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4371,4371,'DCGXCB','DCGXCB','DCGXCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4372,4372,'DCGXCC','DCGXCC','DCGXCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4373,4373,'DCGYA','DCGYA','DCGYA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4374,4374,'DCGYB','DCGYB','DCGYB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4375,4375,'DCGYC','DCGYC','DCGYC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4376,4376,'DCGZA','DCGZA','DCGZA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4377,4377,'DCGZB','DCGZB','DCGZB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4378,4378,'DCGZC','DCGZC','DCGZC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4379,4379,'DCHA','DCHA','DCHA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4380,4380,'DCHAA','DCHAA','DCHAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4381,4381,'DCHAB','DCHAB','DCHAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4382,4382,'DCHB','DCHB','DCHB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4383,4383,'DCIA','DCIA','DCIA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4384,4384,'DCIB','DCIB','DCIB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4385,4385,'DCLAA','DCLAA','DCLAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4386,4386,'DCLAB','DCLAB','DCLAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4387,4387,'DCLBA','DCLBA','DCLBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4388,4388,'DCLBB','DCLBB','DCLBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4389,4389,'DCLCA','DCLCA','DCLCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4390,4390,'DCLCB','DCLCB','DCLCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4391,4391,'DCMA','DCMA','DCMA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4392,4392,'DCMB','DCMB','DCMB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4393,4393,'DCMC','DCMC','DCMC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4394,4394,'DDA','DDA','DDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4395,4395,'DDB','DDB','DDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4396,4396,'DDCA','DDCA','DDCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4397,4397,'DDCB','DDCB','DDCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4398,4398,'DDCC','DDCC','DDCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4399,4399,'DDCD','DDCD','DDCD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4400,4400,'DDCZ','DDCZ','DDCZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4401,4401,'DDD','DDD','DDD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4402,4402,'DDEAA','DDEAA','DDEAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4403,4403,'DDEAB','DDEAB','DDEAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4404,4404,'DDEAC','DDEAC','DDEAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4405,4405,'DDEBA','DDEBA','DDEBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4406,4406,'DDEBB','DDEBB','DDEBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4407,4407,'DDEBC','DDEBC','DDEBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4408,4408,'DDEYA','DDEYA','DDEYA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4409,4409,'DDEYB','DDEYB','DDEYB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4410,4410,'DDEYY','DDEYY','DDEYY', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4411,4411,'DDFA','DDFA','DDFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4412,4412,'DDFB','DDFB','DDFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4413,4413,'DDFC','DDFC','DDFC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4414,4414,'DDFZ','DDFZ','DDFZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4416,4416,'DDGA','DDGA','DDGA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4417,4417,'DDGB','DDGB','DDGB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4418,4418,'DDGC','DDGC','DDGC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_damage_code_manhole (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4419,4419,'DDGZ','DDGZ','DDGZ', '', '', '', 'true');
 ALTER TABLE qgep.od_damage_manhole ADD CONSTRAINT fkey_vl_damage_manhole_damage_code_manhole FOREIGN KEY (damage_code_manhole)
 REFERENCES qgep.vl_damage_manhole_damage_code_manhole (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_damage_manhole_manhole_shaft_area () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_damage_manhole_manhole_shaft_area ADD CONSTRAINT pkey_qgep_vl_damage_manhole_manhole_shaft_area_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3743,3743,'A','A','A', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3744,3744,'B','B','B', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3745,3745,'D','D','D', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3746,3746,'F','F','F', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3747,3747,'H','H','H', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3748,3748,'I','I','I', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_manhole_manhole_shaft_area (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3749,3749,'J','J','J', '', '', '', 'true');
 ALTER TABLE qgep.od_damage_manhole ADD CONSTRAINT fkey_vl_damage_manhole_manhole_shaft_area FOREIGN KEY (manhole_shaft_area)
 REFERENCES qgep.vl_damage_manhole_manhole_shaft_area (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_damage_channel ADD CONSTRAINT oorel_od_damage_channel_damage FOREIGN KEY (obj_id) REFERENCES qgep.od_damage(obj_id);
CREATE TABLE qgep.vl_damage_channel_channel_damage_code () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_damage_channel_channel_damage_code ADD CONSTRAINT pkey_qgep_vl_damage_channel_channel_damage_code_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4103,4103,'AECXA','AECXA','AECXA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4104,4104,'AECXB','AECXB','AECXB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4105,4105,'AECXC','AECXC','AECXC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4106,4106,'AECXD','AECXD','AECXD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4107,4107,'AECXE','AECXE','AECXE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4108,4108,'AECXF','AECXF','AECXF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4109,4109,'AECXG','AECXG','AECXG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4110,4110,'AECXH','AECXH','AECXH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4111,4111,'AEDXA','AEDXA','AEDXA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4112,4112,'AEDXB','AEDXB','AEDXB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4113,4113,'AEDXC','AEDXC','AEDXC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4114,4114,'AEDXD','AEDXD','AEDXD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4115,4115,'AEDXE','AEDXE','AEDXE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4116,4116,'AEDXF','AEDXF','AEDXF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4117,4117,'AEDXG','AEDXG','AEDXG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4118,4118,'AEDXH','AEDXH','AEDXH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4119,4119,'AEDXI','AEDXI','AEDXI', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4120,4120,'AEDXJ','AEDXJ','AEDXJ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4121,4121,'AEDXK','AEDXK','AEDXK', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4122,4122,'AEDXL','AEDXL','AEDXL', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4123,4123,'AEDXM','AEDXM','AEDXM', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4124,4124,'AEDXN','AEDXN','AEDXN', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4125,4125,'AEDXO','AEDXO','AEDXO', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4126,4126,'AEDXP','AEDXP','AEDXP', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4127,4127,'AEDXQ','AEDXQ','AEDXQ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4128,4128,'AEDXR','AEDXR','AEDXR', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4129,4129,'AEDXS','AEDXS','AEDXS', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4130,4130,'AEDXT','AEDXT','AEDXT', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4131,4131,'AEDXU','AEDXU','AEDXU', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4132,4132,'AEDXV','AEDXV','AEDXV', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4133,4133,'AEDXW','AEDXW','AEDXW', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4134,4134,'AEDXX','AEDXX','AEDXX', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4135,4135,'AEF','AEF','AEF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3900,3900,'BAAA','BAAA','BAAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3901,3901,'BAAB','BAAB','BAAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3902,3902,'BABAA','BABAA','BABAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3903,3903,'BABAB','BABAB','BABAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3904,3904,'BABAC','BABAC','BABAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3905,3905,'BABAD','BABAD','BABAD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3906,3906,'BABBA','BABBA','BABBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3907,3907,'BABBB','BABBB','BABBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3908,3908,'BABBC','BABBC','BABBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3909,3909,'BABBD','BABBD','BABBD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3910,3910,'BABCA','BABCA','BABCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3911,3911,'BABCB','BABCB','BABCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3912,3912,'BABCC','BABCC','BABCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3913,3913,'BABCD','BABCD','BABCD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3914,3914,'BACA','BACA','BACA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3915,3915,'BACB','BACB','BACB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3916,3916,'BACC','BACC','BACC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3917,3917,'BADA','BADA','BADA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3918,3918,'BADB','BADB','BADB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3919,3919,'BADC','BADC','BADC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3920,3920,'BADD','BADD','BADD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3921,3921,'BAE','BAE','BAE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3922,3922,'BAFAA','BAFAA','BAFAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3923,3923,'BAFAB','BAFAB','BAFAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3924,3924,'BAFAC','BAFAC','BAFAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3925,3925,'BAFAD','BAFAD','BAFAD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3926,3926,'BAFAE','BAFAE','BAFAE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3927,3927,'BAFBA','BAFBA','BAFBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3928,3928,'BAFBE','BAFBE','BAFBE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3929,3929,'BAFCA','BAFCA','BAFCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3930,3930,'BAFCB','BAFCB','BAFCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3931,3931,'BAFCC','BAFCC','BAFCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3932,3932,'BAFCD','BAFCD','BAFCD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3933,3933,'BAFCE','BAFCE','BAFCE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3934,3934,'BAFDA','BAFDA','BAFDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3935,3935,'BAFDB','BAFDB','BAFDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3936,3936,'BAFDC','BAFDC','BAFDC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3937,3937,'BAFDD','BAFDD','BAFDD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3938,3938,'BAFDE','BAFDE','BAFDE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3939,3939,'BAFEA','BAFEA','BAFEA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3940,3940,'BAFEB','BAFEB','BAFEB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3941,3941,'BAFEC','BAFEC','BAFEC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3942,3942,'BAFED','BAFED','BAFED', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3943,3943,'BAFEE','BAFEE','BAFEE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3944,3944,'BAFFA','BAFFA','BAFFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3945,3945,'BAFFB','BAFFB','BAFFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3946,3946,'BAFFC','BAFFC','BAFFC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3947,3947,'BAFFD','BAFFD','BAFFD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3948,3948,'BAFFE','BAFFE','BAFFE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3949,3949,'BAFGA','BAFGA','BAFGA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3950,3950,'BAFGB','BAFGB','BAFGB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3951,3951,'BAFGC','BAFGC','BAFGC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3952,3952,'BAFGD','BAFGD','BAFGD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3953,3953,'BAFGE','BAFGE','BAFGE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3954,3954,'BAFHB','BAFHB','BAFHB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3955,3955,'BAFHC','BAFHC','BAFHC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3956,3956,'BAFHD','BAFHD','BAFHD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3957,3957,'BAFHE','BAFHE','BAFHE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3958,3958,'BAFIA','BAFIA','BAFIA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3959,3959,'BAFIB','BAFIB','BAFIB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3960,3960,'BAFIC','BAFIC','BAFIC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3961,3961,'BAFID','BAFID','BAFID', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3962,3962,'BAFIE','BAFIE','BAFIE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3963,3963,'BAFJB','BAFJB','BAFJB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3964,3964,'BAFJC','BAFJC','BAFJC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3965,3965,'BAFJD','BAFJD','BAFJD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3966,3966,'BAFJE','BAFJE','BAFJE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3967,3967,'BAFZA','BAFZA','BAFZA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3968,3968,'BAFZB','BAFZB','BAFZB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3969,3969,'BAFZC','BAFZC','BAFZC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3970,3970,'BAFZD','BAFZD','BAFZD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3971,3971,'BAFZE','BAFZE','BAFZE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3972,3972,'BAGA','BAGA','BAGA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3973,3973,'BAHA','BAHA','BAHA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3974,3974,'BAHB','BAHB','BAHB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3975,3975,'BAHC','BAHC','BAHC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3976,3976,'BAHD','BAHD','BAHD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3977,3977,'BAHE','BAHE','BAHE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3978,3978,'BAHZ','BAHZ','BAHZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3979,3979,'BAIAA','BAIAA','BAIAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3980,3980,'BAIAB','BAIAB','BAIAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3981,3981,'BAIAC','BAIAC','BAIAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3982,3982,'BAIAD','BAIAD','BAIAD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3983,3983,'BAIZ','BAIZ','BAIZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3984,3984,'BAJA','BAJA','BAJA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3985,3985,'BAJB','BAJB','BAJB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3986,3986,'BAJC','BAJC','BAJC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3987,3987,'BAKA','BAKA','BAKA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3988,3988,'BAKB','BAKB','BAKB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3989,3989,'BAKC','BAKC','BAKC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3990,3990,'BAKDA','BAKDA','BAKDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3991,3991,'BAKDB','BAKDB','BAKDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3992,3992,'BAKDC','BAKDC','BAKDC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3993,3993,'BAKE','BAKE','BAKE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3994,3994,'BAKZ','BAKZ','BAKZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3995,3995,'BALA','BALA','BALA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3996,3996,'BALB','BALB','BALB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3997,3997,'BALZ','BALZ','BALZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3998,3998,'BAMA','BAMA','BAMA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3999,3999,'BAMB','BAMB','BAMB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4000,4000,'BAMC','BAMC','BAMC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4001,4001,'BAN','BAN','BAN', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4002,4002,'BAO','BAO','BAO', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4003,4003,'BAP','BAP','BAP', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4004,4004,'BBAA','BBAA','BBAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4005,4005,'BBAB','BBAB','BBAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4006,4006,'BBAC','BBAC','BBAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4007,4007,'BBBA','BBBA','BBBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4008,4008,'BBBB','BBBB','BBBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4009,4009,'BBBC','BBBC','BBBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4010,4010,'BBBZ','BBBZ','BBBZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4011,4011,'BBCA','BBCA','BBCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4012,4012,'BBCB','BBCB','BBCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4013,4013,'BBCC','BBCC','BBCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4014,4014,'BBCZ','BBCZ','BBCZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4015,4015,'BBDA','BBDA','BBDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4016,4016,'BBDB','BBDB','BBDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4017,4017,'BBDC','BBDC','BBDC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4018,4018,'BBDD','BBDD','BBDD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4019,4019,'BBDZ','BBDZ','BBDZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4020,4020,'BBEA','BBEA','BBEA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4021,4021,'BBEB','BBEB','BBEB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4022,4022,'BBEC','BBEC','BBEC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4023,4023,'BBED','BBED','BBED', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4024,4024,'BBEE','BBEE','BBEE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4025,4025,'BBEF','BBEF','BBEF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4026,4026,'BBEG','BBEG','BBEG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4027,4027,'BBEH','BBEH','BBEH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4028,4028,'BBEZ','BBEZ','BBEZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4029,4029,'BBFA','BBFA','BBFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4030,4030,'BBFB','BBFB','BBFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4031,4031,'BBFC','BBFC','BBFC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4032,4032,'BBFD','BBFD','BBFD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4033,4033,'BBG','BBG','BBG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4034,4034,'BBHAA','BBHAA','BBHAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4035,4035,'BBHAB','BBHAB','BBHAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4036,4036,'BBHAC','BBHAC','BBHAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4037,4037,'BBHAZ','BBHAZ','BBHAZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4038,4038,'BBHBA','BBHBA','BBHBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4039,4039,'BBHBB','BBHBB','BBHBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4040,4040,'BBHBC','BBHBC','BBHBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4041,4041,'BBHBZ','BBHBZ','BBHBZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4042,4042,'BBHZA','BBHZA','BBHZA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4043,4043,'BBHZB','BBHZB','BBHZB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4044,4044,'BBHZC','BBHZC','BBHZC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4045,4045,'BBHZZ','BBHZZ','BBHZZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4046,4046,'BCAAA','BCAAA','BCAAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4047,4047,'BCAAB','BCAAB','BCAAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4048,4048,'BCABA','BCABA','BCABA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4049,4049,'BCABB','BCABB','BCABB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4050,4050,'BCACA','BCACA','BCACA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4051,4051,'BCACB','BCACB','BCACB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4052,4052,'BCADA','BCADA','BCADA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4053,4053,'BCADB','BCADB','BCADB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4054,4054,'BCAEA','BCAEA','BCAEA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4055,4055,'BCAEB','BCAEB','BCAEB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4056,4056,'BCAFA','BCAFA','BCAFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4057,4057,'BCAFB','BCAFB','BCAFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4058,4058,'BCAGA','BCAGA','BCAGA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4059,4059,'BCAGB','BCAGB','BCAGB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4060,4060,'BCAZA','BCAZA','BCAZA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4061,4061,'BCAZB','BCAZB','BCAZB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4062,4062,'BCBA','BCBA','BCBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4063,4063,'BCBB','BCBB','BCBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4064,4064,'BCBC','BCBC','BCBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4065,4065,'BCBD','BCBD','BCBD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4066,4066,'BCBE','BCBE','BCBE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4067,4067,'BCBZ','BCBZ','BCBZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4068,4068,'BCCAA','BCCAA','BCCAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4069,4069,'BCCAB','BCCAB','BCCAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4070,4070,'BCCAY','BCCAY','BCCAY', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4071,4071,'BCCBA','BCCBA','BCCBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4072,4072,'BCCBB','BCCBB','BCCBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4073,4073,'BCCBY','BCCBY','BCCBY', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4074,4074,'BCCYA','BCCYA','BCCYA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4075,4075,'BCCYB','BCCYB','BCCYB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4076,4076,'BCD','BCD','BCD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4077,4077,'BCE','BCE','BCE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4078,4078,'BDA','BDA','BDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4079,4079,'BDB','BDB','BDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4136,4136,'BDBA','BDBA','BDBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4137,4137,'BDBB','BDBB','BDBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4138,4138,'BDBC','BDBC','BDBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4139,4139,'BDBD','BDBD','BDBD', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4140,4140,'BDBE','BDBE','BDBE', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4141,4141,'BDBF','BDBF','BDBF', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4142,4142,'BDBG','BDBG','BDBG', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4143,4143,'BDBH','BDBH','BDBH', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4144,4144,'BDBI','BDBI','BDBI', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4145,4145,'BDBJ','BDBJ','BDBJ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4146,4146,'BDBK','BDBK','BDBK', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4147,4147,'BDBL','BDBL','BDBL', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4080,4080,'BDCA','BDCA','BDCA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4081,4081,'BDCB','BDCB','BDCB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4082,4082,'BDCC','BDCC','BDCC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4083,4083,'BDCZ','BDCZ','BDCZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4084,4084,'BDDA','BDDA','BDDA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4085,4085,'BDDB','BDDB','BDDB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4086,4086,'BDEAA','BDEAA','BDEAA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4087,4087,'BDEAB','BDEAB','BDEAB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4088,4088,'BDEAC','BDEAC','BDEAC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4089,4089,'BDEBA','BDEBA','BDEBA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4090,4090,'BDEBB','BDEBB','BDEBB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4091,4091,'BDEBC','BDEBC','BDEBC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4092,4092,'BDEYA','BDEYA','BDEYA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4093,4093,'BDEYB','BDEYB','BDEYB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4094,4094,'BDEYY','BDEYY','BDEYY', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4095,4095,'BDFA','BDFA','BDFA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4096,4096,'BDFB','BDFB','BDFB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4097,4097,'BDFC','BDFC','BDFC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4098,4098,'BDFZ','BDFZ','BDFZ', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4099,4099,'BDGA','BDGA','BDGA', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4100,4100,'BDGB','BDGB','BDGB', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4101,4101,'BDGC','BDGC','BDGC', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_channel_damage_code (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4102,4102,'BDGZ','BDGZ','BDGZ', '', '', '', 'true');
 ALTER TABLE qgep.od_damage_channel ADD CONSTRAINT fkey_vl_damage_channel_channel_damage_code FOREIGN KEY (channel_damage_code)
 REFERENCES qgep.vl_damage_channel_channel_damage_code (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_damage_channel_connection () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_damage_channel_connection ADD CONSTRAINT pkey_qgep_vl_damage_channel_connection_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_damage_channel_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3724,3724,'yes','ja','oui', '', '', '', 'true');
 INSERT INTO qgep.vl_damage_channel_connection (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3725,3725,'no','nein','non', '', '', '', 'true');
 ALTER TABLE qgep.od_damage_channel ADD CONSTRAINT fkey_vl_damage_channel_connection FOREIGN KEY (connection)
 REFERENCES qgep.vl_damage_channel_connection (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_param_ca_general ADD CONSTRAINT oorel_od_param_ca_general_surface_runoff_parameters FOREIGN KEY (obj_id) REFERENCES qgep.od_surface_runoff_parameters(obj_id);
ALTER TABLE qgep.od_param_ca_mouse1 ADD CONSTRAINT oorel_od_param_ca_mouse1_surface_runoff_parameters FOREIGN KEY (obj_id) REFERENCES qgep.od_surface_runoff_parameters(obj_id);
ALTER TABLE qgep.od_private ADD CONSTRAINT oorel_od_private_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_administrative_office ADD CONSTRAINT oorel_od_administrative_office_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_canton ADD CONSTRAINT oorel_od_canton_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_cooperative ADD CONSTRAINT oorel_od_cooperative_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_municipality ADD CONSTRAINT oorel_od_municipality_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_waste_water_association ADD CONSTRAINT oorel_od_waste_water_association_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_waste_water_treatment_plant ADD CONSTRAINT oorel_od_waste_water_treatment_plant_organisation FOREIGN KEY (obj_id) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_reach ADD CONSTRAINT oorel_od_reach_wastewater_networkelement FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_networkelement(obj_id);
CREATE TABLE qgep.vl_reach_elevation_determination () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_elevation_determination ADD CONSTRAINT pkey_qgep_vl_reach_elevation_determination_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_elevation_determination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4780,4780,'accurate','genau','precise', '', 'LG', 'P', 'true');
 INSERT INTO qgep.vl_reach_elevation_determination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4778,4778,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_reach_elevation_determination (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (4779,4779,'inaccurate','ungenau','imprecise', '', 'LU', 'IP', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_elevation_determination FOREIGN KEY (elevation_determination)
 REFERENCES qgep.vl_reach_elevation_determination (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_horizontal_positioning () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_horizontal_positioning ADD CONSTRAINT pkey_qgep_vl_reach_horizontal_positioning_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_horizontal_positioning (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5378,5378,'accurate','genau','precise', '', 'LG', 'P', 'true');
 INSERT INTO qgep.vl_reach_horizontal_positioning (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5379,5379,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_reach_horizontal_positioning (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5380,5380,'inaccurate','ungenau','imprecise', '', 'LU', 'IP', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_horizontal_positioning FOREIGN KEY (horizontal_positioning)
 REFERENCES qgep.vl_reach_horizontal_positioning (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_inside_coating () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_inside_coating ADD CONSTRAINT pkey_qgep_vl_reach_inside_coating_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_inside_coating (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5383,5383,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_reach_inside_coating (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (248,248,'coating','Anstrich_Beschichtung','peinture_revetement', 'C', 'B', 'PR', 'true');
 INSERT INTO qgep.vl_reach_inside_coating (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (250,250,'brick_lining','Kanalklinkerauskleidung','revetement_en_brique', '', 'KL', 'RB', 'true');
 INSERT INTO qgep.vl_reach_inside_coating (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (251,251,'stoneware_lining','Steinzeugauskleidung','revetement_en_gres', '', 'ST', 'RG', 'true');
 INSERT INTO qgep.vl_reach_inside_coating (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5384,5384,'unknown','unbekannt','inconnue', '', 'U', 'I', 'true');
 INSERT INTO qgep.vl_reach_inside_coating (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (249,249,'cement_mortar_lining','Zementmoertelauskleidung','revetement_en_mortier_de_ciment', '', 'ZM', 'RM', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_inside_coating FOREIGN KEY (inside_coating)
 REFERENCES qgep.vl_reach_inside_coating (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_material ADD CONSTRAINT pkey_qgep_vl_reach_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5381,5381,'other','andere','autre', 'O', 'A', 'AU', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2754,2754,'asbestos_cement','Asbestzement','amiante_ciment', 'AC', 'AZ', 'AC', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3638,3638,'concrete_normal','Beton_Normalbeton','beton_normal', 'CN', 'NB', 'BN', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3639,3639,'concrete_insitu','Beton_Ortsbeton','beton_coule_sur_place', 'CI', 'OB', 'BCP', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3640,3640,'concrete_presspipe','Beton_Pressrohrbeton','beton_pousse_tube', 'CP', 'PRB', 'BPT', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3641,3641,'concrete_special','Beton_Spezialbeton','beton_special', 'CS', 'SB', 'BS', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3256,3256,'concrete_unknown','Beton_unbekannt','beton_inconnu', 'CU', 'BU', 'BI', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (147,147,'fiber_cement','Faserzement','fibrociment', 'FC', 'FZ', 'FC', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2755,2755,'bricks','Gebrannte_Steine','terre_cuite', 'BR', 'SG', 'TC', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (148,148,'cast_ductile_iron','Guss_duktil','fonte_ductile', 'ID', 'GD', 'FD', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3648,3648,'cast_gray_iron','Guss_Grauguss','fonte_grise', 'CGI', 'GG', 'FG', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5076,5076,'plastic_epoxy_resin','Kunststoff_Epoxydharz','matiere_synthetique_resine_d_epoxy', 'PER', 'EP', 'EP', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5077,5077,'plastic_highdensity_polyethylene','Kunststoff_Hartpolyethylen','matiere_synthetique_polyethylene_dur', 'HPE', 'HPE', 'PD', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5078,5078,'plastic_polyester_GUP','Kunststoff_Polyester_GUP','matiere_synthetique_polyester_GUP', 'GUP', 'GUP', 'GUP', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5079,5079,'plastic_polyethylene','Kunststoff_Polyethylen','matiere_synthetique_polyethylene', 'PE', 'PE', 'PE', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5080,5080,'plastic_polypropylene','Kunststoff_Polypropylen','matiere_synthetique_polypropylene', 'PP', 'PP', 'PP', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5081,5081,'plastic_PVC','Kunststoff_Polyvinilchlorid','matiere_synthetique_PVC', 'PVC', 'PVC', 'PVC', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5382,5382,'plastic_unknown','Kunststoff_unbekannt','matiere_synthetique_inconnue', 'PU', 'KUU', 'MSI', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (153,153,'steel','Stahl','acier', 'ST', 'ST', 'AC', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3654,3654,'steel_stainless','Stahl_rostfrei','acier_inoxydable', 'SST', 'STI', 'ACI', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (154,154,'stoneware','Steinzeug','gres', 'SW', 'STZ', 'GR', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2761,2761,'clay','Ton','argile', 'CL', 'T', 'AR', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3016,3016,'unknown','unbekannt','inconnu', 'U', 'U', 'I', 'true');
 INSERT INTO qgep.vl_reach_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2762,2762,'cement','Zement','ciment', 'C', 'Z', 'C', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_material FOREIGN KEY (material)
 REFERENCES qgep.vl_reach_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_reliner_material () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_reliner_material ADD CONSTRAINT pkey_qgep_vl_reach_reliner_material_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6459,6459,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6461,6461,'epoxy_resin_glass_fibre_laminate','Epoxidharz_Glasfaserlaminat','resine_epoxy_lamine_en_fibre_de_verre', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6460,6460,'epoxy_resin_plastic_felt','Epoxidharz_Kunststofffilz','resine_epoxy_feutre_synthetique', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6483,6483,'GUP_pipe','GUP_Rohr','tuyau_PRV', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6462,6462,'HDPE','HDPE','HDPE', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6484,6484,'isocyanate_resin_glass_fibre_laminate','Isocyanatharze_Glasfaserlaminat','isocyanat_resine_lamine_en_fibre_de_verre', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6485,6485,'isocyanate_resin_plastic_felt','Isocyanatharze_Kunststofffilz','isocyanat_resine_lamine_feutre_synthetique', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6464,6464,'polyester_resin_glass_fibre_laminate','Polyesterharz_Glasfaserlaminat','resine_de_polyester_lamine_en_fibre_de_verre', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6463,6463,'polyester_resin_plastic_felt','Polyesterharz_Kunststofffilz','resine_de_polyester_feutre_synthetique', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6482,6482,'polypropylene','Polypropylen','polypropylene', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6465,6465,'PVC','Polyvinilchlorid','PVC', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6466,6466,'bottom_with_polyester_concret_shell','Sohle_mit_Schale_aus_Polyesterbeton','radier_avec_pellicule_en_beton_polyester', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6467,6467,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6486,6486,'UP_resin_LED_synthetic_fibre_liner','UP_Harz_LED_Synthesefaserliner','UP_resine_LED_fibre_synthetiques_liner', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6468,6468,'vinyl_ester_resin_glass_fibre_laminate','Vinylesterharz_Glasfaserlaminat','resine_d_ester_vinylique_lamine_en_fibre_de_verre', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_reliner_material (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6469,6469,'vinyl_ester_resin_plastic_felt','Vinylesterharz_Kunststofffilz','resine_d_ester_vinylique_feutre_synthetique', '', '', '', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_reliner_material FOREIGN KEY (reliner_material)
 REFERENCES qgep.vl_reach_reliner_material (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_relining_construction () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_relining_construction ADD CONSTRAINT pkey_qgep_vl_reach_relining_construction_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6448,6448,'other','andere','autre', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6479,6479,'close_fit_relining','Close_Fit_Relining','close_fit_relining', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6449,6449,'relining_short_tube','Kurzrohrrelining','relining_tube_court', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6481,6481,'grouted_in_place_lining','Noppenschlauchrelining','Noppenschlauchrelining', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6452,6452,'partial_liner','Partieller_Liner','liner_partiel', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6450,6450,'pipe_string_relining','Rohrstrangrelining','chemisage_par_ligne_de_tuyau', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6451,6451,'hose_relining','Schlauchrelining','chemisage_par_gainage', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6453,6453,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_construction (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6480,6480,'spiral_lining','Wickelrohrrelining','chemisage_par_tube_spirale', '', '', '', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_relining_construction FOREIGN KEY (relining_construction)
 REFERENCES qgep.vl_reach_relining_construction (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_relining_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_relining_kind ADD CONSTRAINT pkey_qgep_vl_reach_relining_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_relining_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6455,6455,'full_reach','ganze_Haltung','troncon_entier', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6456,6456,'partial','partiell','partiellement', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_relining_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6457,6457,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_reach ADD CONSTRAINT fkey_vl_reach_relining_kind FOREIGN KEY (relining_kind)
 REFERENCES qgep.vl_reach_relining_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_reach ADD COLUMN fk_reach_point_from varchar (16);
ALTER TABLE qgep.od_reach ADD CONSTRAINT rel_reach_reach_point_from FOREIGN KEY (fk_reach_point_from) REFERENCES qgep.od_reach_point(obj_id);
ALTER TABLE qgep.od_reach ADD COLUMN fk_reach_point_to varchar (16);
ALTER TABLE qgep.od_reach ADD CONSTRAINT rel_reach_reach_point_to FOREIGN KEY (fk_reach_point_to) REFERENCES qgep.od_reach_point(obj_id);
ALTER TABLE qgep.od_reach ADD COLUMN fk_pipe_profile varchar (16);
ALTER TABLE qgep.od_reach ADD CONSTRAINT rel_reach_pipe_profile FOREIGN KEY (fk_pipe_profile) REFERENCES qgep.od_pipe_profile(obj_id);
ALTER TABLE qgep.od_wastewater_node ADD CONSTRAINT oorel_od_wastewater_node_wastewater_networkelement FOREIGN KEY (obj_id) REFERENCES qgep.od_wastewater_networkelement(obj_id);
ALTER TABLE qgep.od_wastewater_node ADD COLUMN fk_hydr_geometry varchar (16);
ALTER TABLE qgep.od_wastewater_node ADD CONSTRAINT rel_wastewater_node_hydr_geometry FOREIGN KEY (fk_hydr_geometry) REFERENCES qgep.od_hydr_geometry(obj_id);
ALTER TABLE qgep.od_pump ADD CONSTRAINT oorel_od_pump_overflow FOREIGN KEY (obj_id) REFERENCES qgep.od_overflow(obj_id);
CREATE TABLE qgep.vl_pump_contruction_type () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_pump_contruction_type ADD CONSTRAINT pkey_qgep_vl_pump_contruction_type_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2983,2983,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2662,2662,'compressed_air_system','Druckluftanlage','systeme_a_air_comprime', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (314,314,'piston_pump','Kolbenpumpe','pompe_a_piston', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (309,309,'centrifugal_pump','Kreiselpumpe','pompe_centrifuge', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (310,310,'screw_pump','Schneckenpumpe','pompe_a_vis', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3082,3082,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_contruction_type (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2661,2661,'vacuum_system','Vakuumanlage','systeme_a_vide_d_air', '', '', '', 'true');
 ALTER TABLE qgep.od_pump ADD CONSTRAINT fkey_vl_pump_contruction_type FOREIGN KEY (contruction_type)
 REFERENCES qgep.vl_pump_contruction_type (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_pump_placement_of_actuation () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_pump_placement_of_actuation ADD CONSTRAINT pkey_qgep_vl_pump_placement_of_actuation_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_pump_placement_of_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (318,318,'wet','nass','immerge', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_placement_of_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (311,311,'dry','trocken','non_submersible', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_placement_of_actuation (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3070,3070,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_pump ADD CONSTRAINT fkey_vl_pump_placement_of_actuation FOREIGN KEY (placement_of_actuation)
 REFERENCES qgep.vl_pump_placement_of_actuation (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_pump_placement_of_pump () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_pump_placement_of_pump ADD CONSTRAINT pkey_qgep_vl_pump_placement_of_pump_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_pump_placement_of_pump (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (362,362,'horizontal','horizontal','horizontal', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_placement_of_pump (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3071,3071,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_placement_of_pump (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (363,363,'vertical','vertikal','vertical', '', '', '', 'true');
 ALTER TABLE qgep.od_pump ADD CONSTRAINT fkey_vl_pump_placement_of_pump FOREIGN KEY (placement_of_pump)
 REFERENCES qgep.vl_pump_placement_of_pump (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_pump_usage_current () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_pump_usage_current ADD CONSTRAINT pkey_qgep_vl_pump_usage_current_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6325,6325,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6202,6202,'creek_water','Bachwasser','eaux_cours_d_eau', '', '', '', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6203,6203,'discharged_combined_wastewater','entlastetes_Mischabwasser','eaux_mixtes_deversees', 'DCW', 'EW', 'EUD', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6204,6204,'industrial_wastewater','Industrieabwasser','eaux_industrielles', '', 'CW', 'EUC', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6201,6201,'combined_wastewater','Mischabwasser','eaux_mixtes', '', 'MW', 'EUM', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6205,6205,'rain_wastewater','Regenabwasser','eaux_pluviales', '', 'RW', 'EUP', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6200,6200,'clean_wastewater','Reinabwasser','eaux_claires', '', 'KW', 'EUR', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6206,6206,'wastewater','Schmutzabwasser','eaux_usees', '', 'SW', 'EU', 'true');
 INSERT INTO qgep.vl_pump_usage_current (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (6326,6326,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_pump ADD CONSTRAINT fkey_vl_pump_usage_current FOREIGN KEY (usage_current)
 REFERENCES qgep.vl_pump_usage_current (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_leapingweir ADD CONSTRAINT oorel_od_leapingweir_overflow FOREIGN KEY (obj_id) REFERENCES qgep.od_overflow(obj_id);
CREATE TABLE qgep.vl_leapingweir_opening_shape () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_leapingweir_opening_shape ADD CONSTRAINT pkey_qgep_vl_leapingweir_opening_shape_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_leapingweir_opening_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3581,3581,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_leapingweir_opening_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3582,3582,'circle','Kreis','circulaire', '', '', '', 'true');
 INSERT INTO qgep.vl_leapingweir_opening_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3585,3585,'parable','Parabel','parabolique', '', '', '', 'true');
 INSERT INTO qgep.vl_leapingweir_opening_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3583,3583,'rectangular','Rechteck','rectangulaire', '', '', '', 'true');
 INSERT INTO qgep.vl_leapingweir_opening_shape (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3584,3584,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_leapingweir ADD CONSTRAINT fkey_vl_leapingweir_opening_shape FOREIGN KEY (opening_shape)
 REFERENCES qgep.vl_leapingweir_opening_shape (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_prank_weir ADD CONSTRAINT oorel_od_prank_weir_overflow FOREIGN KEY (obj_id) REFERENCES qgep.od_overflow(obj_id);
CREATE TABLE qgep.vl_prank_weir_weir_edge () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_prank_weir_weir_edge ADD CONSTRAINT pkey_qgep_vl_prank_weir_weir_edge_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_prank_weir_weir_edge (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2995,2995,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_prank_weir_weir_edge (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (351,351,'rectangular','rechteckig','angulaire', '', '', '', 'true');
 INSERT INTO qgep.vl_prank_weir_weir_edge (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (350,350,'round','rund','arrondie', '', '', '', 'true');
 INSERT INTO qgep.vl_prank_weir_weir_edge (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (349,349,'sharp_edged','scharfkantig','arete_vive', '', '', '', 'true');
 INSERT INTO qgep.vl_prank_weir_weir_edge (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3014,3014,'unknown','unbekannt','inconnu', '', '', '', 'true');
 ALTER TABLE qgep.od_prank_weir ADD CONSTRAINT fkey_vl_prank_weir_weir_edge FOREIGN KEY (weir_edge)
 REFERENCES qgep.vl_prank_weir_weir_edge (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_prank_weir_weir_kind () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_prank_weir_weir_kind ADD CONSTRAINT pkey_qgep_vl_prank_weir_weir_kind_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_prank_weir_weir_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5772,5772,'raised','hochgezogen','a_seuil_sureleve', '', '', '', 'true');
 INSERT INTO qgep.vl_prank_weir_weir_kind (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (5771,5771,'low','niedrig','a_seuil_abaisse', '', '', '', 'true');
 ALTER TABLE qgep.od_prank_weir ADD CONSTRAINT fkey_vl_prank_weir_weir_kind FOREIGN KEY (weir_kind)
 REFERENCES qgep.vl_prank_weir_weir_kind (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_individual_surface ADD CONSTRAINT oorel_od_individual_surface_connection_object FOREIGN KEY (obj_id) REFERENCES qgep.od_connection_object(obj_id);
CREATE TABLE qgep.vl_individual_surface_function () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_individual_surface_function ADD CONSTRAINT pkey_qgep_vl_individual_surface_function_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2979,2979,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3466,3466,'railway_site','Bahnanlagen','installation_ferroviaire', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3461,3461,'roof_industrial_or_commercial_building','DachflaecheIndustrieundGewerbebetriebe','surface_toits_bat_industriels_artisanaux', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3460,3460,'roof_residential_or_office_building','DachflaecheWohnundBuerogebaeude','surface_toits_imm_habitation_administratifs', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3464,3464,'access_or_collecting_road','Erschliessungs_Sammelstrassen','routes_de_desserte_et_collectives', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3467,3467,'parking_lot','Parkplaetze','parkings', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3462,3462,'transfer_site_or_stockyard','UmschlagundLagerplaetze','places_transbordement_entreposage', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3029,3029,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3465,3465,'connecting_or_principal_or_major_road','Verbindungs_Hauptverkehrs_Hochleistungsstrassen','routes_de_raccordement_principales_grand_trafic', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_function (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3463,3463,'forecourt_and_access_road','VorplaetzeZufahrten','places_devant_entree_acces', '', '', '', 'true');
 ALTER TABLE qgep.od_individual_surface ADD CONSTRAINT fkey_vl_individual_surface_function FOREIGN KEY (function)
 REFERENCES qgep.vl_individual_surface_function (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_individual_surface_pavement () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_individual_surface_pavement ADD CONSTRAINT pkey_qgep_vl_individual_surface_pavement_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_individual_surface_pavement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2978,2978,'other','andere','autres', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_pavement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2031,2031,'paved','befestigt','impermeabilise', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_pavement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2032,2032,'forested','bestockt','boise', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_pavement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2033,2033,'soil_covered','humusiert','couverture_vegetale', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_pavement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (3030,3030,'unknown','unbekannt','inconnu', '', '', '', 'true');
 INSERT INTO qgep.vl_individual_surface_pavement (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (2034,2034,'barren','vegetationslos','sans_vegetation', '', '', '', 'true');
 ALTER TABLE qgep.od_individual_surface ADD CONSTRAINT fkey_vl_individual_surface_pavement FOREIGN KEY (pavement)
 REFERENCES qgep.vl_individual_surface_pavement (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE qgep.od_building ADD CONSTRAINT oorel_od_building_connection_object FOREIGN KEY (obj_id) REFERENCES qgep.od_connection_object(obj_id);
ALTER TABLE qgep.od_reservoir ADD CONSTRAINT oorel_od_reservoir_connection_object FOREIGN KEY (obj_id) REFERENCES qgep.od_connection_object(obj_id);
ALTER TABLE qgep.od_fountain ADD CONSTRAINT oorel_od_fountain_connection_object FOREIGN KEY (obj_id) REFERENCES qgep.od_connection_object(obj_id);

------------ Text and Symbol Tables ----------- ;
-------
CREATE TABLE qgep.od_wastewater_structure_text
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wastewater_structure_text_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wastewater_structure_text_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wastewater_structure_text ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wastewater_structure_text');
COMMENT ON COLUMN qgep.od_wastewater_structure_text.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN plantype  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.plantype IS '';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.remark IS '';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN text  text ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.text IS 'yyy_Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / valeur calculée à partir d’attributs, plusieurs lignes possible';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN texthali  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.texthali IS '';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN textori  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.textori IS '';
SELECT AddGeometryColumn('qgep', 'od_wastewater_structure_text', 'textpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_wastewater_structure_text_textpos_geometry ON qgep.od_wastewater_structure_text USING gist (textpos_geometry );
COMMENT ON COLUMN qgep.od_wastewater_structure_text.textpos_geometry IS '';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN textvali  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.textvali IS '';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_wastewater_structure_text.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_text.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_wastewater_structure_text
BEFORE UPDATE OR INSERT ON
 qgep.od_wastewater_structure_text
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_reach_text
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_reach_text_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_reach_text_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_reach_text ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_reach_text');
COMMENT ON COLUMN qgep.od_reach_text.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_reach_text ADD COLUMN plantype  integer ;
COMMENT ON COLUMN qgep.od_reach_text.plantype IS '';
 ALTER TABLE qgep.od_reach_text ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_reach_text.remark IS '';
 ALTER TABLE qgep.od_reach_text ADD COLUMN text  text ;
COMMENT ON COLUMN qgep.od_reach_text.text IS 'yyy_Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / valeur calculée à partir d’attributs, plusieurs lignes possible';
 ALTER TABLE qgep.od_reach_text ADD COLUMN texthali  smallint ;
COMMENT ON COLUMN qgep.od_reach_text.texthali IS '';
 ALTER TABLE qgep.od_reach_text ADD COLUMN textori  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_reach_text.textori IS '';
SELECT AddGeometryColumn('qgep', 'od_reach_text', 'textpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_reach_text_textpos_geometry ON qgep.od_reach_text USING gist (textpos_geometry );
COMMENT ON COLUMN qgep.od_reach_text.textpos_geometry IS '';
 ALTER TABLE qgep.od_reach_text ADD COLUMN textvali  smallint ;
COMMENT ON COLUMN qgep.od_reach_text.textvali IS '';
 ALTER TABLE qgep.od_reach_text ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_reach_text.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_reach_text ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_reach_text.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_reach_text ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_reach_text.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_reach_text
BEFORE UPDATE OR INSERT ON
 qgep.od_reach_text
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_catchment_area_text
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_catchment_area_text_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_catchment_area_text_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_catchment_area_text ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_catchment_area_text');
COMMENT ON COLUMN qgep.od_catchment_area_text.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN plantype  integer ;
COMMENT ON COLUMN qgep.od_catchment_area_text.plantype IS '';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_catchment_area_text.remark IS '';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN text  text ;
COMMENT ON COLUMN qgep.od_catchment_area_text.text IS 'yyy_Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / Aus Attributwerten zusammengesetzter Wert, mehrzeilig möglich / valeur calculée à partir d’attributs, plusieurs lignes possible';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN texthali  smallint ;
COMMENT ON COLUMN qgep.od_catchment_area_text.texthali IS '';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN textori  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_catchment_area_text.textori IS '';
SELECT AddGeometryColumn('qgep', 'od_catchment_area_text', 'textpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_catchment_area_text_textpos_geometry ON qgep.od_catchment_area_text USING gist (textpos_geometry );
COMMENT ON COLUMN qgep.od_catchment_area_text.textpos_geometry IS '';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN textvali  smallint ;
COMMENT ON COLUMN qgep.od_catchment_area_text.textvali IS '';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_catchment_area_text.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_catchment_area_text.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_catchment_area_text ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_catchment_area_text.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_catchment_area_text
BEFORE UPDATE OR INSERT ON
 qgep.od_catchment_area_text
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------
-------
CREATE TABLE qgep.od_wastewater_structure_symbol
(
   obj_id varchar(16) NOT NULL,
   CONSTRAINT pkey_qgep_od_wastewater_structure_symbol_obj_id PRIMARY KEY (obj_id)
)
WITH (
   OIDS = False
);
CREATE SEQUENCE qgep.seq_od_wastewater_structure_symbol_oid INCREMENT 1 MINVALUE 0 MAXVALUE 999999 START 0;
 ALTER TABLE qgep.od_wastewater_structure_symbol ALTER COLUMN obj_id SET DEFAULT qgep.generate_oid('od_wastewater_structure_symbol');
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.obj_id IS 'INTERLIS STANDARD OID (with Postfix/Präfix) or UUOID, see www.interlis.ch';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN plantype  integer ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.plantype IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN remark  varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.remark IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN symbol_scaling_heigth  decimal(2,1) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.symbol_scaling_heigth IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN symbol_scaling_width  decimal(2,1) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.symbol_scaling_width IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN symbolhali  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.symbolhali IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN symbolori  decimal(4,1) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.symbolori IS '';
SELECT AddGeometryColumn('qgep', 'od_wastewater_structure_symbol', 'symbolpos_geometry', 21781, 'POINT', 2, true);
CREATE INDEX in_qgep_od_wastewater_structure_symbol_symbolpos_geometry ON qgep.od_wastewater_structure_symbol USING gist (symbolpos_geometry );
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.symbolpos_geometry IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN symbolvali  smallint ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.symbolvali IS '';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN last_modification TIMESTAMP without time zone DEFAULT now();
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.last_modification IS 'Last modification / Letzte_Aenderung / Derniere_modification: INTERLIS_1_DATE';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN dataowner varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.dataowner IS 'Metaattribute dataowner - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN provider varchar(80) ;
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.provider IS 'Metaattribute provider - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN fk_dataowner varchar(16);
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.dataowner IS 'Foreignkey to Metaattribute dataowner (as an organisation) - this is the person or body who is allowed to delete, change or maintain this object / Metaattribut Datenherr ist diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu löschen, zu ändern bzw. zu verwalten / Maître des données gestionnaire de données, qui est la personne ou l''organisation autorisée pour gérer, modifier ou supprimer les données de cette table/classe';
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN fk_provider varchar (16);
COMMENT ON COLUMN qgep.od_wastewater_structure_symbol.provider IS 'Foreignkey to Metaattribute provider (as an organisation) - this is the person or body who delivered the data / Metaattribut Datenlieferant ist diejenige Person oder Stelle, die die Daten geliefert hat / FOURNISSEUR DES DONNEES Organisation qui crée l’enregistrement de ces données ';
-------
CREATE TRIGGER
update_last_modified_wastewater_structure_symbol
BEFORE UPDATE OR INSERT ON
 qgep.od_wastewater_structure_symbol
FOR EACH ROW EXECUTE PROCEDURE
 qgep.update_last_modified();

-------

------------ Text and Symbol Tables Relationships ----------- ;
ALTER TABLE qgep.od_wastewater_structure_text ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_wastewater_structure_text ADD CONSTRAINT rel_wastewater_structure_text_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);
ALTER TABLE qgep.od_reach_text ADD COLUMN fk_reach varchar (16);
ALTER TABLE qgep.od_reach_text ADD CONSTRAINT rel_reach_text_reach FOREIGN KEY (fk_reach) REFERENCES qgep.od_reach(obj_id);
ALTER TABLE qgep.od_catchment_area_text ADD COLUMN fk_catchment_area varchar (16);
ALTER TABLE qgep.od_catchment_area_text ADD CONSTRAINT rel_catchment_area_text_catchment_area FOREIGN KEY (fk_catchment_area) REFERENCES qgep.od_catchment_area(obj_id);
ALTER TABLE qgep.od_wastewater_structure_symbol ADD COLUMN fk_wastewater_structure varchar (16);
ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT rel_wastewater_structure_symbol_wastewater_structure FOREIGN KEY (fk_wastewater_structure) REFERENCES qgep.od_wastewater_structure(obj_id);

------------ Text and Symbol Tables Values ----------- ;
CREATE TABLE qgep.vl_wastewater_structure_text_plantype () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_text_plantype ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_text_plantype_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7844,7844,'pipeline_registry','Leitungskataster','cadastre_des_conduites_souterraines', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7846,7846,'overviewmap.om10','Uebersichtsplan.UeP10','plan_d_ensemble.pe10', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7847,7847,'overviewmap.om2','Uebersichtsplan.UeP2','plan_d_ensemble.pe5', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7848,7848,'overviewmap.om5','Uebersichtsplan.UeP5','plan_d_ensemble.pe2', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7845,7845,'network_plan','Werkplan','plan_de_reseau', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure_text ADD CONSTRAINT fkey_vl_wastewater_structure_text_plantype FOREIGN KEY (plantype)
 REFERENCES qgep.vl_wastewater_structure_text_plantype (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_text_texthali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_text_texthali ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_text_texthali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7850,7850,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7851,7851,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7852,7852,'2','2','2', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure_text ADD CONSTRAINT fkey_vl_wastewater_structure_text_texthali FOREIGN KEY (texthali)
 REFERENCES qgep.vl_wastewater_structure_text_texthali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_text_textvali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_text_textvali ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_text_textvali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7853,7853,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7854,7854,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7855,7855,'2','2','2', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7856,7856,'3','3','3', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7857,7857,'4','4','4', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure_text ADD CONSTRAINT fkey_vl_wastewater_structure_text_textvali FOREIGN KEY (textvali)
 REFERENCES qgep.vl_wastewater_structure_text_textvali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_text_plantype () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_text_plantype ADD CONSTRAINT pkey_qgep_vl_reach_text_plantype_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7844,7844,'pipeline_registry','Leitungskataster','cadastre_des_conduites_souterraines', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7846,7846,'overviewmap.om10','Uebersichtsplan.UeP10','plan_d_ensemble.pe10', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7847,7847,'overviewmap.om2','Uebersichtsplan.UeP2','plan_d_ensemble.pe5', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7848,7848,'overviewmap.om5','Uebersichtsplan.UeP5','plan_d_ensemble.pe2', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7845,7845,'network_plan','Werkplan','plan_de_reseau', '', '', '', 'true');
 ALTER TABLE qgep.od_reach_text ADD CONSTRAINT fkey_vl_reach_text_plantype FOREIGN KEY (plantype)
 REFERENCES qgep.vl_reach_text_plantype (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_text_texthali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_text_texthali ADD CONSTRAINT pkey_qgep_vl_reach_text_texthali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7850,7850,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7851,7851,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7852,7852,'2','2','2', '', '', '', 'true');
 ALTER TABLE qgep.od_reach_text ADD CONSTRAINT fkey_vl_reach_text_texthali FOREIGN KEY (texthali)
 REFERENCES qgep.vl_reach_text_texthali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_reach_text_textvali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_reach_text_textvali ADD CONSTRAINT pkey_qgep_vl_reach_text_textvali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_reach_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7853,7853,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7854,7854,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7855,7855,'2','2','2', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7856,7856,'3','3','3', '', '', '', 'true');
 INSERT INTO qgep.vl_reach_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7857,7857,'4','4','4', '', '', '', 'true');
 ALTER TABLE qgep.od_reach_text ADD CONSTRAINT fkey_vl_reach_text_textvali FOREIGN KEY (textvali)
 REFERENCES qgep.vl_reach_text_textvali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_text_plantype () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_text_plantype ADD CONSTRAINT pkey_qgep_vl_catchment_area_text_plantype_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7844,7844,'pipeline_registry','Leitungskataster','cadastre_des_conduites_souterraines', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7846,7846,'overviewmap.om10','Uebersichtsplan.UeP10','plan_d_ensemble.pe10', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7847,7847,'overviewmap.om2','Uebersichtsplan.UeP2','plan_d_ensemble.pe5', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7848,7848,'overviewmap.om5','Uebersichtsplan.UeP5','plan_d_ensemble.pe2', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7845,7845,'network_plan','Werkplan','plan_de_reseau', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area_text ADD CONSTRAINT fkey_vl_catchment_area_text_plantype FOREIGN KEY (plantype)
 REFERENCES qgep.vl_catchment_area_text_plantype (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_text_texthali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_text_texthali ADD CONSTRAINT pkey_qgep_vl_catchment_area_text_texthali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7850,7850,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7851,7851,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_texthali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7852,7852,'2','2','2', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area_text ADD CONSTRAINT fkey_vl_catchment_area_text_texthali FOREIGN KEY (texthali)
 REFERENCES qgep.vl_catchment_area_text_texthali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_catchment_area_text_textvali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_catchment_area_text_textvali ADD CONSTRAINT pkey_qgep_vl_catchment_area_text_textvali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_catchment_area_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7853,7853,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7854,7854,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7855,7855,'2','2','2', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7856,7856,'3','3','3', '', '', '', 'true');
 INSERT INTO qgep.vl_catchment_area_text_textvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7857,7857,'4','4','4', '', '', '', 'true');
 ALTER TABLE qgep.od_catchment_area_text ADD CONSTRAINT fkey_vl_catchment_area_text_textvali FOREIGN KEY (textvali)
 REFERENCES qgep.vl_catchment_area_text_textvali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_symbol_plantype () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_symbol_plantype ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_symbol_plantype_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7874,7874,'pipeline_registry','Leitungskataster','cadastre_des_conduites_souterraines', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7876,7876,'overviewmap.om10','Uebersichtsplan.UeP10','plan_d_ensemble.pe10', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7877,7877,'overviewmap.om2','Uebersichtsplan.UeP2','plan_d_ensemble.pe5', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7878,7878,'overviewmap.om5','Uebersichtsplan.UeP5','plan_d_ensemble.pe2', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_plantype (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7875,7875,'network_plan','Werkplan','plan_de_reseau', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT fkey_vl_wastewater_structure_symbol_plantype FOREIGN KEY (plantype)
 REFERENCES qgep.vl_wastewater_structure_symbol_plantype (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_symbol_symbolhali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_symbol_symbolhali ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_symbol_symbolhali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolhali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7880,7880,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolhali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7881,7881,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolhali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7882,7882,'2','2','2', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT fkey_vl_wastewater_structure_symbol_symbolhali FOREIGN KEY (symbolhali)
 REFERENCES qgep.vl_wastewater_structure_symbol_symbolhali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE qgep.vl_wastewater_structure_symbol_symbolvali () INHERITS (qgep.is_value_list_base);
ALTER TABLE qgep.vl_wastewater_structure_symbol_symbolvali ADD CONSTRAINT pkey_qgep_vl_wastewater_structure_symbol_symbolvali_code PRIMARY KEY (code);
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7883,7883,'0','0','0', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7884,7884,'1','1','1', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7885,7885,'2','2','2', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7886,7886,'3','3','3', '', '', '', 'true');
 INSERT INTO qgep.vl_wastewater_structure_symbol_symbolvali (code, vsacode, value_en, value_de, value_fr, abbr_en, abbr_de, abbr_fr, active) VALUES (7887,7887,'4','4','4', '', '', '', 'true');
 ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT fkey_vl_wastewater_structure_symbol_symbolvali FOREIGN KEY (symbolvali)
 REFERENCES qgep.vl_wastewater_structure_symbol_symbolvali (code) MATCH SIMPLE 
 ON UPDATE RESTRICT ON DELETE RESTRICT;
--------- Relations to class organisation for dataowner and provider (new 3.11.2014);

ALTER TABLE qgep.txt_symbol ADD CONSTRAINT rel_txt_symbol_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.txt_symbol ADD CONSTRAINT rel_txt_symbol_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_mutation ADD CONSTRAINT rel_od_mutation_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_mutation ADD CONSTRAINT rel_od_mutation_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_organisation ADD CONSTRAINT rel_od_organisation_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_organisation ADD CONSTRAINT rel_od_organisation_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_zone ADD CONSTRAINT rel_od_zone_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_zone ADD CONSTRAINT rel_od_zone_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_farm ADD CONSTRAINT rel_od_farm_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_farm ADD CONSTRAINT rel_od_farm_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group ADD CONSTRAINT rel_od_building_group_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group ADD CONSTRAINT rel_od_building_group_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group_baugwr ADD CONSTRAINT rel_od_building_group_baugwr_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_building_group_baugwr ADD CONSTRAINT rel_od_building_group_baugwr_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_disposal ADD CONSTRAINT rel_od_disposal_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_disposal ADD CONSTRAINT rel_od_disposal_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_sludge_treatment ADD CONSTRAINT rel_od_sludge_treatment_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_sludge_treatment ADD CONSTRAINT rel_od_sludge_treatment_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_waste_water_treatment ADD CONSTRAINT rel_od_waste_water_treatment_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_waste_water_treatment ADD CONSTRAINT rel_od_waste_water_treatment_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wwtp_energy_use ADD CONSTRAINT rel_od_wwtp_energy_use_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wwtp_energy_use ADD CONSTRAINT rel_od_wwtp_energy_use_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_control_center ADD CONSTRAINT rel_od_control_center_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_control_center ADD CONSTRAINT rel_od_control_center_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_sector_water_body ADD CONSTRAINT rel_od_sector_water_body_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_sector_water_body ADD CONSTRAINT rel_od_sector_water_body_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_river_bed ADD CONSTRAINT rel_od_river_bed_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_river_bed ADD CONSTRAINT rel_od_river_bed_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT rel_od_water_course_segment_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_water_course_segment ADD CONSTRAINT rel_od_water_course_segment_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_surface_water_bodies ADD CONSTRAINT rel_od_surface_water_bodies_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_surface_water_bodies ADD CONSTRAINT rel_od_surface_water_bodies_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_aquifier ADD CONSTRAINT rel_od_aquifier_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_aquifier ADD CONSTRAINT rel_od_aquifier_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_bathing_area ADD CONSTRAINT rel_od_bathing_area_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_bathing_area ADD CONSTRAINT rel_od_bathing_area_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_water_control_structure ADD CONSTRAINT rel_od_water_control_structure_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_water_control_structure ADD CONSTRAINT rel_od_water_control_structure_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT rel_od_water_catchment_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_water_catchment ADD CONSTRAINT rel_od_water_catchment_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_fish_pass ADD CONSTRAINT rel_od_fish_pass_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_fish_pass ADD CONSTRAINT rel_od_fish_pass_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_river_bank ADD CONSTRAINT rel_od_river_bank_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_river_bank ADD CONSTRAINT rel_od_river_bank_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_damage ADD CONSTRAINT rel_od_damage_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_damage ADD CONSTRAINT rel_od_damage_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hydr_geometry ADD CONSTRAINT rel_od_hydr_geometry_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hydr_geometry ADD CONSTRAINT rel_od_hydr_geometry_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hydr_geom_relation ADD CONSTRAINT rel_od_hydr_geom_relation_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hydr_geom_relation ADD CONSTRAINT rel_od_hydr_geom_relation_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_pipe_profile ADD CONSTRAINT rel_od_pipe_profile_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_pipe_profile ADD CONSTRAINT rel_od_pipe_profile_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_networkelement ADD CONSTRAINT rel_od_wastewater_networkelement_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_networkelement ADD CONSTRAINT rel_od_wastewater_networkelement_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hq_relation ADD CONSTRAINT rel_od_hq_relation_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hq_relation ADD CONSTRAINT rel_od_hq_relation_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_accident ADD CONSTRAINT rel_od_accident_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_accident ADD CONSTRAINT rel_od_accident_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_log_card ADD CONSTRAINT rel_od_log_card_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_log_card ADD CONSTRAINT rel_od_log_card_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_overflow_characteristic ADD CONSTRAINT rel_od_overflow_characteristic_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_overflow_characteristic ADD CONSTRAINT rel_od_overflow_characteristic_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_data_media ADD CONSTRAINT rel_od_data_media_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_data_media ADD CONSTRAINT rel_od_data_media_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_structure_part ADD CONSTRAINT rel_od_structure_part_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_structure_part ADD CONSTRAINT rel_od_structure_part_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT rel_od_wastewater_structure_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_structure ADD CONSTRAINT rel_od_wastewater_structure_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_maintenance_event ADD CONSTRAINT rel_od_maintenance_event_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_maintenance_event ADD CONSTRAINT rel_od_maintenance_event_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT rel_od_hydraulic_characteristic_data_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hydraulic_characteristic_data ADD CONSTRAINT rel_od_hydraulic_characteristic_data_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_retention_body ADD CONSTRAINT rel_od_retention_body_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_retention_body ADD CONSTRAINT rel_od_retention_body_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_od_throttle_shut_off_unit_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_throttle_shut_off_unit ADD CONSTRAINT rel_od_throttle_shut_off_unit_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_reach_point ADD CONSTRAINT rel_od_reach_point_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_reach_point ADD CONSTRAINT rel_od_reach_point_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_mechanical_pretreatment ADD CONSTRAINT rel_od_mechanical_pretreatment_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_mechanical_pretreatment ADD CONSTRAINT rel_od_mechanical_pretreatment_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_profile_geometry ADD CONSTRAINT rel_od_profile_geometry_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_profile_geometry ADD CONSTRAINT rel_od_profile_geometry_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_file ADD CONSTRAINT rel_od_file_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_file ADD CONSTRAINT rel_od_file_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_od_overflow_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_overflow ADD CONSTRAINT rel_od_overflow_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_od_catchment_area_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_catchment_area ADD CONSTRAINT rel_od_catchment_area_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hazard_source ADD CONSTRAINT rel_od_hazard_source_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_hazard_source ADD CONSTRAINT rel_od_hazard_source_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_connection_object ADD CONSTRAINT rel_od_connection_object_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_connection_object ADD CONSTRAINT rel_od_connection_object_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_surface_runoff_parameters ADD CONSTRAINT rel_od_surface_runoff_parameters_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_surface_runoff_parameters ADD CONSTRAINT rel_od_surface_runoff_parameters_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_catchement_area_totals ADD CONSTRAINT rel_od_catchement_area_totals_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_catchement_area_totals ADD CONSTRAINT rel_od_catchement_area_totals_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_substance ADD CONSTRAINT rel_od_substance_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_substance ADD CONSTRAINT rel_od_substance_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measure ADD CONSTRAINT rel_od_measure_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measure ADD CONSTRAINT rel_od_measure_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measuring_device ADD CONSTRAINT rel_od_measuring_device_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measuring_device ADD CONSTRAINT rel_od_measuring_device_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_od_measuring_point_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measuring_point ADD CONSTRAINT rel_od_measuring_point_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measurement_series ADD CONSTRAINT rel_od_measurement_series_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measurement_series ADD CONSTRAINT rel_od_measurement_series_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT rel_od_measurement_result_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_measurement_result ADD CONSTRAINT rel_od_measurement_result_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT rel_od_wastewater_structure_symbol_fk_dataowner FOREIGN KEY (fk_dataowner) REFERENCES qgep.od_organisation(obj_id);
ALTER TABLE qgep.od_wastewater_structure_symbol ADD CONSTRAINT rel_od_wastewater_structure_symbol_fk_dataprovider FOREIGN KEY (fk_provider) REFERENCES qgep.od_organisation(obj_id);

------ Indexes on identifiers

 CREATE UNIQUE INDEX in_od_organisation_identifier ON qgep.od_organisation USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_zone_identifier ON qgep.od_zone USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_building_group_identifier ON qgep.od_building_group USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_sludge_treatment_identifier ON qgep.od_sludge_treatment USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_waste_water_treatment_identifier ON qgep.od_waste_water_treatment USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_wwtp_energy_use_identifier ON qgep.od_wwtp_energy_use USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_control_center_identifier ON qgep.od_control_center USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_sector_water_body_identifier ON qgep.od_sector_water_body USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_river_bed_identifier ON qgep.od_river_bed USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_water_course_segment_identifier ON qgep.od_water_course_segment USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_surface_water_bodies_identifier ON qgep.od_surface_water_bodies USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_aquifier_identifier ON qgep.od_aquifier USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_bathing_area_identifier ON qgep.od_bathing_area USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_water_control_structure_identifier ON qgep.od_water_control_structure USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_water_catchment_identifier ON qgep.od_water_catchment USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_fish_pass_identifier ON qgep.od_fish_pass USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_river_bank_identifier ON qgep.od_river_bank USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_hydr_geometry_identifier ON qgep.od_hydr_geometry USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_pipe_profile_identifier ON qgep.od_pipe_profile USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_wastewater_networkelement_identifier ON qgep.od_wastewater_networkelement USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_accident_identifier ON qgep.od_accident USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_overflow_characteristic_identifier ON qgep.od_overflow_characteristic USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_data_media_identifier ON qgep.od_data_media USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_structure_part_identifier ON qgep.od_structure_part USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_wastewater_structure_identifier ON qgep.od_wastewater_structure USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_maintenance_event_identifier ON qgep.od_maintenance_event USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_hydraulic_characteristic_data_identifier ON qgep.od_hydraulic_characteristic_data USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_retention_body_identifier ON qgep.od_retention_body USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_throttle_shut_off_unit_identifier ON qgep.od_throttle_shut_off_unit USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_reach_point_identifier ON qgep.od_reach_point USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_mechanical_pretreatment_identifier ON qgep.od_mechanical_pretreatment USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_file_identifier ON qgep.od_file USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_overflow_identifier ON qgep.od_overflow USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_catchment_area_identifier ON qgep.od_catchment_area USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_hazard_source_identifier ON qgep.od_hazard_source USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_connection_object_identifier ON qgep.od_connection_object USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_surface_runoff_parameters_identifier ON qgep.od_surface_runoff_parameters USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_substance_identifier ON qgep.od_substance USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_measure_identifier ON qgep.od_measure USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_measuring_device_identifier ON qgep.od_measuring_device USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_measuring_point_identifier ON qgep.od_measuring_point USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_measurement_series_identifier ON qgep.od_measurement_series USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);
 CREATE UNIQUE INDEX in_od_measurement_result_identifier ON qgep.od_measurement_result USING btree (identifier ASC NULLS LAST, fk_dataowner ASC NULLS LAST);

COMMIT;
