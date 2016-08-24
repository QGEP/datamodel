-- DSS_2015.Siedlungsentwaesserung.Amt
DROP TABLE vsadss2015_2_d.Amt;
-- DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk_Text
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_Text;
DROP TABLE vsadss2015_2_d.Erhaltungsereignis_Status;
DROP TABLE vsadss2015_2_d.T_ILI2DB_DATASET;
DROP TABLE vsadss2015_2_d.Feststoffrueckhalt_Art;
DROP TABLE vsadss2015_2_d.FoerderAggregat_Nutzungsart_Ist;
DROP TABLE vsadss2015_2_d.Deckel_Schlammeimer;
-- DSS_2015.Siedlungsentwaesserung.Abwasserverband
DROP TABLE vsadss2015_2_d.Abwasserverband;
-- DSS_2015.Siedlungsentwaesserung.Haltung
DROP TABLE vsadss2015_2_d.Haltung;
SELECT DropGeometryColumn('vsadss2015_2_d','haltung','verlauf');
-- DSS_2015.Siedlungsentwaesserung.Gewaessersektor
DROP TABLE vsadss2015_2_d.Gewaessersektor;
SELECT DropGeometryColumn('vsadss2015_2_d','gewaessersektor','verlauf');
DROP TABLE vsadss2015_2_d.Normschacht_Oberflaechenzulauf;
-- DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk
DROP TABLE vsadss2015_2_d.Abwasserbauwerk;
SELECT DropGeometryColumn('vsadss2015_2_d','abwasserbauwerk','detailgeometrie');
-- DSS_2015.Siedlungsentwaesserung.Bankett
DROP TABLE vsadss2015_2_d.Bankett;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Versickerung_Ist;
DROP TABLE vsadss2015_2_d.T_ILI2DB_BASKET;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Entwaesserungssystem_geplant;
-- DSS_2015.Siedlungsentwaesserung.GewaesserWehr
DROP TABLE vsadss2015_2_d.GewaesserWehr;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Notueberlauf;
DROP TABLE vsadss2015_2_d.Hydr_Kennwerte_Pumpenregime;
DROP TABLE vsadss2015_2_d.Gewaessersohle_Verbauungsart;
DROP TABLE vsadss2015_2_d.Wasserfassung_Art;
-- DSS_2015.Siedlungsentwaesserung.Einzelflaeche
DROP TABLE vsadss2015_2_d.Einzelflaeche;
SELECT DropGeometryColumn('vsadss2015_2_d','einzelflaeche','perimeter');
DROP TABLE vsadss2015_2_d.Ufer_Seite;
-- DSS_2015.Siedlungsentwaesserung.Leapingwehr
DROP TABLE vsadss2015_2_d.Leapingwehr;
DROP TABLE vsadss2015_2_d.Einleitstelle_Relevanz;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Retention_Ist;
-- DSS_2015.Siedlungsentwaesserung.Entwaesserungssystem
DROP TABLE vsadss2015_2_d.Entwaesserungssystem;
SELECT DropGeometryColumn('vsadss2015_2_d','entwaesserungssystem','perimeter');
-- DSS_2015.Siedlungsentwaesserung.Streichwehr
DROP TABLE vsadss2015_2_d.Streichwehr;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Tiefenvariabilitaet;
DROP TABLE vsadss2015_2_d.Absperr_Drosselorgan_Antrieb;
DROP TABLE vsadss2015_2_d.Haltung_Lagebestimmung;
DROP TABLE vsadss2015_2_d.Messstelle_Staukoerper;
DROP TABLE vsadss2015_2_d.T_ILI2DB_CLASSNAME;
DROP TABLE vsadss2015_2_d.Haltung_Material;
-- Base.SymbolPos
DROP TABLE vsadss2015_2_d.SymbolPos;
SELECT DropGeometryColumn('vsadss2015_2_d','symbolpos','symbolpos');
DROP TABLE vsadss2015_2_d.Deckel_Lagegenauigkeit;
DROP TABLE vsadss2015_2_d.Ueberlauf_Signaluebermittlung;
-- DSS_2015.Siedlungsentwaesserung.Abwasserbehandlung
DROP TABLE vsadss2015_2_d.Abwasserbehandlung;
-- DSS_2015.Siedlungsentwaesserung.Gewaessersohle
DROP TABLE vsadss2015_2_d.Gewaessersohle;
DROP TABLE vsadss2015_2_d.Absperr_Drosselorgan_Signaluebermittlung;
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_BaulicherZustand;
DROP TABLE vsadss2015_2_d.Haltungspunkt_Hoehengenauigkeit;
-- DSS_2015.Siedlungsentwaesserung.Fischpass
DROP TABLE vsadss2015_2_d.Fischpass;
-- DSS_2015.Siedlungsentwaesserung.Reservoir
DROP TABLE vsadss2015_2_d.Reservoir;
SELECT DropGeometryColumn('vsadss2015_2_d','reservoir','lage');
-- DSS_2015.Siedlungsentwaesserung.Messreihe
DROP TABLE vsadss2015_2_d.Messreihe;
DROP TABLE vsadss2015_2_d.Bankett_Art;
-- DSS_2015.Siedlungsentwaesserung.Organisation_Teil_vonAssoc
DROP TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc;
-- DSS_2015.Siedlungsentwaesserung.Messstelle
DROP TABLE vsadss2015_2_d.Messstelle;
SELECT DropGeometryColumn('vsadss2015_2_d','messstelle','lage');
DROP TABLE vsadss2015_2_d.Leapingwehr_Oeffnungsform;
-- DSS_2015.Siedlungsentwaesserung.Beckenreinigung
DROP TABLE vsadss2015_2_d.Beckenreinigung;
DROP TABLE vsadss2015_2_d.Deckel_Deckelform;
DROP TABLE vsadss2015_2_d.Deckel_Verschluss;
DROP TABLE vsadss2015_2_d.Erhaltungsereignis_Art;
DROP TABLE vsadss2015_2_d.GewaesserAbsturz_Material;
-- DSS_2015.Siedlungsentwaesserung.Normschacht
DROP TABLE vsadss2015_2_d.Normschacht;
DROP TABLE vsadss2015_2_d.Sohlrampe_Befestigung;
-- DSS_2015.Siedlungsentwaesserung.Kanton
DROP TABLE vsadss2015_2_d.Kanton;
SELECT DropGeometryColumn('vsadss2015_2_d','kanton','perimeter');
-- DSS_2015.Siedlungsentwaesserung.Organisation
DROP TABLE vsadss2015_2_d.Organisation;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Abflussregime;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Versickerungswasser;
-- DSS_2015.Siedlungsentwaesserung.Trockenwetterrinne
DROP TABLE vsadss2015_2_d.Trockenwetterrinne;
-- DSS_2015.Siedlungsentwaesserung.Steuerungszentrale
DROP TABLE vsadss2015_2_d.Steuerungszentrale;
SELECT DropGeometryColumn('vsadss2015_2_d','steuerungszentrale','lage');
-- DSS_2015.Siedlungsentwaesserung.Retentionskoerper
DROP TABLE vsadss2015_2_d.Retentionskoerper;
-- DSS_2015.Siedlungsentwaesserung.Einzugsgebiet
DROP TABLE vsadss2015_2_d.Einzugsgebiet;
SELECT DropGeometryColumn('vsadss2015_2_d','einzugsgebiet','perimeter');
-- DSS_2015.Siedlungsentwaesserung.Messresultat
DROP TABLE vsadss2015_2_d.Messresultat;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Breitenvariabilitaet;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Linienfuehrung;
-- DSS_2015.Siedlungsentwaesserung.Zone
DROP TABLE vsadss2015_2_d.Zone;
-- DSS_2015.Siedlungsentwaesserung.Gewaesserschutzbereich
DROP TABLE vsadss2015_2_d.Gewaesserschutzbereich;
SELECT DropGeometryColumn('vsadss2015_2_d','gewaesserschutzbereich','perimeter');
DROP TABLE vsadss2015_2_d.Kanal_Verbindungsart;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Direkteinleitung_in_Gewaesser_geplant;
DROP TABLE vsadss2015_2_d.ElektromechanischeAusruestung_Art;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Hoehenstufe;
-- DSS_2015.Siedlungsentwaesserung.Oberflaechengewaesser
DROP TABLE vsadss2015_2_d.Oberflaechengewaesser;
-- DSS_2015.Siedlungsentwaesserung.Ueberlaufcharakteristik
DROP TABLE vsadss2015_2_d.Ueberlaufcharakteristik;
-- DSS_2015.Siedlungsentwaesserung.Trockenwetterfallrohr
DROP TABLE vsadss2015_2_d.Trockenwetterfallrohr;
DROP TABLE vsadss2015_2_d.Spezialbauwerk_Regenbecken_Anordnung;
DROP TABLE vsadss2015_2_d.Statuswerte;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Makrophytenbewuchs;
DROP TABLE vsadss2015_2_d.Kanal_FunktionHydraulisch;
DROP TABLE vsadss2015_2_d.T_ILI2DB_IMPORT;
DROP TABLE vsadss2015_2_d.Fliessgewaesser_Art;
-- DSS_2015.Siedlungsentwaesserung.Schlammbehandlung
DROP TABLE vsadss2015_2_d.Schlammbehandlung;
DROP TABLE vsadss2015_2_d.Deckel_Entlueftung;
DROP TABLE vsadss2015_2_d.Versickerungsbereich_Versickerungsmoeglichkeit;
-- DSS_2015.Siedlungsentwaesserung.Gemeinde
DROP TABLE vsadss2015_2_d.Gemeinde;
SELECT DropGeometryColumn('vsadss2015_2_d','gemeinde','perimeter');
-- DSS_2015.Siedlungsentwaesserung.ElektromechanischeAusruestung
DROP TABLE vsadss2015_2_d.ElektromechanischeAusruestung;
DROP TABLE vsadss2015_2_d.Einzelflaeche_Befestigung;
-- DSS_2015.Siedlungsentwaesserung.Ufer
DROP TABLE vsadss2015_2_d.Ufer;
-- DSS_2015.Siedlungsentwaesserung.Anschlussobjekt
DROP TABLE vsadss2015_2_d.Anschlussobjekt;
-- DSS_2015.Siedlungsentwaesserung.Feststoffrueckhalt
DROP TABLE vsadss2015_2_d.Feststoffrueckhalt;
-- DSS_2015.Siedlungsentwaesserung.Kanal
DROP TABLE vsadss2015_2_d.Kanal;
DROP TABLE vsadss2015_2_d.Deckel_Material;
-- DSS_2015.Siedlungsentwaesserung.Stoff
DROP TABLE vsadss2015_2_d.Stoff;
DROP TABLE vsadss2015_2_d.Ufer_Uferbereich;
-- DSS_2015.Siedlungsentwaesserung.Hydr_Geometrie
DROP TABLE vsadss2015_2_d.Hydr_Geometrie;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Algenbewuchs;
-- DSS_2015.Siedlungsentwaesserung.Messstelle_ReferenzstelleAssoc
DROP TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc;
DROP TABLE vsadss2015_2_d.Normschacht_Funktion;
DROP TABLE vsadss2015_2_d.Absperr_Drosselorgan_Art;
-- DSS_2015.Siedlungsentwaesserung.Abwasserknoten
DROP TABLE vsadss2015_2_d.Abwasserknoten;
SELECT DropGeometryColumn('vsadss2015_2_d','abwasserknoten','lage');
-- DSS_2015.Siedlungsentwaesserung.Rohrprofil
DROP TABLE vsadss2015_2_d.Rohrprofil;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Wasserdichtheit;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Wasserhaerte;
DROP TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_OBJECT;
-- DSS_2015.Siedlungsentwaesserung.Messgeraet
DROP TABLE vsadss2015_2_d.Messgeraet;
DROP TABLE vsadss2015_2_d.Beckenreinigung_Art;
DROP TABLE vsadss2015_2_d.Ufer_Verbauungsgrad;
DROP TABLE vsadss2015_2_d.T_ILI2DB_ATTRNAME;
DROP TABLE vsadss2015_2_d.ElektrischeEinrichtung_Art;
DROP TABLE vsadss2015_2_d.Absperr_Drosselorgan_Steuerung;
DROP TABLE vsadss2015_2_d.BauwerksTeil_Instandstellung;
-- DSS_2015.Siedlungsentwaesserung.Grundwasserleiter
DROP TABLE vsadss2015_2_d.Grundwasserleiter;
SELECT DropGeometryColumn('vsadss2015_2_d','grundwasserleiter','perimeter');
DROP TABLE vsadss2015_2_d.Normschacht_Material;
-- DSS_2015.Siedlungsentwaesserung.Furt
DROP TABLE vsadss2015_2_d.Furt;
DROP TABLE vsadss2015_2_d.Ueberlauf_Funktion;
DROP TABLE vsadss2015_2_d.Retentionskoerper_Art;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Saugwagen;
DROP TABLE vsadss2015_2_d.Spezialbauwerk_Notueberlauf;
-- SIA405_Base.SIA405_TextPos
DROP TABLE vsadss2015_2_d.SIA405_TextPos;
DROP TABLE vsadss2015_2_d.FoerderAggregat_Bauart;
-- DSS_2015.Siedlungsentwaesserung.ARABauwerk
DROP TABLE vsadss2015_2_d.ARABauwerk;
-- DSS_2015.Siedlungsentwaesserung.Schleuse
DROP TABLE vsadss2015_2_d.Schleuse;
-- DSS_2015.Siedlungsentwaesserung.EZG_PARAMETER_ALLG
DROP TABLE vsadss2015_2_d.EZG_PARAMETER_ALLG;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Direkteinleitung_in_Gewaesser_Ist;
-- DSS_2015.Siedlungsentwaesserung.Einleitstelle
DROP TABLE vsadss2015_2_d.Einleitstelle;
-- DSS_2015.Siedlungsentwaesserung.Fliessgewaesser
DROP TABLE vsadss2015_2_d.Fliessgewaesser;
-- DSS_2015.Siedlungsentwaesserung.Brunnen
DROP TABLE vsadss2015_2_d.Brunnen;
SELECT DropGeometryColumn('vsadss2015_2_d','brunnen','lage');
-- DSS_2015.Siedlungsentwaesserung.MUTATION
DROP TABLE vsadss2015_2_d.MUTATION;
DROP TABLE vsadss2015_2_d.Trockenwetterrinne_Material;
DROP TABLE vsadss2015_2_d.Einzelflaeche_Funktion;
DROP TABLE vsadss2015_2_d.T_ILI2DB_SETTINGS;
-- DSS_2015.Siedlungsentwaesserung.ARAEnergienutzung
DROP TABLE vsadss2015_2_d.ARAEnergienutzung;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Entwaesserungssystem_Ist;
DROP TABLE vsadss2015_2_d.T_ILI2DB_INHERITANCE;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Nutzung;
DROP TABLE vsadss2015_2_d.Kanal_Nutzungsart_geplant;
DROP TABLE vsadss2015_2_d.Messgeraet_Art;
DROP TABLE vsadss2015_2_d.Ueberlaufcharakteristik_Kennlinie_digital;
-- Base.TextPos
DROP TABLE vsadss2015_2_d.TextPos;
SELECT DropGeometryColumn('vsadss2015_2_d','textpos','textpos');
DROP TABLE vsadss2015_2_d.Hydr_Kennwerte_Springt_an;
-- DSS_2015.Siedlungsentwaesserung.MechanischeVorreinigung
DROP TABLE vsadss2015_2_d.MechanischeVorreinigung;
-- DSS_2015.Siedlungsentwaesserung.Haltungspunkt
DROP TABLE vsadss2015_2_d.Haltungspunkt;
SELECT DropGeometryColumn('vsadss2015_2_d','haltungspunkt','lage');
-- SIA405_Base.Metaattribute
DROP TABLE vsadss2015_2_d.Metaattribute;
DROP TABLE vsadss2015_2_d.Status;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Maengel;
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_Finanzierung;
DROP TABLE vsadss2015_2_d.Gewaessersektor_Art;
-- DSS_2015.Siedlungsentwaesserung.Rohrprofil_Geometrie
DROP TABLE vsadss2015_2_d.Rohrprofil_Geometrie;
DROP TABLE vsadss2015_2_d.ARABauwerk_Art;
-- DSS_2015.Siedlungsentwaesserung.Rueckstausicherung
DROP TABLE vsadss2015_2_d.Rueckstausicherung;
DROP TABLE vsadss2015_2_d.Rohrprofil_Profiltyp;
-- DSS_2015.Siedlungsentwaesserung.Einzugsgebiet_Text
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Text;
-- Base.BaseClass
DROP TABLE vsadss2015_2_d.BaseClass;
-- DSS_2015.Siedlungsentwaesserung.EZG_PARAMETER_MOUSE1
DROP TABLE vsadss2015_2_d.EZG_PARAMETER_MOUSE1;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Retention_geplant;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Gefaelle;
-- DSS_2015.Siedlungsentwaesserung.Privat
DROP TABLE vsadss2015_2_d.Privat;
DROP TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_BASKET;
-- DSS_2015.Siedlungsentwaesserung.ElektrischeEinrichtung
DROP TABLE vsadss2015_2_d.ElektrischeEinrichtung;
DROP TABLE vsadss2015_2_d.GewaesserAbsturz_Typ;
-- DSS_2015.Siedlungsentwaesserung.BauwerksTeil
DROP TABLE vsadss2015_2_d.BauwerksTeil;
DROP TABLE vsadss2015_2_d.Gewaesserschutzbereich_Art;
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_Sanierungsbedarf;
DROP TABLE vsadss2015_2_d.Plantyp;
DROP TABLE vsadss2015_2_d.Haltung_Reliner_Art;
-- DSS_2015.Siedlungsentwaesserung.Abwasserreinigungsanlage
DROP TABLE vsadss2015_2_d.Abwasserreinigungsanlage;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Totholz;
DROP TABLE vsadss2015_2_d.Kanal_Bettung_Umhuellung;
DROP TABLE vsadss2015_2_d.Ufer_Verbauungsart;
DROP TABLE vsadss2015_2_d.MechanischeVorreinigung_Art;
DROP TABLE vsadss2015_2_d.Ueberlauf_Verstellbarkeit;
DROP TABLE vsadss2015_2_d.Ueberlaufcharakteristik_Kennlinie_Typ;
DROP TABLE vsadss2015_2_d.Spezialbauwerk_Bypass;
-- DSS_2015.Siedlungsentwaesserung.Beckenentleerung
DROP TABLE vsadss2015_2_d.Beckenentleerung;
DROP TABLE vsadss2015_2_d.Einstiegshilfe_Art;
DROP TABLE vsadss2015_2_d.Kanal_Nutzungsart_Ist;
-- DSS_2015.Siedlungsentwaesserung.Spezialbauwerk
DROP TABLE vsadss2015_2_d.Spezialbauwerk;
DROP TABLE vsadss2015_2_d.Spezialbauwerk_Funktion;
-- DSS_2015.Siedlungsentwaesserung.Versickerungsanlage
DROP TABLE vsadss2015_2_d.Versickerungsanlage;
-- DSS_2015.Siedlungsentwaesserung.Unfall
DROP TABLE vsadss2015_2_d.Unfall;
SELECT DropGeometryColumn('vsadss2015_2_d','unfall','lage');
DROP TABLE vsadss2015_2_d.Haltung_Reliner_Bautechnik;
-- DSS_2015.Siedlungsentwaesserung.Absperr_Drosselorgan
DROP TABLE vsadss2015_2_d.Absperr_Drosselorgan;
DROP TABLE vsadss2015_2_d.Messreihe_Art;
-- DSS_2015.Siedlungsentwaesserung.Badestelle
DROP TABLE vsadss2015_2_d.Badestelle;
SELECT DropGeometryColumn('vsadss2015_2_d','badestelle','lage');
-- DSS_2015.Siedlungsentwaesserung.Grundwasserschutzzone
DROP TABLE vsadss2015_2_d.Grundwasserschutzzone;
SELECT DropGeometryColumn('vsadss2015_2_d','grundwasserschutzzone','perimeter');
DROP TABLE vsadss2015_2_d.FoerderAggregat_AufstellungAntrieb;
DROP TABLE vsadss2015_2_d.Ueberlauf_Antrieb;
DROP TABLE vsadss2015_2_d.Schlammbehandlung_Stabilisierung;
DROP TABLE vsadss2015_2_d.VALIGNMENT;
DROP TABLE vsadss2015_2_d.Hydr_Kennwerte_Foerderaggregat_Nutzungsart_Ist;
-- DSS_2015.Siedlungsentwaesserung.Haltung_Text
DROP TABLE vsadss2015_2_d.Haltung_Text;
DROP TABLE vsadss2015_2_d.Messresultat_Messart;
-- DSS_2015.Siedlungsentwaesserung.FoerderAggregat
DROP TABLE vsadss2015_2_d.FoerderAggregat;
DROP TABLE vsadss2015_2_d.FoerderAggregat_AufstellungFoerderaggregat;
-- DSS_2015.Siedlungsentwaesserung.Wasserfassung
DROP TABLE vsadss2015_2_d.Wasserfassung;
SELECT DropGeometryColumn('vsadss2015_2_d','wasserfassung','lage');
DROP TABLE vsadss2015_2_d.MUTATION_ART;
DROP TABLE vsadss2015_2_d.Streichwehr_Wehr_Art;
DROP TABLE vsadss2015_2_d.Einzugsgebiet_Versickerung_geplant;
-- DSS_2015.Siedlungsentwaesserung.Geschiebesperre
DROP TABLE vsadss2015_2_d.Geschiebesperre;
DROP TABLE vsadss2015_2_d.Haltung_Innenschutz;
DROP TABLE vsadss2015_2_d.Hydr_Kennwerte_Status;
-- SIA405_Base.SIA405_BaseClass
DROP TABLE vsadss2015_2_d.SIA405_BaseClass;
-- DSS_2015.Siedlungsentwaesserung.Haltung_AlternativVerlauf
DROP TABLE vsadss2015_2_d.Haltung_AlternativVerlauf;
SELECT DropGeometryColumn('vsadss2015_2_d','haltung_alternativverlauf','verlauf');
DROP TABLE vsadss2015_2_d.T_ILI2DB_MODEL;
DROP TABLE vsadss2015_2_d.GewaesserWehr_Art;
-- DSS_2015.Siedlungsentwaesserung.Gewaesserabschnitt
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt;
SELECT DropGeometryColumn('vsadss2015_2_d','gewaesserabschnitt','bis');
SELECT DropGeometryColumn('vsadss2015_2_d','gewaesserabschnitt','von');
DROP TABLE vsadss2015_2_d.Abwasserbehandlung_Art;
DROP TABLE vsadss2015_2_d.Entwaesserungssystem_Art;
DROP TABLE vsadss2015_2_d.Grundwasserschutzzone_Art;
DROP TABLE vsadss2015_2_d.T_KEY_OBJECT;
-- DSS_2015.Siedlungsentwaesserung.Erhaltungsereignis_AbwasserbauwerkAssoc
DROP TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc;
-- DSS_2015.Siedlungsentwaesserung.Durchlass
DROP TABLE vsadss2015_2_d.Durchlass;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Oekom_Klassifizierung;
-- DSS_2015.Siedlungsentwaesserung.See
DROP TABLE vsadss2015_2_d.See;
SELECT DropGeometryColumn('vsadss2015_2_d','see','perimeter');
-- DSS_2015.Siedlungsentwaesserung.Abwasserbauwerk_Symbol
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol;
DROP TABLE vsadss2015_2_d.Ufer_Umlandnutzung;
-- DSS_2015.Siedlungsentwaesserung.GewaesserAbsturz
DROP TABLE vsadss2015_2_d.GewaesserAbsturz;
-- DSS_2015.Siedlungsentwaesserung.Gefahrenquelle
DROP TABLE vsadss2015_2_d.Gefahrenquelle;
SELECT DropGeometryColumn('vsadss2015_2_d','gefahrenquelle','lage');
-- SIA405_Base.SIA405_SymbolPos
DROP TABLE vsadss2015_2_d.SIA405_SymbolPos;
DROP TABLE vsadss2015_2_d.Rueckstausicherung_Art;
DROP TABLE vsadss2015_2_d.Gewaessersohle_Verbauungsgrad;
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_WBW_Bauart;
DROP TABLE vsadss2015_2_d.Haltungspunkt_Auslaufform;
DROP TABLE vsadss2015_2_d.Haltung_Reliner_Material;
-- DSS_2015.Siedlungsentwaesserung.Einstiegshilfe
DROP TABLE vsadss2015_2_d.Einstiegshilfe;
DROP TABLE vsadss2015_2_d.Abwasserbauwerk_Zugaenglichkeit;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Art;
-- DSS_2015.Siedlungsentwaesserung.Versickerungsbereich
DROP TABLE vsadss2015_2_d.Versickerungsbereich;
SELECT DropGeometryColumn('vsadss2015_2_d','versickerungsbereich','perimeter');
-- DSS_2015.Siedlungsentwaesserung.Hydr_Kennwerte
DROP TABLE vsadss2015_2_d.Hydr_Kennwerte;
DROP TABLE vsadss2015_2_d.Hydr_Kennwerte_Hauptwehrart;
-- DSS_2015.Siedlungsentwaesserung.Abwassernetzelement
DROP TABLE vsadss2015_2_d.Abwassernetzelement;
DROP TABLE vsadss2015_2_d.Kanal_FunktionHierarchisch;
-- DSS_2015.Siedlungsentwaesserung.Planungszone
DROP TABLE vsadss2015_2_d.Planungszone;
SELECT DropGeometryColumn('vsadss2015_2_d','planungszone','perimeter');
-- DSS_2015.Siedlungsentwaesserung.Sohlrampe
DROP TABLE vsadss2015_2_d.Sohlrampe;
DROP TABLE vsadss2015_2_d.Planungszone_Art;
-- DSS_2015.Siedlungsentwaesserung.Hydr_GeomRelation
DROP TABLE vsadss2015_2_d.Hydr_GeomRelation;
DROP TABLE vsadss2015_2_d.Messstelle_Zweck;
DROP TABLE vsadss2015_2_d.Versickerungsanlage_Beschriftung;
-- DSS_2015.Siedlungsentwaesserung.Gebaeude
DROP TABLE vsadss2015_2_d.Gebaeude;
SELECT DropGeometryColumn('vsadss2015_2_d','gebaeude','perimeter');
SELECT DropGeometryColumn('vsadss2015_2_d','gebaeude','referenzpunkt');
DROP TABLE vsadss2015_2_d.Gewaessersohle_Art;
-- DSS_2015.Siedlungsentwaesserung.Ueberlauf
DROP TABLE vsadss2015_2_d.Ueberlauf;
DROP TABLE vsadss2015_2_d.Streichwehr_Ueberfallkante;
-- DSS_2015.Siedlungsentwaesserung.Erhaltungsereignis
DROP TABLE vsadss2015_2_d.Erhaltungsereignis;
-- DSS_2015.Siedlungsentwaesserung.Gewaesserverbauung
DROP TABLE vsadss2015_2_d.Gewaesserverbauung;
SELECT DropGeometryColumn('vsadss2015_2_d','gewaesserverbauung','lage');
-- DSS_2015.Siedlungsentwaesserung.HQ_Relation
DROP TABLE vsadss2015_2_d.HQ_Relation;
DROP TABLE vsadss2015_2_d.Ufer_Vegetation;
DROP TABLE vsadss2015_2_d.Ueberlauf_Steuerung;
-- DSS_2015.Siedlungsentwaesserung.Deckel
DROP TABLE vsadss2015_2_d.Deckel;
SELECT DropGeometryColumn('vsadss2015_2_d','deckel','lage');
-- DSS_2015.Siedlungsentwaesserung.Oberflaechenabflussparameter
DROP TABLE vsadss2015_2_d.Oberflaechenabflussparameter;
DROP TABLE vsadss2015_2_d.Absperr_Drosselorgan_Verstellbarkeit;
DROP TABLE vsadss2015_2_d.HALIGNMENT;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Laengsprofil;
-- DSS_2015.Siedlungsentwaesserung.Grundwasserschutzareal
DROP TABLE vsadss2015_2_d.Grundwasserschutzareal;
SELECT DropGeometryColumn('vsadss2015_2_d','grundwasserschutzareal','perimeter');
DROP TABLE vsadss2015_2_d.Beckenentleerung_Art;
DROP TABLE vsadss2015_2_d.Gewaesserabschnitt_Art;
-- DSS_2015.Siedlungsentwaesserung.Genossenschaft_Korporation
DROP TABLE vsadss2015_2_d.Genossenschaft_Korporation;
ALTER TABLE vsadss2015_2_d.Amt DROP CONSTRAINT Amt_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Text DROP CONSTRAINT Abwasserbauwerk_Text_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Text DROP CONSTRAINT Abwasserbauwerk_Text_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserverband DROP CONSTRAINT Abwasserverband_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltung DROP CONSTRAINT Haltung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltung DROP CONSTRAINT Haltung_RohrprofilRef_fkey;
ALTER TABLE vsadss2015_2_d.Haltung DROP CONSTRAINT Haltung_nachHaltungspunktRef_fkey;
ALTER TABLE vsadss2015_2_d.Haltung DROP CONSTRAINT Haltung_vonHaltungspunktRef_fkey;
ALTER TABLE vsadss2015_2_d.Gewaessersektor DROP CONSTRAINT Gewaessersektor_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gewaessersektor DROP CONSTRAINT Gewaessersektor_OberflaechengewaesserRef_fkey;
ALTER TABLE vsadss2015_2_d.Gewaessersektor DROP CONSTRAINT Gewaessersektor_VorherigerSektorRef_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk DROP CONSTRAINT Abwasserbauwerk_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk DROP CONSTRAINT Abwasserbauwerk_BetreiberRef_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk DROP CONSTRAINT Abwasserbauwerk_EigentuemerRef_fkey;
ALTER TABLE vsadss2015_2_d.Bankett DROP CONSTRAINT Bankett_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_BASKET DROP CONSTRAINT T_ILI2DB_BASKET_dataset_fkey;
ALTER TABLE vsadss2015_2_d.GewaesserWehr DROP CONSTRAINT GewaesserWehr_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Einzelflaeche DROP CONSTRAINT Einzelflaeche_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Leapingwehr DROP CONSTRAINT Leapingwehr_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Entwaesserungssystem DROP CONSTRAINT Entwaesserungssystem_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Streichwehr DROP CONSTRAINT Streichwehr_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.SymbolPos DROP CONSTRAINT SymbolPos_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbehandlung DROP CONSTRAINT Abwasserbehandlung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbehandlung DROP CONSTRAINT Abwasserbehandlung_AbwasserreinigungsanlageRef_fkey;
ALTER TABLE vsadss2015_2_d.Gewaessersohle DROP CONSTRAINT Gewaessersohle_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gewaessersohle DROP CONSTRAINT Gewaessersohle_GewaesserabschnittRef_fkey;
ALTER TABLE vsadss2015_2_d.Fischpass DROP CONSTRAINT Fischpass_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Fischpass DROP CONSTRAINT Fischpass_GewaesserverbauungRef_fkey;
ALTER TABLE vsadss2015_2_d.Reservoir DROP CONSTRAINT Reservoir_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messreihe DROP CONSTRAINT Messreihe_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messreihe DROP CONSTRAINT Messreihe_MessstelleRef_fkey;
ALTER TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc DROP CONSTRAINT Organisation_Teil_vonAssoc_Teil_vonRef_fkey;
ALTER TABLE vsadss2015_2_d.Organisation_Teil_vonAssoc DROP CONSTRAINT Organisation_Teil_vonAssoc_Organisation_Teil_vonAssocRef_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle DROP CONSTRAINT Messstelle_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle DROP CONSTRAINT Messstelle_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle DROP CONSTRAINT Messstelle_AbwasserreinigungsanlageRef_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle DROP CONSTRAINT Messstelle_BetreiberRef_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle DROP CONSTRAINT Messstelle_GewaesserabschnittRef_fkey;
ALTER TABLE vsadss2015_2_d.Beckenreinigung DROP CONSTRAINT Beckenreinigung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Normschacht DROP CONSTRAINT Normschacht_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Kanton DROP CONSTRAINT Kanton_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Organisation DROP CONSTRAINT Organisation_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Trockenwetterrinne DROP CONSTRAINT Trockenwetterrinne_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Steuerungszentrale DROP CONSTRAINT Steuerungszentrale_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Retentionskoerper DROP CONSTRAINT Retentionskoerper_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Retentionskoerper DROP CONSTRAINT Retentionskoerper_VersickerungsanlageRef_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet DROP CONSTRAINT Einzugsgebiet_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet DROP CONSTRAINT Einzugsgebiet_Abwassernetzelement_RW_IstRef_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet DROP CONSTRAINT Einzugsgebiet_Abwassernetzelement_RW_geplantRef_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet DROP CONSTRAINT Einzugsgebiet_Abwassernetzelement_SW_IstRef_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet DROP CONSTRAINT Einzugsgebiet_Abwassernetzelement_SW_geplantRef_fkey;
ALTER TABLE vsadss2015_2_d.Messresultat DROP CONSTRAINT Messresultat_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messresultat DROP CONSTRAINT Messresultat_MessgeraetRef_fkey;
ALTER TABLE vsadss2015_2_d.Messresultat DROP CONSTRAINT Messresultat_MessreiheRef_fkey;
ALTER TABLE vsadss2015_2_d.Zone DROP CONSTRAINT Zone_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gewaesserschutzbereich DROP CONSTRAINT Gewaesserschutzbereich_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Oberflaechengewaesser DROP CONSTRAINT Oberflaechengewaesser_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Ueberlaufcharakteristik DROP CONSTRAINT Ueberlaufcharakteristik_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Trockenwetterfallrohr DROP CONSTRAINT Trockenwetterfallrohr_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_IMPORT DROP CONSTRAINT T_ILI2DB_IMPORT_dataset_fkey;
ALTER TABLE vsadss2015_2_d.Schlammbehandlung DROP CONSTRAINT Schlammbehandlung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Schlammbehandlung DROP CONSTRAINT Schlammbehandlung_AbwasserreinigungsanlageRef_fkey;
ALTER TABLE vsadss2015_2_d.Gemeinde DROP CONSTRAINT Gemeinde_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.ElektromechanischeAusruestung DROP CONSTRAINT ElektromechanischeAusruestung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Ufer DROP CONSTRAINT Ufer_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Ufer DROP CONSTRAINT Ufer_GewaesserabschnittRef_fkey;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_AbwassernetzelementRef_fkey;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_BetreiberRef_fkey;
ALTER TABLE vsadss2015_2_d.Anschlussobjekt DROP CONSTRAINT Anschlussobjekt_EigentuemerRef_fkey;
ALTER TABLE vsadss2015_2_d.Feststoffrueckhalt DROP CONSTRAINT Feststoffrueckhalt_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Kanal DROP CONSTRAINT Kanal_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Stoff DROP CONSTRAINT Stoff_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Stoff DROP CONSTRAINT Stoff_GefahrenquelleRef_fkey;
ALTER TABLE vsadss2015_2_d.Hydr_Geometrie DROP CONSTRAINT Hydr_Geometrie_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc DROP CONSTRAINT Messstelle_ReferenzstelleAssoc_ReferenzstelleRef_fkey;
ALTER TABLE vsadss2015_2_d.Messstelle_ReferenzstelleAssoc DROP CONSTRAINT Messstelle_ReferenzstelleAssoc_Messstelle_ReferenzstelleAssocRef_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserknoten DROP CONSTRAINT Abwasserknoten_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserknoten DROP CONSTRAINT Abwasserknoten_Hydr_GeometrieRef_fkey;
ALTER TABLE vsadss2015_2_d.Rohrprofil DROP CONSTRAINT Rohrprofil_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messgeraet DROP CONSTRAINT Messgeraet_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Messgeraet DROP CONSTRAINT Messgeraet_MessstelleRef_fkey;
ALTER TABLE vsadss2015_2_d.Grundwasserleiter DROP CONSTRAINT Grundwasserleiter_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Furt DROP CONSTRAINT Furt_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.SIA405_TextPos DROP CONSTRAINT SIA405_TextPos_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.ARABauwerk DROP CONSTRAINT ARABauwerk_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Schleuse DROP CONSTRAINT Schleuse_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.EZG_PARAMETER_ALLG DROP CONSTRAINT EZG_PARAMETER_ALLG_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Einleitstelle DROP CONSTRAINT Einleitstelle_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Einleitstelle DROP CONSTRAINT Einleitstelle_GewaessersektorRef_fkey;
ALTER TABLE vsadss2015_2_d.Fliessgewaesser DROP CONSTRAINT Fliessgewaesser_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Brunnen DROP CONSTRAINT Brunnen_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.MUTATION DROP CONSTRAINT MUTATION_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.ARAEnergienutzung DROP CONSTRAINT ARAEnergienutzung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.ARAEnergienutzung DROP CONSTRAINT ARAEnergienutzung_AbwasserreinigungsanlageRef_fkey;
ALTER TABLE vsadss2015_2_d.TextPos DROP CONSTRAINT TextPos_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.MechanischeVorreinigung DROP CONSTRAINT MechanischeVorreinigung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.MechanischeVorreinigung DROP CONSTRAINT MechanischeVorreinigung_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.MechanischeVorreinigung DROP CONSTRAINT MechanischeVorreinigung_VersickerungsanlageRef_fkey;
ALTER TABLE vsadss2015_2_d.Haltungspunkt DROP CONSTRAINT Haltungspunkt_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltungspunkt DROP CONSTRAINT Haltungspunkt_AbwassernetzelementRef_fkey;
ALTER TABLE vsadss2015_2_d.Metaattribute DROP CONSTRAINT Metaattribute_SIA405_Base_SIA405_BaseClass_Metaattribute_fkey;
ALTER TABLE vsadss2015_2_d.Rohrprofil_Geometrie DROP CONSTRAINT Rohrprofil_Geometrie_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Rohrprofil_Geometrie DROP CONSTRAINT Rohrprofil_Geometrie_RohrprofilRef_fkey;
ALTER TABLE vsadss2015_2_d.Rueckstausicherung DROP CONSTRAINT Rueckstausicherung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Rueckstausicherung DROP CONSTRAINT Rueckstausicherung_Absperr_DrosselorganRef_fkey;
ALTER TABLE vsadss2015_2_d.Rueckstausicherung DROP CONSTRAINT Rueckstausicherung_FoerderAggregatRef_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet_Text DROP CONSTRAINT Einzugsgebiet_Text_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Einzugsgebiet_Text DROP CONSTRAINT Einzugsgebiet_Text_EinzugsgebietRef_fkey;
ALTER TABLE vsadss2015_2_d.EZG_PARAMETER_MOUSE1 DROP CONSTRAINT EZG_PARAMETER_MOUSE1_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Privat DROP CONSTRAINT Privat_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_BASKET DROP CONSTRAINT T_ILI2DB_IMPORT_BASKET_import_fkey;
ALTER TABLE vsadss2015_2_d.T_ILI2DB_IMPORT_BASKET DROP CONSTRAINT T_ILI2DB_IMPORT_BASKET_basket_fkey;
ALTER TABLE vsadss2015_2_d.ElektrischeEinrichtung DROP CONSTRAINT ElektrischeEinrichtung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.BauwerksTeil DROP CONSTRAINT BauwerksTeil_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.BauwerksTeil DROP CONSTRAINT BauwerksTeil_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserreinigungsanlage DROP CONSTRAINT Abwasserreinigungsanlage_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Beckenentleerung DROP CONSTRAINT Beckenentleerung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Beckenentleerung DROP CONSTRAINT Beckenentleerung_Absperr_DrosselorganRef_fkey;
ALTER TABLE vsadss2015_2_d.Beckenentleerung DROP CONSTRAINT Beckenentleerung_UeberlaufRef_fkey;
ALTER TABLE vsadss2015_2_d.Spezialbauwerk DROP CONSTRAINT Spezialbauwerk_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Versickerungsanlage DROP CONSTRAINT Versickerungsanlage_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Versickerungsanlage DROP CONSTRAINT Versickerungsanlage_GrundwasserleiterRef_fkey;
ALTER TABLE vsadss2015_2_d.Unfall DROP CONSTRAINT Unfall_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Unfall DROP CONSTRAINT Unfall_GefahrenquelleRef_fkey;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan DROP CONSTRAINT Absperr_Drosselorgan_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan DROP CONSTRAINT Absperr_Drosselorgan_AbwasserknotenRef_fkey;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan DROP CONSTRAINT Absperr_Drosselorgan_SteuerungszentraleRef_fkey;
ALTER TABLE vsadss2015_2_d.Absperr_Drosselorgan DROP CONSTRAINT Absperr_Drosselorgan_UeberlaufRef_fkey;
ALTER TABLE vsadss2015_2_d.Badestelle DROP CONSTRAINT Badestelle_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Badestelle DROP CONSTRAINT Badestelle_OberflaechengewaesserRef_fkey;
ALTER TABLE vsadss2015_2_d.Grundwasserschutzzone DROP CONSTRAINT Grundwasserschutzzone_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltung_Text DROP CONSTRAINT Haltung_Text_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltung_Text DROP CONSTRAINT Haltung_Text_HaltungRef_fkey;
ALTER TABLE vsadss2015_2_d.FoerderAggregat DROP CONSTRAINT FoerderAggregat_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Wasserfassung DROP CONSTRAINT Wasserfassung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Wasserfassung DROP CONSTRAINT Wasserfassung_GrundwasserleiterRef_fkey;
ALTER TABLE vsadss2015_2_d.Wasserfassung DROP CONSTRAINT Wasserfassung_OberflaechengewaesserRef_fkey;
ALTER TABLE vsadss2015_2_d.Geschiebesperre DROP CONSTRAINT Geschiebesperre_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.SIA405_BaseClass DROP CONSTRAINT SIA405_BaseClass_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltung_AlternativVerlauf DROP CONSTRAINT Haltung_AlternativVerlauf_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Haltung_AlternativVerlauf DROP CONSTRAINT Haltung_AlternativVerlauf_HaltungRef_fkey;
ALTER TABLE vsadss2015_2_d.Gewaesserabschnitt DROP CONSTRAINT Gewaesserabschnitt_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gewaesserabschnitt DROP CONSTRAINT Gewaesserabschnitt_FliessgewaesserRef_fkey;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc DROP CONSTRAINT Erhaltungsereignis_AbwasserbauwerkAssoc_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis_AbwasserbauwerkAssoc DROP CONSTRAINT Erhaltungsereignis_AbwasserbauwerkAssoc_Erhaltungsereignis_AbwasserbauwerkAssocRef_fkey;
ALTER TABLE vsadss2015_2_d.Durchlass DROP CONSTRAINT Durchlass_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.See DROP CONSTRAINT See_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol DROP CONSTRAINT Abwasserbauwerk_Symbol_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwasserbauwerk_Symbol DROP CONSTRAINT Abwasserbauwerk_Symbol_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.GewaesserAbsturz DROP CONSTRAINT GewaesserAbsturz_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gefahrenquelle DROP CONSTRAINT Gefahrenquelle_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gefahrenquelle DROP CONSTRAINT Gefahrenquelle_AnschlussobjektRef_fkey;
ALTER TABLE vsadss2015_2_d.Gefahrenquelle DROP CONSTRAINT Gefahrenquelle_EigentuemerRef_fkey;
ALTER TABLE vsadss2015_2_d.SIA405_SymbolPos DROP CONSTRAINT SIA405_SymbolPos_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Einstiegshilfe DROP CONSTRAINT Einstiegshilfe_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Versickerungsbereich DROP CONSTRAINT Versickerungsbereich_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Hydr_Kennwerte DROP CONSTRAINT Hydr_Kennwerte_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Hydr_Kennwerte DROP CONSTRAINT Hydr_Kennwerte_AbwasserknotenRef_fkey;
ALTER TABLE vsadss2015_2_d.Hydr_Kennwerte DROP CONSTRAINT Hydr_Kennwerte_UeberlaufcharakteristikRef_fkey;
ALTER TABLE vsadss2015_2_d.Abwassernetzelement DROP CONSTRAINT Abwassernetzelement_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Abwassernetzelement DROP CONSTRAINT Abwassernetzelement_AbwasserbauwerkRef_fkey;
ALTER TABLE vsadss2015_2_d.Planungszone DROP CONSTRAINT Planungszone_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Sohlrampe DROP CONSTRAINT Sohlrampe_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Hydr_GeomRelation DROP CONSTRAINT Hydr_GeomRelation_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Hydr_GeomRelation DROP CONSTRAINT Hydr_GeomRelation_Hydr_GeometrieRef_fkey;
ALTER TABLE vsadss2015_2_d.Gebaeude DROP CONSTRAINT Gebaeude_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Ueberlauf DROP CONSTRAINT Ueberlauf_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Ueberlauf DROP CONSTRAINT Ueberlauf_AbwasserknotenRef_fkey;
ALTER TABLE vsadss2015_2_d.Ueberlauf DROP CONSTRAINT Ueberlauf_SteuerungszentraleRef_fkey;
ALTER TABLE vsadss2015_2_d.Ueberlauf DROP CONSTRAINT Ueberlauf_UeberlaufNachRef_fkey;
ALTER TABLE vsadss2015_2_d.Ueberlauf DROP CONSTRAINT Ueberlauf_UeberlaufcharakteristikRef_fkey;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis DROP CONSTRAINT Erhaltungsereignis_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Erhaltungsereignis DROP CONSTRAINT Erhaltungsereignis_Ausfuehrender_FirmaRef_fkey;
ALTER TABLE vsadss2015_2_d.Gewaesserverbauung DROP CONSTRAINT Gewaesserverbauung_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Gewaesserverbauung DROP CONSTRAINT Gewaesserverbauung_GewaesserabschnittRef_fkey;
ALTER TABLE vsadss2015_2_d.HQ_Relation DROP CONSTRAINT HQ_Relation_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.HQ_Relation DROP CONSTRAINT HQ_Relation_UeberlaufcharakteristikRef_fkey;
ALTER TABLE vsadss2015_2_d.Deckel DROP CONSTRAINT Deckel_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Oberflaechenabflussparameter DROP CONSTRAINT Oberflaechenabflussparameter_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Oberflaechenabflussparameter DROP CONSTRAINT Oberflaechenabflussparameter_EinzugsgebietRef_fkey;
ALTER TABLE vsadss2015_2_d.Grundwasserschutzareal DROP CONSTRAINT Grundwasserschutzareal_T_Id_fkey;
ALTER TABLE vsadss2015_2_d.Genossenschaft_Korporation DROP CONSTRAINT Genossenschaft_Korporation_T_Id_fkey;
