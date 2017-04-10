-- valid for ili2pg export SIA405_Abwasser_2014_2_d.ili
-- manually adapted 2.3.2015 Stefan Burckhardt - no guarantee
-- includes too many classes - just replaced 'DSS_2015.Siedlungsentwaesserung with 'SIA405_Abwasser.SIA405_Abwasser


-- else create yourself by importing valid dataset with your modell, then export this table 



-- PostgreSQL database dump
--

-- Dumped from database version 9.3.6
-- Dumped by pg_dump version 9.3.6
-- Started on 2016-01-21 20:16:17

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET client_encoding = 'UTF8';
-- SET standard_conforming_strings = on;
-- SET check_function_bodies = false;
-- SET client_min_messages = warning;

-- SET search_path = vsadss2015_2_d, pg_catalog;

--
-- TOC entry 6135 (class 0 OID 130335)
-- Dependencies: 436
-- Data for Name: sia405abwasser_2015_2_d.t_ili2db_classname; Type: TABLE DATA; Schema: vsadss2015_2_d; Owner: postgres
--

delete from sia405abwasser.t_ili2db_classname;

INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ElektrischeEinrichtung.Art', 'ElektrischeEinrichtung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Strickler', 'Strickler');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gefahrenquelle', 'Gefahrenquelle');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung.Innenschutz', 'Haltung_Innenschutz');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einstiegshilfe', 'Einstiegshilfe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan.Art', 'Absperr_Drosselorgan_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Organisation_Teil_vonAssoc', 'Organisation_Teil_vonAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlaufcharakteristik.Kennlinie_digital', 'Ueberlaufcharakteristik_Kennlinie_digital');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gebaeude', 'Gebaeude');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.BSB5', 'BSB5');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Oekom_Klassifizierung', 'Gewaesserabschnitt_Oekom_Klassifizierung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Geometrie', 'Hydr_Geometrie');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer.Verbauungsart', 'Ufer_Verbauungsart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Hoehenstufe', 'Gewaesserabschnitt_Hoehenstufe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rohrprofil', 'Rohrprofil');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet_Abwassernetzelement_RW_geplantAssoc', 'Einzugsgebiet_Abwassernetzelement_RW_geplantAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Schlammbehandlung_AbwasserreinigungsanlageAssoc', 'Schlammbehandlung_AbwasserreinigungsanlageAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.See', 'See');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.UID', 'UID');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Badestelle_OberflaechengewaesserAssoc', 'Badestelle_OberflaechengewaesserAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung.Reliner_Material', 'Haltung_Reliner_Material');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung.Reliner_Art', 'Haltung_Reliner_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gefahrenquelle_EigentuemerAssoc', 'Gefahrenquelle_EigentuemerAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Trockenwetterrinne.Material', 'Trockenwetterrinne_Material');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Leapingwehr', 'Leapingwehr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Linienfuehrung', 'Gewaesserabschnitt_Linienfuehrung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte.Status', 'Hydr_Kennwerte_Status');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.MechanischeVorreinigung.Art', 'MechanischeVorreinigung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf_UeberlaufNachAssoc', 'Ueberlauf_UeberlaufNachAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.Abmessung', 'Abmessung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle_AbwasserbauwerkAssoc', 'Messstelle_AbwasserbauwerkAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf', 'Ueberlauf');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersohle.Verbauungsgrad', 'Gewaessersohle_Verbauungsgrad');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Erhaltungsereignis_AbwasserbauwerkAssoc', 'Erhaltungsereignis_AbwasserbauwerkAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Direkteinleitung_in_Gewaesser_Ist', 'Einzugsgebiet_Direkteinleitung_in_Gewaesser_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung.Material', 'Haltung_Material');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gefaelle_Promille', 'Gefaelle_Promille');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Saugwagen', 'Versickerungsanlage_Saugwagen');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf_SteuerungszentraleAssoc', 'Ueberlauf_SteuerungszentraleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Trockenwetterfallrohr', 'Trockenwetterfallrohr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan.Verstellbarkeit', 'Absperr_Drosselorgan_Verstellbarkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.MechanischeVorreinigung_VersickerungsanlageAssoc', 'MechanischeVorreinigung_VersickerungsanlageAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.FoerderAggregat', 'FoerderAggregat');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk_TextAssoc', 'Abwasserbauwerk_TextAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Abflussregime', 'Gewaesserabschnitt_Abflussregime');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal.Nutzungsart_geplant', 'Kanal_Nutzungsart_geplant');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Beckenentleerung', 'Beckenentleerung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Unfall', 'Unfall');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Feststoffrueckhalt.Art', 'Feststoffrueckhalt_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Lichte_Hoehe', 'Lichte_Hoehe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltungspunkt.Hoehengenauigkeit', 'Haltungspunkt_Hoehengenauigkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Makrophytenbewuchs', 'Gewaesserabschnitt_Makrophytenbewuchs');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.TextPos', 'TextPos');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan_UeberlaufAssoc', 'Absperr_Drosselorgan_UeberlaufAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rueckstausicherung.Art', 'Rueckstausicherung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf.Steuerung', 'Ueberlauf_Steuerung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf.Antrieb', 'Ueberlauf_Antrieb');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal', 'Kanal');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Grundwasserschutzareal', 'Grundwasserschutzareal');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ARAEnergienutzung', 'ARAEnergienutzung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Gefaelle', 'Gewaesserabschnitt_Gefaelle');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Spezialbauwerk.Notueberlauf', 'Spezialbauwerk_Notueberlauf');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.HQ_Relation', 'HQ_Relation');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messgeraet.Art', 'Messgeraet_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbehandlung', 'Abwasserbehandlung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_vonHaltungspunktAssoc', 'Haltung_vonHaltungspunktAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Schleuse', 'Schleuse');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Wasserdichtheit', 'Versickerungsanlage_Wasserdichtheit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messresultat_MessgeraetAssoc', 'Messresultat_MessgeraetAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Entwaesserungssystem_geplant', 'Einzugsgebiet_Entwaesserungssystem_geplant');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Brunnen', 'Brunnen');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet_Text', 'Einzugsgebiet_Text');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.FoerderAggregat.Nutzungsart_Ist', 'FoerderAggregat_Nutzungsart_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal.FunktionHierarchisch', 'Kanal_FunktionHierarchisch');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.MUTATION.ART', 'MUTATION_ART');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal.Verbindungsart', 'Kanal_Verbindungsart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Foerderhoehe', 'Foerderhoehe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk_BetreiberAssoc', 'Abwasserbauwerk_BetreiberAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Fliessgewaesser.Art', 'Fliessgewaesser_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer.Verbauungsgrad', 'Ufer_Verbauungsgrad');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Organisation', 'Organisation');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rohrprofil_Geometrie_RohrprofilAssoc', 'Rohrprofil_Geometrie_RohrprofilAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel.Entlueftung', 'Deckel_Entlueftung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Versickerungswasser', 'Versickerungsanlage_Versickerungswasser');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle_GewaesserabschnittAssoc', 'Messstelle_GewaesserabschnittAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.SymbolPos', 'SymbolPos');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Verhaeltnis_H_B', 'Verhaeltnis_H_B');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk.WBW_Bauart', 'Abwasserbauwerk_WBW_Bauart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserreinigungsanlage', 'Abwasserreinigungsanlage');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Normschacht.Funktion', 'Normschacht_Funktion');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer.Seite', 'Ufer_Seite');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.GewaesserAbsturz.Typ', 'GewaesserAbsturz_Typ');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.GemeindeNr', 'GemeindeNr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messgeraet', 'Messgeraet');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Wasserfassung_GrundwasserleiterAssoc', 'Wasserfassung_GrundwasserleiterAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Geschiebesperre', 'Geschiebesperre');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ARABauwerk.Art', 'ARABauwerk_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte_AbwasserknotenAssoc', 'Hydr_Kennwerte_AbwasserknotenAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf.Signaluebermittlung', 'Ueberlauf_Signaluebermittlung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Zone', 'Zone');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.GewaesserWehr.Art', 'GewaesserWehr_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Oberflaechengewaesser', 'Oberflaechengewaesser');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung', 'Haltung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal.Bettung_Umhuellung', 'Kanal_Bettung_Umhuellung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf.Funktion', 'Ueberlauf_Funktion');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Grundwasserschutzzone', 'Grundwasserschutzzone');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.MechanischeVorreinigung', 'MechanischeVorreinigung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.Orientierung', 'Orientierung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rueckstausicherung_Absperr_DrosselorganAssoc', 'Rueckstausicherung_Absperr_DrosselorganAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer_GewaesserabschnittAssoc', 'Ufer_GewaesserabschnittAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte.Pumpenregime', 'Hydr_Kennwerte_Pumpenregime');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk_Symbol', 'Abwasserbauwerk_Symbol');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserschutzbereich.Art', 'Gewaesserschutzbereich_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt_FliessgewaesserAssoc', 'Gewaesserabschnitt_FliessgewaesserAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Anschlussobjekt_EigentuemerAssoc', 'Anschlussobjekt_EigentuemerAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messresultat_MessreiheAssoc', 'Messresultat_MessreiheAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersektor_VorherigerSektorAssoc', 'Gewaessersektor_VorherigerSektorAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Amt', 'Amt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Entwaesserungssystem_Ist', 'Einzugsgebiet_Entwaesserungssystem_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Direkteinleitung_in_Gewaesser_geplant', 'Einzugsgebiet_Direkteinleitung_in_Gewaesser_geplant');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersektor_OberflaechengewaesserAssoc', 'Gewaessersektor_OberflaechengewaesserAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlaufcharakteristik', 'Ueberlaufcharakteristik');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Badestelle', 'Badestelle');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ElektromechanischeAusruestung.Art', 'ElektromechanischeAusruestung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.NH4', 'NH4');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ARAEnergienutzung_AbwasserreinigungsanlageAssoc', 'ARAEnergienutzung_AbwasserreinigungsanlageAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Anschlussobjekt', 'Anschlussobjekt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk_SymbolAssoc', 'Abwasserbauwerk_SymbolAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan.Steuerung', 'Absperr_Drosselorgan_Steuerung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rueckstausicherung_FoerderAggregatAssoc', 'Rueckstausicherung_FoerderAggregatAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Erhaltungsereignis', 'Erhaltungsereignis');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.GewaesserWehr', 'GewaesserWehr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan.Signaluebermittlung', 'Absperr_Drosselorgan_Signaluebermittlung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rueckstausicherung', 'Rueckstausicherung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rohrprofil_Geometrie', 'Rohrprofil_Geometrie');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle', 'Messstelle');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.CSB', 'CSB');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel.Verschluss', 'Deckel_Verschluss');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Anschlussobjekt_BetreiberAssoc', 'Anschlussobjekt_BetreiberAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Beckenentleerung.Art', 'Beckenentleerung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel.Deckelform', 'Deckel_Deckelform');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Normschacht.Material', 'Normschacht_Material');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle_BetreiberAssoc', 'Messstelle_BetreiberAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersektor', 'Gewaessersektor');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Erhaltungsereignis.Status', 'Erhaltungsereignis_Status');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Entwaesserungssystem', 'Entwaesserungssystem');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle_ReferenzstelleAssoc', 'Messstelle_ReferenzstelleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Art', 'Gewaesserabschnitt_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk.Sanierungsbedarf', 'Abwasserbauwerk_Sanierungsbedarf');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Fischpass', 'Fischpass');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf.Verstellbarkeit', 'Ueberlauf_Verstellbarkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.Hoehe', 'Hoehe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersohle.Art', 'Gewaessersohle_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte_UeberlaufcharakteristikAssoc', 'Hydr_Kennwerte_UeberlaufcharakteristikAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gebietseinteilung', 'Gebietseinteilung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan_AbwasserknotenAssoc', 'Absperr_Drosselorgan_AbwasserknotenAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einleitstelle.Relevanz', 'Einleitstelle_Relevanz');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle.Zweck', 'Messstelle_Zweck');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.Metaattribute', 'Metaattribute');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.BaseClass', 'BaseClass');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.EGW', 'EGW');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Breitenvariabilitaet', 'Gewaesserabschnitt_Breitenvariabilitaet');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Reservoir', 'Reservoir');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kilometrierung', 'Kilometrierung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Bankett', 'Bankett');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.EZG_PARAMETER_MOUSE1', 'EZG_PARAMETER_MOUSE1');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwassernetzelement', 'Abwassernetzelement');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte', 'Hydr_Kennwerte');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Versickerung_geplant', 'Einzugsgebiet_Versickerung_geplant');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk_Text', 'Abwasserbauwerk_Text');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle.Staukoerper', 'Messstelle_Staukoerper');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gemeinde', 'Gemeinde');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Planungszone', 'Planungszone');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_GeomRelation_Hydr_GeometrieAssoc', 'Hydr_GeomRelation_Hydr_GeometrieAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Unfall_GefahrenquelleAssoc', 'Unfall_GefahrenquelleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Notueberlauf', 'Versickerungsanlage_Notueberlauf');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messreihe.Art', 'Messreihe_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('INTERLIS.VALIGNMENT', 'VALIGNMENT');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk.Zugaenglichkeit', 'Abwasserbauwerk_Zugaenglichkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Retention_Ist', 'Einzugsgebiet_Retention_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Intervall', 'Intervall');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Versickerung_Ist', 'Einzugsgebiet_Versickerung_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.MechanischeVorreinigung_AbwasserbauwerkAssoc', 'MechanischeVorreinigung_AbwasserbauwerkAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Number', 'anumber');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gefahrenquelle_AnschlussobjektAssoc', 'Gefahrenquelle_AnschlussobjektAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal.FunktionHydraulisch', 'Kanal_FunktionHydraulisch');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('INTERLIS.INTERLIS_1_DATE', 'INTERLIS_1_DATE');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_nachHaltungspunktAssoc', 'Haltung_nachHaltungspunktAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlaufcharakteristik.Kennlinie_Typ', 'Ueberlaufcharakteristik_Kennlinie_Typ');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Rohrprofil.Profiltyp', 'Rohrprofil_Profiltyp');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte.Springt_an', 'Hydr_Kennwerte_Springt_an');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserschutzbereich', 'Gewaesserschutzbereich');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte.Foerderaggregat_Nutzungsart_Ist', 'Hydr_Kennwerte_Foerderaggregat_Nutzungsart_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Erhaltungsereignis.Art', 'Erhaltungsereignis_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.MUTATION', 'MUTATION');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_TextAssoc', 'Haltung_TextAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzelflaeche.Befestigung', 'Einzelflaeche_Befestigung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Erhaltungsereignis_Ausfuehrender_FirmaAssoc', 'Erhaltungsereignis_Ausfuehrender_FirmaAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan', 'Absperr_Drosselorgan');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Steuerungszentrale', 'Steuerungszentrale');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltungspunkt', 'Haltungspunkt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsbereich', 'Versickerungsbereich');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet', 'Einzugsgebiet');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Normschacht', 'Normschacht');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Bankett.Art', 'Bankett_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Fracht', 'Fracht');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Stoff_GefahrenquelleAssoc', 'Stoff_GefahrenquelleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet_Abwassernetzelement_RW_IstAssoc', 'Einzugsgebiet_Abwassernetzelement_RW_IstAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.Jahr', 'Jahr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzelflaeche.Funktion', 'Einzelflaeche_Funktion');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Statuswerte', 'Statuswerte');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel.Schlammeimer', 'Deckel_Schlammeimer');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.Surface', 'Surface');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Grundwasserleiter', 'Grundwasserleiter');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Beckenentleerung_Absperr_DrosselorganAssoc', 'Beckenentleerung_Absperr_DrosselorganAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messreihe_MessstelleAssoc', 'Messreihe_MessstelleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Aggregatezahl', 'Aggregatezahl');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Furt', 'Furt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Retentionskoerper', 'Retentionskoerper');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Algenbewuchs', 'Gewaesserabschnitt_Algenbewuchs');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Laengsprofil', 'Gewaesserabschnitt_Laengsprofil');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ElektromechanischeAusruestung', 'ElektromechanischeAusruestung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Streichwehr.Wehr_Art', 'Streichwehr_Wehr_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.FoerderAggregat.AufstellungAntrieb', 'FoerderAggregat_AufstellungAntrieb');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage_GrundwasserleiterAssoc', 'Versickerungsanlage_GrundwasserleiterAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Feststoffrueckhalt', 'Feststoffrueckhalt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Genossenschaft_Korporation', 'Genossenschaft_Korporation');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Oberflaechenabflussparameter_EinzugsgebietAssoc', 'Oberflaechenabflussparameter_EinzugsgebietAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einwohnerdichte', 'Einwohnerdichte');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.Polyline', 'Polyline');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanal.Nutzungsart_Ist', 'Kanal_Nutzungsart_Ist');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_GeomRelation', 'Hydr_GeomRelation');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.HQ_Relation_UeberlaufcharakteristikAssoc', 'HQ_Relation_UeberlaufcharakteristikAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel', 'Deckel');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Wasserhaerte', 'Gewaesserabschnitt_Wasserhaerte');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messstelle_AbwasserreinigungsanlageAssoc', 'Messstelle_AbwasserreinigungsanlageAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltungspunkt_AbwassernetzelementAssoc', 'Haltungspunkt_AbwassernetzelementAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Trockenwetterrinne', 'Trockenwetterrinne');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf_UeberlaufcharakteristikAssoc', 'Ueberlauf_UeberlaufcharakteristikAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Fischpass_GewaesserverbauungAssoc', 'Fischpass_GewaesserverbauungAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzelflaeche', 'Einzelflaeche');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Beckenreinigung', 'Beckenreinigung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Normschacht.Oberflaechenzulauf', 'Normschacht_Oberflaechenzulauf');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einstiegshilfe.Art', 'Einstiegshilfe_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messresultat.Messart', 'Messresultat_Messart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserverbauung', 'Gewaesserverbauung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Schlammbehandlung.Stabilisierung', 'Schlammbehandlung_Stabilisierung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Maengel', 'Versickerungsanlage_Maengel');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('Base.LKoord', 'LKoord');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer', 'Ufer');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung.Lagebestimmung', 'Haltung_Lagebestimmung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Retentionskoerper_VersickerungsanlageAssoc', 'Retentionskoerper_VersickerungsanlageAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.OrganisationBezeichnung', 'OrganisationBezeichnung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.Plantyp', 'Plantyp');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet_Abwassernetzelement_SW_IstAssoc', 'Einzugsgebiet_Abwassernetzelement_SW_IstAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_RohrprofilAssoc', 'Haltung_RohrprofilAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet.Retention_geplant', 'Einzugsgebiet_Retention_geplant');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel.Material', 'Deckel_Material');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersohle.Verbauungsart', 'Gewaessersohle_Verbauungsart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserverbauung_GewaesserabschnittAssoc', 'Gewaesserverbauung_GewaesserabschnittAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.Status', 'Status');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserknoten', 'Abwasserknoten');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan_SteuerungszentraleAssoc', 'Absperr_Drosselorgan_SteuerungszentraleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ziffernblatt', 'Ziffernblatt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.SIA405_BaseClass', 'SIA405_BaseClass');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Oberflaechenabflussparameter', 'Oberflaechenabflussparameter');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersohle_GewaesserabschnittAssoc', 'Gewaessersohle_GewaesserabschnittAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Wasserfassung_OberflaechengewaesserAssoc', 'Wasserfassung_OberflaechengewaesserAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Totholz', 'Gewaesserabschnitt_Totholz');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Kanton', 'Kanton');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Art', 'Versickerungsanlage_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Position', 'Position');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserknoten_Hydr_GeometrieAssoc', 'Abwasserknoten_Hydr_GeometrieAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Wasserfassung', 'Wasserfassung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer.Uferbereich', 'Ufer_Uferbereich');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Verlust', 'Verlust');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlauf_AbwasserknotenAssoc', 'Ueberlauf_AbwasserknotenAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Fliessgewaesser', 'Fliessgewaesser');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage', 'Versickerungsanlage');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Anschlussobjekt_AbwassernetzelementAssoc', 'Anschlussobjekt_AbwassernetzelementAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_Text', 'Haltung_Text');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Entwaesserungssystem.Art', 'Entwaesserungssystem_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Spezialbauwerk.Funktion', 'Spezialbauwerk_Funktion');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Deckel.Lagegenauigkeit', 'Deckel_Lagegenauigkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Hydr_Kennwerte.Hauptwehrart', 'Hydr_Kennwerte_Hauptwehrart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Beckenentleerung_UeberlaufAssoc', 'Beckenentleerung_UeberlaufAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk.Finanzierung', 'Abwasserbauwerk_Finanzierung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Retentionskoerper.Art', 'Retentionskoerper_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk', 'Abwasserbauwerk');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Spezialbauwerk', 'Spezialbauwerk');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Durchlass', 'Durchlass');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbehandlung_AbwasserreinigungsanlageAssoc', 'Abwasserbehandlung_AbwasserreinigungsanlageAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Prandtl', 'Prandtl');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.GewaesserAbsturz.Material', 'GewaesserAbsturz_Material');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.BauwerksTeil', 'BauwerksTeil');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Stoff', 'Stoff');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.FoerderAggregat.AufstellungFoerderaggregat', 'FoerderAggregat_AufstellungFoerderaggregat');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Planungszone.Art', 'Planungszone_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Absperr_Drosselorgan.Antrieb', 'Absperr_Drosselorgan_Antrieb');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk_EigentuemerAssoc', 'Abwasserbauwerk_EigentuemerAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Streichwehr.Ueberfallkante', 'Streichwehr_Ueberfallkante');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_AlternativVerlauf', 'Haltung_AlternativVerlauf');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Beckenreinigung.Art', 'Beckenreinigung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Neigung_Promille', 'Neigung_Promille');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Schlammbehandlung', 'Schlammbehandlung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.SIA405_TextPos', 'SIA405_TextPos');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Wasserfassung.Art', 'Wasserfassung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einleitstelle_GewaessersektorAssoc', 'Einleitstelle_GewaessersektorAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt', 'Gewaesserabschnitt');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messreihe', 'Messreihe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Sohlrampe', 'Sohlrampe');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwassernetzelement_AbwasserbauwerkAssoc', 'Abwassernetzelement_AbwasserbauwerkAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung.Reliner_Bautechnik', 'Haltung_Reliner_Bautechnik');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('INTERLIS.HALIGNMENT', 'HALIGNMENT');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.FoerderAggregat.Bauart', 'FoerderAggregat_Bauart');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbauwerk.BaulicherZustand', 'Abwasserbauwerk_BaulicherZustand');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.BauwerksTeil.Instandstellung', 'BauwerksTeil_Instandstellung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsbereich.Versickerungsmoeglichkeit', 'Versickerungsbereich_Versickerungsmoeglichkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Streichwehr', 'Streichwehr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer.Vegetation', 'Ufer_Vegetation');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserverband', 'Abwasserverband');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Tiefenvariabilitaet', 'Gewaesserabschnitt_Tiefenvariabilitaet');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersektor.Art', 'Gewaessersektor_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaessersohle', 'Gewaessersohle');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltungspunkt.Auslaufform', 'Haltungspunkt_Auslaufform');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Haltung_AlternativVerlaufAssoc', 'Haltung_AlternativVerlaufAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Gewaesserabschnitt.Nutzung', 'Gewaesserabschnitt_Nutzung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Spezialbauwerk.Bypass', 'Spezialbauwerk_Bypass');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Versickerungsanlage.Beschriftung', 'Versickerungsanlage_Beschriftung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ueberlaufhaeufigkeit', 'Ueberlaufhaeufigkeit');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Sohlrampe.Befestigung', 'Sohlrampe_Befestigung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Abwasserbehandlung.Art', 'Abwasserbehandlung_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Spezialbauwerk.Regenbecken_Anordnung', 'Spezialbauwerk_Regenbecken_Anordnung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet_TextAssoc', 'Einzugsgebiet_TextAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messgeraet_MessstelleAssoc', 'Messgeraet_MessstelleAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einleitstelle', 'Einleitstelle');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Base.SIA405_SymbolPos', 'SIA405_SymbolPos');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Grundwasserschutzzone.Art', 'Grundwasserschutzzone_Art');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Privat', 'Privat');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.EZG_PARAMETER_ALLG', 'EZG_PARAMETER_ALLG');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Messresultat', 'Messresultat');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Ufer.Umlandnutzung', 'Ufer_Umlandnutzung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ElektrischeEinrichtung', 'ElektrischeEinrichtung');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.BauwerksTeil_AbwasserbauwerkAssoc', 'BauwerksTeil_AbwasserbauwerkAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Einzugsgebiet_Abwassernetzelement_SW_geplantAssoc', 'Einzugsgebiet_Abwassernetzelement_SW_geplantAssoc');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Strahler', 'Strahler');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ARANr', 'ARANr');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.ARABauwerk', 'ARABauwerk');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.GewaesserAbsturz', 'GewaesserAbsturz');
INSERT INTO sia405abwasser.t_ili2db_classname (iliname, sqlname) VALUES ('SIA405_Abwasser.SIA405_Abwasser.Leapingwehr.Oeffnungsform', 'Leapingwehr_Oeffnungsform');


-- SET search_path = vsadss2015_2_d_251, pg_catalog;

--
-- TOC entry 6136 (class 0 OID 148242)
-- Dependencies: 700
-- Data for Name: sia405abwasser.t_ili2db_classname; Type: TABLE DATA; Schema: vsadss2015_2_d_251; Owner: postgres
--



-- Completed on 2016-01-21 20:16:17

--
-- PostgreSQL database dump complete
--

