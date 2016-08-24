DROP TABLE vsadss2008_1_d.Kanal_Verbindungsart;
-- DSS_2008.Siedlungsentwaesserung.Ufer
DROP TABLE vsadss2008_1_d.Ufer;
-- DSS_2008.Siedlungsentwaesserung.Leapingwehr
DROP TABLE vsadss2008_1_d.Leapingwehr;
DROP TABLE vsadss2008_1_d.ARABauwerk_Art;
DROP TABLE vsadss2008_1_d.T_ILI2DB_BASKET;
DROP TABLE vsadss2008_1_d.Abwasserbehandlung_Art;
-- DSS_2008.Siedlungsentwaesserung.Amt
DROP TABLE vsadss2008_1_d.Amt;
DROP TABLE vsadss2008_1_d.Schlammbehandlung_Stabilisierung;
DROP TABLE vsadss2008_1_d.Ufer_Verbauungsart;
-- DSS_2008.Siedlungsentwaesserung.Deckel
DROP TABLE vsadss2008_1_d.Deckel;
SELECT DropGeometryColumn('vsadss2008_1_d','deckel','lage');
-- DSS_2008.Siedlungsentwaesserung.Absperr_Drosselorgan
DROP TABLE vsadss2008_1_d.Absperr_Drosselorgan;
DROP TABLE vsadss2008_1_d.Planungszone_Art;
DROP TABLE vsadss2008_1_d.Entwaesserungssystem_Art;
DROP TABLE vsadss2008_1_d.Normschacht_Funktion;
DROP TABLE vsadss2008_1_d.Haltung_Innenschutz;
DROP TABLE vsadss2008_1_d.Einzelflaeche_Befestigung;
-- DSS_2008.Siedlungsentwaesserung.Messstelle
DROP TABLE vsadss2008_1_d.Messstelle;
SELECT DropGeometryColumn('vsadss2008_1_d','messstelle','lage');
-- DSS_2008.Siedlungsentwaesserung.Abwasserknoten
DROP TABLE vsadss2008_1_d.Abwasserknoten;
SELECT DropGeometryColumn('vsadss2008_1_d','abwasserknoten','lage');
-- DSS_2008.Siedlungsentwaesserung.Hydr_Geometrie
DROP TABLE vsadss2008_1_d.Hydr_Geometrie;
-- DSS_2008.Siedlungsentwaesserung.See
DROP TABLE vsadss2008_1_d.See;
SELECT DropGeometryColumn('vsadss2008_1_d','see','perimeter');
-- DSS_2008.Siedlungsentwaesserung.GewaesserAbsturz
DROP TABLE vsadss2008_1_d.GewaesserAbsturz;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Wasserhaerte;
DROP TABLE vsadss2008_1_d.Leapingwehr_Oeffnungsform;
DROP TABLE vsadss2008_1_d.Gewaessersohle_Verbauungsart;
DROP TABLE vsadss2008_1_d.Ufer_Uferbereich;
DROP TABLE vsadss2008_1_d.FoerderAggregat_Bauart;
DROP TABLE vsadss2008_1_d.Gewaesserschutzbereich_Art;
-- DSS_2008.Siedlungsentwaesserung.ElektrischeEinrichtung
DROP TABLE vsadss2008_1_d.ElektrischeEinrichtung;
-- DSS_2008.Siedlungsentwaesserung.Schleuse
DROP TABLE vsadss2008_1_d.Schleuse;
-- DSS_2008.Siedlungsentwaesserung.Abwasserbauwerk
DROP TABLE vsadss2008_1_d.Abwasserbauwerk;
SELECT DropGeometryColumn('vsadss2008_1_d','abwasserbauwerk','detailgeometrie');
DROP TABLE vsadss2008_1_d.Abwasserbauwerk_Sanierungsbedarf;
DROP TABLE vsadss2008_1_d.Rohrprofil_Profiltyp;
DROP TABLE vsadss2008_1_d.Deckel_Verschluss;
DROP TABLE vsadss2008_1_d.MechanischeVorreinigung_Art;
-- DSS_2008.Siedlungsentwaesserung.Kanal
DROP TABLE vsadss2008_1_d.Kanal;
DROP TABLE vsadss2008_1_d.ElektrischeEinrichtung_Art;
-- DSS_2008.Siedlungsentwaesserung.Einstiegshilfe
DROP TABLE vsadss2008_1_d.Einstiegshilfe;
-- DSS_2008.Siedlungsentwaesserung.Normschacht
DROP TABLE vsadss2008_1_d.Normschacht;
-- DSS_2008.Siedlungsentwaesserung.Hydr_GeomRelation
DROP TABLE vsadss2008_1_d.Hydr_GeomRelation;
-- DSS_2008.Siedlungsentwaesserung.ElektromechanischeAusruestung
DROP TABLE vsadss2008_1_d.ElektromechanischeAusruestung;
DROP TABLE vsadss2008_1_d.Haltungspunkt_Hoehengenauigkeit;
-- DSS_2008.Siedlungsentwaesserung.Messgeraet
DROP TABLE vsadss2008_1_d.Messgeraet;
-- DSS_2008.Siedlungsentwaesserung.Gewaesserschutzbereich
DROP TABLE vsadss2008_1_d.Gewaesserschutzbereich;
SELECT DropGeometryColumn('vsadss2008_1_d','gewaesserschutzbereich','perimeter');
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Algenbewuchs;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Totholz;
-- DSS_2008.Siedlungsentwaesserung.Furt
DROP TABLE vsadss2008_1_d.Furt;
-- DSS_2008.Siedlungsentwaesserung.Grundwasserleiter
DROP TABLE vsadss2008_1_d.Grundwasserleiter;
SELECT DropGeometryColumn('vsadss2008_1_d','grundwasserleiter','perimeter');
DROP TABLE vsadss2008_1_d.T_ILI2DB_MODEL;
DROP TABLE vsadss2008_1_d.FoerderAggregat_AufstellungFoerderaggregat;
DROP TABLE vsadss2008_1_d.Normschacht_Oberflaechenzulauf;
DROP TABLE vsadss2008_1_d.Absperr_Drosselorgan_Antrieb;
-- DSS_2008.Siedlungsentwaesserung.Entwaesserungssystem
DROP TABLE vsadss2008_1_d.Entwaesserungssystem;
SELECT DropGeometryColumn('vsadss2008_1_d','entwaesserungssystem','perimeter');
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Laengsprofil;
DROP TABLE vsadss2008_1_d.Spezialbauwerk_Bypass;
DROP TABLE vsadss2008_1_d.Deckel_Entlueftung;
-- DSS_2008.Siedlungsentwaesserung.Abwasserverband
DROP TABLE vsadss2008_1_d.Abwasserverband;
-- DSS_2008.Siedlungsentwaesserung.Gemeinde
DROP TABLE vsadss2008_1_d.Gemeinde;
SELECT DropGeometryColumn('vsadss2008_1_d','gemeinde','perimeter');
DROP TABLE vsadss2008_1_d.Deckel_Deckelform;
-- DSS_2008.Siedlungsentwaesserung.Planungszone
DROP TABLE vsadss2008_1_d.Planungszone;
SELECT DropGeometryColumn('vsadss2008_1_d','planungszone','perimeter');
DROP TABLE vsadss2008_1_d.Deckel_Schlammeimer;
-- DSS_2008.Siedlungsentwaesserung.Messresultat
DROP TABLE vsadss2008_1_d.Messresultat;
DROP TABLE vsadss2008_1_d.Versickerungsbereich_Versickerungsmoeglichkeit;
DROP TABLE vsadss2008_1_d.Haltung_Material;
DROP TABLE vsadss2008_1_d.Haltungspunkt_Auslaufform;
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Wasserdichtheit;
-- DSS_2008.Siedlungsentwaesserung.Einzugsgebiet_Text
DROP TABLE vsadss2008_1_d.Einzugsgebiet_Text;
SELECT DropGeometryColumn('vsadss2008_1_d','einzugsgebiet_text','textpos');
-- DSS_2008.Siedlungsentwaesserung.Organisation
DROP TABLE vsadss2008_1_d.Organisation;
-- DSS_2008.Siedlungsentwaesserung.Vorflutereinlauf
DROP TABLE vsadss2008_1_d.Vorflutereinlauf;
-- DSS_2008.Siedlungsentwaesserung.Ueberlauf
DROP TABLE vsadss2008_1_d.Ueberlauf;
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Saugwagen;
DROP TABLE vsadss2008_1_d.Sohlrampe_Befestigung;
DROP TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_BASKET;
DROP TABLE vsadss2008_1_d.T_KEY_OBJECT;
-- DSS_2008.Siedlungsentwaesserung.MechanischeVorreinigung
DROP TABLE vsadss2008_1_d.MechanischeVorreinigung;
DROP TABLE vsadss2008_1_d.Ufer_Vegetation;
-- DSS_2008.Siedlungsentwaesserung.Wasserfassung
DROP TABLE vsadss2008_1_d.Wasserfassung;
SELECT DropGeometryColumn('vsadss2008_1_d','wasserfassung','lage');
DROP TABLE vsadss2008_1_d.Ufer_Seite;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Oekom_Klassifizierung;
-- DSS_2008.Siedlungsentwaesserung.Gewaesserverbauung
DROP TABLE vsadss2008_1_d.Gewaesserverbauung;
SELECT DropGeometryColumn('vsadss2008_1_d','gewaesserverbauung','lage');
-- DSS_2008.Siedlungsentwaesserung.Kanton
DROP TABLE vsadss2008_1_d.Kanton;
SELECT DropGeometryColumn('vsadss2008_1_d','kanton','perimeter');
DROP TABLE vsadss2008_1_d.Abwasserbauwerk_Zugaenglichkeit;
-- DSS_2008.Siedlungsentwaesserung.MUTATION
DROP TABLE vsadss2008_1_d.MUTATION;
DROP TABLE vsadss2008_1_d.Deckel_Lagegenauigkeit;
DROP TABLE vsadss2008_1_d.GewaesserAbsturz_Typ;
DROP TABLE vsadss2008_1_d.Plantyp;
DROP TABLE vsadss2008_1_d.Kanal_FunktionHierarchisch;
DROP TABLE vsadss2008_1_d.MUTATION_ART;
-- DSS_2008.Siedlungsentwaesserung.Messstelle_Hierarchie
DROP TABLE vsadss2008_1_d.Messstelle_Hierarchie;
DROP TABLE vsadss2008_1_d.Ueberlauf_Steuerung;
-- DSS_2008.Siedlungsentwaesserung.Anschlussobjekt
DROP TABLE vsadss2008_1_d.Anschlussobjekt;
-- DSS_2008.Siedlungsentwaesserung.EZG_PARAMETER_ALLG
DROP TABLE vsadss2008_1_d.EZG_PARAMETER_ALLG;
-- DSS_2008.Siedlungsentwaesserung.Abwasserbehandlung
DROP TABLE vsadss2008_1_d.Abwasserbehandlung;
DROP TABLE vsadss2008_1_d.Fliessgewaesser_Art;
-- DSS_2008.Siedlungsentwaesserung.ARABauwerk
DROP TABLE vsadss2008_1_d.ARABauwerk;
DROP TABLE vsadss2008_1_d.Gewaessersohle_Art;
-- DSS_2008.Siedlungsentwaesserung.Ueberlaufcharakteristik
DROP TABLE vsadss2008_1_d.Ueberlaufcharakteristik;
-- DSS_2008.Siedlungsentwaesserung.Rohrprofil_Geometrie
DROP TABLE vsadss2008_1_d.Rohrprofil_Geometrie;
DROP TABLE vsadss2008_1_d.Abwasserbauwerk_BaulicherZustand;
-- DSS_2008.Siedlungsentwaesserung.Rohrprofil
DROP TABLE vsadss2008_1_d.Rohrprofil;
-- DSS_2008.Siedlungsentwaesserung.Haltungspunkt
DROP TABLE vsadss2008_1_d.Haltungspunkt;
SELECT DropGeometryColumn('vsadss2008_1_d','haltungspunkt','lage');
-- DSS_2008.Siedlungsentwaesserung.Geschiebesperre
DROP TABLE vsadss2008_1_d.Geschiebesperre;
DROP TABLE vsadss2008_1_d.Haltung_Lagebestimmung;
DROP TABLE vsadss2008_1_d.Ueberlauf_Verstellbarkeit;
DROP TABLE vsadss2008_1_d.Einzugsgebiet_Art;
-- DSS_2008.Siedlungsentwaesserung.Versickerungsbereich
DROP TABLE vsadss2008_1_d.Versickerungsbereich;
SELECT DropGeometryColumn('vsadss2008_1_d','versickerungsbereich','perimeter');
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Tiefenvariabilitaet;
DROP TABLE vsadss2008_1_d.Spezialbauwerk_Funktion;
-- DSS_2008.Siedlungsentwaesserung.Schlammbehandlung
DROP TABLE vsadss2008_1_d.Schlammbehandlung;
-- DSS_2008.Siedlungsentwaesserung.Fischpass
DROP TABLE vsadss2008_1_d.Fischpass;
-- DSS_2008.Siedlungsentwaesserung.Organisation_Hierarchie
DROP TABLE vsadss2008_1_d.Organisation_Hierarchie;
DROP TABLE vsadss2008_1_d.T_ILI2DB_IMPORT;
-- DSS_2008.Siedlungsentwaesserung.Gewaessersohle
DROP TABLE vsadss2008_1_d.Gewaessersohle;
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Art;
-- DSS_2008.Siedlungsentwaesserung.ARAEnergienutzung
DROP TABLE vsadss2008_1_d.ARAEnergienutzung;
-- DSS_2008.Siedlungsentwaesserung.Unfall
DROP TABLE vsadss2008_1_d.Unfall;
SELECT DropGeometryColumn('vsadss2008_1_d','unfall','lage');
DROP TABLE vsadss2008_1_d.Retentionskoerper_Art;
-- DSS_2008.Siedlungsentwaesserung.Retentionskoerper
DROP TABLE vsadss2008_1_d.Retentionskoerper;
DROP TABLE vsadss2008_1_d.GewaesserAbsturz_Material;
-- DSS_2008.Siedlungsentwaesserung.Zone
DROP TABLE vsadss2008_1_d.Zone;
-- DSS_2008.Siedlungsentwaesserung.Messreihe
DROP TABLE vsadss2008_1_d.Messreihe;
DROP TABLE vsadss2008_1_d.Ueberlauf_Signaluebermittlung;
DROP TABLE vsadss2008_1_d.Messreihe_Art;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Linienfuehrung;
DROP TABLE vsadss2008_1_d.Absperr_Drosselorgan_Art;
DROP TABLE vsadss2008_1_d.T_ILI2DB_SETTINGS;
DROP TABLE vsadss2008_1_d.Einzugsgebiet_Status;
DROP TABLE vsadss2008_1_d.Ueberlauf_Antrieb;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Art;
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Notueberlauf;
-- DSS_2008.Siedlungsentwaesserung.Oberflaechenabflussparameter
DROP TABLE vsadss2008_1_d.Oberflaechenabflussparameter;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Gefaelle;
DROP TABLE vsadss2008_1_d.Normschacht_Material;
DROP TABLE vsadss2008_1_d.FoerderAggregat_AufstellungAntrieb;
-- DSS_2008.Siedlungsentwaesserung.Durchlass
DROP TABLE vsadss2008_1_d.Durchlass;
-- DSS_2008.Siedlungsentwaesserung.Fliessgewaesser
DROP TABLE vsadss2008_1_d.Fliessgewaesser;
-- DSS_2008.Siedlungsentwaesserung.Erhaltungsereignis
DROP TABLE vsadss2008_1_d.Erhaltungsereignis;
DROP TABLE vsadss2008_1_d.Absperr_Drosselorgan_Steuerung;
DROP TABLE vsadss2008_1_d.T_ILI2DB_CLASSNAME;
DROP TABLE vsadss2008_1_d.Abwasserbauwerk_Status;
-- DSS_2008.Siedlungsentwaesserung.Streichwehr
DROP TABLE vsadss2008_1_d.Streichwehr;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Nutzung;
DROP TABLE vsadss2008_1_d.Einstiegshilfe_Art;
DROP TABLE vsadss2008_1_d.Erhaltungsereignis_Status;
DROP TABLE vsadss2008_1_d.T_ILI2DB_DATASET;
DROP TABLE vsadss2008_1_d.Bankett_Art;
-- DSS_2008.Siedlungsentwaesserung.HQ_Relation
DROP TABLE vsadss2008_1_d.HQ_Relation;
-- DSS_2008.Siedlungsentwaesserung.Steuerungszentrale
DROP TABLE vsadss2008_1_d.Steuerungszentrale;
SELECT DropGeometryColumn('vsadss2008_1_d','steuerungszentrale','lage');
DROP TABLE vsadss2008_1_d.Deckel_Material;
-- DSS_2008.Siedlungsentwaesserung.Gewaesserabschnitt
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt;
SELECT DropGeometryColumn('vsadss2008_1_d','gewaesserabschnitt','bis');
SELECT DropGeometryColumn('vsadss2008_1_d','gewaesserabschnitt','von');
-- DSS_2008.Siedlungsentwaesserung.FoerderAggregat
DROP TABLE vsadss2008_1_d.FoerderAggregat;
DROP TABLE vsadss2008_1_d.Kanal_FunktionHydraulisch;
DROP TABLE vsadss2008_1_d.Erhaltungsereignis_Art;
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Versickerungswasser;
-- DSS_2008.Siedlungsentwaesserung.Badestelle
DROP TABLE vsadss2008_1_d.Badestelle;
SELECT DropGeometryColumn('vsadss2008_1_d','badestelle','lage');
-- DSS_2008.Siedlungsentwaesserung.Abwassernetzelement
DROP TABLE vsadss2008_1_d.Abwassernetzelement;
-- DSS_2008.Siedlungsentwaesserung.Haltung
DROP TABLE vsadss2008_1_d.Haltung;
SELECT DropGeometryColumn('vsadss2008_1_d','haltung','verlauf');
-- DSS_2008.Siedlungsentwaesserung.Gewaessersektor
DROP TABLE vsadss2008_1_d.Gewaessersektor;
SELECT DropGeometryColumn('vsadss2008_1_d','gewaessersektor','verlauf');
-- DSS_2008.Siedlungsentwaesserung.Abwasserbauwerk_Text
DROP TABLE vsadss2008_1_d.Abwasserbauwerk_Text;
SELECT DropGeometryColumn('vsadss2008_1_d','abwasserbauwerk_text','textpos');
DROP TABLE vsadss2008_1_d.Streichwehr_WehrschwellenZahl;
DROP TABLE vsadss2008_1_d.Einzelflaeche_Funktion;
DROP TABLE vsadss2008_1_d.VALIGNMENT;
DROP TABLE vsadss2008_1_d.T_ILI2DB_INHERITANCE;
DROP TABLE vsadss2008_1_d.HALIGNMENT;
DROP TABLE vsadss2008_1_d.Absperr_Drosselorgan_Signaluebermittlung;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Hoehenstufe;
-- DSS_2008.Siedlungsentwaesserung.Einzugsgebiet
DROP TABLE vsadss2008_1_d.Einzugsgebiet;
SELECT DropGeometryColumn('vsadss2008_1_d','einzugsgebiet','perimeter');
-- DSS_2008.Siedlungsentwaesserung.Bankett
DROP TABLE vsadss2008_1_d.Bankett;
-- DSS_2008.Siedlungsentwaesserung.Gewaessersektor_Hierarchie
DROP TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie;
DROP TABLE vsadss2008_1_d.T_ILI2DB_ATTRNAME;
-- DSS_2008.Siedlungsentwaesserung.Erhaltungsereignis_Abwasserbauwerk
DROP TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk;
DROP TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_OBJECT;
-- DSS_2008.Siedlungsentwaesserung.Grundwasserschutzareal
DROP TABLE vsadss2008_1_d.Grundwasserschutzareal;
SELECT DropGeometryColumn('vsadss2008_1_d','grundwasserschutzareal','perimeter');
-- DSS_2008.Siedlungsentwaesserung.Privat
DROP TABLE vsadss2008_1_d.Privat;
-- DSS_2008.Siedlungsentwaesserung.BauwerksTeil
DROP TABLE vsadss2008_1_d.BauwerksTeil;
-- DSS_2008.Siedlungsentwaesserung.EZG_PARAMETER_MOUSE1
DROP TABLE vsadss2008_1_d.EZG_PARAMETER_MOUSE1;
-- DSS_2008.Siedlungsentwaesserung.Gebaeude
DROP TABLE vsadss2008_1_d.Gebaeude;
SELECT DropGeometryColumn('vsadss2008_1_d','gebaeude','perimeter');
SELECT DropGeometryColumn('vsadss2008_1_d','gebaeude','referenzpunkt');
-- DSS_2008.Siedlungsentwaesserung.Sohlrampe
DROP TABLE vsadss2008_1_d.Sohlrampe;
DROP TABLE vsadss2008_1_d.Absperr_Drosselorgan_Verstellbarkeit;
DROP TABLE vsadss2008_1_d.GewaesserWehr_Art;
DROP TABLE vsadss2008_1_d.Gewaessersektor_Art;
-- DSS_2008.Siedlungsentwaesserung.Spezialbauwerk
DROP TABLE vsadss2008_1_d.Spezialbauwerk;
DROP TABLE vsadss2008_1_d.Grundwasserschutzzone_Art;
DROP TABLE vsadss2008_1_d.Ufer_Umlandnutzung;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Makrophytenbewuchs;
-- DSS_2008.Siedlungsentwaesserung.Grundwasserschutzzone
DROP TABLE vsadss2008_1_d.Grundwasserschutzzone;
SELECT DropGeometryColumn('vsadss2008_1_d','grundwasserschutzzone','perimeter');
-- DSS_2008.Siedlungsentwaesserung.Abwasserreinigungsanlage
DROP TABLE vsadss2008_1_d.Abwasserreinigungsanlage;
-- DSS_2008.Siedlungsentwaesserung.Stoff
DROP TABLE vsadss2008_1_d.Stoff;
-- DSS_2008.Siedlungsentwaesserung.Trockenwetterfallrohr
DROP TABLE vsadss2008_1_d.Trockenwetterfallrohr;
-- DSS_2008.Siedlungsentwaesserung.Reservoir
DROP TABLE vsadss2008_1_d.Reservoir;
SELECT DropGeometryColumn('vsadss2008_1_d','reservoir','lage');
DROP TABLE vsadss2008_1_d.Gewaessersohle_Verbauungsgrad;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Breitenvariabilitaet;
DROP TABLE vsadss2008_1_d.Ufer_Verbauungsgrad;
DROP TABLE vsadss2008_1_d.Wasserfassung_Art;
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Maengel;
-- DSS_2008.Siedlungsentwaesserung.Versickerungsanlage
DROP TABLE vsadss2008_1_d.Versickerungsanlage;
DROP TABLE vsadss2008_1_d.Kanal_Nutzungsart_Ist;
-- DSS_2008.Siedlungsentwaesserung.Haltung_Text
DROP TABLE vsadss2008_1_d.Haltung_Text;
SELECT DropGeometryColumn('vsadss2008_1_d','haltung_text','textpos');
DROP TABLE vsadss2008_1_d.Versickerungsanlage_Beschriftung;
-- DSS_2008.Siedlungsentwaesserung.Oberflaechengewaesser
DROP TABLE vsadss2008_1_d.Oberflaechengewaesser;
DROP TABLE vsadss2008_1_d.Ueberlauf_Funktion;
-- DSS_2008.Siedlungsentwaesserung.Brunnen
DROP TABLE vsadss2008_1_d.Brunnen;
SELECT DropGeometryColumn('vsadss2008_1_d','brunnen','lage');
DROP TABLE vsadss2008_1_d.Einzugsgebiet_System;
DROP TABLE vsadss2008_1_d.BauwerksTeil_Instandstellung;
DROP TABLE vsadss2008_1_d.Kanal_Bettung_Umhuellung;
DROP TABLE vsadss2008_1_d.Kanal_Nutzungsart_geplant;
-- DSS_2008.Siedlungsentwaesserung.Trockenwetterrinne
DROP TABLE vsadss2008_1_d.Trockenwetterrinne;
-- DSS_2008.Siedlungsentwaesserung.GewaesserWehr
DROP TABLE vsadss2008_1_d.GewaesserWehr;
DROP TABLE vsadss2008_1_d.Trockenwetterrinne_Material;
DROP TABLE vsadss2008_1_d.Streichwehr_Ueberfallkante;
-- DSS_2008.Siedlungsentwaesserung.Einzelflaeche
DROP TABLE vsadss2008_1_d.Einzelflaeche;
SELECT DropGeometryColumn('vsadss2008_1_d','einzelflaeche','perimeter');
DROP TABLE vsadss2008_1_d.ElektromechanischeAusruestung_Art;
DROP TABLE vsadss2008_1_d.Gewaesserabschnitt_Abflussregime;
-- DSS_2008.Siedlungsentwaesserung.Gefahrenquelle
DROP TABLE vsadss2008_1_d.Gefahrenquelle;
SELECT DropGeometryColumn('vsadss2008_1_d','gefahrenquelle','lage');
ALTER TABLE vsadss2008_1_d.Ufer DROP CONSTRAINT Ufer_Gewaesserabschnitt_fkey;
ALTER TABLE vsadss2008_1_d.Leapingwehr DROP CONSTRAINT Leapingwehr_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_BASKET DROP CONSTRAINT T_ILI2DB_BASKET_dataset_fkey;
ALTER TABLE vsadss2008_1_d.Amt DROP CONSTRAINT Amt_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Deckel DROP CONSTRAINT Deckel_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Absperr_Drosselorgan DROP CONSTRAINT Absperr_Drosselorgan_Abwasserknoten_fkey;
ALTER TABLE vsadss2008_1_d.Absperr_Drosselorgan DROP CONSTRAINT Absperr_Drosselorgan_Steuerungszentrale_fkey;
ALTER TABLE vsadss2008_1_d.Messstelle DROP CONSTRAINT Messstelle_Betreiber_fkey;
ALTER TABLE vsadss2008_1_d.Messstelle DROP CONSTRAINT Messstelle_Abwasserreinigungsanlage_fkey;
ALTER TABLE vsadss2008_1_d.Messstelle DROP CONSTRAINT Messstelle_Abwasserbauwerk_fkey;
ALTER TABLE vsadss2008_1_d.Messstelle DROP CONSTRAINT Messstelle_Gewaesserabschnitt_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserknoten DROP CONSTRAINT Abwasserknoten_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserknoten DROP CONSTRAINT Abwasserknoten_Hydr_Geometrie_fkey;
ALTER TABLE vsadss2008_1_d.See DROP CONSTRAINT See_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.GewaesserAbsturz DROP CONSTRAINT GewaesserAbsturz_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.ElektrischeEinrichtung DROP CONSTRAINT ElektrischeEinrichtung_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Schleuse DROP CONSTRAINT Schleuse_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserbauwerk DROP CONSTRAINT Abwasserbauwerk_Eigentuemer_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserbauwerk DROP CONSTRAINT Abwasserbauwerk_Betreiber_fkey;
ALTER TABLE vsadss2008_1_d.Kanal DROP CONSTRAINT Kanal_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Einstiegshilfe DROP CONSTRAINT Einstiegshilfe_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Normschacht DROP CONSTRAINT Normschacht_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Hydr_GeomRelation DROP CONSTRAINT Hydr_GeomRelation_Hydr_Geometrie_fkey;
ALTER TABLE vsadss2008_1_d.ElektromechanischeAusruestung DROP CONSTRAINT ElektromechanischeAusruestung_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Gewaesserschutzbereich DROP CONSTRAINT Gewaesserschutzbereich_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Furt DROP CONSTRAINT Furt_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Entwaesserungssystem DROP CONSTRAINT Entwaesserungssystem_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserverband DROP CONSTRAINT Abwasserverband_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Gemeinde DROP CONSTRAINT Gemeinde_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Planungszone DROP CONSTRAINT Planungszone_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Messresultat DROP CONSTRAINT Messresultat_Messgeraet_fkey;
ALTER TABLE vsadss2008_1_d.Messresultat DROP CONSTRAINT Messresultat_Messreihe_fkey;
ALTER TABLE vsadss2008_1_d.Einzugsgebiet_Text DROP CONSTRAINT Einzugsgebiet_Text_EinzugsgebietRef_fkey;
ALTER TABLE vsadss2008_1_d.Vorflutereinlauf DROP CONSTRAINT Vorflutereinlauf_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Vorflutereinlauf DROP CONSTRAINT Vorflutereinlauf_Gewaessersektor_fkey;
ALTER TABLE vsadss2008_1_d.Ueberlauf DROP CONSTRAINT Ueberlauf_Abwasserknoten_fkey;
ALTER TABLE vsadss2008_1_d.Ueberlauf DROP CONSTRAINT Ueberlauf_UeberlaufNach_fkey;
ALTER TABLE vsadss2008_1_d.Ueberlauf DROP CONSTRAINT Ueberlauf_Ueberlaufcharakteristik_fkey;
ALTER TABLE vsadss2008_1_d.Ueberlauf DROP CONSTRAINT Ueberlauf_Steuerungszentrale_fkey;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_BASKET DROP CONSTRAINT T_ILI2DB_IMPORT_BASKET_import_fkey;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_IMPORT_BASKET DROP CONSTRAINT T_ILI2DB_IMPORT_BASKET_basket_fkey;
ALTER TABLE vsadss2008_1_d.MechanischeVorreinigung DROP CONSTRAINT MechanischeVorreinigung_Versickerungsanlage_fkey;
ALTER TABLE vsadss2008_1_d.MechanischeVorreinigung DROP CONSTRAINT MechanischeVorreinigung_Abwasserbauwerk_fkey;
ALTER TABLE vsadss2008_1_d.Wasserfassung DROP CONSTRAINT Wasserfassung_Grundwasserleiter_fkey;
ALTER TABLE vsadss2008_1_d.Wasserfassung DROP CONSTRAINT Wasserfassung_Oberflaechengewaesser_fkey;
ALTER TABLE vsadss2008_1_d.Gewaesserverbauung DROP CONSTRAINT Gewaesserverbauung_Gewaesserabschnitt_fkey;
ALTER TABLE vsadss2008_1_d.Kanton DROP CONSTRAINT Kanton_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Messstelle_Hierarchie DROP CONSTRAINT Messstelle_Hierarchie_Messstelle_fkey;
ALTER TABLE vsadss2008_1_d.Messstelle_Hierarchie DROP CONSTRAINT Messstelle_Hierarchie_Referenzstelle_fkey;
ALTER TABLE vsadss2008_1_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_Abwassernetzelement_fkey;
ALTER TABLE vsadss2008_1_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_Eigentuemer_fkey;
ALTER TABLE vsadss2008_1_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_Betreiber_fkey;
ALTER TABLE vsadss2008_1_d.EZG_PARAMETER_ALLG DROP CONSTRAINT EZG_PARAMETER_ALLG_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserbehandlung DROP CONSTRAINT Abwasserbehandlung_Abwasserreinigungsanlage_fkey;
ALTER TABLE vsadss2008_1_d.ARABauwerk DROP CONSTRAINT ARABauwerk_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Rohrprofil_Geometrie DROP CONSTRAINT Rohrprofil_Geometrie_Rohrprofil_fkey;
ALTER TABLE vsadss2008_1_d.Haltungspunkt DROP CONSTRAINT Haltungspunkt_Abwassernetzelement_fkey;
ALTER TABLE vsadss2008_1_d.Geschiebesperre DROP CONSTRAINT Geschiebesperre_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Versickerungsbereich DROP CONSTRAINT Versickerungsbereich_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Schlammbehandlung DROP CONSTRAINT Schlammbehandlung_Abwasserreinigungsanlage_fkey;
ALTER TABLE vsadss2008_1_d.Fischpass DROP CONSTRAINT Fischpass_Gewaesserverbauung_fkey;
ALTER TABLE vsadss2008_1_d.Organisation_Hierarchie DROP CONSTRAINT Organisation_Hierarchie_Organisation_fkey;
ALTER TABLE vsadss2008_1_d.Organisation_Hierarchie DROP CONSTRAINT Organisation_Hierarchie_Teil_von_fkey;
ALTER TABLE vsadss2008_1_d.T_ILI2DB_IMPORT DROP CONSTRAINT T_ILI2DB_IMPORT_dataset_fkey;
ALTER TABLE vsadss2008_1_d.Gewaessersohle DROP CONSTRAINT Gewaessersohle_Gewaesserabschnitt_fkey;
ALTER TABLE vsadss2008_1_d.ARAEnergienutzung DROP CONSTRAINT ARAEnergienutzung_Abwasserreinigungsanlage_fkey;
ALTER TABLE vsadss2008_1_d.Unfall DROP CONSTRAINT Unfall_Gefahrenquelle_fkey;
ALTER TABLE vsadss2008_1_d.Retentionskoerper DROP CONSTRAINT Retentionskoerper_Versickerungsanlage_fkey;
ALTER TABLE vsadss2008_1_d.Messreihe DROP CONSTRAINT Messreihe_Messstelle_fkey;
ALTER TABLE vsadss2008_1_d.Oberflaechenabflussparameter DROP CONSTRAINT Oberflaechenabflussparameter_Einzugsgebiet_fkey;
ALTER TABLE vsadss2008_1_d.Durchlass DROP CONSTRAINT Durchlass_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Fliessgewaesser DROP CONSTRAINT Fliessgewaesser_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Erhaltungsereignis DROP CONSTRAINT Erhaltungsereignis_Abwasserbauwerk_fkey;
ALTER TABLE vsadss2008_1_d.Streichwehr DROP CONSTRAINT Streichwehr_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.HQ_Relation DROP CONSTRAINT HQ_Relation_Ueberlaufcharakteristik_fkey;
ALTER TABLE vsadss2008_1_d.Gewaesserabschnitt DROP CONSTRAINT Gewaesserabschnitt_Fliessgewaesser_fkey;
ALTER TABLE vsadss2008_1_d.FoerderAggregat DROP CONSTRAINT FoerderAggregat_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Badestelle DROP CONSTRAINT Badestelle_Oberflaechengewaesser_fkey;
ALTER TABLE vsadss2008_1_d.Abwassernetzelement DROP CONSTRAINT Abwassernetzelement_Abwasserbauwerk_fkey;
ALTER TABLE vsadss2008_1_d.Haltung DROP CONSTRAINT Haltung_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Haltung DROP CONSTRAINT Haltung_vonHaltungspunkt_fkey;
ALTER TABLE vsadss2008_1_d.Haltung DROP CONSTRAINT Haltung_nachHaltungspunkt_fkey;
ALTER TABLE vsadss2008_1_d.Haltung DROP CONSTRAINT Haltung_Rohrprofil_fkey;
ALTER TABLE vsadss2008_1_d.Gewaessersektor DROP CONSTRAINT Gewaessersektor_Oberflaechengewaesser_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserbauwerk_Text DROP CONSTRAINT Abwasserbauwerk_Text_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2008_1_d.Einzugsgebiet DROP CONSTRAINT Einzugsgebiet_Abwassernetzelement_fkey;
ALTER TABLE vsadss2008_1_d.Bankett DROP CONSTRAINT Bankett_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie DROP CONSTRAINT Gewaessersektor_Hierarchie_Gewaessersektor_fkey;
ALTER TABLE vsadss2008_1_d.Gewaessersektor_Hierarchie DROP CONSTRAINT Gewaessersektor_Hierarchie_VorherigerSektor_fkey;
ALTER TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk DROP CONSTRAINT Erhaltungsereignis_Abwasserbauwerk_Erhaltungsereignis_fkey;
ALTER TABLE vsadss2008_1_d.Erhaltungsereignis_Abwasserbauwerk DROP CONSTRAINT Erhaltungsereignis_Abwasserbauwerk_Abwasserbauwerk_fkey;
ALTER TABLE vsadss2008_1_d.Grundwasserschutzareal DROP CONSTRAINT Grundwasserschutzareal_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Privat DROP CONSTRAINT Privat_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.BauwerksTeil DROP CONSTRAINT BauwerksTeil_Abwasserbauwerk_fkey;
ALTER TABLE vsadss2008_1_d.EZG_PARAMETER_MOUSE1 DROP CONSTRAINT EZG_PARAMETER_MOUSE1_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Gebaeude DROP CONSTRAINT Gebaeude_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Sohlrampe DROP CONSTRAINT Sohlrampe_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Spezialbauwerk DROP CONSTRAINT Spezialbauwerk_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Grundwasserschutzzone DROP CONSTRAINT Grundwasserschutzzone_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Abwasserreinigungsanlage DROP CONSTRAINT Abwasserreinigungsanlage_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Stoff DROP CONSTRAINT Stoff_Gefahrenquelle_fkey;
ALTER TABLE vsadss2008_1_d.Trockenwetterfallrohr DROP CONSTRAINT Trockenwetterfallrohr_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Reservoir DROP CONSTRAINT Reservoir_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Versickerungsanlage DROP CONSTRAINT Versickerungsanlage_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Versickerungsanlage DROP CONSTRAINT Versickerungsanlage_Grundwasserleiter_fkey;
ALTER TABLE vsadss2008_1_d.Haltung_Text DROP CONSTRAINT Haltung_Text_HaltungRef_fkey;
ALTER TABLE vsadss2008_1_d.Brunnen DROP CONSTRAINT Brunnen_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Trockenwetterrinne DROP CONSTRAINT Trockenwetterrinne_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.GewaesserWehr DROP CONSTRAINT GewaesserWehr_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Einzelflaeche DROP CONSTRAINT Einzelflaeche_Superclass_fkey;
ALTER TABLE vsadss2008_1_d.Gefahrenquelle DROP CONSTRAINT Gefahrenquelle_Anschlussobjekt_fkey;
ALTER TABLE vsadss2008_1_d.Gefahrenquelle DROP CONSTRAINT Gefahrenquelle_Eigentuemer_fkey;
