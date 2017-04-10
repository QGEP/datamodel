CREATE TABLE vsadss2008_1_d.Kanal_Verbindungsart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Ufer
CREATE TABLE vsadss2008_1_d.Ufer (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gewaesserabschnitt integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Breite decimal(8,2) NULL
  ,Seite varchar(255) NULL
  ,Seite_txt varchar(255) NULL
  ,Uferbereich varchar(255) NULL
  ,Uferbereich_txt varchar(255) NULL
  ,Umlandnutzung varchar(255) NULL
  ,Umlandnutzung_txt varchar(255) NULL
  ,Vegetation varchar(255) NULL
  ,Vegetation_txt varchar(255) NULL
  ,Verbauungsart varchar(255) NULL
  ,Verbauungsart_txt varchar(255) NULL
  ,Verbauungsgrad varchar(255) NULL
  ,Verbauungsgrad_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Ufer IS '@iliname DSS_2008.Siedlungsentwaesserung.Ufer';
-- DSS_2008.Siedlungsentwaesserung.Leapingwehr
CREATE TABLE vsadss2008_1_d.Leapingwehr (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Breite decimal(8,2) NULL
  ,Laenge decimal(8,2) NULL
  ,Oeffnungsform varchar(255) NULL
  ,Oeffnungsform_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Leapingwehr IS '@iliname DSS_2008.Siedlungsentwaesserung.Leapingwehr';
CREATE TABLE vsadss2008_1_d.ARABauwerk_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.T_ILI2DB_BASKET (
  T_Id integer PRIMARY KEY
  ,dataset integer NULL
  ,topic varchar(200) NOT NULL
  ,T_Ili_Tid varchar(200) NULL
  ,attachmentKey varchar(200) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Abwasserbehandlung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Amt
CREATE TABLE vsadss2008_1_d.Amt (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Amt IS '@iliname DSS_2008.Siedlungsentwaesserung.Amt';
CREATE TABLE vsadss2008_1_d.Schlammbehandlung_Stabilisierung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Ufer_Verbauungsart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Deckel
CREATE TABLE vsadss2008_1_d.Deckel (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Deckelform varchar(255) NULL
  ,Deckelform_txt varchar(255) NULL
  ,Durchmesser integer NULL
  ,Entlueftung varchar(255) NULL
  ,Entlueftung_txt varchar(255) NULL
  ,Fabrikat varchar(50) NULL
  ,Kote decimal(8,3) NULL
  ,Lagegenauigkeit varchar(255) NULL
  ,Lagegenauigkeit_txt varchar(255) NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
  ,Schlammeimer varchar(255) NULL
  ,Schlammeimer_txt varchar(255) NULL
  ,Verschluss varchar(255) NULL
  ,Verschluss_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','deckel','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Deckel IS '@iliname DSS_2008.Siedlungsentwaesserung.Deckel';
-- DSS_2008.Siedlungsentwaesserung.Absperr_Drosselorgan
CREATE TABLE vsadss2008_1_d.Absperr_Drosselorgan (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserknoten integer NULL
  ,Steuerungszentrale integer NULL
  ,Antrieb varchar(255) NULL
  ,Antrieb_txt varchar(255) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,BruttoKosten decimal(11,2) NULL
  ,Fabrikat varchar(50) NULL
  ,Querschnitt decimal(9,2) NULL
  ,Signaluebermittlung varchar(255) NULL
  ,Signaluebermittlung_txt varchar(255) NULL
  ,Steuerung varchar(255) NULL
  ,Steuerung_txt varchar(255) NULL
  ,Subventionen decimal(11,2) NULL
  ,Verstellbarkeit varchar(255) NULL
  ,Verstellbarkeit_txt varchar(255) NULL
  ,Wirksamer_QS decimal(9,2) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Absperr_Drosselorgan IS '@iliname DSS_2008.Siedlungsentwaesserung.Absperr_Drosselorgan';
CREATE TABLE vsadss2008_1_d.Planungszone_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Entwaesserungssystem_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Normschacht_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Haltung_Innenschutz (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Einzelflaeche_Befestigung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Messstelle
CREATE TABLE vsadss2008_1_d.Messstelle (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Betreiber integer NULL
  ,Abwasserreinigungsanlage integer NULL
  ,Abwasserbauwerk integer NULL
  ,Gewaesserabschnitt integer NULL
  ,Art varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','messstelle','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Messstelle IS '@iliname DSS_2008.Siedlungsentwaesserung.Messstelle';
-- DSS_2008.Siedlungsentwaesserung.Abwasserknoten
CREATE TABLE vsadss2008_1_d.Abwasserknoten (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Hydr_Geometrie integer NULL
  ,Rueckstaukote decimal(8,3) NULL
  ,Sohlenkote decimal(8,3) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','abwasserknoten','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Abwasserknoten IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwasserknoten';
-- DSS_2008.Siedlungsentwaesserung.Hydr_Geometrie
CREATE TABLE vsadss2008_1_d.Hydr_Geometrie (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Hydr_Geometrie IS '@iliname DSS_2008.Siedlungsentwaesserung.Hydr_Geometrie';
-- DSS_2008.Siedlungsentwaesserung.See
CREATE TABLE vsadss2008_1_d.See (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','see','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.See IS '@iliname DSS_2008.Siedlungsentwaesserung.See';
-- DSS_2008.Siedlungsentwaesserung.GewaesserAbsturz
CREATE TABLE vsadss2008_1_d.GewaesserAbsturz (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Absturzhoehe decimal(8,2) NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
  ,Typ varchar(255) NULL
  ,Typ_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.GewaesserAbsturz IS '@iliname DSS_2008.Siedlungsentwaesserung.GewaesserAbsturz';
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Wasserhaerte (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Leapingwehr_Oeffnungsform (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaessersohle_Verbauungsart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Ufer_Uferbereich (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.FoerderAggregat_Bauart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserschutzbereich_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.ElektrischeEinrichtung
CREATE TABLE vsadss2008_1_d.ElektrischeEinrichtung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,BruttoKosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.ElektrischeEinrichtung IS '@iliname DSS_2008.Siedlungsentwaesserung.ElektrischeEinrichtung';
-- DSS_2008.Siedlungsentwaesserung.Schleuse
CREATE TABLE vsadss2008_1_d.Schleuse (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Absturzhoehe decimal(8,2) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Schleuse IS '@iliname DSS_2008.Siedlungsentwaesserung.Schleuse';
-- DSS_2008.Siedlungsentwaesserung.Abwasserbauwerk
CREATE TABLE vsadss2008_1_d.Abwasserbauwerk (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Eigentuemer integer NULL
  ,Betreiber integer NULL
  ,Baujahr integer NULL
  ,BaulicherZustand varchar(255) NULL
  ,BaulicherZustand_txt varchar(255) NULL
  ,Baulos varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
  ,Inspektionsintervall decimal(5,2) NULL
  ,Sanierungsbedarf varchar(255) NULL
  ,Sanierungsbedarf_txt varchar(255) NULL
  ,Standortname varchar(50) NULL
  ,Status varchar(255) NULL
  ,Status_txt varchar(255) NULL
  ,Subventionen decimal(11,2) NULL
  ,Zugaenglichkeit varchar(255) NULL
  ,Zugaenglichkeit_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','abwasserbauwerk','detailgeometrie',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Abwasserbauwerk IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwasserbauwerk';
CREATE TABLE vsadss2008_1_d.Abwasserbauwerk_Sanierungsbedarf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Rohrprofil_Profiltyp (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Deckel_Verschluss (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.MechanischeVorreinigung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Kanal
CREATE TABLE vsadss2008_1_d.Kanal (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Bettung_Umhuellung varchar(255) NULL
  ,Bettung_Umhuellung_txt varchar(255) NULL
  ,FunktionHierarchisch varchar(255) NULL
  ,FunktionHierarchisch_txt varchar(255) NULL
  ,FunktionHydraulisch varchar(255) NULL
  ,FunktionHydraulisch_txt varchar(255) NULL
  ,Nutzungsart_geplant varchar(255) NULL
  ,Nutzungsart_geplant_txt varchar(255) NULL
  ,Nutzungsart_Ist varchar(255) NULL
  ,Nutzungsart_Ist_txt varchar(255) NULL
  ,Rohrlaenge decimal(8,2) NULL
  ,Spuelintervall decimal(5,2) NULL
  ,Verbindungsart varchar(255) NULL
  ,Verbindungsart_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Kanal IS '@iliname DSS_2008.Siedlungsentwaesserung.Kanal';
CREATE TABLE vsadss2008_1_d.ElektrischeEinrichtung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Einstiegshilfe
CREATE TABLE vsadss2008_1_d.Einstiegshilfe (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Einstiegshilfe IS '@iliname DSS_2008.Siedlungsentwaesserung.Einstiegshilfe';
-- DSS_2008.Siedlungsentwaesserung.Normschacht
CREATE TABLE vsadss2008_1_d.Normschacht (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Dimension1 integer NULL
  ,Dimension2 integer NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
  ,Oberflaechenzulauf varchar(255) NULL
  ,Oberflaechenzulauf_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Normschacht IS '@iliname DSS_2008.Siedlungsentwaesserung.Normschacht';
-- DSS_2008.Siedlungsentwaesserung.Hydr_GeomRelation
CREATE TABLE vsadss2008_1_d.Hydr_GeomRelation (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Hydr_Geometrie integer NULL
  ,BenetzteQuerschnittsflaeche decimal(9,2) NULL
  ,Wasseroberflaeche decimal(9,2) NULL
  ,Wassertiefe decimal(8,2) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Hydr_GeomRelation IS '@iliname DSS_2008.Siedlungsentwaesserung.Hydr_GeomRelation';
-- DSS_2008.Siedlungsentwaesserung.ElektromechanischeAusruestung
CREATE TABLE vsadss2008_1_d.ElektromechanischeAusruestung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,BruttoKosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.ElektromechanischeAusruestung IS '@iliname DSS_2008.Siedlungsentwaesserung.ElektromechanischeAusruestung';
CREATE TABLE vsadss2008_1_d.Haltungspunkt_Hoehengenauigkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Messgeraet
CREATE TABLE vsadss2008_1_d.Messgeraet (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Art varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Fabrikat varchar(50) NULL
  ,Seriennummer varchar(50) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Messgeraet IS '@iliname DSS_2008.Siedlungsentwaesserung.Messgeraet';
-- DSS_2008.Siedlungsentwaesserung.Gewaesserschutzbereich
CREATE TABLE vsadss2008_1_d.Gewaesserschutzbereich (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gewaesserschutzbereich','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Gewaesserschutzbereich IS '@iliname DSS_2008.Siedlungsentwaesserung.Gewaesserschutzbereich';
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Algenbewuchs (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Totholz (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Furt
CREATE TABLE vsadss2008_1_d.Furt (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Furt IS '@iliname DSS_2008.Siedlungsentwaesserung.Furt';
-- DSS_2008.Siedlungsentwaesserung.Grundwasserleiter
CREATE TABLE vsadss2008_1_d.Grundwasserleiter (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,MaxGWSpiegel decimal(8,3) NULL
  ,MinGWSpiegel decimal(8,3) NULL
  ,MittlererGWSpiegel decimal(8,3) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','grundwasserleiter','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Grundwasserleiter IS '@iliname DSS_2008.Siedlungsentwaesserung.Grundwasserleiter';
CREATE TABLE vsadss2008_1_d.T_ILI2DB_MODEL (
  file varchar(250) NOT NULL
  ,iliversion varchar(3) NOT NULL
  ,modelName text NOT NULL
  ,content text NOT NULL
  ,importDate timestamp NOT NULL
  ,PRIMARY KEY (modelName,iliversion)
)
;
CREATE TABLE vsadss2008_1_d.FoerderAggregat_AufstellungFoerderaggregat (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Normschacht_Oberflaechenzulauf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Absperr_Drosselorgan_Antrieb (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Entwaesserungssystem
CREATE TABLE vsadss2008_1_d.Entwaesserungssystem (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','entwaesserungssystem','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Entwaesserungssystem IS '@iliname DSS_2008.Siedlungsentwaesserung.Entwaesserungssystem';
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Laengsprofil (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Spezialbauwerk_Bypass (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Deckel_Entlueftung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Abwasserverband
CREATE TABLE vsadss2008_1_d.Abwasserverband (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Abwasserverband IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwasserverband';
-- DSS_2008.Siedlungsentwaesserung.Gemeinde
CREATE TABLE vsadss2008_1_d.Gemeinde (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Einwohner integer NULL
  ,Flaeche decimal(9,2) NULL
  ,Gemeindenummer integer NULL
  ,GEP_Jahr integer NULL
  ,Hoehe decimal(8,3) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gemeinde','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Gemeinde IS '@iliname DSS_2008.Siedlungsentwaesserung.Gemeinde';
CREATE TABLE vsadss2008_1_d.Deckel_Deckelform (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Planungszone
CREATE TABLE vsadss2008_1_d.Planungszone (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','planungszone','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Planungszone IS '@iliname DSS_2008.Siedlungsentwaesserung.Planungszone';
CREATE TABLE vsadss2008_1_d.Deckel_Schlammeimer (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Messresultat
CREATE TABLE vsadss2008_1_d.Messresultat (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Messgeraet integer NULL
  ,Messreihe integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Messart varchar(50) NULL
  ,Messdauer integer NULL
  ,Wert decimal(14,4) NULL
  ,Zeit date NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Messresultat IS '@iliname DSS_2008.Siedlungsentwaesserung.Messresultat';
CREATE TABLE vsadss2008_1_d.Versickerungsbereich_Versickerungsmoeglichkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Haltung_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Haltungspunkt_Auslaufform (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Wasserdichtheit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Einzugsgebiet_Text
CREATE TABLE vsadss2008_1_d.Einzugsgebiet_Text (
  T_Id integer PRIMARY KEY
  ,EinzugsgebietRef integer NULL
  ,Textinhalt varchar(80) NOT NULL
  ,TextOri decimal(5,1) NULL
  ,TextHAli varchar(255) NULL
  ,TextHAli_txt varchar(255) NULL
  ,TextVAli varchar(255) NULL
  ,TextVAli_txt varchar(255) NULL
  ,Plantyp varchar(255) NOT NULL
  ,Plantyp_txt varchar(255) NOT NULL
  ,Bemerkung varchar(80) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','einzugsgebiet_text','textpos',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Einzugsgebiet_Text IS '@iliname DSS_2008.Siedlungsentwaesserung.Einzugsgebiet_Text';
-- DSS_2008.Siedlungsentwaesserung.Organisation
CREATE TABLE vsadss2008_1_d.Organisation (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Organisation IS '@iliname DSS_2008.Siedlungsentwaesserung.Organisation';
-- DSS_2008.Siedlungsentwaesserung.Vorflutereinlauf
CREATE TABLE vsadss2008_1_d.Vorflutereinlauf (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Gewaessersektor integer NULL
  ,Hochwasserkote decimal(8,3) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Vorflutereinlauf IS '@iliname DSS_2008.Siedlungsentwaesserung.Vorflutereinlauf';
-- DSS_2008.Siedlungsentwaesserung.Ueberlauf
CREATE TABLE vsadss2008_1_d.Ueberlauf (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserknoten integer NULL
  ,UeberlaufNach integer NULL
  ,Ueberlaufcharakteristik integer NULL
  ,Steuerungszentrale integer NULL
  ,Antrieb varchar(255) NULL
  ,Antrieb_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,BruttoKosten decimal(11,2) NULL
  ,Fabrikat varchar(50) NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
  ,Qan_dim decimal(9,3) NULL
  ,Qan_ist decimal(9,3) NULL
  ,Signaluebermittlung varchar(255) NULL
  ,Signaluebermittlung_txt varchar(255) NULL
  ,Steuerung varchar(255) NULL
  ,Steuerung_txt varchar(255) NULL
  ,Subventionen decimal(11,2) NULL
  ,Ueberlaufdauer decimal(7,1) NULL
  ,Ueberlauffracht integer NULL
  ,Ueberlaufhaeufigkeit decimal(14,4) NULL
  ,Ueberlaufmenge decimal(10,2) NULL
  ,Verstellbarkeit varchar(255) NULL
  ,Verstellbarkeit_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Ueberlauf IS '@iliname DSS_2008.Siedlungsentwaesserung.Ueberlauf';
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Saugwagen (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Sohlrampe_Befestigung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_BASKET (
  T_Id integer PRIMARY KEY
  ,import integer NOT NULL
  ,basket integer NOT NULL
  ,objectCount integer NULL
  ,start_t_id integer NULL
  ,end_t_id integer NULL
)
;
CREATE TABLE vsadss2008_1_d.T_KEY_OBJECT (
  T_Key varchar(30) PRIMARY KEY
  ,T_LastUniqueId integer NOT NULL
  ,T_LastChange timestamp NOT NULL
  ,T_CreateDate timestamp NOT NULL
  ,T_User varchar(40) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.MechanischeVorreinigung
CREATE TABLE vsadss2008_1_d.MechanischeVorreinigung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Versickerungsanlage integer NULL
  ,Abwasserbauwerk integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.MechanischeVorreinigung IS '@iliname DSS_2008.Siedlungsentwaesserung.MechanischeVorreinigung';
CREATE TABLE vsadss2008_1_d.Ufer_Vegetation (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Wasserfassung
CREATE TABLE vsadss2008_1_d.Wasserfassung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Grundwasserleiter integer NULL
  ,Oberflaechengewaesser integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','wasserfassung','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Wasserfassung IS '@iliname DSS_2008.Siedlungsentwaesserung.Wasserfassung';
CREATE TABLE vsadss2008_1_d.Ufer_Seite (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Oekom_Klassifizierung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Gewaesserverbauung
CREATE TABLE vsadss2008_1_d.Gewaesserverbauung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gewaesserabschnitt integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gewaesserverbauung','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Gewaesserverbauung IS '@iliname DSS_2008.Siedlungsentwaesserung.Gewaesserverbauung';
-- DSS_2008.Siedlungsentwaesserung.Kanton
CREATE TABLE vsadss2008_1_d.Kanton (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','kanton','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Kanton IS '@iliname DSS_2008.Siedlungsentwaesserung.Kanton';
CREATE TABLE vsadss2008_1_d.Abwasserbauwerk_Zugaenglichkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.MUTATION
CREATE TABLE vsadss2008_1_d.MUTATION (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,OBJEKT varchar(20) NOT NULL
  ,KLASSE varchar(50) NOT NULL
  ,ATTRIBUT varchar(50) NOT NULL
  ,LETZTER_WERT varchar(80) NULL
  ,ART varchar(255) NOT NULL
  ,ART_txt varchar(255) NOT NULL
  ,AUFNAHMEDATUM date NULL
  ,AUFNEHMER varchar(30) NULL
  ,MUTATIONSDATUM date NULL
  ,SYSTEMBENUTZER varchar(30) NULL
  ,BEMERKUNG varchar(80) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.MUTATION IS '@iliname DSS_2008.Siedlungsentwaesserung.MUTATION';
CREATE TABLE vsadss2008_1_d.Deckel_Lagegenauigkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.GewaesserAbsturz_Typ (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Plantyp (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Kanal_FunktionHierarchisch (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.MUTATION_ART (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Messstelle_Hierarchie
CREATE TABLE vsadss2008_1_d.Messstelle_Hierarchie (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Messstelle integer NULL
  ,Referenzstelle integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Messstelle_Hierarchie IS '@iliname DSS_2008.Siedlungsentwaesserung.Messstelle_Hierarchie';
CREATE TABLE vsadss2008_1_d.Ueberlauf_Steuerung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Anschlussobjekt
CREATE TABLE vsadss2008_1_d.Anschlussobjekt (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwassernetzelement integer NULL
  ,Eigentuemer integer NULL
  ,Betreiber integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Fremdwasseranfall decimal(10,3) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Anschlussobjekt IS '@iliname DSS_2008.Siedlungsentwaesserung.Anschlussobjekt';
-- DSS_2008.Siedlungsentwaesserung.EZG_PARAMETER_ALLG
CREATE TABLE vsadss2008_1_d.EZG_PARAMETER_ALLG (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Einwohnergleichwert integer NULL
  ,Flaeche decimal(9,2) NULL
  ,Fliessweggefaelle integer NULL
  ,Fliessweglaenge decimal(8,2) NULL
  ,Trockenwetteranfall decimal(10,3) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.EZG_PARAMETER_ALLG IS '@iliname DSS_2008.Siedlungsentwaesserung.EZG_PARAMETER_ALLG';
-- DSS_2008.Siedlungsentwaesserung.Abwasserbehandlung
CREATE TABLE vsadss2008_1_d.Abwasserbehandlung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserreinigungsanlage integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Abwasserbehandlung IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwasserbehandlung';
CREATE TABLE vsadss2008_1_d.Fliessgewaesser_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.ARABauwerk
CREATE TABLE vsadss2008_1_d.ARABauwerk (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.ARABauwerk IS '@iliname DSS_2008.Siedlungsentwaesserung.ARABauwerk';
CREATE TABLE vsadss2008_1_d.Gewaessersohle_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Ueberlaufcharakteristik
CREATE TABLE vsadss2008_1_d.Ueberlaufcharakteristik (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Ueberlaufcharakteristik IS '@iliname DSS_2008.Siedlungsentwaesserung.Ueberlaufcharakteristik';
-- DSS_2008.Siedlungsentwaesserung.Rohrprofil_Geometrie
CREATE TABLE vsadss2008_1_d.Rohrprofil_Geometrie (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Rohrprofil integer NULL
  ,Position decimal(14,4) NULL
  ,x decimal(14,4) NULL
  ,y decimal(14,4) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Rohrprofil_Geometrie IS '@iliname DSS_2008.Siedlungsentwaesserung.Rohrprofil_Geometrie';
CREATE TABLE vsadss2008_1_d.Abwasserbauwerk_BaulicherZustand (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Rohrprofil
CREATE TABLE vsadss2008_1_d.Rohrprofil (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,HoehenBreitenverhaeltnis decimal(6,2) NULL
  ,Profiltyp varchar(255) NULL
  ,Profiltyp_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Rohrprofil IS '@iliname DSS_2008.Siedlungsentwaesserung.Rohrprofil';
-- DSS_2008.Siedlungsentwaesserung.Haltungspunkt
CREATE TABLE vsadss2008_1_d.Haltungspunkt (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwassernetzelement integer NULL
  ,Auslaufform varchar(255) NULL
  ,Auslaufform_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Hoehengenauigkeit varchar(255) NULL
  ,Hoehengenauigkeit_txt varchar(255) NULL
  ,Kote decimal(8,3) NULL
  ,Lage_Anschluss integer NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','haltungspunkt','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Haltungspunkt IS '@iliname DSS_2008.Siedlungsentwaesserung.Haltungspunkt';
-- DSS_2008.Siedlungsentwaesserung.Geschiebesperre
CREATE TABLE vsadss2008_1_d.Geschiebesperre (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Absturzhoehe decimal(8,2) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Geschiebesperre IS '@iliname DSS_2008.Siedlungsentwaesserung.Geschiebesperre';
CREATE TABLE vsadss2008_1_d.Haltung_Lagebestimmung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Ueberlauf_Verstellbarkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Einzugsgebiet_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Versickerungsbereich
CREATE TABLE vsadss2008_1_d.Versickerungsbereich (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Versickerungsmoeglichkeit varchar(255) NULL
  ,Versickerungsmoeglichkeit_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','versickerungsbereich','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Versickerungsbereich IS '@iliname DSS_2008.Siedlungsentwaesserung.Versickerungsbereich';
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Tiefenvariabilitaet (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Spezialbauwerk_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Schlammbehandlung
CREATE TABLE vsadss2008_1_d.Schlammbehandlung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserreinigungsanlage integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,EntwaessertKlaerschlammstapelung decimal(10,2) NULL
  ,Entwaesserung decimal(8,2) NULL
  ,Faulschlammverbrennung decimal(8,2) NULL
  ,Fluessigklaerschlammstapelung decimal(10,2) NULL
  ,Frischschlammverbrennung decimal(8,2) NULL
  ,Hygienisierung decimal(8,2) NULL
  ,Kompostierung decimal(8,2) NULL
  ,Mischschlammvoreindickung decimal(10,2) NULL
  ,PrimaerschlammVoreindickung decimal(10,2) NULL
  ,Stabilisierung varchar(255) NULL
  ,Stabilisierung_txt varchar(255) NULL
  ,Trocknung decimal(8,2) NULL
  ,Ueberschusschalmmvoreindickung decimal(10,2) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Schlammbehandlung IS '@iliname DSS_2008.Siedlungsentwaesserung.Schlammbehandlung';
-- DSS_2008.Siedlungsentwaesserung.Fischpass
CREATE TABLE vsadss2008_1_d.Fischpass (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gewaesserverbauung integer NULL
  ,Absturzhoehe decimal(8,2) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Fischpass IS '@iliname DSS_2008.Siedlungsentwaesserung.Fischpass';
-- DSS_2008.Siedlungsentwaesserung.Organisation_Hierarchie
CREATE TABLE vsadss2008_1_d.Organisation_Hierarchie (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Organisation integer NULL
  ,Teil_von integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Organisation_Hierarchie IS '@iliname DSS_2008.Siedlungsentwaesserung.Organisation_Hierarchie';
CREATE TABLE vsadss2008_1_d.T_ILI2DB_IMPORT (
  T_Id integer PRIMARY KEY
  ,dataset integer NOT NULL
  ,importDate timestamp NOT NULL
  ,importUser varchar(40) NOT NULL
  ,importFile varchar(200) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Gewaessersohle
CREATE TABLE vsadss2008_1_d.Gewaessersohle (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gewaesserabschnitt integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Breite decimal(8,2) NULL
  ,Verbauungsart varchar(255) NULL
  ,Verbauungsart_txt varchar(255) NULL
  ,Verbauungsgrad varchar(255) NULL
  ,Verbauungsgrad_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Gewaessersohle IS '@iliname DSS_2008.Siedlungsentwaesserung.Gewaessersohle';
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.ARAEnergienutzung
CREATE TABLE vsadss2008_1_d.ARAEnergienutzung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserreinigungsanlage integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Gasmotor integer NULL
  ,Turbinierung integer NULL
  ,Waermepumpe integer NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.ARAEnergienutzung IS '@iliname DSS_2008.Siedlungsentwaesserung.ARAEnergienutzung';
-- DSS_2008.Siedlungsentwaesserung.Unfall
CREATE TABLE vsadss2008_1_d.Unfall (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gefahrenquelle integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Datum date NULL
  ,Ort varchar(50) NULL
  ,Verursacher varchar(50) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','unfall','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Unfall IS '@iliname DSS_2008.Siedlungsentwaesserung.Unfall';
CREATE TABLE vsadss2008_1_d.Retentionskoerper_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Retentionskoerper
CREATE TABLE vsadss2008_1_d.Retentionskoerper (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Versickerungsanlage integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Retention_Volumen decimal(10,2) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Retentionskoerper IS '@iliname DSS_2008.Siedlungsentwaesserung.Retentionskoerper';
CREATE TABLE vsadss2008_1_d.GewaesserAbsturz_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Zone
CREATE TABLE vsadss2008_1_d.Zone (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Zone IS '@iliname DSS_2008.Siedlungsentwaesserung.Zone';
-- DSS_2008.Siedlungsentwaesserung.Messreihe
CREATE TABLE vsadss2008_1_d.Messreihe (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Messstelle integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Dimension varchar(50) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Messreihe IS '@iliname DSS_2008.Siedlungsentwaesserung.Messreihe';
CREATE TABLE vsadss2008_1_d.Ueberlauf_Signaluebermittlung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Messreihe_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Linienfuehrung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Absperr_Drosselorgan_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.T_ILI2DB_SETTINGS (
  tag varchar(60) PRIMARY KEY
  ,setting varchar(60) NULL
)
;
CREATE TABLE vsadss2008_1_d.Einzugsgebiet_Status (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Ueberlauf_Antrieb (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Notueberlauf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Oberflaechenabflussparameter
CREATE TABLE vsadss2008_1_d.Oberflaechenabflussparameter (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Einzugsgebiet integer NULL
  ,Bemerkung varchar(80) NULL
  ,Benetzungsverlust decimal(5,1) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Muldenverlust decimal(5,1) NULL
  ,Verdunstungsverlust decimal(5,1) NULL
  ,Versickerungsverlust decimal(5,1) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Oberflaechenabflussparameter IS '@iliname DSS_2008.Siedlungsentwaesserung.Oberflaechenabflussparameter';
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Gefaelle (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Normschacht_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.FoerderAggregat_AufstellungAntrieb (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Durchlass
CREATE TABLE vsadss2008_1_d.Durchlass (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Durchlass IS '@iliname DSS_2008.Siedlungsentwaesserung.Durchlass';
-- DSS_2008.Siedlungsentwaesserung.Fliessgewaesser
CREATE TABLE vsadss2008_1_d.Fliessgewaesser (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Fliessgewaesser IS '@iliname DSS_2008.Siedlungsentwaesserung.Fliessgewaesser';
-- DSS_2008.Siedlungsentwaesserung.Erhaltungsereignis
CREATE TABLE vsadss2008_1_d.Erhaltungsereignis (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserbauwerk integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Ausfuehrender varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Datengrundlage varchar(50) NULL
  ,Dauer integer NULL
  ,Detaildaten varchar(50) NULL
  ,Ergebnis varchar(50) NULL
  ,Grund varchar(50) NULL
  ,Kosten decimal(11,2) NULL
  ,Status varchar(255) NULL
  ,Status_txt varchar(255) NULL
  ,Zeitpunkt date NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Erhaltungsereignis IS '@iliname DSS_2008.Siedlungsentwaesserung.Erhaltungsereignis';
CREATE TABLE vsadss2008_1_d.Absperr_Drosselorgan_Steuerung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.T_ILI2DB_CLASSNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Abwasserbauwerk_Status (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Streichwehr
CREATE TABLE vsadss2008_1_d.Streichwehr (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,HydrUeberfallaenge decimal(8,2) NULL
  ,KoteMax decimal(8,3) NULL
  ,KoteMin decimal(8,3) NULL
  ,Ueberfallkante varchar(255) NULL
  ,Ueberfallkante_txt varchar(255) NULL
  ,WehrschwellenZahl varchar(255) NULL
  ,WehrschwellenZahl_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Streichwehr IS '@iliname DSS_2008.Siedlungsentwaesserung.Streichwehr';
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Nutzung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Einstiegshilfe_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Erhaltungsereignis_Status (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.T_ILI2DB_DATASET (
  T_Id integer PRIMARY KEY
)
;
CREATE TABLE vsadss2008_1_d.Bankett_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.HQ_Relation
CREATE TABLE vsadss2008_1_d.HQ_Relation (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Ueberlaufcharakteristik integer NULL
  ,Durchfluss decimal(9,3) NULL
  ,Hoehe decimal(8,3) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.HQ_Relation IS '@iliname DSS_2008.Siedlungsentwaesserung.HQ_Relation';
-- DSS_2008.Siedlungsentwaesserung.Steuerungszentrale
CREATE TABLE vsadss2008_1_d.Steuerungszentrale (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','steuerungszentrale','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Steuerungszentrale IS '@iliname DSS_2008.Siedlungsentwaesserung.Steuerungszentrale';
CREATE TABLE vsadss2008_1_d.Deckel_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Gewaesserabschnitt
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Fliessgewaesser integer NULL
  ,Abflussregime varchar(255) NULL
  ,Abflussregime_txt varchar(255) NULL
  ,Algenbewuchs varchar(255) NULL
  ,Algenbewuchs_txt varchar(255) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Breitenvariabilitaet varchar(255) NULL
  ,Breitenvariabilitaet_txt varchar(255) NULL
  ,Gefaelle varchar(255) NULL
  ,Gefaelle_txt varchar(255) NULL
  ,Groesse integer NULL
  ,Hoehenstufe varchar(255) NULL
  ,Hoehenstufe_txt varchar(255) NULL
  ,Laengsprofil varchar(255) NULL
  ,Laengsprofil_txt varchar(255) NULL
  ,Linienfuehrung varchar(255) NULL
  ,Linienfuehrung_txt varchar(255) NULL
  ,Makrophytenbewuchs varchar(255) NULL
  ,Makrophytenbewuchs_txt varchar(255) NULL
  ,Nutzung varchar(255) NULL
  ,Nutzung_txt varchar(255) NULL
  ,Oekom_Klassifizierung varchar(255) NULL
  ,Oekom_Klassifizierung_txt varchar(255) NULL
  ,Sohlenbreite decimal(8,2) NULL
  ,Tiefenvariabilitaet varchar(255) NULL
  ,Tiefenvariabilitaet_txt varchar(255) NULL
  ,Totholz varchar(255) NULL
  ,Totholz_txt varchar(255) NULL
  ,Wasserhaerte varchar(255) NULL
  ,Wasserhaerte_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gewaesserabschnitt','bis',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
SELECT AddGeometryColumn('vsadss2008_1_d','gewaesserabschnitt','von',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Gewaesserabschnitt IS '@iliname DSS_2008.Siedlungsentwaesserung.Gewaesserabschnitt';
-- DSS_2008.Siedlungsentwaesserung.FoerderAggregat
CREATE TABLE vsadss2008_1_d.FoerderAggregat (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Aggregatezahl decimal(14,4) NULL
  ,Arbeitspunkt decimal(10,2) NULL
  ,AufstellungAntrieb varchar(255) NULL
  ,AufstellungAntrieb_txt varchar(255) NULL
  ,AufstellungFoerderaggregat varchar(255) NULL
  ,AufstellungFoerderaggregat_txt varchar(255) NULL
  ,Bauart varchar(255) NULL
  ,Bauart_txt varchar(255) NULL
  ,KoteStart decimal(8,3) NULL
  ,KoteStop decimal(8,3) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.FoerderAggregat IS '@iliname DSS_2008.Siedlungsentwaesserung.FoerderAggregat';
CREATE TABLE vsadss2008_1_d.Kanal_FunktionHydraulisch (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Erhaltungsereignis_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Versickerungswasser (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Badestelle
CREATE TABLE vsadss2008_1_d.Badestelle (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Oberflaechengewaesser integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','badestelle','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Badestelle IS '@iliname DSS_2008.Siedlungsentwaesserung.Badestelle';
-- DSS_2008.Siedlungsentwaesserung.Abwassernetzelement
CREATE TABLE vsadss2008_1_d.Abwassernetzelement (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserbauwerk integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Abwassernetzelement IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwassernetzelement';
-- DSS_2008.Siedlungsentwaesserung.Haltung
CREATE TABLE vsadss2008_1_d.Haltung (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,vonHaltungspunkt integer NULL
  ,nachHaltungspunkt integer NULL
  ,Rohrprofil integer NULL
  ,Innenschutz varchar(255) NULL
  ,Innenschutz_txt varchar(255) NULL
  ,LaengeEffektiv decimal(8,2) NULL
  ,Lagebestimmung varchar(255) NULL
  ,Lagebestimmung_txt varchar(255) NULL
  ,Lichte_Hoehe integer NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
  ,Reibungsbeiwert integer NULL
  ,Wandrauhigkeit decimal(6,2) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','haltung','verlauf',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'COMPOUNDCURVE',2);
COMMENT ON TABLE vsadss2008_1_d.Haltung IS '@iliname DSS_2008.Siedlungsentwaesserung.Haltung';
-- DSS_2008.Siedlungsentwaesserung.Gewaessersektor
CREATE TABLE vsadss2008_1_d.Gewaessersektor (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Oberflaechengewaesser integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,BWG_Code varchar(50) NULL
  ,KilomO decimal(10,3) NULL
  ,KilomU decimal(10,3) NULL
  ,RefLaenge decimal(8,2) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gewaessersektor','verlauf',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'COMPOUNDCURVE',2);
COMMENT ON TABLE vsadss2008_1_d.Gewaessersektor IS '@iliname DSS_2008.Siedlungsentwaesserung.Gewaessersektor';
-- DSS_2008.Siedlungsentwaesserung.Abwasserbauwerk_Text
CREATE TABLE vsadss2008_1_d.Abwasserbauwerk_Text (
  T_Id integer PRIMARY KEY
  ,AbwasserbauwerkRef integer NULL
  ,Textinhalt varchar(80) NOT NULL
  ,TextOri decimal(5,1) NULL
  ,TextHAli varchar(255) NULL
  ,TextHAli_txt varchar(255) NULL
  ,TextVAli varchar(255) NULL
  ,TextVAli_txt varchar(255) NULL
  ,Plantyp varchar(255) NOT NULL
  ,Plantyp_txt varchar(255) NOT NULL
  ,Bemerkung varchar(80) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','abwasserbauwerk_text','textpos',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Abwasserbauwerk_Text IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwasserbauwerk_Text';
CREATE TABLE vsadss2008_1_d.Streichwehr_WehrschwellenZahl (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Einzelflaeche_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.VALIGNMENT (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.T_ILI2DB_INHERITANCE (
  thisClass varchar(60) PRIMARY KEY
  ,baseClass varchar(60) NULL
)
;
CREATE TABLE vsadss2008_1_d.HALIGNMENT (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Absperr_Drosselorgan_Signaluebermittlung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Hoehenstufe (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Einzugsgebiet
CREATE TABLE vsadss2008_1_d.Einzugsgebiet (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwassernetzelement integer NULL
  ,Abflussbeiwert integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Befestigungsgrad integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Einwohnerdichte integer NULL
  ,Status varchar(255) NULL
  ,Status_txt varchar(255) NULL
  ,System varchar(255) NULL
  ,System_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','einzugsgebiet','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Einzugsgebiet IS '@iliname DSS_2008.Siedlungsentwaesserung.Einzugsgebiet';
-- DSS_2008.Siedlungsentwaesserung.Bankett
CREATE TABLE vsadss2008_1_d.Bankett (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Bankett IS '@iliname DSS_2008.Siedlungsentwaesserung.Bankett';
-- DSS_2008.Siedlungsentwaesserung.Gewaessersektor_Hierarchie
CREATE TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gewaessersektor integer NULL
  ,VorherigerSektor integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie IS '@iliname DSS_2008.Siedlungsentwaesserung.Gewaessersektor_Hierarchie';
CREATE TABLE vsadss2008_1_d.T_ILI2DB_ATTRNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Erhaltungsereignis_Abwasserbauwerk
CREATE TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Erhaltungsereignis integer NULL
  ,Abwasserbauwerk integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk IS '@iliname DSS_2008.Siedlungsentwaesserung.Erhaltungsereignis_Abwasserbauwerk';
CREATE TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_OBJECT (
  T_Id integer PRIMARY KEY
  ,import_basket integer NOT NULL
  ,class varchar(200) NOT NULL
  ,objectCount integer NULL
  ,start_t_id integer NULL
  ,end_t_id integer NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Grundwasserschutzareal
CREATE TABLE vsadss2008_1_d.Grundwasserschutzareal (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','grundwasserschutzareal','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Grundwasserschutzareal IS '@iliname DSS_2008.Siedlungsentwaesserung.Grundwasserschutzareal';
-- DSS_2008.Siedlungsentwaesserung.Privat
CREATE TABLE vsadss2008_1_d.Privat (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(50) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Privat IS '@iliname DSS_2008.Siedlungsentwaesserung.Privat';
-- DSS_2008.Siedlungsentwaesserung.BauwerksTeil
CREATE TABLE vsadss2008_1_d.BauwerksTeil (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Abwasserbauwerk integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Instandstellung varchar(255) NULL
  ,Instandstellung_txt varchar(255) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.BauwerksTeil IS '@iliname DSS_2008.Siedlungsentwaesserung.BauwerksTeil';
-- DSS_2008.Siedlungsentwaesserung.EZG_PARAMETER_MOUSE1
CREATE TABLE vsadss2008_1_d.EZG_PARAMETER_MOUSE1 (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Einwohnergleichwert integer NULL
  ,Flaeche decimal(9,2) NULL
  ,Fliessweggefaelle integer NULL
  ,Fliessweglaenge decimal(8,2) NULL
  ,Nutzungsart varchar(50) NULL
  ,Trockenwetteranfall decimal(10,3) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.EZG_PARAMETER_MOUSE1 IS '@iliname DSS_2008.Siedlungsentwaesserung.EZG_PARAMETER_MOUSE1';
-- DSS_2008.Siedlungsentwaesserung.Gebaeude
CREATE TABLE vsadss2008_1_d.Gebaeude (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Hausnummer varchar(50) NULL
  ,Standortname varchar(50) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gebaeude','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
SELECT AddGeometryColumn('vsadss2008_1_d','gebaeude','referenzpunkt',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Gebaeude IS '@iliname DSS_2008.Siedlungsentwaesserung.Gebaeude';
-- DSS_2008.Siedlungsentwaesserung.Sohlrampe
CREATE TABLE vsadss2008_1_d.Sohlrampe (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Absturzhoehe decimal(8,2) NULL
  ,Befestigung varchar(255) NULL
  ,Befestigung_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Sohlrampe IS '@iliname DSS_2008.Siedlungsentwaesserung.Sohlrampe';
CREATE TABLE vsadss2008_1_d.Absperr_Drosselorgan_Verstellbarkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.GewaesserWehr_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaessersektor_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Spezialbauwerk
CREATE TABLE vsadss2008_1_d.Spezialbauwerk (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Bypass varchar(255) NULL
  ,Bypass_txt varchar(255) NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Spezialbauwerk IS '@iliname DSS_2008.Siedlungsentwaesserung.Spezialbauwerk';
CREATE TABLE vsadss2008_1_d.Grundwasserschutzzone_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Ufer_Umlandnutzung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Makrophytenbewuchs (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Grundwasserschutzzone
CREATE TABLE vsadss2008_1_d.Grundwasserschutzzone (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','grundwasserschutzzone','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Grundwasserschutzzone IS '@iliname DSS_2008.Siedlungsentwaesserung.Grundwasserschutzzone';
-- DSS_2008.Siedlungsentwaesserung.Abwasserreinigungsanlage
CREATE TABLE vsadss2008_1_d.Abwasserreinigungsanlage (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Anlagenummer integer NULL
  ,Art varchar(50) NULL
  ,BSB5 integer NULL
  ,CSB integer NULL
  ,EliminationCSB integer NULL
  ,EliminationN integer NULL
  ,EliminationNH4 integer NULL
  ,EliminationP integer NULL
  ,Inbetriebnahme integer NULL
  ,NH4 integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Abwasserreinigungsanlage IS '@iliname DSS_2008.Siedlungsentwaesserung.Abwasserreinigungsanlage';
-- DSS_2008.Siedlungsentwaesserung.Stoff
CREATE TABLE vsadss2008_1_d.Stoff (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Gefahrenquelle integer NULL
  ,Art varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Lagerung varchar(50) NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Stoff IS '@iliname DSS_2008.Siedlungsentwaesserung.Stoff';
-- DSS_2008.Siedlungsentwaesserung.Trockenwetterfallrohr
CREATE TABLE vsadss2008_1_d.Trockenwetterfallrohr (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Durchmesser integer NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Trockenwetterfallrohr IS '@iliname DSS_2008.Siedlungsentwaesserung.Trockenwetterfallrohr';
-- DSS_2008.Siedlungsentwaesserung.Reservoir
CREATE TABLE vsadss2008_1_d.Reservoir (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Standortname varchar(50) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','reservoir','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Reservoir IS '@iliname DSS_2008.Siedlungsentwaesserung.Reservoir';
CREATE TABLE vsadss2008_1_d.Gewaessersohle_Verbauungsgrad (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Breitenvariabilitaet (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Ufer_Verbauungsgrad (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Wasserfassung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Maengel (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Versickerungsanlage
CREATE TABLE vsadss2008_1_d.Versickerungsanlage (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Grundwasserleiter integer NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Beschriftung varchar(255) NULL
  ,Beschriftung_txt varchar(255) NULL
  ,Dimension1 integer NULL
  ,Dimension2 integer NULL
  ,GWDistanz decimal(8,2) NULL
  ,Maengel varchar(255) NULL
  ,Maengel_txt varchar(255) NULL
  ,Notueberlauf varchar(255) NULL
  ,Notueberlauf_txt varchar(255) NULL
  ,Saugwagen varchar(255) NULL
  ,Saugwagen_txt varchar(255) NULL
  ,Schluckvermoegen decimal(9,3) NULL
  ,Versickerungswasser varchar(255) NULL
  ,Versickerungswasser_txt varchar(255) NULL
  ,Wasserdichtheit varchar(255) NULL
  ,Wasserdichtheit_txt varchar(255) NULL
  ,Wirksameflaeche decimal(9,2) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Versickerungsanlage IS '@iliname DSS_2008.Siedlungsentwaesserung.Versickerungsanlage';
CREATE TABLE vsadss2008_1_d.Kanal_Nutzungsart_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Haltung_Text
CREATE TABLE vsadss2008_1_d.Haltung_Text (
  T_Id integer PRIMARY KEY
  ,HaltungRef integer NULL
  ,Textinhalt varchar(80) NOT NULL
  ,TextOri decimal(5,1) NULL
  ,TextHAli varchar(255) NULL
  ,TextHAli_txt varchar(255) NULL
  ,TextVAli varchar(255) NULL
  ,TextVAli_txt varchar(255) NULL
  ,Plantyp varchar(255) NOT NULL
  ,Plantyp_txt varchar(255) NOT NULL
  ,Bemerkung varchar(80) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','haltung_text','textpos',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Haltung_Text IS '@iliname DSS_2008.Siedlungsentwaesserung.Haltung_Text';
CREATE TABLE vsadss2008_1_d.Versickerungsanlage_Beschriftung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Oberflaechengewaesser
CREATE TABLE vsadss2008_1_d.Oberflaechengewaesser (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Oberflaechengewaesser IS '@iliname DSS_2008.Siedlungsentwaesserung.Oberflaechengewaesser';
CREATE TABLE vsadss2008_1_d.Ueberlauf_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Brunnen
CREATE TABLE vsadss2008_1_d.Brunnen (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Standortname varchar(50) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','brunnen','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Brunnen IS '@iliname DSS_2008.Siedlungsentwaesserung.Brunnen';
CREATE TABLE vsadss2008_1_d.Einzugsgebiet_System (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.BauwerksTeil_Instandstellung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Kanal_Bettung_Umhuellung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Kanal_Nutzungsart_geplant (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Trockenwetterrinne
CREATE TABLE vsadss2008_1_d.Trockenwetterrinne (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.Trockenwetterrinne IS '@iliname DSS_2008.Siedlungsentwaesserung.Trockenwetterrinne';
-- DSS_2008.Siedlungsentwaesserung.GewaesserWehr
CREATE TABLE vsadss2008_1_d.GewaesserWehr (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Absturzhoehe decimal(8,2) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2008_1_d.GewaesserWehr IS '@iliname DSS_2008.Siedlungsentwaesserung.GewaesserWehr';
CREATE TABLE vsadss2008_1_d.Trockenwetterrinne_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Streichwehr_Ueberfallkante (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Einzelflaeche
CREATE TABLE vsadss2008_1_d.Einzelflaeche (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Superclass integer NULL
  ,Befestigung varchar(255) NULL
  ,Befestigung_txt varchar(255) NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
  ,Neigung integer NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','einzelflaeche','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2008_1_d.Einzelflaeche IS '@iliname DSS_2008.Siedlungsentwaesserung.Einzelflaeche';
CREATE TABLE vsadss2008_1_d.ElektromechanischeAusruestung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2008_1_d.Gewaesserabschnitt_Abflussregime (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2008.Siedlungsentwaesserung.Gefahrenquelle
CREATE TABLE vsadss2008_1_d.Gefahrenquelle (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(20) NOT NULL
  ,Anschlussobjekt integer NULL
  ,Eigentuemer integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NOT NULL
  ,Letzte_Aenderung date NULL
  ,MD_Datenherr varchar(12) NULL
)
;
SELECT AddGeometryColumn('vsadss2008_1_d','gefahrenquelle','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2008_1_d.Gefahrenquelle IS '@iliname DSS_2008.Siedlungsentwaesserung.Gefahrenquelle';
ALTER TABLE vsadss2008_1_d.Ufer ADD CONSTRAINT Ufer_Gewaesserabschnitt_fkey FOREIGN KEY ( Gewaesserabschnitt ) REFERENCES vsadss2008_1_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Leapingwehr ADD CONSTRAINT Leapingwehr_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_BASKET ADD CONSTRAINT T_ILI2DB_BASKET_dataset_fkey FOREIGN KEY ( dataset ) REFERENCES vsadss2008_1_d.T_ILI2DB_DATASET DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Amt ADD CONSTRAINT Amt_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Deckel ADD CONSTRAINT Deckel_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Absperr_Drosselorgan ADD CONSTRAINT Absperr_Drosselorgan_Abwasserknoten_fkey FOREIGN KEY ( Abwasserknoten ) REFERENCES vsadss2008_1_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Absperr_Drosselorgan ADD CONSTRAINT Absperr_Drosselorgan_Steuerungszentrale_fkey FOREIGN KEY ( Steuerungszentrale ) REFERENCES vsadss2008_1_d.Steuerungszentrale DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messstelle ADD CONSTRAINT Messstelle_Betreiber_fkey FOREIGN KEY ( Betreiber ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messstelle ADD CONSTRAINT Messstelle_Abwasserreinigungsanlage_fkey FOREIGN KEY ( Abwasserreinigungsanlage ) REFERENCES vsadss2008_1_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messstelle ADD CONSTRAINT Messstelle_Abwasserbauwerk_fkey FOREIGN KEY ( Abwasserbauwerk ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messstelle ADD CONSTRAINT Messstelle_Gewaesserabschnitt_fkey FOREIGN KEY ( Gewaesserabschnitt ) REFERENCES vsadss2008_1_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserknoten ADD CONSTRAINT Abwasserknoten_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserknoten ADD CONSTRAINT Abwasserknoten_Hydr_Geometrie_fkey FOREIGN KEY ( Hydr_Geometrie ) REFERENCES vsadss2008_1_d.Hydr_Geometrie DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.See ADD CONSTRAINT See_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.GewaesserAbsturz ADD CONSTRAINT GewaesserAbsturz_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.ElektrischeEinrichtung ADD CONSTRAINT ElektrischeEinrichtung_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Schleuse ADD CONSTRAINT Schleuse_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserbauwerk ADD CONSTRAINT Abwasserbauwerk_Eigentuemer_fkey FOREIGN KEY ( Eigentuemer ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserbauwerk ADD CONSTRAINT Abwasserbauwerk_Betreiber_fkey FOREIGN KEY ( Betreiber ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Kanal ADD CONSTRAINT Kanal_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Einstiegshilfe ADD CONSTRAINT Einstiegshilfe_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Normschacht ADD CONSTRAINT Normschacht_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Hydr_GeomRelation ADD CONSTRAINT Hydr_GeomRelation_Hydr_Geometrie_fkey FOREIGN KEY ( Hydr_Geometrie ) REFERENCES vsadss2008_1_d.Hydr_Geometrie DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.ElektromechanischeAusruestung ADD CONSTRAINT ElektromechanischeAusruestung_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaesserschutzbereich ADD CONSTRAINT Gewaesserschutzbereich_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Furt ADD CONSTRAINT Furt_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Entwaesserungssystem ADD CONSTRAINT Entwaesserungssystem_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserverband ADD CONSTRAINT Abwasserverband_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gemeinde ADD CONSTRAINT Gemeinde_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Planungszone ADD CONSTRAINT Planungszone_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messresultat ADD CONSTRAINT Messresultat_Messgeraet_fkey FOREIGN KEY ( Messgeraet ) REFERENCES vsadss2008_1_d.Messgeraet DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messresultat ADD CONSTRAINT Messresultat_Messreihe_fkey FOREIGN KEY ( Messreihe ) REFERENCES vsadss2008_1_d.Messreihe DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Einzugsgebiet_Text ADD CONSTRAINT Einzugsgebiet_Text_EinzugsgebietRef_fkey FOREIGN KEY ( EinzugsgebietRef ) REFERENCES vsadss2008_1_d.Einzugsgebiet DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Vorflutereinlauf ADD CONSTRAINT Vorflutereinlauf_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Vorflutereinlauf ADD CONSTRAINT Vorflutereinlauf_Gewaessersektor_fkey FOREIGN KEY ( Gewaessersektor ) REFERENCES vsadss2008_1_d.Gewaessersektor DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Ueberlauf ADD CONSTRAINT Ueberlauf_Abwasserknoten_fkey FOREIGN KEY ( Abwasserknoten ) REFERENCES vsadss2008_1_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Ueberlauf ADD CONSTRAINT Ueberlauf_UeberlaufNach_fkey FOREIGN KEY ( UeberlaufNach ) REFERENCES vsadss2008_1_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Ueberlauf ADD CONSTRAINT Ueberlauf_Ueberlaufcharakteristik_fkey FOREIGN KEY ( Ueberlaufcharakteristik ) REFERENCES vsadss2008_1_d.Ueberlaufcharakteristik DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Ueberlauf ADD CONSTRAINT Ueberlauf_Steuerungszentrale_fkey FOREIGN KEY ( Steuerungszentrale ) REFERENCES vsadss2008_1_d.Steuerungszentrale DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_BASKET ADD CONSTRAINT T_ILI2DB_IMPORT_BASKET_import_fkey FOREIGN KEY ( import ) REFERENCES vsadss2008_1_d.T_ILI2DB_IMPORT DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_BASKET ADD CONSTRAINT T_ILI2DB_IMPORT_BASKET_basket_fkey FOREIGN KEY ( basket ) REFERENCES vsadss2008_1_d.T_ILI2DB_BASKET DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.MechanischeVorreinigung ADD CONSTRAINT MechanischeVorreinigung_Versickerungsanlage_fkey FOREIGN KEY ( Versickerungsanlage ) REFERENCES vsadss2008_1_d.Versickerungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.MechanischeVorreinigung ADD CONSTRAINT MechanischeVorreinigung_Abwasserbauwerk_fkey FOREIGN KEY ( Abwasserbauwerk ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Wasserfassung ADD CONSTRAINT Wasserfassung_Grundwasserleiter_fkey FOREIGN KEY ( Grundwasserleiter ) REFERENCES vsadss2008_1_d.Grundwasserleiter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Wasserfassung ADD CONSTRAINT Wasserfassung_Oberflaechengewaesser_fkey FOREIGN KEY ( Oberflaechengewaesser ) REFERENCES vsadss2008_1_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaesserverbauung ADD CONSTRAINT Gewaesserverbauung_Gewaesserabschnitt_fkey FOREIGN KEY ( Gewaesserabschnitt ) REFERENCES vsadss2008_1_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Kanton ADD CONSTRAINT Kanton_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messstelle_Hierarchie ADD CONSTRAINT Messstelle_Hierarchie_Messstelle_fkey FOREIGN KEY ( Messstelle ) REFERENCES vsadss2008_1_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messstelle_Hierarchie ADD CONSTRAINT Messstelle_Hierarchie_Referenzstelle_fkey FOREIGN KEY ( Referenzstelle ) REFERENCES vsadss2008_1_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_Abwassernetzelement_fkey FOREIGN KEY ( Abwassernetzelement ) REFERENCES vsadss2008_1_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_Eigentuemer_fkey FOREIGN KEY ( Eigentuemer ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_Betreiber_fkey FOREIGN KEY ( Betreiber ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.EZG_PARAMETER_ALLG ADD CONSTRAINT EZG_PARAMETER_ALLG_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Oberflaechenabflussparameter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserbehandlung ADD CONSTRAINT Abwasserbehandlung_Abwasserreinigungsanlage_fkey FOREIGN KEY ( Abwasserreinigungsanlage ) REFERENCES vsadss2008_1_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.ARABauwerk ADD CONSTRAINT ARABauwerk_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Rohrprofil_Geometrie ADD CONSTRAINT Rohrprofil_Geometrie_Rohrprofil_fkey FOREIGN KEY ( Rohrprofil ) REFERENCES vsadss2008_1_d.Rohrprofil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Haltungspunkt ADD CONSTRAINT Haltungspunkt_Abwassernetzelement_fkey FOREIGN KEY ( Abwassernetzelement ) REFERENCES vsadss2008_1_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Geschiebesperre ADD CONSTRAINT Geschiebesperre_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Versickerungsbereich ADD CONSTRAINT Versickerungsbereich_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Schlammbehandlung ADD CONSTRAINT Schlammbehandlung_Abwasserreinigungsanlage_fkey FOREIGN KEY ( Abwasserreinigungsanlage ) REFERENCES vsadss2008_1_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Fischpass ADD CONSTRAINT Fischpass_Gewaesserverbauung_fkey FOREIGN KEY ( Gewaesserverbauung ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Organisation_Hierarchie ADD CONSTRAINT Organisation_Hierarchie_Organisation_fkey FOREIGN KEY ( Organisation ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Organisation_Hierarchie ADD CONSTRAINT Organisation_Hierarchie_Teil_von_fkey FOREIGN KEY ( Teil_von ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_IMPORT ADD CONSTRAINT T_ILI2DB_IMPORT_dataset_fkey FOREIGN KEY ( dataset ) REFERENCES vsadss2008_1_d.T_ILI2DB_DATASET DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaessersohle ADD CONSTRAINT Gewaessersohle_Gewaesserabschnitt_fkey FOREIGN KEY ( Gewaesserabschnitt ) REFERENCES vsadss2008_1_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.ARAEnergienutzung ADD CONSTRAINT ARAEnergienutzung_Abwasserreinigungsanlage_fkey FOREIGN KEY ( Abwasserreinigungsanlage ) REFERENCES vsadss2008_1_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Unfall ADD CONSTRAINT Unfall_Gefahrenquelle_fkey FOREIGN KEY ( Gefahrenquelle ) REFERENCES vsadss2008_1_d.Gefahrenquelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Retentionskoerper ADD CONSTRAINT Retentionskoerper_Versickerungsanlage_fkey FOREIGN KEY ( Versickerungsanlage ) REFERENCES vsadss2008_1_d.Versickerungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Messreihe ADD CONSTRAINT Messreihe_Messstelle_fkey FOREIGN KEY ( Messstelle ) REFERENCES vsadss2008_1_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Oberflaechenabflussparameter ADD CONSTRAINT Oberflaechenabflussparameter_Einzugsgebiet_fkey FOREIGN KEY ( Einzugsgebiet ) REFERENCES vsadss2008_1_d.Einzugsgebiet DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Durchlass ADD CONSTRAINT Durchlass_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Fliessgewaesser ADD CONSTRAINT Fliessgewaesser_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Erhaltungsereignis ADD CONSTRAINT Erhaltungsereignis_Abwasserbauwerk_fkey FOREIGN KEY ( Abwasserbauwerk ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Streichwehr ADD CONSTRAINT Streichwehr_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.HQ_Relation ADD CONSTRAINT HQ_Relation_Ueberlaufcharakteristik_fkey FOREIGN KEY ( Ueberlaufcharakteristik ) REFERENCES vsadss2008_1_d.Ueberlaufcharakteristik DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaesserabschnitt ADD CONSTRAINT Gewaesserabschnitt_Fliessgewaesser_fkey FOREIGN KEY ( Fliessgewaesser ) REFERENCES vsadss2008_1_d.Fliessgewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.FoerderAggregat ADD CONSTRAINT FoerderAggregat_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Badestelle ADD CONSTRAINT Badestelle_Oberflaechengewaesser_fkey FOREIGN KEY ( Oberflaechengewaesser ) REFERENCES vsadss2008_1_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwassernetzelement ADD CONSTRAINT Abwassernetzelement_Abwasserbauwerk_fkey FOREIGN KEY ( Abwasserbauwerk ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Haltung ADD CONSTRAINT Haltung_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Haltung ADD CONSTRAINT Haltung_vonHaltungspunkt_fkey FOREIGN KEY ( vonHaltungspunkt ) REFERENCES vsadss2008_1_d.Haltungspunkt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Haltung ADD CONSTRAINT Haltung_nachHaltungspunkt_fkey FOREIGN KEY ( nachHaltungspunkt ) REFERENCES vsadss2008_1_d.Haltungspunkt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Haltung ADD CONSTRAINT Haltung_Rohrprofil_fkey FOREIGN KEY ( Rohrprofil ) REFERENCES vsadss2008_1_d.Rohrprofil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaessersektor ADD CONSTRAINT Gewaessersektor_Oberflaechengewaesser_fkey FOREIGN KEY ( Oberflaechengewaesser ) REFERENCES vsadss2008_1_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserbauwerk_Text ADD CONSTRAINT Abwasserbauwerk_Text_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Einzugsgebiet ADD CONSTRAINT Einzugsgebiet_Abwassernetzelement_fkey FOREIGN KEY ( Abwassernetzelement ) REFERENCES vsadss2008_1_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Bankett ADD CONSTRAINT Bankett_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie ADD CONSTRAINT Gewaessersektor_Hierarchie_Gewaessersektor_fkey FOREIGN KEY ( Gewaessersektor ) REFERENCES vsadss2008_1_d.Gewaessersektor DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie ADD CONSTRAINT Gewaessersektor_Hierarchie_VorherigerSektor_fkey FOREIGN KEY ( VorherigerSektor ) REFERENCES vsadss2008_1_d.Gewaessersektor DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk ADD CONSTRAINT Erhaltungsereignis_Abwasserbauwerk_Erhaltungsereignis_fkey FOREIGN KEY ( Erhaltungsereignis ) REFERENCES vsadss2008_1_d.Erhaltungsereignis DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk ADD CONSTRAINT Erhaltungsereignis_Abwasserbauwerk_Abwasserbauwerk_fkey FOREIGN KEY ( Abwasserbauwerk ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Grundwasserschutzareal ADD CONSTRAINT Grundwasserschutzareal_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Privat ADD CONSTRAINT Privat_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.BauwerksTeil ADD CONSTRAINT BauwerksTeil_Abwasserbauwerk_fkey FOREIGN KEY ( Abwasserbauwerk ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.EZG_PARAMETER_MOUSE1 ADD CONSTRAINT EZG_PARAMETER_MOUSE1_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Oberflaechenabflussparameter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gebaeude ADD CONSTRAINT Gebaeude_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Sohlrampe ADD CONSTRAINT Sohlrampe_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Spezialbauwerk ADD CONSTRAINT Spezialbauwerk_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Grundwasserschutzzone ADD CONSTRAINT Grundwasserschutzzone_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Abwasserreinigungsanlage ADD CONSTRAINT Abwasserreinigungsanlage_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Stoff ADD CONSTRAINT Stoff_Gefahrenquelle_fkey FOREIGN KEY ( Gefahrenquelle ) REFERENCES vsadss2008_1_d.Gefahrenquelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Trockenwetterfallrohr ADD CONSTRAINT Trockenwetterfallrohr_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Reservoir ADD CONSTRAINT Reservoir_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Versickerungsanlage ADD CONSTRAINT Versickerungsanlage_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Versickerungsanlage ADD CONSTRAINT Versickerungsanlage_Grundwasserleiter_fkey FOREIGN KEY ( Grundwasserleiter ) REFERENCES vsadss2008_1_d.Grundwasserleiter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Haltung_Text ADD CONSTRAINT Haltung_Text_HaltungRef_fkey FOREIGN KEY ( HaltungRef ) REFERENCES vsadss2008_1_d.Haltung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Brunnen ADD CONSTRAINT Brunnen_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Trockenwetterrinne ADD CONSTRAINT Trockenwetterrinne_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.GewaesserWehr ADD CONSTRAINT GewaesserWehr_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Einzelflaeche ADD CONSTRAINT Einzelflaeche_Superclass_fkey FOREIGN KEY ( Superclass ) REFERENCES vsadss2008_1_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gefahrenquelle ADD CONSTRAINT Gefahrenquelle_Anschlussobjekt_fkey FOREIGN KEY ( Anschlussobjekt ) REFERENCES vsadss2008_1_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2008_1_d.Gefahrenquelle ADD CONSTRAINT Gefahrenquelle_Eigentuemer_fkey FOREIGN KEY ( Eigentuemer ) REFERENCES vsadss2008_1_d.Organisation DEFERRABLE INITIALLY DEFERRED;
