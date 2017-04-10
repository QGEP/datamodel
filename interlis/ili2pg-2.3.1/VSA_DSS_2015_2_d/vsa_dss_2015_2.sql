-- DSS_2015.Siedlungsentwaesserung.Amt
CREATE TABLE vsadss2015_2_d.Amt (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE vsadss2015_2_d.Amt IS '@iliname DSS_2015.Siedlungsentwaesserung.Amt';
-- DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk_Text
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_Text (
  T_Id integer PRIMARY KEY
  ,AbwasserbauwerkRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Abwasserbauwerk_Text IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk_Text';
CREATE TABLE vsadss2015_2_d.Erhaltungsereignis_Status (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_DATASET (
  T_Id integer PRIMARY KEY
)
;
CREATE TABLE vsadss2015_2_d.Feststoffrueckhalt_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.FoerderAggregat_Nutzungsart_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Deckel_Schlammeimer (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Abwasserverband
CREATE TABLE vsadss2015_2_d.Abwasserverband (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE vsadss2015_2_d.Abwasserverband IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserverband';
-- DSS_2015.Siedlungsentwaesserung.Haltung
CREATE TABLE vsadss2015_2_d.Haltung (
  T_Id integer PRIMARY KEY
  ,Innenschutz varchar(255) NULL
  ,Innenschutz_txt varchar(255) NULL
  ,LaengeEffektiv decimal(8,2) NULL
  ,Lagebestimmung varchar(255) NULL
  ,Lagebestimmung_txt varchar(255) NULL
  ,Lichte_Hoehe integer NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
  ,Plangefaelle integer NULL
  ,Reibungsbeiwert integer NULL
  ,Reliner_Art varchar(255) NULL
  ,Reliner_Art_txt varchar(255) NULL
  ,Reliner_Bautechnik varchar(255) NULL
  ,Reliner_Bautechnik_txt varchar(255) NULL
  ,Reliner_Material varchar(255) NULL
  ,Reliner_Material_txt varchar(255) NULL
  ,Reliner_Nennweite integer NULL
  ,Ringsteifigkeit integer NULL
  ,Wandrauhigkeit decimal(6,2) NULL
  ,RohrprofilRef integer NULL
  ,nachHaltungspunktRef integer NULL
  ,vonHaltungspunktRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','haltung','verlauf',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'COMPOUNDCURVE',2);
COMMENT ON TABLE vsadss2015_2_d.Haltung IS '@iliname DSS_2015.Siedlungsentwaesserung.Haltung';
-- DSS_2015.Siedlungsentwaesserung.Gewaessersektor
CREATE TABLE vsadss2015_2_d.Gewaessersektor (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,BWG_Code varchar(50) NULL
  ,KilomO decimal(10,3) NULL
  ,KilomU decimal(10,3) NULL
  ,RefLaenge decimal(8,2) NULL
  ,OberflaechengewaesserRef integer NULL
  ,VorherigerSektorRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gewaessersektor','verlauf',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'COMPOUNDCURVE',2);
COMMENT ON TABLE vsadss2015_2_d.Gewaessersektor IS '@iliname DSS_2015.Siedlungsentwaesserung.Gewaessersektor';
CREATE TABLE vsadss2015_2_d.Normschacht_Oberflaechenzulauf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk (
  T_Id integer PRIMARY KEY
  ,Akten varchar(255) NULL
  ,Baujahr integer NULL
  ,BaulicherZustand varchar(255) NULL
  ,BaulicherZustand_txt varchar(255) NULL
  ,Baulos varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
  ,Finanzierung varchar(255) NULL
  ,Finanzierung_txt varchar(255) NULL
  ,Inspektionsintervall decimal(5,2) NULL
  ,Sanierungsbedarf varchar(255) NULL
  ,Sanierungsbedarf_txt varchar(255) NULL
  ,Standortname varchar(50) NULL
  ,Status varchar(255) NULL
  ,Subventionen decimal(11,2) NULL
  ,WBW_Basisjahr integer NULL
  ,WBW_Bauart varchar(255) NULL
  ,WBW_Bauart_txt varchar(255) NULL
  ,Wiederbeschaffungswert decimal(11,2) NULL
  ,Zugaenglichkeit varchar(255) NULL
  ,Zugaenglichkeit_txt varchar(255) NULL
  ,BetreiberRef integer NULL
  ,EigentuemerRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','abwasserbauwerk','detailgeometrie',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Abwasserbauwerk IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk';
-- DSS_2015.Siedlungsentwaesserung.Bankett
CREATE TABLE vsadss2015_2_d.Bankett (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Bankett IS '@iliname DSS_2015.Siedlungsentwaesserung.Bankett';
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Versickerung_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_BASKET (
  T_Id integer PRIMARY KEY
  ,dataset integer NULL
  ,topic varchar(200) NOT NULL
  ,T_Ili_Tid varchar(200) NULL
  ,attachmentKey varchar(200) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Entwaesserungssystem_geplant (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.GewaesserWehr
CREATE TABLE vsadss2015_2_d.GewaesserWehr (
  T_Id integer PRIMARY KEY
  ,Absturzhoehe decimal(8,2) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.GewaesserWehr IS '@iliname DSS_2015.Siedlungsentwaesserung.GewaesserWehr';
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Notueberlauf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Hydr_Kennwerte_Pumpenregime (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaessersohle_Verbauungsart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Wasserfassung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Einzelflaeche
CREATE TABLE vsadss2015_2_d.Einzelflaeche (
  T_Id integer PRIMARY KEY
  ,Befestigung varchar(255) NULL
  ,Befestigung_txt varchar(255) NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
  ,Neigung integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','einzelflaeche','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Einzelflaeche IS '@iliname DSS_2015.Siedlungsentwaesserung.Einzelflaeche';
CREATE TABLE vsadss2015_2_d.Ufer_Seite (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Leapingwehr
CREATE TABLE vsadss2015_2_d.Leapingwehr (
  T_Id integer PRIMARY KEY
  ,Breite decimal(8,2) NULL
  ,Laenge decimal(8,2) NULL
  ,Oeffnungsform varchar(255) NULL
  ,Oeffnungsform_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Leapingwehr IS '@iliname DSS_2015.Siedlungsentwaesserung.Leapingwehr';
CREATE TABLE vsadss2015_2_d.Einleitstelle_Relevanz (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Retention_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Entwaesserungssystem
CREATE TABLE vsadss2015_2_d.Entwaesserungssystem (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','entwaesserungssystem','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Entwaesserungssystem IS '@iliname DSS_2015.Siedlungsentwaesserung.Entwaesserungssystem';
-- DSS_2015.Siedlungsentwaesserung.Streichwehr
CREATE TABLE vsadss2015_2_d.Streichwehr (
  T_Id integer PRIMARY KEY
  ,HydrUeberfalllaenge decimal(8,2) NULL
  ,KoteMax decimal(8,3) NULL
  ,KoteMin decimal(8,3) NULL
  ,Ueberfallkante varchar(255) NULL
  ,Ueberfallkante_txt varchar(255) NULL
  ,Wehr_Art varchar(255) NULL
  ,Wehr_Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Streichwehr IS '@iliname DSS_2015.Siedlungsentwaesserung.Streichwehr';
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Tiefenvariabilitaet (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Absperr_Drosselorgan_Antrieb (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Haltung_Lagebestimmung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Messstelle_Staukoerper (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_CLASSNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Haltung_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- Base.SymbolPos
CREATE TABLE vsadss2015_2_d.SymbolPos (
  T_Id integer PRIMARY KEY
  ,SymbolOri decimal(5,1) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','symbolpos','symbolpos',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.SymbolPos IS '@iliname Base.SymbolPos';
CREATE TABLE vsadss2015_2_d.Deckel_Lagegenauigkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ueberlauf_Signaluebermittlung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Abwasserbehandlung
CREATE TABLE vsadss2015_2_d.Abwasserbehandlung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,AbwasserreinigungsanlageRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Abwasserbehandlung IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserbehandlung';
-- DSS_2015.Siedlungsentwaesserung.Gewaessersohle
CREATE TABLE vsadss2015_2_d.Gewaessersohle (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Breite decimal(8,2) NULL
  ,Verbauungsart varchar(255) NULL
  ,Verbauungsart_txt varchar(255) NULL
  ,Verbauungsgrad varchar(255) NULL
  ,Verbauungsgrad_txt varchar(255) NULL
  ,GewaesserabschnittRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Gewaessersohle IS '@iliname DSS_2015.Siedlungsentwaesserung.Gewaessersohle';
CREATE TABLE vsadss2015_2_d.Absperr_Drosselorgan_Signaluebermittlung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_BaulicherZustand (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Haltungspunkt_Hoehengenauigkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Fischpass
CREATE TABLE vsadss2015_2_d.Fischpass (
  T_Id integer PRIMARY KEY
  ,Absturzhoehe decimal(8,2) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,GewaesserverbauungRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Fischpass IS '@iliname DSS_2015.Siedlungsentwaesserung.Fischpass';
-- DSS_2015.Siedlungsentwaesserung.Reservoir
CREATE TABLE vsadss2015_2_d.Reservoir (
  T_Id integer PRIMARY KEY
  ,Standortname varchar(50) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','reservoir','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Reservoir IS '@iliname DSS_2015.Siedlungsentwaesserung.Reservoir';
-- DSS_2015.Siedlungsentwaesserung.Messreihe
CREATE TABLE vsadss2015_2_d.Messreihe (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Dimension varchar(50) NULL
  ,MessstelleRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Messreihe IS '@iliname DSS_2015.Siedlungsentwaesserung.Messreihe';
CREATE TABLE vsadss2015_2_d.Bankett_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Organisation_Teil_vonAssoc
CREATE TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc (
  T_Id integer PRIMARY KEY
  ,Teil_vonRef integer NOT NULL
  ,Organisation_Teil_vonAssocRef integer NOT NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc IS '@iliname DSS_2015.Siedlungsentwaesserung.Organisation_Teil_vonAssoc';
-- DSS_2015.Siedlungsentwaesserung.Messstelle
CREATE TABLE vsadss2015_2_d.Messstelle (
  T_Id integer PRIMARY KEY
  ,Art varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Staukoerper varchar(255) NULL
  ,Staukoerper_txt varchar(255) NULL
  ,Zweck varchar(255) NULL
  ,Zweck_txt varchar(255) NULL
  ,AbwasserbauwerkRef integer NULL
  ,AbwasserreinigungsanlageRef integer NULL
  ,BetreiberRef integer NULL
  ,GewaesserabschnittRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','messstelle','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Messstelle IS '@iliname DSS_2015.Siedlungsentwaesserung.Messstelle';
CREATE TABLE vsadss2015_2_d.Leapingwehr_Oeffnungsform (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Beckenreinigung
CREATE TABLE vsadss2015_2_d.Beckenreinigung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Beckenreinigung IS '@iliname DSS_2015.Siedlungsentwaesserung.Beckenreinigung';
CREATE TABLE vsadss2015_2_d.Deckel_Deckelform (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Deckel_Verschluss (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Erhaltungsereignis_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.GewaesserAbsturz_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Normschacht
CREATE TABLE vsadss2015_2_d.Normschacht (
  T_Id integer PRIMARY KEY
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
COMMENT ON TABLE vsadss2015_2_d.Normschacht IS '@iliname DSS_2015.Siedlungsentwaesserung.Normschacht';
CREATE TABLE vsadss2015_2_d.Sohlrampe_Befestigung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Kanton
CREATE TABLE vsadss2015_2_d.Kanton (
  T_Id integer PRIMARY KEY
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','kanton','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Kanton IS '@iliname DSS_2015.Siedlungsentwaesserung.Kanton';
-- DSS_2015.Siedlungsentwaesserung.Organisation
CREATE TABLE vsadss2015_2_d.Organisation (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(80) NULL
  ,UID varchar(12) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Organisation IS '@iliname DSS_2015.Siedlungsentwaesserung.Organisation';
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Abflussregime (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Versickerungswasser (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Trockenwetterrinne
CREATE TABLE vsadss2015_2_d.Trockenwetterrinne (
  T_Id integer PRIMARY KEY
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Trockenwetterrinne IS '@iliname DSS_2015.Siedlungsentwaesserung.Trockenwetterrinne';
-- DSS_2015.Siedlungsentwaesserung.Steuerungszentrale
CREATE TABLE vsadss2015_2_d.Steuerungszentrale (
  T_Id integer PRIMARY KEY
  ,Bezeichnung varchar(20) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','steuerungszentrale','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Steuerungszentrale IS '@iliname DSS_2015.Siedlungsentwaesserung.Steuerungszentrale';
-- DSS_2015.Siedlungsentwaesserung.Retentionskoerper
CREATE TABLE vsadss2015_2_d.Retentionskoerper (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Retention_Volumen decimal(11,2) NULL
  ,VersickerungsanlageRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Retentionskoerper IS '@iliname DSS_2015.Siedlungsentwaesserung.Retentionskoerper';
-- DSS_2015.Siedlungsentwaesserung.Einzugsgebiet
CREATE TABLE vsadss2015_2_d.Einzugsgebiet (
  T_Id integer PRIMARY KEY
  ,Abflussbegrenzung_geplant decimal(5,1) NULL
  ,Abflussbegrenzung_Ist decimal(5,1) NULL
  ,Abflussbeiwert_RW_geplant decimal(6,2) NULL
  ,Abflussbeiwert_RW_Ist decimal(6,2) NULL
  ,Abflussbeiwert_SW_geplant decimal(6,2) NULL
  ,Abflussbeiwert_SW_Ist decimal(6,2) NULL
  ,Befestigungsgrad_RW_geplant decimal(6,2) NULL
  ,Befestigungsgrad_RW_Ist decimal(6,2) NULL
  ,Befestigungsgrad_SW_geplant decimal(6,2) NULL
  ,Befestigungsgrad_SW_Ist decimal(6,2) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Direkteinleitung_in_Gewaesser_geplant varchar(255) NULL
  ,Direkteinleitung_in_Gewaesser_geplant_txt varchar(255) NULL
  ,Direkteinleitung_in_Gewaesser_Ist varchar(255) NULL
  ,Direkteinleitung_in_Gewaesser_Ist_txt varchar(255) NULL
  ,Einwohnerdichte_geplant integer NULL
  ,Einwohnerdichte_Ist integer NULL
  ,Entwaesserungssystem_geplant varchar(255) NULL
  ,Entwaesserungssystem_geplant_txt varchar(255) NULL
  ,Entwaesserungssystem_Ist varchar(255) NULL
  ,Entwaesserungssystem_Ist_txt varchar(255) NULL
  ,Flaeche decimal(11,4) NULL
  ,Fremdwasseranfall_geplant decimal(10,3) NULL
  ,Fremdwasseranfall_Ist decimal(10,3) NULL
  ,Retention_geplant varchar(255) NULL
  ,Retention_geplant_txt varchar(255) NULL
  ,Retention_Ist varchar(255) NULL
  ,Retention_Ist_txt varchar(255) NULL
  ,Schmutzabwasseranfall_geplant decimal(10,3) NULL
  ,Schmutzabwasseranfall_Ist decimal(10,3) NULL
  ,Versickerung_geplant varchar(255) NULL
  ,Versickerung_geplant_txt varchar(255) NULL
  ,Versickerung_Ist varchar(255) NULL
  ,Versickerung_Ist_txt varchar(255) NULL
  ,Abwassernetzelement_RW_IstRef integer NULL
  ,Abwassernetzelement_RW_geplantRef integer NULL
  ,Abwassernetzelement_SW_IstRef integer NULL
  ,Abwassernetzelement_SW_geplantRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','einzugsgebiet','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Einzugsgebiet IS '@iliname DSS_2015.Siedlungsentwaesserung.Einzugsgebiet';
-- DSS_2015.Siedlungsentwaesserung.Messresultat
CREATE TABLE vsadss2015_2_d.Messresultat (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Messart varchar(255) NULL
  ,Messart_txt varchar(255) NULL
  ,Messdauer integer NULL
  ,Wert decimal(14,4) NULL
  ,Zeit date NULL
  ,MessgeraetRef integer NULL
  ,MessreiheRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Messresultat IS '@iliname DSS_2015.Siedlungsentwaesserung.Messresultat';
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Breitenvariabilitaet (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Linienfuehrung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Zone
CREATE TABLE vsadss2015_2_d.Zone (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Zone IS '@iliname DSS_2015.Siedlungsentwaesserung.Zone';
-- DSS_2015.Siedlungsentwaesserung.Gewaesserschutzbereich
CREATE TABLE vsadss2015_2_d.Gewaesserschutzbereich (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gewaesserschutzbereich','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Gewaesserschutzbereich IS '@iliname DSS_2015.Siedlungsentwaesserung.Gewaesserschutzbereich';
CREATE TABLE vsadss2015_2_d.Kanal_Verbindungsart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Direkteinleitung_in_Gewaesser_geplant (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.ElektromechanischeAusruestung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Hoehenstufe (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Oberflaechengewaesser
CREATE TABLE vsadss2015_2_d.Oberflaechengewaesser (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Oberflaechengewaesser IS '@iliname DSS_2015.Siedlungsentwaesserung.Oberflaechengewaesser';
-- DSS_2015.Siedlungsentwaesserung.Ueberlaufcharakteristik
CREATE TABLE vsadss2015_2_d.Ueberlaufcharakteristik (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Kennlinie_digital varchar(255) NULL
  ,Kennlinie_digital_txt varchar(255) NULL
  ,Kennlinie_Typ varchar(255) NULL
  ,Kennlinie_Typ_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Ueberlaufcharakteristik IS '@iliname DSS_2015.Siedlungsentwaesserung.Ueberlaufcharakteristik';
-- DSS_2015.Siedlungsentwaesserung.Trockenwetterfallrohr
CREATE TABLE vsadss2015_2_d.Trockenwetterfallrohr (
  T_Id integer PRIMARY KEY
  ,Durchmesser integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Trockenwetterfallrohr IS '@iliname DSS_2015.Siedlungsentwaesserung.Trockenwetterfallrohr';
CREATE TABLE vsadss2015_2_d.Spezialbauwerk_Regenbecken_Anordnung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Statuswerte (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Makrophytenbewuchs (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Kanal_FunktionHydraulisch (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_IMPORT (
  T_Id integer PRIMARY KEY
  ,dataset integer NOT NULL
  ,importDate timestamp NOT NULL
  ,importUser varchar(40) NOT NULL
  ,importFile varchar(200) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Fliessgewaesser_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Schlammbehandlung
CREATE TABLE vsadss2015_2_d.Schlammbehandlung (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,EntwaessertKlaerschlammstapelung decimal(11,2) NULL
  ,Entwaesserung decimal(8,2) NULL
  ,Faulschlammverbrennung decimal(8,2) NULL
  ,Fluessigklaerschlammstapelung decimal(11,2) NULL
  ,Frischschlammverbrennung decimal(8,2) NULL
  ,Hygienisierung decimal(8,2) NULL
  ,Kompostierung decimal(8,2) NULL
  ,Mischschlammvoreindickung decimal(11,2) NULL
  ,PrimaerschlammVoreindickung decimal(11,2) NULL
  ,Stabilisierung varchar(255) NULL
  ,Stabilisierung_txt varchar(255) NULL
  ,Trocknung decimal(8,2) NULL
  ,Ueberschusschlammvoreindickung decimal(11,2) NULL
  ,AbwasserreinigungsanlageRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Schlammbehandlung IS '@iliname DSS_2015.Siedlungsentwaesserung.Schlammbehandlung';
CREATE TABLE vsadss2015_2_d.Deckel_Entlueftung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Versickerungsbereich_Versickerungsmoeglichkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Gemeinde
CREATE TABLE vsadss2015_2_d.Gemeinde (
  T_Id integer PRIMARY KEY
  ,Einwohner integer NULL
  ,Flaeche decimal(11,4) NULL
  ,Gemeindenummer integer NULL
  ,GEP_Jahr integer NULL
  ,Hoehe decimal(8,3) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gemeinde','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Gemeinde IS '@iliname DSS_2015.Siedlungsentwaesserung.Gemeinde';
-- DSS_2015.Siedlungsentwaesserung.ElektromechanischeAusruestung
CREATE TABLE vsadss2015_2_d.ElektromechanischeAusruestung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.ElektromechanischeAusruestung IS '@iliname DSS_2015.Siedlungsentwaesserung.ElektromechanischeAusruestung';
CREATE TABLE vsadss2015_2_d.Einzelflaeche_Befestigung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Ufer
CREATE TABLE vsadss2015_2_d.Ufer (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
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
  ,GewaesserabschnittRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Ufer IS '@iliname DSS_2015.Siedlungsentwaesserung.Ufer';
-- DSS_2015.Siedlungsentwaesserung.Anschlussobjekt
CREATE TABLE vsadss2015_2_d.Anschlussobjekt (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Fremdwasseranfall decimal(10,3) NULL
  ,AbwassernetzelementRef integer NULL
  ,BetreiberRef integer NULL
  ,EigentuemerRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Anschlussobjekt IS '@iliname DSS_2015.Siedlungsentwaesserung.Anschlussobjekt';
-- DSS_2015.Siedlungsentwaesserung.Feststoffrueckhalt
CREATE TABLE vsadss2015_2_d.Feststoffrueckhalt (
  T_Id integer PRIMARY KEY
  ,Anspringkote decimal(8,3) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Dimensionierungswert decimal(10,3) NULL
  ,Ersatzjahr integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Feststoffrueckhalt IS '@iliname DSS_2015.Siedlungsentwaesserung.Feststoffrueckhalt';
-- DSS_2015.Siedlungsentwaesserung.Kanal
CREATE TABLE vsadss2015_2_d.Kanal (
  T_Id integer PRIMARY KEY
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
COMMENT ON TABLE vsadss2015_2_d.Kanal IS '@iliname DSS_2015.Siedlungsentwaesserung.Kanal';
CREATE TABLE vsadss2015_2_d.Deckel_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Stoff
CREATE TABLE vsadss2015_2_d.Stoff (
  T_Id integer PRIMARY KEY
  ,Art varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Lagerung varchar(50) NULL
  ,GefahrenquelleRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Stoff IS '@iliname DSS_2015.Siedlungsentwaesserung.Stoff';
CREATE TABLE vsadss2015_2_d.Ufer_Uferbereich (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Hydr_Geometrie
CREATE TABLE vsadss2015_2_d.Hydr_Geometrie (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Nutzinhalt decimal(11,2) NULL
  ,Nutzinhalt_Fangteil decimal(11,2) NULL
  ,Nutzinhalt_Klaerteil decimal(11,2) NULL
  ,Stauraum decimal(11,2) NULL
  ,Volumen_Pumpensumpf decimal(11,2) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Hydr_Geometrie IS '@iliname DSS_2015.Siedlungsentwaesserung.Hydr_Geometrie';
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Algenbewuchs (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Messstelle_ReferenzstelleAssoc
CREATE TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc (
  T_Id integer PRIMARY KEY
  ,ReferenzstelleRef integer NOT NULL
  ,Messstelle_ReferenzstelleAssocRef integer NOT NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc IS '@iliname DSS_2015.Siedlungsentwaesserung.Messstelle_ReferenzstelleAssoc';
CREATE TABLE vsadss2015_2_d.Normschacht_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Absperr_Drosselorgan_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Abwasserknoten
CREATE TABLE vsadss2015_2_d.Abwasserknoten (
  T_Id integer PRIMARY KEY
  ,Rueckstaukote decimal(8,3) NULL
  ,Sohlenkote decimal(8,3) NULL
  ,Hydr_GeometrieRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','abwasserknoten','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Abwasserknoten IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserknoten';
-- DSS_2015.Siedlungsentwaesserung.Rohrprofil
CREATE TABLE vsadss2015_2_d.Rohrprofil (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,HoehenBreitenverhaeltnis decimal(6,2) NULL
  ,Profiltyp varchar(255) NULL
  ,Profiltyp_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Rohrprofil IS '@iliname DSS_2015.Siedlungsentwaesserung.Rohrprofil';
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Wasserdichtheit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Wasserhaerte (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_OBJECT (
  T_Id integer PRIMARY KEY
  ,import_basket integer NOT NULL
  ,class varchar(200) NOT NULL
  ,objectCount integer NULL
  ,start_t_id integer NULL
  ,end_t_id integer NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Messgeraet
CREATE TABLE vsadss2015_2_d.Messgeraet (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Fabrikat varchar(50) NULL
  ,Seriennummer varchar(50) NULL
  ,MessstelleRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Messgeraet IS '@iliname DSS_2015.Siedlungsentwaesserung.Messgeraet';
CREATE TABLE vsadss2015_2_d.Beckenreinigung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ufer_Verbauungsgrad (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_ATTRNAME (
  IliName varchar(1024) PRIMARY KEY
  ,SqlName varchar(1024) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.ElektrischeEinrichtung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Absperr_Drosselorgan_Steuerung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.BauwerksTeil_Instandstellung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Grundwasserleiter
CREATE TABLE vsadss2015_2_d.Grundwasserleiter (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,MaxGWSpiegel decimal(8,3) NULL
  ,MinGWSpiegel decimal(8,3) NULL
  ,MittlererGWSpiegel decimal(8,3) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','grundwasserleiter','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Grundwasserleiter IS '@iliname DSS_2015.Siedlungsentwaesserung.Grundwasserleiter';
CREATE TABLE vsadss2015_2_d.Normschacht_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Furt
CREATE TABLE vsadss2015_2_d.Furt (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE vsadss2015_2_d.Furt IS '@iliname DSS_2015.Siedlungsentwaesserung.Furt';
CREATE TABLE vsadss2015_2_d.Ueberlauf_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Retentionskoerper_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Saugwagen (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Spezialbauwerk_Notueberlauf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- SIA405_Base.SIA405_TextPos
CREATE TABLE vsadss2015_2_d.SIA405_TextPos (
  T_Id integer PRIMARY KEY
  ,Plantyp varchar(255) NULL
  ,Plantyp_txt varchar(255) NULL
  ,Textinhalt varchar(80) NULL
  ,Bemerkung varchar(80) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.SIA405_TextPos IS '@iliname SIA405_Base.SIA405_TextPos';
CREATE TABLE vsadss2015_2_d.FoerderAggregat_Bauart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.ARABauwerk
CREATE TABLE vsadss2015_2_d.ARABauwerk (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.ARABauwerk IS '@iliname DSS_2015.Siedlungsentwaesserung.ARABauwerk';
-- DSS_2015.Siedlungsentwaesserung.Schleuse
CREATE TABLE vsadss2015_2_d.Schleuse (
  T_Id integer PRIMARY KEY
  ,Absturzhoehe decimal(8,2) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Schleuse IS '@iliname DSS_2015.Siedlungsentwaesserung.Schleuse';
-- DSS_2015.Siedlungsentwaesserung.EZG_PARAMETER_ALLG
CREATE TABLE vsadss2015_2_d.EZG_PARAMETER_ALLG (
  T_Id integer PRIMARY KEY
  ,Einwohnergleichwert integer NULL
  ,Flaeche decimal(9,2) NULL
  ,Fliessweggefaelle integer NULL
  ,Fliessweglaenge decimal(8,2) NULL
  ,Trockenwetteranfall decimal(10,3) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.EZG_PARAMETER_ALLG IS '@iliname DSS_2015.Siedlungsentwaesserung.EZG_PARAMETER_ALLG';
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Direkteinleitung_in_Gewaesser_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Einleitstelle
CREATE TABLE vsadss2015_2_d.Einleitstelle (
  T_Id integer PRIMARY KEY
  ,Hochwasserkote decimal(8,3) NULL
  ,Relevanz varchar(255) NULL
  ,Relevanz_txt varchar(255) NULL
  ,Terrainkote decimal(8,3) NULL
  ,Wasserspiegel_Hydraulik decimal(8,3) NULL
  ,GewaessersektorRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Einleitstelle IS '@iliname DSS_2015.Siedlungsentwaesserung.Einleitstelle';
-- DSS_2015.Siedlungsentwaesserung.Fliessgewaesser
CREATE TABLE vsadss2015_2_d.Fliessgewaesser (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Fliessgewaesser IS '@iliname DSS_2015.Siedlungsentwaesserung.Fliessgewaesser';
-- DSS_2015.Siedlungsentwaesserung.Brunnen
CREATE TABLE vsadss2015_2_d.Brunnen (
  T_Id integer PRIMARY KEY
  ,Standortname varchar(50) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','brunnen','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Brunnen IS '@iliname DSS_2015.Siedlungsentwaesserung.Brunnen';
-- DSS_2015.Siedlungsentwaesserung.MUTATION
CREATE TABLE vsadss2015_2_d.MUTATION (
  T_Id integer PRIMARY KEY
  ,ART varchar(255) NULL
  ,ART_txt varchar(255) NULL
  ,ATTRIBUT varchar(50) NULL
  ,AUFNAHMEDATUM date NULL
  ,AUFNEHMER varchar(80) NULL
  ,BEMERKUNG varchar(80) NULL
  ,KLASSE varchar(50) NULL
  ,LETZTER_WERT varchar(100) NULL
  ,MUTATIONSDATUM date NULL
  ,OBJEKT varchar(41) NULL
  ,SYSTEMBENUTZER varchar(41) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.MUTATION IS '@iliname DSS_2015.Siedlungsentwaesserung.MUTATION';
CREATE TABLE vsadss2015_2_d.Trockenwetterrinne_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Einzelflaeche_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_SETTINGS (
  tag varchar(60) PRIMARY KEY
  ,setting varchar(60) NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.ARAEnergienutzung
CREATE TABLE vsadss2015_2_d.ARAEnergienutzung (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Gasmotor integer NULL
  ,Turbinierung integer NULL
  ,Waermepumpe integer NULL
  ,AbwasserreinigungsanlageRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.ARAEnergienutzung IS '@iliname DSS_2015.Siedlungsentwaesserung.ARAEnergienutzung';
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Entwaesserungssystem_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_ILI2DB_INHERITANCE (
  thisClass varchar(60) PRIMARY KEY
  ,baseClass varchar(60) NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Nutzung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Kanal_Nutzungsart_geplant (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Messgeraet_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ueberlaufcharakteristik_Kennlinie_digital (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- Base.TextPos
CREATE TABLE vsadss2015_2_d.TextPos (
  T_Id integer PRIMARY KEY
  ,TextOri decimal(5,1) NULL
  ,TextHAli varchar(255) NULL
  ,TextHAli_txt varchar(255) NULL
  ,TextVAli varchar(255) NULL
  ,TextVAli_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','textpos','textpos',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.TextPos IS '@iliname Base.TextPos';
CREATE TABLE vsadss2015_2_d.Hydr_Kennwerte_Springt_an (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.MechanischeVorreinigung
CREATE TABLE vsadss2015_2_d.MechanischeVorreinigung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,AbwasserbauwerkRef integer NULL
  ,VersickerungsanlageRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.MechanischeVorreinigung IS '@iliname DSS_2015.Siedlungsentwaesserung.MechanischeVorreinigung';
-- DSS_2015.Siedlungsentwaesserung.Haltungspunkt
CREATE TABLE vsadss2015_2_d.Haltungspunkt (
  T_Id integer PRIMARY KEY
  ,Auslaufform varchar(255) NULL
  ,Auslaufform_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Hoehengenauigkeit varchar(255) NULL
  ,Hoehengenauigkeit_txt varchar(255) NULL
  ,Kote decimal(8,3) NULL
  ,Lage_Anschluss integer NULL
  ,AbwassernetzelementRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','haltungspunkt','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Haltungspunkt IS '@iliname DSS_2015.Siedlungsentwaesserung.Haltungspunkt';
-- SIA405_Base.Metaattribute
CREATE TABLE vsadss2015_2_d.Metaattribute (
  T_Id integer PRIMARY KEY
  ,T_Seq integer NOT NULL
  ,Datenherr varchar(80) NULL
  ,Datenlieferant varchar(80) NULL
  ,Letzte_Aenderung date NULL
  ,SIA405_Base_SIA405_BaseClass_Metaattribute integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Metaattribute IS '@iliname SIA405_Base.Metaattribute';
COMMENT ON COLUMN vsadss2015_2_d.Metaattribute.SIA405_Base_SIA405_BaseClass_Metaattribute IS '@iliname SIA405_Base.SIA405_BaseClass.Metaattribute';
CREATE TABLE vsadss2015_2_d.Status (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Maengel (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_Finanzierung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaessersektor_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Rohrprofil_Geometrie
CREATE TABLE vsadss2015_2_d.Rohrprofil_Geometrie (
  T_Id integer PRIMARY KEY
  ,Position integer NULL
  ,x decimal(14,4) NULL
  ,y decimal(14,4) NULL
  ,RohrprofilRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Rohrprofil_Geometrie IS '@iliname DSS_2015.Siedlungsentwaesserung.Rohrprofil_Geometrie';
CREATE TABLE vsadss2015_2_d.ARABauwerk_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Rueckstausicherung
CREATE TABLE vsadss2015_2_d.Rueckstausicherung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
  ,Absperr_DrosselorganRef integer NULL
  ,FoerderAggregatRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Rueckstausicherung IS '@iliname DSS_2015.Siedlungsentwaesserung.Rueckstausicherung';
CREATE TABLE vsadss2015_2_d.Rohrprofil_Profiltyp (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Einzugsgebiet_Text
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Text (
  T_Id integer PRIMARY KEY
  ,EinzugsgebietRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Einzugsgebiet_Text IS '@iliname DSS_2015.Siedlungsentwaesserung.Einzugsgebiet_Text';
-- Base.BaseClass
CREATE TABLE vsadss2015_2_d.BaseClass (
  T_Id integer PRIMARY KEY
  ,T_Type varchar(60) NOT NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.BaseClass IS '@iliname Base.BaseClass';
-- DSS_2015.Siedlungsentwaesserung.EZG_PARAMETER_MOUSE1
CREATE TABLE vsadss2015_2_d.EZG_PARAMETER_MOUSE1 (
  T_Id integer PRIMARY KEY
  ,Einwohnergleichwert integer NULL
  ,Flaeche decimal(9,2) NULL
  ,Fliessweggefaelle integer NULL
  ,Fliessweglaenge decimal(8,2) NULL
  ,Nutzungsart varchar(50) NULL
  ,Trockenwetteranfall decimal(10,3) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.EZG_PARAMETER_MOUSE1 IS '@iliname DSS_2015.Siedlungsentwaesserung.EZG_PARAMETER_MOUSE1';
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Retention_geplant (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Gefaelle (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Privat
CREATE TABLE vsadss2015_2_d.Privat (
  T_Id integer PRIMARY KEY
  ,Art varchar(50) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Privat IS '@iliname DSS_2015.Siedlungsentwaesserung.Privat';
CREATE TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_BASKET (
  T_Id integer PRIMARY KEY
  ,import integer NOT NULL
  ,basket integer NOT NULL
  ,objectCount integer NULL
  ,start_t_id integer NULL
  ,end_t_id integer NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.ElektrischeEinrichtung
CREATE TABLE vsadss2015_2_d.ElektrischeEinrichtung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.ElektrischeEinrichtung IS '@iliname DSS_2015.Siedlungsentwaesserung.ElektrischeEinrichtung';
CREATE TABLE vsadss2015_2_d.GewaesserAbsturz_Typ (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.BauwerksTeil
CREATE TABLE vsadss2015_2_d.BauwerksTeil (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Instandstellung varchar(255) NULL
  ,Instandstellung_txt varchar(255) NULL
  ,AbwasserbauwerkRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.BauwerksTeil IS '@iliname DSS_2015.Siedlungsentwaesserung.BauwerksTeil';
CREATE TABLE vsadss2015_2_d.Gewaesserschutzbereich_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_Sanierungsbedarf (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Plantyp (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Haltung_Reliner_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Abwasserreinigungsanlage
CREATE TABLE vsadss2015_2_d.Abwasserreinigungsanlage (
  T_Id integer PRIMARY KEY
  ,Anlagenummer integer NULL
  ,Art varchar(50) NULL
  ,BSB5 integer NULL
  ,CSB integer NULL
  ,EliminationCSB decimal(6,2) NULL
  ,EliminationN decimal(6,2) NULL
  ,EliminationNH4 decimal(6,2) NULL
  ,EliminationP decimal(6,2) NULL
  ,Inbetriebnahme integer NULL
  ,NH4 integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Abwasserreinigungsanlage IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserreinigungsanlage';
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Totholz (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Kanal_Bettung_Umhuellung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ufer_Verbauungsart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.MechanischeVorreinigung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ueberlauf_Verstellbarkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ueberlaufcharakteristik_Kennlinie_Typ (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Spezialbauwerk_Bypass (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Beckenentleerung
CREATE TABLE vsadss2015_2_d.Beckenentleerung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Ersatzjahr integer NULL
  ,Leistung decimal(10,3) NULL
  ,Absperr_DrosselorganRef integer NULL
  ,UeberlaufRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Beckenentleerung IS '@iliname DSS_2015.Siedlungsentwaesserung.Beckenentleerung';
CREATE TABLE vsadss2015_2_d.Einstiegshilfe_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Kanal_Nutzungsart_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Spezialbauwerk
CREATE TABLE vsadss2015_2_d.Spezialbauwerk (
  T_Id integer PRIMARY KEY
  ,Bypass varchar(255) NULL
  ,Bypass_txt varchar(255) NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
  ,Notueberlauf varchar(255) NULL
  ,Notueberlauf_txt varchar(255) NULL
  ,Regenbecken_Anordnung varchar(255) NULL
  ,Regenbecken_Anordnung_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Spezialbauwerk IS '@iliname DSS_2015.Siedlungsentwaesserung.Spezialbauwerk';
CREATE TABLE vsadss2015_2_d.Spezialbauwerk_Funktion (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Versickerungsanlage
CREATE TABLE vsadss2015_2_d.Versickerungsanlage (
  T_Id integer PRIMARY KEY
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
  ,Schluckvermoegen decimal(10,3) NULL
  ,Versickerungswasser varchar(255) NULL
  ,Versickerungswasser_txt varchar(255) NULL
  ,Wasserdichtheit varchar(255) NULL
  ,Wasserdichtheit_txt varchar(255) NULL
  ,Wirksameflaeche decimal(9,2) NULL
  ,GrundwasserleiterRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Versickerungsanlage IS '@iliname DSS_2015.Siedlungsentwaesserung.Versickerungsanlage';
-- DSS_2015.Siedlungsentwaesserung.Unfall
CREATE TABLE vsadss2015_2_d.Unfall (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Datum date NULL
  ,Ort varchar(50) NULL
  ,Verursacher varchar(50) NULL
  ,GefahrenquelleRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','unfall','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Unfall IS '@iliname DSS_2015.Siedlungsentwaesserung.Unfall';
CREATE TABLE vsadss2015_2_d.Haltung_Reliner_Bautechnik (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Absperr_Drosselorgan
CREATE TABLE vsadss2015_2_d.Absperr_Drosselorgan (
  T_Id integer PRIMARY KEY
  ,Antrieb varchar(255) NULL
  ,Antrieb_txt varchar(255) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Drosselorgan_Oeffnung_Ist integer NULL
  ,Drosselorgan_Oeffnung_Ist_optimiert integer NULL
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
  ,AbwasserknotenRef integer NULL
  ,SteuerungszentraleRef integer NULL
  ,UeberlaufRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Absperr_Drosselorgan IS '@iliname DSS_2015.Siedlungsentwaesserung.Absperr_Drosselorgan';
CREATE TABLE vsadss2015_2_d.Messreihe_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Badestelle
CREATE TABLE vsadss2015_2_d.Badestelle (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,OberflaechengewaesserRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','badestelle','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Badestelle IS '@iliname DSS_2015.Siedlungsentwaesserung.Badestelle';
-- DSS_2015.Siedlungsentwaesserung.Grundwasserschutzzone
CREATE TABLE vsadss2015_2_d.Grundwasserschutzzone (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','grundwasserschutzzone','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Grundwasserschutzzone IS '@iliname DSS_2015.Siedlungsentwaesserung.Grundwasserschutzzone';
CREATE TABLE vsadss2015_2_d.FoerderAggregat_AufstellungAntrieb (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ueberlauf_Antrieb (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Schlammbehandlung_Stabilisierung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.VALIGNMENT (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Hydr_Kennwerte_Foerderaggregat_Nutzungsart_Ist (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Haltung_Text
CREATE TABLE vsadss2015_2_d.Haltung_Text (
  T_Id integer PRIMARY KEY
  ,HaltungRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Haltung_Text IS '@iliname DSS_2015.Siedlungsentwaesserung.Haltung_Text';
CREATE TABLE vsadss2015_2_d.Messresultat_Messart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.FoerderAggregat
CREATE TABLE vsadss2015_2_d.FoerderAggregat (
  T_Id integer PRIMARY KEY
  ,Arbeitspunkt decimal(11,2) NULL
  ,AufstellungAntrieb varchar(255) NULL
  ,AufstellungAntrieb_txt varchar(255) NULL
  ,AufstellungFoerderaggregat varchar(255) NULL
  ,AufstellungFoerderaggregat_txt varchar(255) NULL
  ,Bauart varchar(255) NULL
  ,Bauart_txt varchar(255) NULL
  ,FoerderstromMax_einzel decimal(10,3) NULL
  ,FoerderstromMin_einzel decimal(10,3) NULL
  ,KoteStart decimal(8,3) NULL
  ,KoteStop decimal(8,3) NULL
  ,Nutzungsart_Ist varchar(255) NULL
  ,Nutzungsart_Ist_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.FoerderAggregat IS '@iliname DSS_2015.Siedlungsentwaesserung.FoerderAggregat';
CREATE TABLE vsadss2015_2_d.FoerderAggregat_AufstellungFoerderaggregat (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Wasserfassung
CREATE TABLE vsadss2015_2_d.Wasserfassung (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,GrundwasserleiterRef integer NULL
  ,OberflaechengewaesserRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','wasserfassung','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Wasserfassung IS '@iliname DSS_2015.Siedlungsentwaesserung.Wasserfassung';
CREATE TABLE vsadss2015_2_d.MUTATION_ART (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Streichwehr_Wehr_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Einzugsgebiet_Versickerung_geplant (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Geschiebesperre
CREATE TABLE vsadss2015_2_d.Geschiebesperre (
  T_Id integer PRIMARY KEY
  ,Absturzhoehe decimal(8,2) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Geschiebesperre IS '@iliname DSS_2015.Siedlungsentwaesserung.Geschiebesperre';
CREATE TABLE vsadss2015_2_d.Haltung_Innenschutz (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Hydr_Kennwerte_Status (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- SIA405_Base.SIA405_BaseClass
CREATE TABLE vsadss2015_2_d.SIA405_BaseClass (
  T_Id integer PRIMARY KEY
  ,OBJ_ID varchar(16) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.SIA405_BaseClass IS '@iliname SIA405_Base.SIA405_BaseClass';
-- DSS_2015.Siedlungsentwaesserung.Haltung_AlternativVerlauf
CREATE TABLE vsadss2015_2_d.Haltung_AlternativVerlauf (
  T_Id integer PRIMARY KEY
  ,Plantyp varchar(255) NULL
  ,Plantyp_txt varchar(255) NULL
  ,HaltungRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','haltung_alternativverlauf','verlauf',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'COMPOUNDCURVE',2);
COMMENT ON TABLE vsadss2015_2_d.Haltung_AlternativVerlauf IS '@iliname DSS_2015.Siedlungsentwaesserung.Haltung_AlternativVerlauf';
CREATE TABLE vsadss2015_2_d.T_ILI2DB_MODEL (
  file varchar(250) NOT NULL
  ,iliversion varchar(3) NOT NULL
  ,modelName text NOT NULL
  ,content text NOT NULL
  ,importDate timestamp NOT NULL
  ,PRIMARY KEY (modelName,iliversion)
)
;
CREATE TABLE vsadss2015_2_d.GewaesserWehr_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Gewaesserabschnitt
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt (
  T_Id integer PRIMARY KEY
  ,Abflussregime varchar(255) NULL
  ,Abflussregime_txt varchar(255) NULL
  ,Algenbewuchs varchar(255) NULL
  ,Algenbewuchs_txt varchar(255) NULL
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
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
  ,FliessgewaesserRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gewaesserabschnitt','bis',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
SELECT AddGeometryColumn('vsadss2015_2_d','gewaesserabschnitt','von',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Gewaesserabschnitt IS '@iliname DSS_2015.Siedlungsentwaesserung.Gewaesserabschnitt';
CREATE TABLE vsadss2015_2_d.Abwasserbehandlung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Entwaesserungssystem_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Grundwasserschutzzone_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.T_KEY_OBJECT (
  T_Key varchar(30) PRIMARY KEY
  ,T_LastUniqueId integer NOT NULL
  ,T_LastChange timestamp NOT NULL
  ,T_CreateDate timestamp NOT NULL
  ,T_User varchar(40) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Erhaltungsereignis_AbwasserbauwerkAssoc
CREATE TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc (
  T_Id integer PRIMARY KEY
  ,AbwasserbauwerkRef integer NOT NULL
  ,Erhaltungsereignis_AbwasserbauwerkAssocRef integer NOT NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc IS '@iliname DSS_2015.Siedlungsentwaesserung.Erhaltungsereignis_AbwasserbauwerkAssoc';
-- DSS_2015.Siedlungsentwaesserung.Durchlass
CREATE TABLE vsadss2015_2_d.Durchlass (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE vsadss2015_2_d.Durchlass IS '@iliname DSS_2015.Siedlungsentwaesserung.Durchlass';
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Oekom_Klassifizierung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.See
CREATE TABLE vsadss2015_2_d.See (
  T_Id integer PRIMARY KEY
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','see','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.See IS '@iliname DSS_2015.Siedlungsentwaesserung.See';
-- DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk_Symbol
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol (
  T_Id integer PRIMARY KEY
  ,AbwasserbauwerkRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk_Symbol';
CREATE TABLE vsadss2015_2_d.Ufer_Umlandnutzung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.GewaesserAbsturz
CREATE TABLE vsadss2015_2_d.GewaesserAbsturz (
  T_Id integer PRIMARY KEY
  ,Absturzhoehe decimal(8,2) NULL
  ,Material varchar(255) NULL
  ,Material_txt varchar(255) NULL
  ,Typ varchar(255) NULL
  ,Typ_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.GewaesserAbsturz IS '@iliname DSS_2015.Siedlungsentwaesserung.GewaesserAbsturz';
-- DSS_2015.Siedlungsentwaesserung.Gefahrenquelle
CREATE TABLE vsadss2015_2_d.Gefahrenquelle (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,AnschlussobjektRef integer NULL
  ,EigentuemerRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gefahrenquelle','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Gefahrenquelle IS '@iliname DSS_2015.Siedlungsentwaesserung.Gefahrenquelle';
-- SIA405_Base.SIA405_SymbolPos
CREATE TABLE vsadss2015_2_d.SIA405_SymbolPos (
  T_Id integer PRIMARY KEY
  ,Plantyp varchar(255) NULL
  ,Plantyp_txt varchar(255) NULL
  ,SymbolskalierungLaengs decimal(3,1) NULL
  ,SymbolskalierungHoch decimal(3,1) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.SIA405_SymbolPos IS '@iliname SIA405_Base.SIA405_SymbolPos';
CREATE TABLE vsadss2015_2_d.Rueckstausicherung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaessersohle_Verbauungsgrad (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_WBW_Bauart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Haltungspunkt_Auslaufform (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Haltung_Reliner_Material (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Einstiegshilfe
CREATE TABLE vsadss2015_2_d.Einstiegshilfe (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Einstiegshilfe IS '@iliname DSS_2015.Siedlungsentwaesserung.Einstiegshilfe';
CREATE TABLE vsadss2015_2_d.Abwasserbauwerk_Zugaenglichkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Versickerungsbereich
CREATE TABLE vsadss2015_2_d.Versickerungsbereich (
  T_Id integer PRIMARY KEY
  ,Versickerungsmoeglichkeit varchar(255) NULL
  ,Versickerungsmoeglichkeit_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','versickerungsbereich','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Versickerungsbereich IS '@iliname DSS_2015.Siedlungsentwaesserung.Versickerungsbereich';
-- DSS_2015.Siedlungsentwaesserung.Hydr_Kennwerte
CREATE TABLE vsadss2015_2_d.Hydr_Kennwerte (
  T_Id integer PRIMARY KEY
  ,Aggregatezahl integer NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Foerderaggregat_Nutzungsart_Ist varchar(255) NULL
  ,Foerderaggregat_Nutzungsart_Ist_txt varchar(255) NULL
  ,Foerderhoehe_geodaetisch decimal(8,2) NULL
  ,FoerderstromMax decimal(10,3) NULL
  ,FoerderstromMin decimal(10,3) NULL
  ,Hauptwehrart varchar(255) NULL
  ,Hauptwehrart_txt varchar(255) NULL
  ,Mehrbelastung decimal(6,2) NULL
  ,Pumpenregime varchar(255) NULL
  ,Pumpenregime_txt varchar(255) NULL
  ,Qab decimal(10,3) NULL
  ,Qan decimal(10,3) NULL
  ,Springt_an varchar(255) NULL
  ,Springt_an_txt varchar(255) NULL
  ,Status varchar(255) NULL
  ,Status_txt varchar(255) NULL
  ,Ueberlaufdauer decimal(7,1) NULL
  ,Ueberlauffracht integer NULL
  ,Ueberlaufhaeufigkeit decimal(5,1) NULL
  ,Ueberlaufmenge decimal(11,2) NULL
  ,AbwasserknotenRef integer NULL
  ,UeberlaufcharakteristikRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Hydr_Kennwerte IS '@iliname DSS_2015.Siedlungsentwaesserung.Hydr_Kennwerte';
CREATE TABLE vsadss2015_2_d.Hydr_Kennwerte_Hauptwehrart (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Abwassernetzelement
CREATE TABLE vsadss2015_2_d.Abwassernetzelement (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,AbwasserbauwerkRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Abwassernetzelement IS '@iliname DSS_2015.Siedlungsentwaesserung.Abwassernetzelement';
CREATE TABLE vsadss2015_2_d.Kanal_FunktionHierarchisch (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Planungszone
CREATE TABLE vsadss2015_2_d.Planungszone (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','planungszone','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Planungszone IS '@iliname DSS_2015.Siedlungsentwaesserung.Planungszone';
-- DSS_2015.Siedlungsentwaesserung.Sohlrampe
CREATE TABLE vsadss2015_2_d.Sohlrampe (
  T_Id integer PRIMARY KEY
  ,Absturzhoehe decimal(8,2) NULL
  ,Befestigung varchar(255) NULL
  ,Befestigung_txt varchar(255) NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Sohlrampe IS '@iliname DSS_2015.Siedlungsentwaesserung.Sohlrampe';
CREATE TABLE vsadss2015_2_d.Planungszone_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Hydr_GeomRelation
CREATE TABLE vsadss2015_2_d.Hydr_GeomRelation (
  T_Id integer PRIMARY KEY
  ,BenetzteQuerschnittsflaeche decimal(9,2) NULL
  ,Wasseroberflaeche decimal(9,2) NULL
  ,Wassertiefe decimal(8,2) NULL
  ,Hydr_GeometrieRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Hydr_GeomRelation IS '@iliname DSS_2015.Siedlungsentwaesserung.Hydr_GeomRelation';
CREATE TABLE vsadss2015_2_d.Messstelle_Zweck (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Versickerungsanlage_Beschriftung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Gebaeude
CREATE TABLE vsadss2015_2_d.Gebaeude (
  T_Id integer PRIMARY KEY
  ,Hausnummer varchar(50) NULL
  ,Standortname varchar(50) NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gebaeude','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
SELECT AddGeometryColumn('vsadss2015_2_d','gebaeude','referenzpunkt',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Gebaeude IS '@iliname DSS_2015.Siedlungsentwaesserung.Gebaeude';
CREATE TABLE vsadss2015_2_d.Gewaessersohle_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Ueberlauf
CREATE TABLE vsadss2015_2_d.Ueberlauf (
  T_Id integer PRIMARY KEY
  ,Antrieb varchar(255) NULL
  ,Antrieb_txt varchar(255) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Bruttokosten decimal(11,2) NULL
  ,Einleitstelle varchar(41) NULL
  ,Fabrikat varchar(50) NULL
  ,Funktion varchar(255) NULL
  ,Funktion_txt varchar(255) NULL
  ,Qan_dim decimal(10,3) NULL
  ,Signaluebermittlung varchar(255) NULL
  ,Signaluebermittlung_txt varchar(255) NULL
  ,Steuerung varchar(255) NULL
  ,Steuerung_txt varchar(255) NULL
  ,Subventionen decimal(11,2) NULL
  ,Verstellbarkeit varchar(255) NULL
  ,Verstellbarkeit_txt varchar(255) NULL
  ,AbwasserknotenRef integer NULL
  ,SteuerungszentraleRef integer NULL
  ,UeberlaufNachRef integer NULL
  ,UeberlaufcharakteristikRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Ueberlauf IS '@iliname DSS_2015.Siedlungsentwaesserung.Ueberlauf';
CREATE TABLE vsadss2015_2_d.Streichwehr_Ueberfallkante (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Erhaltungsereignis
CREATE TABLE vsadss2015_2_d.Erhaltungsereignis (
  T_Id integer PRIMARY KEY
  ,Art varchar(255) NULL
  ,Art_txt varchar(255) NULL
  ,Ausfuehrender varchar(50) NULL
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,Datengrundlage varchar(50) NULL
  ,Dauer integer NULL
  ,Detaildaten varchar(50) NULL
  ,Ergebnis varchar(50) NULL
  ,Grund varchar(50) NULL
  ,Kosten decimal(11,2) NULL
  ,Status varchar(255) NULL
  ,Status_txt varchar(255) NULL
  ,Zeitpunkt date NULL
  ,Ausfuehrender_FirmaRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Erhaltungsereignis IS '@iliname DSS_2015.Siedlungsentwaesserung.Erhaltungsereignis';
-- DSS_2015.Siedlungsentwaesserung.Gewaesserverbauung
CREATE TABLE vsadss2015_2_d.Gewaesserverbauung (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Bezeichnung varchar(20) NULL
  ,GewaesserabschnittRef integer NULL
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','gewaesserverbauung','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Gewaesserverbauung IS '@iliname DSS_2015.Siedlungsentwaesserung.Gewaesserverbauung';
-- DSS_2015.Siedlungsentwaesserung.HQ_Relation
CREATE TABLE vsadss2015_2_d.HQ_Relation (
  T_Id integer PRIMARY KEY
  ,Abfluss decimal(10,3) NULL
  ,Hoehe decimal(8,3) NULL
  ,Zufluss decimal(10,3) NULL
  ,UeberlaufcharakteristikRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.HQ_Relation IS '@iliname DSS_2015.Siedlungsentwaesserung.HQ_Relation';
CREATE TABLE vsadss2015_2_d.Ufer_Vegetation (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Ueberlauf_Steuerung (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Deckel
CREATE TABLE vsadss2015_2_d.Deckel (
  T_Id integer PRIMARY KEY
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
SELECT AddGeometryColumn('vsadss2015_2_d','deckel','lage',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'POINT',2);
COMMENT ON TABLE vsadss2015_2_d.Deckel IS '@iliname DSS_2015.Siedlungsentwaesserung.Deckel';
-- DSS_2015.Siedlungsentwaesserung.Oberflaechenabflussparameter
CREATE TABLE vsadss2015_2_d.Oberflaechenabflussparameter (
  T_Id integer PRIMARY KEY
  ,Bemerkung varchar(80) NULL
  ,Benetzungsverlust decimal(5,1) NULL
  ,Bezeichnung varchar(20) NULL
  ,Muldenverlust decimal(5,1) NULL
  ,Verdunstungsverlust decimal(5,1) NULL
  ,Versickerungsverlust decimal(5,1) NULL
  ,EinzugsgebietRef integer NULL
)
;
COMMENT ON TABLE vsadss2015_2_d.Oberflaechenabflussparameter IS '@iliname DSS_2015.Siedlungsentwaesserung.Oberflaechenabflussparameter';
CREATE TABLE vsadss2015_2_d.Absperr_Drosselorgan_Verstellbarkeit (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.HALIGNMENT (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Laengsprofil (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Grundwasserschutzareal
CREATE TABLE vsadss2015_2_d.Grundwasserschutzareal (
  T_Id integer PRIMARY KEY
)
;
SELECT AddGeometryColumn('vsadss2015_2_d','grundwasserschutzareal','perimeter',(SELECT srid FROM SPATIAL_REF_SYS WHERE AUTH_NAME='EPSG' AND AUTH_SRID=21781),'CURVEPOLYGON',2);
COMMENT ON TABLE vsadss2015_2_d.Grundwasserschutzareal IS '@iliname DSS_2015.Siedlungsentwaesserung.Grundwasserschutzareal';
CREATE TABLE vsadss2015_2_d.Beckenentleerung_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
CREATE TABLE vsadss2015_2_d.Gewaesserabschnitt_Art (
  itfCode integer PRIMARY KEY
  ,iliCode varchar(1024) NOT NULL
  ,seq integer NULL
  ,dispName varchar(250) NOT NULL
)
;
-- DSS_2015.Siedlungsentwaesserung.Genossenschaft_Korporation
CREATE TABLE vsadss2015_2_d.Genossenschaft_Korporation (
  T_Id integer PRIMARY KEY
)
;
COMMENT ON TABLE vsadss2015_2_d.Genossenschaft_Korporation IS '@iliname DSS_2015.Siedlungsentwaesserung.Genossenschaft_Korporation';
ALTER TABLE vsadss2015_2_d.Amt ADD CONSTRAINT Amt_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Text ADD CONSTRAINT Abwasserbauwerk_Text_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_TextPos DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Text ADD CONSTRAINT Abwasserbauwerk_Text_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserverband ADD CONSTRAINT Abwasserverband_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung ADD CONSTRAINT Haltung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung ADD CONSTRAINT Haltung_RohrprofilRef_fkey FOREIGN KEY ( RohrprofilRef ) REFERENCES vsadss2015_2_d.Rohrprofil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung ADD CONSTRAINT Haltung_nachHaltungspunktRef_fkey FOREIGN KEY ( nachHaltungspunktRef ) REFERENCES vsadss2015_2_d.Haltungspunkt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung ADD CONSTRAINT Haltung_vonHaltungspunktRef_fkey FOREIGN KEY ( vonHaltungspunktRef ) REFERENCES vsadss2015_2_d.Haltungspunkt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaessersektor ADD CONSTRAINT Gewaessersektor_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaessersektor ADD CONSTRAINT Gewaessersektor_OberflaechengewaesserRef_fkey FOREIGN KEY ( OberflaechengewaesserRef ) REFERENCES vsadss2015_2_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaessersektor ADD CONSTRAINT Gewaessersektor_VorherigerSektorRef_fkey FOREIGN KEY ( VorherigerSektorRef ) REFERENCES vsadss2015_2_d.Gewaessersektor DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk ADD CONSTRAINT Abwasserbauwerk_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk ADD CONSTRAINT Abwasserbauwerk_BetreiberRef_fkey FOREIGN KEY ( BetreiberRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk ADD CONSTRAINT Abwasserbauwerk_EigentuemerRef_fkey FOREIGN KEY ( EigentuemerRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Bankett ADD CONSTRAINT Bankett_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_BASKET ADD CONSTRAINT T_ILI2DB_BASKET_dataset_fkey FOREIGN KEY ( dataset ) REFERENCES vsadss2015_2_d.T_ILI2DB_DATASET DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.GewaesserWehr ADD CONSTRAINT GewaesserWehr_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzelflaeche ADD CONSTRAINT Einzelflaeche_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Leapingwehr ADD CONSTRAINT Leapingwehr_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Entwaesserungssystem ADD CONSTRAINT Entwaesserungssystem_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Streichwehr ADD CONSTRAINT Streichwehr_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.SymbolPos ADD CONSTRAINT SymbolPos_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbehandlung ADD CONSTRAINT Abwasserbehandlung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbehandlung ADD CONSTRAINT Abwasserbehandlung_AbwasserreinigungsanlageRef_fkey FOREIGN KEY ( AbwasserreinigungsanlageRef ) REFERENCES vsadss2015_2_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaessersohle ADD CONSTRAINT Gewaessersohle_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaessersohle ADD CONSTRAINT Gewaessersohle_GewaesserabschnittRef_fkey FOREIGN KEY ( GewaesserabschnittRef ) REFERENCES vsadss2015_2_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Fischpass ADD CONSTRAINT Fischpass_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Fischpass ADD CONSTRAINT Fischpass_GewaesserverbauungRef_fkey FOREIGN KEY ( GewaesserverbauungRef ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Reservoir ADD CONSTRAINT Reservoir_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messreihe ADD CONSTRAINT Messreihe_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messreihe ADD CONSTRAINT Messreihe_MessstelleRef_fkey FOREIGN KEY ( MessstelleRef ) REFERENCES vsadss2015_2_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc ADD CONSTRAINT Organisation_Teil_vonAssoc_Teil_vonRef_fkey FOREIGN KEY ( Teil_vonRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc ADD CONSTRAINT Organisation_Teil_vonAssoc_Organisation_Teil_vonAssocRef_fkey FOREIGN KEY ( Organisation_Teil_vonAssocRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle ADD CONSTRAINT Messstelle_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle ADD CONSTRAINT Messstelle_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle ADD CONSTRAINT Messstelle_AbwasserreinigungsanlageRef_fkey FOREIGN KEY ( AbwasserreinigungsanlageRef ) REFERENCES vsadss2015_2_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle ADD CONSTRAINT Messstelle_BetreiberRef_fkey FOREIGN KEY ( BetreiberRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle ADD CONSTRAINT Messstelle_GewaesserabschnittRef_fkey FOREIGN KEY ( GewaesserabschnittRef ) REFERENCES vsadss2015_2_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Beckenreinigung ADD CONSTRAINT Beckenreinigung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Normschacht ADD CONSTRAINT Normschacht_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Kanton ADD CONSTRAINT Kanton_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Organisation ADD CONSTRAINT Organisation_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Trockenwetterrinne ADD CONSTRAINT Trockenwetterrinne_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Steuerungszentrale ADD CONSTRAINT Steuerungszentrale_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Retentionskoerper ADD CONSTRAINT Retentionskoerper_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Retentionskoerper ADD CONSTRAINT Retentionskoerper_VersickerungsanlageRef_fkey FOREIGN KEY ( VersickerungsanlageRef ) REFERENCES vsadss2015_2_d.Versickerungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet ADD CONSTRAINT Einzugsgebiet_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet ADD CONSTRAINT Einzugsgebiet_Abwassernetzelement_RW_IstRef_fkey FOREIGN KEY ( Abwassernetzelement_RW_IstRef ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet ADD CONSTRAINT Einzugsgebiet_Abwassernetzelement_RW_geplantRef_fkey FOREIGN KEY ( Abwassernetzelement_RW_geplantRef ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet ADD CONSTRAINT Einzugsgebiet_Abwassernetzelement_SW_IstRef_fkey FOREIGN KEY ( Abwassernetzelement_SW_IstRef ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet ADD CONSTRAINT Einzugsgebiet_Abwassernetzelement_SW_geplantRef_fkey FOREIGN KEY ( Abwassernetzelement_SW_geplantRef ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messresultat ADD CONSTRAINT Messresultat_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messresultat ADD CONSTRAINT Messresultat_MessgeraetRef_fkey FOREIGN KEY ( MessgeraetRef ) REFERENCES vsadss2015_2_d.Messgeraet DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messresultat ADD CONSTRAINT Messresultat_MessreiheRef_fkey FOREIGN KEY ( MessreiheRef ) REFERENCES vsadss2015_2_d.Messreihe DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Zone ADD CONSTRAINT Zone_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaesserschutzbereich ADD CONSTRAINT Gewaesserschutzbereich_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Oberflaechengewaesser ADD CONSTRAINT Oberflaechengewaesser_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ueberlaufcharakteristik ADD CONSTRAINT Ueberlaufcharakteristik_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Trockenwetterfallrohr ADD CONSTRAINT Trockenwetterfallrohr_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_IMPORT ADD CONSTRAINT T_ILI2DB_IMPORT_dataset_fkey FOREIGN KEY ( dataset ) REFERENCES vsadss2015_2_d.T_ILI2DB_DATASET DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Schlammbehandlung ADD CONSTRAINT Schlammbehandlung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Schlammbehandlung ADD CONSTRAINT Schlammbehandlung_AbwasserreinigungsanlageRef_fkey FOREIGN KEY ( AbwasserreinigungsanlageRef ) REFERENCES vsadss2015_2_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gemeinde ADD CONSTRAINT Gemeinde_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.ElektromechanischeAusruestung ADD CONSTRAINT ElektromechanischeAusruestung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ufer ADD CONSTRAINT Ufer_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ufer ADD CONSTRAINT Ufer_GewaesserabschnittRef_fkey FOREIGN KEY ( GewaesserabschnittRef ) REFERENCES vsadss2015_2_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_AbwassernetzelementRef_fkey FOREIGN KEY ( AbwassernetzelementRef ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_BetreiberRef_fkey FOREIGN KEY ( BetreiberRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt ADD CONSTRAINT Anschlussobjekt_EigentuemerRef_fkey FOREIGN KEY ( EigentuemerRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Feststoffrueckhalt ADD CONSTRAINT Feststoffrueckhalt_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Kanal ADD CONSTRAINT Kanal_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Stoff ADD CONSTRAINT Stoff_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Stoff ADD CONSTRAINT Stoff_GefahrenquelleRef_fkey FOREIGN KEY ( GefahrenquelleRef ) REFERENCES vsadss2015_2_d.Gefahrenquelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Hydr_Geometrie ADD CONSTRAINT Hydr_Geometrie_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc ADD CONSTRAINT Messstelle_ReferenzstelleAssoc_ReferenzstelleRef_fkey FOREIGN KEY ( ReferenzstelleRef ) REFERENCES vsadss2015_2_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc ADD CONSTRAINT Messstelle_ReferenzstelleAssoc_Messstelle_ReferenzstelleAssocRef_fkey FOREIGN KEY ( Messstelle_ReferenzstelleAssocRef ) REFERENCES vsadss2015_2_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserknoten ADD CONSTRAINT Abwasserknoten_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserknoten ADD CONSTRAINT Abwasserknoten_Hydr_GeometrieRef_fkey FOREIGN KEY ( Hydr_GeometrieRef ) REFERENCES vsadss2015_2_d.Hydr_Geometrie DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Rohrprofil ADD CONSTRAINT Rohrprofil_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messgeraet ADD CONSTRAINT Messgeraet_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Messgeraet ADD CONSTRAINT Messgeraet_MessstelleRef_fkey FOREIGN KEY ( MessstelleRef ) REFERENCES vsadss2015_2_d.Messstelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Grundwasserleiter ADD CONSTRAINT Grundwasserleiter_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Furt ADD CONSTRAINT Furt_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.SIA405_TextPos ADD CONSTRAINT SIA405_TextPos_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.TextPos DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.ARABauwerk ADD CONSTRAINT ARABauwerk_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Schleuse ADD CONSTRAINT Schleuse_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.EZG_PARAMETER_ALLG ADD CONSTRAINT EZG_PARAMETER_ALLG_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Oberflaechenabflussparameter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einleitstelle ADD CONSTRAINT Einleitstelle_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einleitstelle ADD CONSTRAINT Einleitstelle_GewaessersektorRef_fkey FOREIGN KEY ( GewaessersektorRef ) REFERENCES vsadss2015_2_d.Gewaessersektor DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Fliessgewaesser ADD CONSTRAINT Fliessgewaesser_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Brunnen ADD CONSTRAINT Brunnen_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.MUTATION ADD CONSTRAINT MUTATION_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.ARAEnergienutzung ADD CONSTRAINT ARAEnergienutzung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.ARAEnergienutzung ADD CONSTRAINT ARAEnergienutzung_AbwasserreinigungsanlageRef_fkey FOREIGN KEY ( AbwasserreinigungsanlageRef ) REFERENCES vsadss2015_2_d.Abwasserreinigungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.TextPos ADD CONSTRAINT TextPos_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.MechanischeVorreinigung ADD CONSTRAINT MechanischeVorreinigung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.MechanischeVorreinigung ADD CONSTRAINT MechanischeVorreinigung_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.MechanischeVorreinigung ADD CONSTRAINT MechanischeVorreinigung_VersickerungsanlageRef_fkey FOREIGN KEY ( VersickerungsanlageRef ) REFERENCES vsadss2015_2_d.Versickerungsanlage DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltungspunkt ADD CONSTRAINT Haltungspunkt_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltungspunkt ADD CONSTRAINT Haltungspunkt_AbwassernetzelementRef_fkey FOREIGN KEY ( AbwassernetzelementRef ) REFERENCES vsadss2015_2_d.Abwassernetzelement DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Metaattribute ADD CONSTRAINT Metaattribute_SIA405_Base_SIA405_BaseClass_Metaattribute_fkey FOREIGN KEY ( SIA405_Base_SIA405_BaseClass_Metaattribute ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Rohrprofil_Geometrie ADD CONSTRAINT Rohrprofil_Geometrie_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Rohrprofil_Geometrie ADD CONSTRAINT Rohrprofil_Geometrie_RohrprofilRef_fkey FOREIGN KEY ( RohrprofilRef ) REFERENCES vsadss2015_2_d.Rohrprofil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Rueckstausicherung ADD CONSTRAINT Rueckstausicherung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Rueckstausicherung ADD CONSTRAINT Rueckstausicherung_Absperr_DrosselorganRef_fkey FOREIGN KEY ( Absperr_DrosselorganRef ) REFERENCES vsadss2015_2_d.Absperr_Drosselorgan DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Rueckstausicherung ADD CONSTRAINT Rueckstausicherung_FoerderAggregatRef_fkey FOREIGN KEY ( FoerderAggregatRef ) REFERENCES vsadss2015_2_d.FoerderAggregat DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet_Text ADD CONSTRAINT Einzugsgebiet_Text_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_TextPos DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet_Text ADD CONSTRAINT Einzugsgebiet_Text_EinzugsgebietRef_fkey FOREIGN KEY ( EinzugsgebietRef ) REFERENCES vsadss2015_2_d.Einzugsgebiet DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.EZG_PARAMETER_MOUSE1 ADD CONSTRAINT EZG_PARAMETER_MOUSE1_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Oberflaechenabflussparameter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Privat ADD CONSTRAINT Privat_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_BASKET ADD CONSTRAINT T_ILI2DB_IMPORT_BASKET_import_fkey FOREIGN KEY ( import ) REFERENCES vsadss2015_2_d.T_ILI2DB_IMPORT DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_BASKET ADD CONSTRAINT T_ILI2DB_IMPORT_BASKET_basket_fkey FOREIGN KEY ( basket ) REFERENCES vsadss2015_2_d.T_ILI2DB_BASKET DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.ElektrischeEinrichtung ADD CONSTRAINT ElektrischeEinrichtung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.BauwerksTeil ADD CONSTRAINT BauwerksTeil_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.BauwerksTeil ADD CONSTRAINT BauwerksTeil_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserreinigungsanlage ADD CONSTRAINT Abwasserreinigungsanlage_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Beckenentleerung ADD CONSTRAINT Beckenentleerung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Beckenentleerung ADD CONSTRAINT Beckenentleerung_Absperr_DrosselorganRef_fkey FOREIGN KEY ( Absperr_DrosselorganRef ) REFERENCES vsadss2015_2_d.Absperr_Drosselorgan DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Beckenentleerung ADD CONSTRAINT Beckenentleerung_UeberlaufRef_fkey FOREIGN KEY ( UeberlaufRef ) REFERENCES vsadss2015_2_d.FoerderAggregat DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Spezialbauwerk ADD CONSTRAINT Spezialbauwerk_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Versickerungsanlage ADD CONSTRAINT Versickerungsanlage_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Versickerungsanlage ADD CONSTRAINT Versickerungsanlage_GrundwasserleiterRef_fkey FOREIGN KEY ( GrundwasserleiterRef ) REFERENCES vsadss2015_2_d.Grundwasserleiter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Unfall ADD CONSTRAINT Unfall_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Unfall ADD CONSTRAINT Unfall_GefahrenquelleRef_fkey FOREIGN KEY ( GefahrenquelleRef ) REFERENCES vsadss2015_2_d.Gefahrenquelle DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan ADD CONSTRAINT Absperr_Drosselorgan_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan ADD CONSTRAINT Absperr_Drosselorgan_AbwasserknotenRef_fkey FOREIGN KEY ( AbwasserknotenRef ) REFERENCES vsadss2015_2_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan ADD CONSTRAINT Absperr_Drosselorgan_SteuerungszentraleRef_fkey FOREIGN KEY ( SteuerungszentraleRef ) REFERENCES vsadss2015_2_d.Steuerungszentrale DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan ADD CONSTRAINT Absperr_Drosselorgan_UeberlaufRef_fkey FOREIGN KEY ( UeberlaufRef ) REFERENCES vsadss2015_2_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Badestelle ADD CONSTRAINT Badestelle_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Badestelle ADD CONSTRAINT Badestelle_OberflaechengewaesserRef_fkey FOREIGN KEY ( OberflaechengewaesserRef ) REFERENCES vsadss2015_2_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Grundwasserschutzzone ADD CONSTRAINT Grundwasserschutzzone_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung_Text ADD CONSTRAINT Haltung_Text_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_TextPos DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung_Text ADD CONSTRAINT Haltung_Text_HaltungRef_fkey FOREIGN KEY ( HaltungRef ) REFERENCES vsadss2015_2_d.Haltung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.FoerderAggregat ADD CONSTRAINT FoerderAggregat_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Ueberlauf DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Wasserfassung ADD CONSTRAINT Wasserfassung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Wasserfassung ADD CONSTRAINT Wasserfassung_GrundwasserleiterRef_fkey FOREIGN KEY ( GrundwasserleiterRef ) REFERENCES vsadss2015_2_d.Grundwasserleiter DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Wasserfassung ADD CONSTRAINT Wasserfassung_OberflaechengewaesserRef_fkey FOREIGN KEY ( OberflaechengewaesserRef ) REFERENCES vsadss2015_2_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Geschiebesperre ADD CONSTRAINT Geschiebesperre_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.SIA405_BaseClass ADD CONSTRAINT SIA405_BaseClass_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung_AlternativVerlauf ADD CONSTRAINT Haltung_AlternativVerlauf_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Haltung_AlternativVerlauf ADD CONSTRAINT Haltung_AlternativVerlauf_HaltungRef_fkey FOREIGN KEY ( HaltungRef ) REFERENCES vsadss2015_2_d.Haltung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaesserabschnitt ADD CONSTRAINT Gewaesserabschnitt_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaesserabschnitt ADD CONSTRAINT Gewaesserabschnitt_FliessgewaesserRef_fkey FOREIGN KEY ( FliessgewaesserRef ) REFERENCES vsadss2015_2_d.Fliessgewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc ADD CONSTRAINT Erhaltungsereignis_AbwasserbauwerkAssoc_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc ADD CONSTRAINT Erhaltungsereignis_AbwasserbauwerkAssoc_Erhaltungsereignis_AbwasserbauwerkAssocRef_fkey FOREIGN KEY ( Erhaltungsereignis_AbwasserbauwerkAssocRef ) REFERENCES vsadss2015_2_d.Erhaltungsereignis DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Durchlass ADD CONSTRAINT Durchlass_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.See ADD CONSTRAINT See_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Oberflaechengewaesser DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol ADD CONSTRAINT Abwasserbauwerk_Symbol_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_SymbolPos DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol ADD CONSTRAINT Abwasserbauwerk_Symbol_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.GewaesserAbsturz ADD CONSTRAINT GewaesserAbsturz_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gefahrenquelle ADD CONSTRAINT Gefahrenquelle_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gefahrenquelle ADD CONSTRAINT Gefahrenquelle_AnschlussobjektRef_fkey FOREIGN KEY ( AnschlussobjektRef ) REFERENCES vsadss2015_2_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gefahrenquelle ADD CONSTRAINT Gefahrenquelle_EigentuemerRef_fkey FOREIGN KEY ( EigentuemerRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.SIA405_SymbolPos ADD CONSTRAINT SIA405_SymbolPos_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SymbolPos DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Einstiegshilfe ADD CONSTRAINT Einstiegshilfe_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Versickerungsbereich ADD CONSTRAINT Versickerungsbereich_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Hydr_Kennwerte ADD CONSTRAINT Hydr_Kennwerte_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Hydr_Kennwerte ADD CONSTRAINT Hydr_Kennwerte_AbwasserknotenRef_fkey FOREIGN KEY ( AbwasserknotenRef ) REFERENCES vsadss2015_2_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Hydr_Kennwerte ADD CONSTRAINT Hydr_Kennwerte_UeberlaufcharakteristikRef_fkey FOREIGN KEY ( UeberlaufcharakteristikRef ) REFERENCES vsadss2015_2_d.Ueberlaufcharakteristik DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwassernetzelement ADD CONSTRAINT Abwassernetzelement_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Abwassernetzelement ADD CONSTRAINT Abwassernetzelement_AbwasserbauwerkRef_fkey FOREIGN KEY ( AbwasserbauwerkRef ) REFERENCES vsadss2015_2_d.Abwasserbauwerk DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Planungszone ADD CONSTRAINT Planungszone_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Sohlrampe ADD CONSTRAINT Sohlrampe_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Gewaesserverbauung DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Hydr_GeomRelation ADD CONSTRAINT Hydr_GeomRelation_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Hydr_GeomRelation ADD CONSTRAINT Hydr_GeomRelation_Hydr_GeometrieRef_fkey FOREIGN KEY ( Hydr_GeometrieRef ) REFERENCES vsadss2015_2_d.Hydr_Geometrie DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gebaeude ADD CONSTRAINT Gebaeude_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Anschlussobjekt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ueberlauf ADD CONSTRAINT Ueberlauf_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ueberlauf ADD CONSTRAINT Ueberlauf_AbwasserknotenRef_fkey FOREIGN KEY ( AbwasserknotenRef ) REFERENCES vsadss2015_2_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ueberlauf ADD CONSTRAINT Ueberlauf_SteuerungszentraleRef_fkey FOREIGN KEY ( SteuerungszentraleRef ) REFERENCES vsadss2015_2_d.Steuerungszentrale DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ueberlauf ADD CONSTRAINT Ueberlauf_UeberlaufNachRef_fkey FOREIGN KEY ( UeberlaufNachRef ) REFERENCES vsadss2015_2_d.Abwasserknoten DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Ueberlauf ADD CONSTRAINT Ueberlauf_UeberlaufcharakteristikRef_fkey FOREIGN KEY ( UeberlaufcharakteristikRef ) REFERENCES vsadss2015_2_d.Ueberlaufcharakteristik DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis ADD CONSTRAINT Erhaltungsereignis_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis ADD CONSTRAINT Erhaltungsereignis_Ausfuehrender_FirmaRef_fkey FOREIGN KEY ( Ausfuehrender_FirmaRef ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaesserverbauung ADD CONSTRAINT Gewaesserverbauung_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Gewaesserverbauung ADD CONSTRAINT Gewaesserverbauung_GewaesserabschnittRef_fkey FOREIGN KEY ( GewaesserabschnittRef ) REFERENCES vsadss2015_2_d.Gewaesserabschnitt DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.HQ_Relation ADD CONSTRAINT HQ_Relation_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.HQ_Relation ADD CONSTRAINT HQ_Relation_UeberlaufcharakteristikRef_fkey FOREIGN KEY ( UeberlaufcharakteristikRef ) REFERENCES vsadss2015_2_d.Ueberlaufcharakteristik DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Deckel ADD CONSTRAINT Deckel_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.BauwerksTeil DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Oberflaechenabflussparameter ADD CONSTRAINT Oberflaechenabflussparameter_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.SIA405_BaseClass DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Oberflaechenabflussparameter ADD CONSTRAINT Oberflaechenabflussparameter_EinzugsgebietRef_fkey FOREIGN KEY ( EinzugsgebietRef ) REFERENCES vsadss2015_2_d.Einzugsgebiet DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Grundwasserschutzareal ADD CONSTRAINT Grundwasserschutzareal_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Zone DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE vsadss2015_2_d.Genossenschaft_Korporation ADD CONSTRAINT Genossenschaft_Korporation_T_Id_fkey FOREIGN KEY ( T_Id ) REFERENCES vsadss2015_2_d.Organisation DEFERRABLE INITIALLY DEFERRED;
