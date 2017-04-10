-- sets metadata for VSA_DSS_2015_2_d.ili model in ili2pg schema
-- for another modell use different model settings
-- PostgreSQL database dump
--

-- Dumped from database version 9.3.6
-- Dumped by pg_dump version 9.3.6
-- Started on 2016-01-20 22:39:54

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

-- SET search_path = vsadss2015_2_d, pg_catalog;

--
-- TOC entry 6135 (class 0 OID 131624)
-- Dependencies: 608
-- Data for Name: sia405abwasser.t_ili2db_model; Type: TABLE DATA; Schema: vsadss2015_2_d; Owner: postgres
--

INSERT INTO sia405abwasser.t_ili2db_model (file, iliversion, modelname, content, importdate) VALUES ('VSA_DSS_2015_2_d.ili', '2.3', 'DSS_2015{ SIA405_Base Units Base INTERLIS}', '!! VSA_DSS_2015_2_d.ili
!! http://dss.vsa.ch

INTERLIS 2.3;

MODEL DSS_2015 (de) AT "http://www.vsa.ch/models"
  VERSION "17.11.2015" = 

  IMPORTS UNQUALIFIED INTERLIS;     !! new 8.11.2004, imports INTERLIS 2 Baseunits
  IMPORTS Units;
  IMPORTS Base;
  IMPORTS SIA405_Base;

!! Copyright 2002 - 2015
!! Verband Schweizer Abwasser- und Gew�sserschutzfachleute (VSA), Z�rich
!! www.vsa.ch

!! Die Nutzung dieser INTERLIS-Datei ist lizenzpflichtig!
!! �nderungen und Erg�nzungen d�rfen zum Eigengebrauch get�tigt werden. 
!! Sie m�ssen innerhalb der Datei so dokumentiert sein, dass sichtbar wird, 
!! welche �nderungen get�tigt wurden (Einf�gen von INTERLIS Kommentar). 
!! Die Originalmodelldatei  und darauf basierende 
!! abge�nderte Versionen d�rfen nicht weiterverkauft werden. 
!! Die Weitergabe der Originaldatei (als Ganzes oder Teile davon) ist nur 
!! zusammen mit dem Erwerb einer Lizenz beim VSA durch den Empf�nger erlaubt. 

!! Geprueft mit Compiler Version 4.5.14 (10.8.2015)
!! Sachbearbeiter: Stefan Burckhardt / VSA CC Siedlungsentw�sserung

UNIT
  Kilogramm_pro_Jahr [kga] = (kg/Units.a);
  Einwohner_pro_Hektare [EWha] = (Units.CountedObjects/Units.ha);
  Liter_pro_Sekunde_Hektare [lsha] = (SIA405_Base.ls/Units.ha);

TOPIC Siedlungsentwaesserung =


DOMAIN


Gebietseinteilung = AREA WITH (STRAIGHTS,ARCS) VERTEX Base.LKoord WITHOUT OVERLAPS > 0.050;    !! Punkte mit Schweizer Landeskoordinaten
!! Fl�chen d�rfen sich nicht �berlappen
!! Gemeinde.Perimeter
!! Kanton.Perimeter
!! Planungszone.Perimeter
!! Versickerungsbereich.Perimeter


Number = -99999999.9999 ..  99999999.9999;    !! 
!! Messresultat.Wert
!! Rohrprofil_Geometrie.x
!! Rohrprofil_Geometrie.y


Verhaeltnis_H_B = 0.01 .. 100.00;    !! Verh�ltnis H�he zu Breite, ohne Einheit
!! Rohrprofil.HoehenBreitenverhaeltnis


Statuswerte EXTENDS SIA405_Base.Status = (  !! Betriebs- und Planungszustand. 
!! 11.2.2012 Anpassung auf neue Variante von SIA405_Base.Status - Erweiterung Basiswerte im Medium, hierarchische Modellierung und Anpassung auf Compiler 4.5.13
      !! 17.7.2015 ausser_Betrieb,   !! fasst ausser_Betrieb und folgende Werte zusammen
        !!  Reserve !! existiert nicht im Medium Abwasser
      in_Betrieb (  !! fasst in_Betrieb und folgende Werte zusammen
         !! 17.7.2015 in_Betrieb,
         provisorisch,
         wird_aufgehoben
      ),
      tot (  !! fasst tot und folgende Werte zusammen
         !!  tot,   !! existiert nicht im Medium Abwasser
        aufgehoben_nicht_verfuellt,
        aufgehoben_unbekannt,
        verfuellt
      ),
      !! 17.7.2015 unbekannt,
      weitere ( !! fasst folgende Werte zusammen
         Berechnungsvariante,
         geplant,
         Projekt
      )
    );    !! Erweitert Wertebereich von SIA405 Status
!! neu 17.7.2015  
    Status = ALL OF Statuswerte;    !! Erweitert Wertebereich von SIA405 Status
!! Abwasserbauwerk.Status


Intervall = 0.00 .. 20.00 [Units.CountedObjects];    !! Jahre [J]
!! Abwasserbauwerk.Inspektionsintervall
!! Kanal.Spuelintervall


Kilometrierung = 0.000 .. 999999.999 [Units.km];    !! Kilometer oder Kilometrierung [km]
!! Gewaessersektor.KilomO
!! Gewaessersektor.KilomU


Gefaelle_Promille = -10000 .. 10000;    !! Promille [%o]
!! 17.4.2014 neu f�r Plangefaelle (statt Promille), da gr�sser als 1000 sein kann
!! Haltung.Plangefaelle


Neigung_Promille = 0 .. 1000;    !! Promille [%o]
!! 17.4.2014 neu f�r EZG_PARAMETER_ALLG / MOUSE1.Fliessweggefaelle, Einzelflaeche.Neigung
!! Einzelflaeche.Neigung
!! EZG_PARAMETER_ALLG.Fliessweggefaelle
!! EZG_PARAMETER_MOUSE1.Fliessweggefaelle


Strickler = 0 .. 999;    !! Manning-Strickler K oder kstr [m^(1/3)/s]
!! Haltung.Reibungsbeiwert


Prandtl = 0.00 .. 100.00 [Units.mm];    !! Wandrauhigkeitsbeiwert nach Prandtl Colebrook (ks), Milimeter [mm]
!! Haltung.Wandrauhigkeit


Strahler = 0 .. 99 [Units.CountedObjects];    !! Ordnungszahl nach Strahler
!! Gewaesserabschnitt.Groesse


BSB5 = 0 .. 1000 [SIA405_Base.gm3];    !! Biochemischer Sauerstoffbedarf in 5 Tagen [gBSB5/m3]
!! Dimensionierungswert BSB5 Ablauf Vorkl�rung
!! Abwasserreinigungsanlage.BSB5


CSB = 0 .. 1000 [SIA405_Base.gm3];    !! Chemischer Sauerstoffbedarf [gCSB/m3]
!! Abwasserreinigungsanlage.CSB


NH4 = 0 .. 1000 [SIA405_Base.gm3];    !! NH4 [gNH4/m3]
!! Abwasserreinigungsanlage.NH4


Fracht = 0 .. 1000000 [kga];    !! Kilogramm pro Jahr [kg/Jahr]
!! Hydr_Kennwerte.Ueberlauffracht


Einwohnerdichte = 0 .. 10000 [EWha];    !! Einwohner pro Hektare [Einwohner / ha]
!! Einzugsgebiet.Einwohnerdichte_geplant
!! Einzugsgebiet.Einwohnerdichte_Ist


EGW = 0 .. 300000 [Units.CountedObjects];    !! Einwohnergleichwert [EGW]
!! EZG_PARAMETER_ALLG.Einwohnergleichwert
!! EZG_PARAMETER_MOUSE1.Einwohnergleichwert
!! Gemeinde.Einwohner


Verlust = 0.0 .. 500.0 [Units.mm];    !! Milimeter [mm]
!! Oberflaechenabflussparameter.Benetzungsverlust
!! Oberflaechenabflussparameter.Muldenverlust
!! Oberflaechenabflussparameter.Verdunstungsverlust
!! Oberflaechenabflussparameter.Versickerungsverlust


GemeindeNr = 1 .. 9999 [Units.CountedObjects];    !! 
!! Gemeinde.Gemeindenummer


ARANr = 1 .. 999999 [Units.CountedObjects];    !! 
!! Abwasserreinigungsanlage.Anlagenummer


Position = 1 .. 999;    !! 
!! Rohrprofil_Geometrie.Position


Ueberlaufhaeufigkeit = 0.0 .. 999.9;    !! [Anzahl �berl�ufe/Jahr]
!! Hydr_Kennwerte.Ueberlaufhaeufigkeit


Aggregatezahl = 1 .. 9  [Units.CountedObjects];    !! 
!! Hydr_Kennwerte.Aggregatezahl


Lichte_Hoehe = 0 .. 99999 [Units.mm];    !! Milimeter [mm]
!! 18.2.2014 neu f�r Lichte_Hoehe (statt Abmessung)
!! Absperr_Drosselorgan.Drosselorgan_Oeffnung_Ist
!! Absperr_Drosselorgan.Drosselorgan_Oeffnung_Ist_optimiert
!! Haltung.Lichte_Hoehe
!! Haltung.Reliner_Nennweite


UID = TEXT*12;    !! 
!! Organisation.UID


Foerderhoehe = 0.00 .. 30000.00 [m];    !! Meter [m], 2 Dezimalstellen
!! Hydr_Kennwerte.Foerderhoehe_geodaetisch


Ziffernblatt = 0..12;    !! 
!! gem�ss Richtlinie
!! Haltungspunkt.Lage_Anschluss


CLASS MUTATION EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Transfer von Mutationen von Attributwerten beliebiger Klassen
  ATTRIBUTE
    ART: (        
      erstellt,
      geaendert,
      geloescht
    );
    ATTRIBUT: TEXT*50;  !! Attributname des gew�hlten Objektes
    AUFNAHMEDATUM: INTERLIS_1_DATE;  !! Datum/Zeit der Aufnahme im Feld falls vorhanden bei erstellt. Sonst Datum/Uhrzeit der Erstellung auf dem System
    AUFNEHMER: SIA405_Base.OrganisationBezeichnung;  !! Name des Aufnehmers im Feld
    BEMERKUNG: TEXT*80;  !! Allgemeine Bemerkungen
    KLASSE: TEXT*50;  !! Klassenname des gew�hlten Objektes
    LETZTER_WERT: TEXT*100;  !! Letzter Wert umgewandelt in Text. Nur bei ART=geaendert oder geloescht
    MUTATIONSDATUM: INTERLIS_1_DATE;  !! Bei geaendert Datum/Zeit der �nderung. Bei gel�scht Datum/Zeit der L�schung
    OBJEKT: TEXT*41;  !! OBJ_ID des Objektes
    SYSTEMBENUTZER: TEXT*41;  !! Name des Systembenutzers
END MUTATION;

CLASS Grundwasserleiter EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Abgegrenztes Grundwasservorkommen oder abgegrenzter Teil davon
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    MaxGWSpiegel: Base.Hoehe;  !! Maximale Lage des Grundwasserspiegels
    MinGWSpiegel: Base.Hoehe;  !! Minimale Lage des Grundwasserspiegels
    MittlererGWSpiegel: Base.Hoehe;  !! H�he des mittleren Grundwasserspiegels
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
END Grundwasserleiter;

CLASS Oberflaechengewaesser (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! In der Natur fliessendes oder stehendes Wasser einschliesslich Gew�sserbett
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
END Oberflaechengewaesser;

CLASS Fliessgewaesser EXTENDS Oberflaechengewaesser =  
!! St�ndig oder zeitweise fliessendes oberirdisches Gew�sser
  ATTRIBUTE
    Art: (          !! Art des Fliessgew�ssers. Klassifizierung nach GEWISS
      Gletscherbach,
      Moorbach,
      Seeausfluss,
      Travertinbach,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Fliessgewaesser;

CLASS See EXTENDS Oberflaechengewaesser =  
!! Oberirdisches Gew�sser mit stehendem oder nahezu stehendem Wasser
  ATTRIBUTE
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END See;

CLASS Gewaesserabschnitt EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Aus gew�ssermorphologischer Sicht homogener Teil eines Gew�ssers
  ATTRIBUTE
    Abflussregime: (          !! Grad der antropogenen Beeinflussung des charakteristischen Ganges des Abflusses.
      beeintraechtigt,
      kuenstlich,
      naturfern,
      naturnah,
      unbekannt
    );
    Algenbewuchs: (          !! Bewuchs mit Algen
      kein_gering,
      maessig_stark,
      uebermaessig_wuchernd,
      unbekannt
    );
    Art: (        
      eingedolt,
      offen,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    bis: Base.LKoord;  !! Lage Abschnitt-Ende im Gew�sserverlauf
    Breitenvariabilitaet: (          !! Breitenvariabilit�t des Wasserspiegels bei niedrigem bis mittlerem Abfluss
      ausgepraegt,
      eingeschraenkt,
      keine,
      unbekannt
    );
    Gefaelle: (          !! Mittleres Gef�lle des Gew�sserabschnittes
      flach,  !! < 1%
      mittel,  !! 1 bis 3%
      steil,  !! > 3%
      unbekannt
    );
    Groesse: Strahler;  !! Ordnungszahl nach Strahler
    Hoehenstufe: (          !! H�henstufentypen eines Gew�ssers
      alpin,
      kollin,
      montan,
      subalpin,
      unbekannt
    );
    Laengsprofil: (          !! Charakterisierung des Gew�sserl�ngsprofil
      kaskadenartig,
      Schnellen_Kolke,
      stetig,
      unbekannt
    );
    Linienfuehrung: (          !! Linienf�hrung eines Gew�sserabschnittes
      gerade,
      leichtbogig,
      maeandrierend,
      starkbogig,
      unbekannt
    );
    Makrophytenbewuchs: (          !! Bewuchs mit Makrophyten
      kein_gering,
      maessig_stark,
      uebermaessig_wuchernd,
      unbekannt
    );
    Nutzung: (          !! Prim�re Nutzung des Gew�sserabschnittes
      Erholung,
      Fischerei,
      Stauanlage,
      unbekannt
    );
    Oekom_Klassifizierung: (          !! Summenattribut aus der �komorphologischen Klassifizierung nach Stufe F
      eingedolt,
      kuenstlich_naturfremd,
      natuerlich_naturnah,
      nicht_klassiert,
      stark_beeintraechtigt,
      wenig_beeintraechtigt
    );
    Sohlenbreite: 0.00 .. 30000.00 [m];  !! mittlere Sohlenbreite
    Tiefenvariabilitaet: (          !! Variabilit�t der Gew�ssertiefe
      ausgepraegt,
      keine,
      maessig,
      unbekannt
    );
    Totholz: (          !! Ansammlungen von Totholz im Gew�sserabschnitt
      Ansammlungen,
      kein_vereinzelt,
      unbekannt,
      zerstreut
    );
    Von: Base.LKoord;  !! Lage des Abschnittanfangs  im Gew�sserverlauf
    Wasserhaerte: (          !! Chemische Wasserh�rte
      Kalk,
      Silikat,
      unbekannt
    );
END Gewaesserabschnitt;

ASSOCIATION Gewaesserabschnitt_FliessgewaesserAssoc =    !! Komposition
  FliessgewaesserRef  -<#> {1} Fliessgewaesser; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gewaesserabschnitt_FliessgewaesserAssocRef -- {0..*} Gewaesserabschnitt; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gewaesserabschnitt_FliessgewaesserAssoc;

CLASS Wasserfassung EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Entnahme von Grundwasser durch technische Massnahmen
  ATTRIBUTE
    Art: (          !! Art der Trinkwasserfassung
      Brauchwasser,
      Trinkwasser,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
END Wasserfassung;

ASSOCIATION Wasserfassung_GrundwasserleiterAssoc =    !! Assoziation
  GrundwasserleiterRef  -- {0..1} Grundwasserleiter; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Wasserfassung_GrundwasserleiterAssocRef -- {0..*} Wasserfassung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Wasserfassung_GrundwasserleiterAssoc;

ASSOCIATION Wasserfassung_OberflaechengewaesserAssoc =    !! Assoziation
  OberflaechengewaesserRef  -- {0..1} Oberflaechengewaesser; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Wasserfassung_OberflaechengewaesserAssocRef -- {0..*} Wasserfassung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Wasserfassung_OberflaechengewaesserAssoc;

CLASS Ufer EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Ans Gew�sser angrenzende Zone
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Breite: 0.00 .. 30000.00 [m];  !! Breite des Bereiches oberhalb des B�schungsfusses bis zum Gebiet mit "intensiver Landnutzung"
    Seite: (          !! Linke oder rechte Uferseite in Fliessrichtung
      links,
      rechts,
      unbekannt
    );
    Uferbereich: (          !! Beschaffenheit des Bereiches oberhalb des B�schungsfusses
      gewaesserfremd,
      gewaessergerecht,
      kuenstlich,
      unbekannt
    );
    Umlandnutzung: (          !! Nutzung des Gew�sserumlandes
      Bebauungen,
      Gruenland,
      unbekannt,
      Wald
    );
    Vegetation: (        
      fehlend,
      standorttypisch,
      standortuntypisch,
      unbekannt
    );
    Verbauungsart: (          !! Verbauungsart des B�schungsfusses
      andere_dicht,  !! (dicht)
      Betongitterstein_dicht,  !! (dicht)
      Holz_durchlaessig,  !! (durchl�ssig)
      keine_Verbauung,  !! (durchl�ssig)
      Lebendverbau_durchlaessig,  !! (durchl�ssig)
      Mauer_dicht,  !! (dicht)
      Naturstein_dicht,  !! (dicht)
      Naturstein_locker_durchlaessig,  !! (durchl�ssig)
      unbekannt  !! (durchl�ssig)
    );
    Verbauungsgrad: (          !! Fl�chenhafter Verbauungsgrad des B�schungsfusses in %. Aufteilung in Klassen.
      keine,  !! keine (0%)
      maessig,  !! m�ssig (10 - 30 %)
      stark,  !! stark (30 - 60 %)
      ueberwiegend,  !! ueberwiegend (> 60 %)
      unbekannt,
      vereinzelt,  !! vereinzelt (<10%)
      vollstaendig  !! vollst�ndig (100 %)
    );
END Ufer;

ASSOCIATION Ufer_GewaesserabschnittAssoc =    !! Komposition
  GewaesserabschnittRef  -<#> {1} Gewaesserabschnitt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Ufer_GewaesserabschnittAssocRef -- {0..2} Ufer; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Ufer_GewaesserabschnittAssoc;

CLASS Gewaessersohle EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Bei Hochwasser umgelagerter Bereich eines Gew�ssers
  ATTRIBUTE
    Art: (          !! Sohlentyp
      hart,
      unbekannt,
      weich
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Breite: 0.00 .. 30000.00 [m];  !! Bei Hochwasser umgelagerter Bereich (frei von h�heren Wasserpflanzen);
    Verbauungsart: (          !! Art des Sohlenverbaus
      andere_dicht,  !! (dicht)
      Betongittersteine,  !! (dicht)
      Holz,  !! (dicht)
      keine_Verbauung,  !! (durchl�ssig)
      Steinschuettung_Blockwurf,  !! (durchl�ssig)
      unbekannt  !! (durchl�ssig)
    );
    Verbauungsgrad: (          !! Fl�chenhafter Verbauungsgrad der Gew�ssersohle in %. Aufteilung in Klassen.
      keine,  !! keine (0%)
      maessig,  !! m�ssig (10 - 30 %)
      stark,  !! stark (30 - 60 %)
      ueberwiegend,  !! ueberwiegend (> 60 %)
      unbekannt,
      vereinzelt,  !! vereinzelt (<10%)
      vollstaendig  !! vollst�ndig (100 %)
    );
END Gewaessersohle;

ASSOCIATION Gewaessersohle_GewaesserabschnittAssoc =    !! Komposition
  GewaesserabschnittRef  -<#> {1} Gewaesserabschnitt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gewaessersohle_GewaesserabschnittAssocRef -- {0..1} Gewaessersohle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gewaessersohle_GewaesserabschnittAssoc;

CLASS Gewaessersektor EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Teilst�ck aus welchen sich ein  Gew�ssers aufbaut
  ATTRIBUTE
    Art: (          !! Ufer oder Gew�sserlinie. Zur Unterscheidung der Seesektoren wichtig.
      Gewaesser,  !! Ansammlung von Wasser auf und unter der Erdoberfl�che, die als stehendes oder fliessendes Gew�sser bezeichnet werden. Man unterscheidet ausserdem ober- und unterirdische Gew�sser. Zu den Gew�ssern rechnet man s�mtliche, nat�rliche Wasseransammlungen, die oberirdisch oder unterirdisch einen Wasserspiegel, einen freien oder gespannten, haben und auch nach Aufh�ren eines Niederschlages in dem betreffenden Gebiet zeitweilig oder dauernd bestehen. Dazu geh�ren B�che, Fl�sse, Teiche, Seen, S�mpfe, Meere und Grundwasserbest�nde jeglicher Art. (arb)
      ParallelerAbschnitt,
      Seetraverse,
      Ufer,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    BWG_Code: TEXT*50;  !! Code gem�ss Format des Bundesamtes f�r Wasser und Geologie (BWG);
    KilomO: Kilometrierung;  !! Adresskilometer beim Sektorende (nur definieren, falls es sich um den letzten Sektor handelt oder ein Sprung in der Adresskilometrierung von einem Sektor zum n�chsten  existiert);
    KilomU: Kilometrierung;  !! Adresskilometer beim Sektorbeginn
    RefLaenge: 0.00 .. 30000.00 [m];  !! Basisl�nge in Zusammenhang mit der Gew�sserkilometrierung (siehe GEWISS - SYSEAU);
    Verlauf: POLYLINE WITH (STRAIGHTS, ARCS) VERTEX Base.LKoord;  !! Reihenfolge von Punkten die den Verlauf eines Gew�ssersektors beschreiben
END Gewaessersektor;

ASSOCIATION Gewaessersektor_VorherigerSektorAssoc =    !! Assoziation
  VorherigerSektorRef  -- {0..1} Gewaessersektor; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gewaessersektor_VorherigerSektorAssocRef -- {0..*} Gewaessersektor; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gewaessersektor_VorherigerSektorAssoc;

ASSOCIATION Gewaessersektor_OberflaechengewaesserAssoc =    !! Komposition
  OberflaechengewaesserRef  -<#> {1} Oberflaechengewaesser; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gewaessersektor_OberflaechengewaesserAssocRef -- {0..*} Gewaessersektor; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gewaessersektor_OberflaechengewaesserAssoc;

CLASS Organisation (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Superklasse f�r in der Entw�sserungsplanung relevante organisatorische Einheiten (z.B. Gemeinde, Kanton, etc.)
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: SIA405_Base.OrganisationBezeichnung;  !! Es wird empfohlen reale Namen zu nehmen, z.B. Mustergemeinde und nicht Gemeinde. Oder Abwasserverband ARA Muster und nicht nur Abwasserverband, da es sonst Probleme gibt bei der Zusammenf�hrung der Daten.
    UID: UID;  !! Referenz zur Unternehmensidentifikation des Bundesamts fuer Statistik (www.uid.admin.ch), z.B. CHE123456789
END Organisation;

ASSOCIATION Organisation_Teil_vonAssoc =    !! Assoziation
  Teil_vonRef  -- {0..*} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Organisation_Teil_vonAssocRef -- {0..*} Organisation; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Organisation_Teil_vonAssoc;

CLASS Genossenschaft_Korporation EXTENDS Organisation =  
!! Genossenschaft oder Kooperation: K�rperschaft �ffentlichen Rechts. Falls privaten Rechtes dann als Privat abbilden.
  ATTRIBUTE
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Genossenschaft_Korporation;

CLASS Kanton EXTENDS Organisation =  
!! Kanton der Schweiz
  ATTRIBUTE
    Perimeter: Gebietseinteilung;  !! Kantonsgrenze
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Kanton;

CLASS Abwasserverband EXTENDS Organisation =  
!! Abwasserverband
  ATTRIBUTE
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Abwasserverband;

CLASS Gemeinde EXTENDS Organisation =  
!! F�r die Belange der Siedlungsentw�sserung zust�ndiges Organ der Gemeindeverwaltung
  ATTRIBUTE
    Einwohner: EGW;  !! St�ndige Einwohner (laut Einwohnerkontrolle der Gemeinde);
    Flaeche: 0.0000 .. 100000.0000 [Units.ha];  !! Fl�che ohne Seeanteil
    Gemeindenummer: GemeindeNr;  !! Offizielle Nummer gem�ss Bundesamt f�r Statistik
    GEP_Jahr: SIA405_Base.Jahr;  !! Rechtsg�ltiges GEP aus dem Jahr
    Hoehe: Base.Hoehe;  !! Mittlere H�he des Siedlungsgebietes
    Perimeter: Gebietseinteilung;  !! Gemeindegrenze
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Gemeinde;

CLASS Amt EXTENDS Organisation =  
!! Teil einer Organisation (z.B. Amt f�r Umweltschutz, Amt f�r Abwasserentsorgung)
  ATTRIBUTE
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Amt;

CLASS Abwasserreinigungsanlage EXTENDS Organisation =  
!! Abwassreinigungsanlage (ARA)
  ATTRIBUTE
    Anlagenummer: ARANr;  !! ARA-Nummer gem�ss Bundesamt f�r Umwelt (BAFU);
    Art: TEXT*50;
    BSB5: BSB5;  !! Biochemischer Sauerstoffbedarf nach 5 Tagen Messzeit und bei einer Temperatur vom 20 Grad Celsius. Er stellt den Verbrauch an gel�stem Sauerstoff durch die Lebensvorg�nge der im Wasser oder Abwasser enthaltenen Mikroorganismen (Bakterienprotozoen) beim  Abbau organischer Substanzen dar. Der Wert stellt eine wichtige Gr�sse zur Beurteilung der  aerob abbauf�higen Substanzen dar. Der BSB5 wird in den Einheiten mg/l oder g/m3 angegeben. Ausser dem BSB5 wird der biochemische Sauerstoffbedarf auch an 20 Tagen und mehr bestimmt. Dann spricht man z.B. vom BSB20 usw. Siehe Sapromat, Winklerprobe, Verd�nnungsmethode. (arb);
    CSB: CSB;  !! Abk�rzung f�r den chemischen Sauerstoffbedarf. Die englische Abk�rzung lautet COD. Mit einem starken Oxydationsmittel wird mehr oder weniger erfolgreich versucht, die organischen Verbindungen der Abwasserprobe zu CO2 und H2O zu oxydieren. Als Oxydationsmittel eignen sich Chromverbindungen verschiedener Wertigkeit (z.B. Kalium-Dichromat K2Cr2O7) und Manganverbindungen (z.B. KmnO4), wobei man unter dem CSB im Allgemeinen den chemischen Sauerstoffbedarf nach der Kalium-Dichromat-Methode) versteht. Das Resultat kann als Chromatverbrauch oder Kaliumpermanaganatverbrauch ausgedr�ckt werden (z.B. mg CrO4 2-/l oder mg KMnO4/l). Im allgemeinen ergibt die Kalium-Dichromat-Methode h�here Werte als mit Kaliumpermanganat. Das Verh�ltnis des CSB zum BSB5 gilt als Hinweis auf die Abbaubarkeit der organischen Abwasserinhaltsstoffe. Leicht abbaubare h�usliche Abw�sser haben einen DSB/BSB5-Verh�ltnis von 1 bis 1,5. Schweres abbaubares, industrielles Abwasser ein Verh�ltnis von �ber 2. (arb);
    EliminationCSB: 0.00 .. 100.00 [Units.Percent];  !! Dimensionierungswert Eliminationsrate in %
    EliminationN: 0.00 .. 100.00 [Units.Percent];  !! Denitrifikation bei einer Abwassertemperatur von > 10 Grad
    EliminationNH4: 0.00 .. 100.00 [Units.Percent];  !! Dimensionierungswert: Eliminationsrate in %
    EliminationP: 0.00 .. 100.00 [Units.Percent];  !! Dimensionierungswert Eliminationsrate in %
    Inbetriebnahme: SIA405_Base.Jahr;  !! Jahr der Inbetriebnahme
    NH4: NH4;  !! Dimensionierungswert Ablauf Vorkl�rung. NH4 [gNH4/m3]
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Abwasserreinigungsanlage;

CLASS Privat EXTENDS Organisation =  
!! Privatperson oder Privatorganisation, welche im Rahmen der Entw�sserungsplanung auftritt
  ATTRIBUTE
    Art: TEXT*50;
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Privat;

CLASS Abwasserbauwerk (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Bauwerk in einem Entw�sserungsnetz (dss)
  ATTRIBUTE
    Akten: MTEXT*255;  !! Plan Nr. der Ausf�hrungsdokumentation. Kurzbeschrieb weiterer Akten (Betriebsanleitung vom �, etc.);
    Baujahr: SIA405_Base.Jahr;  !! Jahr der Inbetriebsetzung (Schlussabnahme). Falls unbekannt = 1800 setzen (tiefster Wert des Wertebereichs);
    BaulicherZustand: (          !! Zustandsklassen 0 bis 4 gem�ss VSA-Richtline "Erhaltung von Kanalisationen". Beschreibung des baulichen Zustands des Abwasserbauwerks. Nicht zu verwechseln mit den Sanierungsstufen, welche die Priorit�ten der Massnahmen bezeichnen (Attribut Sanierungsbedarf).
      unbekannt,
      Z0,  !! Nicht mehr funktionst�chtig: Das Abwasserbauwerk ist bereits oder demn�chst nicht mehr durchg�ngig: Bauwerk eingest�rzt, totale Verwurzelung oder andere Abflusshindernisse. Das Bauwerk verliert Wasser (Exfiltration / m�gliche Grundwasserverschmutzung).
      Z1,  !! Starke M�ngel: Bauliche Sch�den, bei welchen die statische Sicherheit, Hydraulik oder Dichtheit nicht mehr gew�hrleistet ist: Br�che axial oder radial, (Rohr-)deformationen, visuell sichtbare Wassereintritte oder Wasseraustritte, L�cher in der Wand, stark vorstehende seitliche Anschl�sse, starke Verwurzelungen, Wand stark ausgewaschen. Ungeeignetes (Rohr-)material.
      Z2,  !! Mittlere M�ngel: Bauliche M�ngel, welche die Statik, Hydraulik oder Dichtheit beeintr�chtigen: breite (Rohr-)fugen, nicht verputzte Einl�ufe, Risse, leichte Abflusshindernisse wie Verkalkungen, vorstehende seitliche Anschl�sse, leichte Wandbesch�digungen, einzelne Wurzeleinw�chse, (Rohr-)wand ausgewaschen usw.
      Z3,  !! Leichte M�ngel: Bauliche M�ngel oder Vorkommnisse, welche f�r die Dichtheit, Hydraulik oder Statik einen unbedeutenden Einfluss haben: breite (Rohr-)fugen, schlecht verputzte seitlichen Anschl�sse, leichte Deformation bei Bauwerken aus Kunststoff, leichte Auswaschungen etc.
      Z4  !! Keine M�ngel
    );
    Baulos: TEXT*50;  !! Nummer des Bauloses
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten
    Detailgeometrie: Base.Surface;  !! Detaillierte Geometrie insbesondere bei Spezialbauwerken. F�r Normsch�chte i.d. R.  Dimension1 und 2 verwenden. Dito bei normierten Versickerungsanlagen.  Kan�le haben normalerweise keine Detailgeometrie.
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr, in dem die Lebensdauer des Bauwerks voraussichtlich abl�uft
    Finanzierung: (          !! Finanzierungart (Finanzierung gem�ss GschG Art. 60a).
      oeffentlich,  !! Gesamtheit aller erdverlegten Leitungen und Bauwerke, die �ber Abwassergeb�hren gem�ss Art. 60a des Gew�sserschutzgesetzes finanziert werden
      privat,  !! Gesamtheit aller erdverlegten Leitungen und Bauwerke, die nicht �ber Abwassergeb�hren gem�ss Art. 60a des Gew�sserschutzgesetzes finanziert werden
      unbekannt
    );
    Inspektionsintervall: Intervall;  !! Abst�nde, in welchen das Abwasserbauwerk inspiziert werden sollte (Jahre);
    Sanierungsbedarf: (          !! Dringlichkeitsstufen und Zeithorizont f�r bauliche Massnahmen gem�ss VSA-Richtline "Erhaltung von Kanalisationen"
      dringend,  !! Die Massnahmen sind dringend auszuf�hren. Sofortmassnahmen wie bei kurzfristig sind zu pr�fen. Zeithorizont 3-4 Jahre.
      keiner,  !! Es sind keine Massnahmen bis zur n�chsten Zustandserfassung und Zustandsbeurteilung erforderlich. Zeithorizont >= 10 Jahre.
      kurzfristig,  !! Die Massnahmen sind sehr dringend und kurzfristig auszuf�hren. Im Sinne von Sofortmassnahmen k�nnen durch provisorische, lokale Reparaturen weitere Sch�den tempor�r verhindert werden. Zeithorizont <= 2 Jahre
      langfristig,  !! Die Massnahmen k�nnen l�ngerfristig geplant werden. Zeithorizont 7-10 Jahre.
      mittelfristig,  !! Die Massnahmen sind mittelfristig erforderlich. Zeithorizont 5-7 Jahre.
      unbekannt
    );
    Standortname: TEXT*50;  !! Strassenname oder Ortsbezeichnung  zum Bauwerk
    Status: Status;  !! Betriebs- bzw. Planungszustand des Bauwerks
    Subventionen: 0.00 .. 99999999.99 [Units.CHF];  !! Staats- und Bundesbeitr�ge
    WBW_Basisjahr: SIA405_Base.Jahr;  !! Basisjahr f�r die Kalkulation des Wiederbeschaffungswerts (siehe auch Attribut Wiederbeschaffungswert);
    WBW_Bauart: (          !! Grobe Einteilung der Bauart des Abwasserbauwerks als Inputwert f�r die Berechnung des Wiederbeschaffungswerts.
      andere,
      Feld,  !! Im Feld (Profiltypen f�r Grabenarbeiten nach Norm SIA 190)
      Sanierungsleitung_Bagger,  !! Bei Sanierungsleitungen, die mit einem Bagger gebaut wurden
      Sanierungsleitung_Grabenfraese,  !! Bei Sanierungsleitungen, die mit einer Grabenfr�se gebaut wurden
      Strasse,  !! In der Strasse (Profiltypen f�r Grabenarbeiten nach Norm SIA 190)
      unbekannt
    );
    Wiederbeschaffungswert: 0.00 .. 99999999.99 [Units.CHF];  !! Wiederbeschaffungswert des Bauwerks. Zus�tzlich muss auch das Attribut WBW_Basisjahr erfasst werden
    Zugaenglichkeit: (          !! M�glichkeit der Zug�nglichkeit ins Innere eines Abwasserbauwerks f�r eine Person (nicht f�r ein Fahrzeug)
      ueberdeckt,  !! Hier muss man z.B. zuerst graben, bis man  z.B. den Deckel �ffnen kann
      unbekannt,
      unzugaenglich,
      zugaenglich  !! Zug�nglich f�r eine Person (und nicht unbedingt ein Fahrzeug)
    );
END Abwasserbauwerk;

CLASS Abwasserbauwerk_Text EXTENDS SIA405_Base.SIA405_TextPos =
END Abwasserbauwerk_Text;

ASSOCIATION Abwasserbauwerk_TextAssoc =   !! Komposition
  AbwasserbauwerkRef -<#> {1} Abwasserbauwerk;
  Text -- {0 .. *} Abwasserbauwerk_Text;
END Abwasserbauwerk_TextAssoc;

CLASS Abwasserbauwerk_Symbol EXTENDS SIA405_Base.SIA405_SymbolPos =
END Abwasserbauwerk_Symbol;

ASSOCIATION Abwasserbauwerk_SymbolAssoc =   !! Komposition
  AbwasserbauwerkRef -<#> {1} Abwasserbauwerk;
  Symbol -- {0 .. *} Abwasserbauwerk_Symbol;
END Abwasserbauwerk_SymbolAssoc;

ASSOCIATION Abwasserbauwerk_EigentuemerAssoc =    !! Assoziation
  EigentuemerRef  -- {1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Abwasserbauwerk_EigentuemerAssocRef -- {0..*} Abwasserbauwerk; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Abwasserbauwerk_EigentuemerAssoc;

ASSOCIATION Abwasserbauwerk_BetreiberAssoc =    !! Assoziation
  BetreiberRef  -- {1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Abwasserbauwerk_BetreiberAssocRef -- {0..*} Abwasserbauwerk; !! F�r den Unterhalt eines Bauwerks zust�ndige Stelle, Rolle2 - Klasse2 / R�le2 - Classe2
END Abwasserbauwerk_BetreiberAssoc;

CLASS Kanal EXTENDS Abwasserbauwerk =  
!! Offenes oder geschlossenes Gerinne zur Ableitung von Abwasser zwischen zwei Abwasserbauwerken
  ATTRIBUTE
    Bettung_Umhuellung: (          !! Art und Weise der unmittelbaren Rohrumgebung im Boden: Bettungsschicht (Unterlage der Leitung),  Verd�mmung (seitliche Auff�llung), Schutzschicht
      andere,
      erdverlegt,  !! Entweder im Aushubmaterial gebettet oder Press-/Schlagvortrieb
      in_Kanal_aufgehaengt,
      in_Kanal_einbetoniert,
      in_Leitungsgang,  !! SIA405 1998: inKulisse IKU
      in_Vortriebsrohr_Beton,
      in_Vortriebsrohr_Stahl,
      Sand,
      SIA_Typ1,  !! Gem�ss Definition SIA Norm 190, Ausgabe 2000
      SIA_Typ2,  !! Gem�ss Definition SIA Norm 190, Ausgabe 2000
      SIA_Typ3,  !! Gem�ss Definition SIA Norm 190, Ausgabe 2000
      SIA_Typ4,  !! Gem�ss Definition SIA Norm 190, Ausgabe 2000
      Sohlbrett,  !! Spezielle Art der Bettung bei Meliorationsleitungen
      unbekannt
    );
    FunktionHierarchisch: (       !! Art des Kanals hinsichtlich Bedeutung im Entw�sserungssystem
      PAA (
        andere,  !! Andere prim�re Abwasseranlagen
         Gewaesser,  !! Erfassung aus Kanalperspektive (z.B. weil hydraulische Berechnung notwendig)
         Hauptsammelkanal,  !! �bergeordneter Sammelkanal. Kann je nach Netzhierarchie vorgenommen werden.
         Hauptsammelkanal_regional,  !! Hauptsammelkanal mit regionaler Bedeutung zur Gliederung des Netzes bei Regionalem GEP, z.B. auf regionalem �bersichtsplan, da dies z.T. nicht �ber die Beziehung Eigent�mer gel�st werden kann.
         Liegenschaftsentwaesserung,  !! Liegenschaftsentw�sserung (hydraulisch relevant). Abgrenzung Liegenschaftsentw�sserung von Geb�udeentw�sserung gem�ss Norm "Planung und Erstellung von Anlagen f�r die Liegenschaftsentw�sserung (SN 592 000)"
         Sammelkanal,  !! Kanal, der das Abwasser aus Liegenschafts- und Strassenentw�sserungen aufnimmt.
         Sanierungsleitung,  !! Entw�sserungsleitung (hydraulisch relevant) zum abwassertechnischen Anschluss von abgelegenen Liegenschaften an die Kanalisation, bei deren Planung und Erstellung gewisse Vereinfachungen zul�ssig sind.
         Strassenentwaesserung,  !! Entw�sserung von Strassen (hydraulisch relevant)
         unbekannt
      ),
      SAA (
         andere,  !! Andere sekund�re Abwasseranlage
         Liegenschaftsentwaesserung,  !! Liegenschaftsentw�sserung (hydraulisch nicht relevant). Abgrenzung Liegenschaftsentw�sserung von Geb�udeentw�sserung gem�ss Norm "Planung und Erstellung von Anlagen f�r die Liegenschaftsentw�sserung (SN 592 000)"
         Sanierungsleitung,  !! Entw�sserungsleitung (hydraulisch nicht relevant) zum abwassertechnischen Anschluss von abgelegenen Liegenschaften an die Kanalisation, bei deren Planung und Erstellung gewisse Vereinfachungen zul�ssig sind.
         Strassenentwaesserung,  !! Entw�sserung von Strassen (hydraulisch nicht relevant)
         unbekannt  !! Entw�sserung von Strassen (hydraulisch nicht relevant)
      )
    );
    FunktionHydraulisch: (          !! Art des Kanals hinsichtlich hydraulischer Ausf�hrung
      andere,
      Drainagetransportleitung,  !! Kanal, welcher Wasser aus Drainageleitungen transportiert
      Drosselleitung,  !! Kanal mit vermindertem Querschnitt zur bewussten Begrenzung, resp. Verminderung des Abflusses. Die Funktionsweise basiert auf Abflussverh�ltnissen unter Druck.
      Duekerleitung,  !! Geschlossenes Leitungssystem zur Unterfahrung eines Hindernisses als Abwasserdruckleitung.
      Freispiegelleitung,  !! Die Freispiegelleitung ist eine Rohrleitung, in der das Wasser gem�ss dem Gesetz der Schwerkraft von einem h�her gelegenen Anfangspunkt zu einem tiefer gelegenen Endpunkt gelangt. (arb)
      Pumpendruckleitung,  !! Druckleitung im Anschluss an ein Pumpwerk
      Sickerleitung,  !! 1. Erdverlegte Leitung zur Sammlung und Ableitung von Hang- und Sickerwasser (SN 592 000) 2. Drainageleitung mit undichten Stossfugen, geschlitzten Rohren oder wasserdurchl�ssigem Rohrmaterial zur Entw�sserung des Baugrundes. (arb)
      Speicherleitung,  !! Zur bewussten R�ckhaltung von Abwassermengen dimensionierte Leitung bei einem Regenr�ckhalte-, einem Fang- oder einem Stauraumkanal
      Spuelleitung,  !! Leitung mit spezieller Funktion zum Sp�len einer Entw�sserungsanlage
      unbekannt,
      Vakuumleitung
    );
    Nutzungsart_geplant: (          !! Durch das Konzept vorgesehene Nutzung (vergleiche auch Nutzungsart_Ist)
      andere,  !! Z.B. auch Zugang, Be- und Entl�ftung
      Bachwasser,  !! Wasser eines Fliessgew�ssers, das gem�ss seinem nat�rlichen Zustand oberfl�chlich, aber an einigen Orten auch in unterirdischen Leitungen abfliesst.
      entlastetes_Mischabwasser,  !! Wasser aus einem Entlastungsbauwerk, welches zum Vorfluter gef�hrt wird. In diesen Kanal darf kein Schmutzabwasser eingeleitet werden.
      Industrieabwasser,  !! Unter Industrieabwasser werden alle Abw�sser verstanden, die bei Produktions- und Verarbeitungsprozessen in der Industrie anfallen. Industrieabw�sser m�ssen i.d.R. vorbehandelt werden, bevor sie in �ffentliche Kl�ranlagen eingeleitet werden k�nnen (siehe Indirekteinleiter). Bei direkter Einleitung in Gew�sser (siehe Direkteinleiter) ist eine umfangreiche Reinigung in speziellen werkseigenen Kl�ranlagen erforderlich.
      Mischabwasser,  !! 1. Mischung von Schmutz- und Regenabwasser, die gemeinsam abgeleitet werden 2. Abwasser welches aus einer Mischung von Schmutzabwasser und Regenabwasser besteht
      Regenabwasser,  !! Wasser aus nat�rlichem Niederschlag, das nicht durch Gebrauch verunreinigt wurde. Die Zuordnung zu verschmutztem oder unverschmutztem Abwasser erfolgt nach der Gew�sserschutzgesetzgebung bzw. nach Anleitung der VSA-Richtlinie "Regenwasserentsorgung"
      Reinabwasser,  !! Sicker-, Grund-, Quell- und Brunnenwasser sowie K�hlwasser aus Durchlaufk�hlungen. Gem�ss Gew�sserschutzgesetz gilt Reinabwasser als unverschmutztes Abwasser  (SN 592 000).
      Schmutzabwasser,  !! Durch Gebrauch ver�ndertes Wasser (h�usliches, gewerbliches oder industrielles Abwasser), das in eine Entw�sserungsanlage eingeleitet und einer Abwasserbehandlung zugef�hrt werden muss. Schmutzabwasser gilt als verschmutztes Abwasser im Sinne des Gew�sserschutzgesetzes (SN 592 000)
      unbekannt
    );
    Nutzungsart_Ist: (          !! F�r prim�re Abwasseranlagen gilt: Heute zul�ssige Nutzung. F�r sekund�re Abwasseranlagen gilt: Heute tats�chliche Nutzung
      andere,  !! Z.B. auch Zugang, Be- und Entl�ftung
      Bachwasser,  !! Wasser eines Fliessgew�ssers, das gem�ss seinem nat�rlichen Zustand oberfl�chlich, aber an einigen Orten auch in unterirdischen Leitungen abfliesst.
      entlastetes_Mischabwasser,  !! Wasser aus einem Entlastungsbauwerk, welches zum Vorfluter gef�hrt wird. In diesen Kanal darf kein Schmutzabwasser eingeleitet werden.
      Industrieabwasser,  !! Unter Industrieabwasser werden alle Abw�sser verstanden, die bei Produktions- und Verarbeitungsprozessen in der Industrie anfallen. Industrieabw�sser m�ssen i.d.R. vorbehandelt werden, bevor sie in �ffentliche Kl�ranlagen eingeleitet werden k�nnen (siehe Indirekteinleiter). Bei direkter Einleitung in Gew�sser (siehe Direkteinleiter) ist eine umfangreiche Reinigung in speziellen werkseigenen Kl�ranlagen erforderlich.
      Mischabwasser,  !! 1. Mischung von Schmutz- und Regenabwasser, die gemeinsam abgeleitet werden 2. Abwasser welches aus einer Mischung von Schmutzabwasser und Regenabwasser besteht
      Regenabwasser,  !! Wasser aus nat�rlichem Niederschlag, das nicht durch Gebrauch verunreinigt wurde. Die Zuordnung zu verschmutztem oder unverschmutztem Abwasser erfolgt nach der Gew�sserschutzgesetzgebung bzw. nach Anleitung der VSA-Richtlinie "Regenwasserentsorgung"
      Reinabwasser,  !! Sicker-, Grund-, Quell- und Brunnenwasser sowie K�hlwasser aus Durchlaufk�hlungen. Gem�ss Gew�sserschutzgesetz gilt Reinabwasser als unverschmutztes Abwasser (SN 592 000).
      Schmutzabwasser,  !! Durch Gebrauch ver�ndertres Wasser (h�usliches, gewerbliches oder industrielles Abwasser), das in eine Entw�sserungsanlage eingeleitet und einer Abwasserbehandlung zugef�hrt werden muss. Schmutzabwasser gilt als verschmutztes Abwasser im Sinne des Gew�sserschutzgesetzes (SN 592 000)
      unbekannt
    );
    Rohrlaenge: 0.00 .. 30000.00 [m];  !! Baul�nge der Einzelrohre oder Fugenabst�nde bei Ortsbetonkan�len
    Spuelintervall: Intervall;  !! Abst�nde in welchen der Kanal gesp�lt werden sollte
    Verbindungsart: (          !! Verbindungstypen
      andere,
      Elektroschweissmuffen,
      Flachmuffen,
      Flansch,
      Glockenmuffen,
      Kupplung,
      Schraubmuffen,
      spiegelgeschweisst,
      Spitzmuffen,
      Steckmuffen,
      Ueberschiebmuffen,
      unbekannt,
      Vortriebsrohrkupplung
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Kanal;

CLASS Normschacht EXTENDS Abwasserbauwerk =  
!! Normiertes Schachtbauwerk mit abnehmbarem Deckel im Kanalnetz
  ATTRIBUTE
    Dimension1: SIA405_Base.Abmessung;  !! Dimension1 des Schachtes (gr�sstes Innenmass).
    Dimension2: SIA405_Base.Abmessung;  !! Dimension2 des Schachtes (kleinstes Innenmass). Bei runden Sch�chten wird Dimension2 leer gelassen, bei ovalen abgef�llt. F�r eckige Sch�chte Detailgeometrie verwenden.
    Funktion: (          !! Art der Nutzung
      Absturzbauwerk,  !! Ein Absturzschacht ist ein spezielles Bauwerk im Kanalisationsnetz zur �berwindung von H�henunterschieden auf kurze Entfernung bei gleichzeitiger Energieumwandlung
      andere,
      Be_Entlueftung,  !! Vorrichtung zum gew�nschten Luftaustausch in Abwasserbauwerken
      Dachwasserschacht,  !! Schacht im Bereich der Lienschaftsentw�sserung, in den in der Regel Abflussrohre vom Dach einm�nden. Diese sind meist kleiner als die Einlaufsch�chte
      Einlaufschacht,  !! Ablauf zur Fassung des Oberfl�chenwasssers bestehend aus einem Schacht mit einem Aufsatz aus einem Rahmen und einem Rost (VSS, SN 640 356)
      Entwaesserungsrinne,  !! L�ngliches Bauelement mit geschlitzten �ffnungen zur Aufnahme von abfliessendem Oberfl�chenwasser
      Geleiseschacht,  !! Normschacht zur Entw�sserung von Geleiseanlagen
      Kontrollschacht,  !! Bauwerk, das den Zugang f�r Unterhalts- und Kontrollzwecke zu Abwasser- und Sickerleitungen erm�glicht
      Oelabscheider,  !! Ein �labscheider ist ein spezielles Bauwerk zum Abscheiden von Leichtfl�ssigkeiten von Abwasser. Es verhindert das Einleiten von �l in den Vorfluter. Die Funktionsweise basiert auf dem Dichteunterschied von Wasser und Benzin, das zum Aufschwimmen des �ls f�hrt.
      Pumpwerk,  !! Anlage zum Heben von Abwasser innerhalb eines Kanalnetzes
      Regenueberlauf,  !! Sonderbauwerk, welches Mischabwasser auftrennt und einen Teil davon direkt dem Gewaesser zuf�hrt.
      Schlammsammler,  !! 1. Einlaufschacht mit Schlammsack  2. Ablauf zur Fassung des Oberfl�chenwasssers auf der Strasse bestehend aus einem Schacht mit Absetzraum mit einem Aufsatz aus einem Rahmen und einem Rost (VSS, SN 640 356)
      Schwimmstoffabscheider,  !! Ein Schwimmstoffabscheider ist ein Schlammsammler entweder mit einem verl�ngerten Tauchbogen oder einer Tauchwand. Wird insbesondere bei Versickerungsanlagen als Vorbehandlung gebraucht
      Spuelschacht,  !! Schacht der zu Sp�lzwecken ben�tigt wird
      Trennbauwerk,  !! Bauwerk, welches Abwasser im System auftrennt, aber nicht aus dem System entlastet. Ein oder mehrere Zul�ufe, zwei oder mehr Abl�ufe
      unbekannt
    );
    Material: (          !! Hauptmaterial aus dem das Bauwerk besteht zur groben Klassifizierung.
      andere,
      Beton,
      Kunststoff,
      unbekannt
    );
    Oberflaechenzulauf: (          !! Zuflussm�glichkeit  von Oberfl�chenwasser direkt in den Schacht
      andere,
      keiner,
      Rost,
      unbekannt,
      Zulauf_seitlich
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Normschacht;

CLASS Einleitstelle EXTENDS Abwasserbauwerk =  
!! Auslauf aus dem Kanal in das Fliessgew�sser
  ATTRIBUTE
    Hochwasserkote: Base.Hoehe;  !! Massgebliche Hochwasserkote der Einleitstelle. Diese ist in der Regel gr�sser als der Wasserspiegel_Hydraulik.
    Relevanz: (          !! Gew�sserrelevanz der Einleitstelle
      gewaesserrelevant,  !! Auslauf einer Kanalisationsleitung in ein Oberfl�chengew�sser mit oder ohne Einleitbauwerk, der den Gew�sserzustand oder die Verh�ltnisse im Gew�sser beeinflusst. Neben den Einleitstellen von PAA-Netzen, die per Definition als gew�sserrelevant gelten, k�nnen auch Einleitstellen von SAA-Leitungsnetzen gew�sserrelevant sein
      nicht_gewaesserrelevant  !! Auslauf einer SAA-Kanalisationsleitung in ein Oberfl�chengew�sser mit oder ohne Einleitbauwerk, der den Gew�sserzustand oder die Verh�ltnisse im Gew�s�ser nicht wesentlich beeinflusst.
    );
    Terrainkote: Base.Hoehe;  !! Terrainkote, falls kein Deckel vorhanden bei Einleitstelle (Kanalende ohne Bauwerk oder Bauwerk ohne Deckel);
    Wasserspiegel_Hydraulik: Base.Hoehe;  !! Wasserspiegelkote f�r die hydraulische Berechnung (IST-Zustand). Berechneter Wasserspiegel bei der Einleitstelle. Wo nichts anders gefordert, ist der Wasserspiegel bei einem HQ30 einzusetzen.
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Einleitstelle;

ASSOCIATION Einleitstelle_GewaessersektorAssoc =    !! Assoziation
  GewaessersektorRef  -- {0..1} Gewaessersektor; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Einleitstelle_GewaessersektorAssocRef -- {0..*} Einleitstelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Einleitstelle_GewaessersektorAssoc;

CLASS Spezialbauwerk EXTENDS Abwasserbauwerk =  
!! Nicht normiertes Abwasserbauwerk mit spezieller Funktion, z.B zur Auftrennung von Abwassermengen, zur �berwindung von H�henunterschieden oder zur Speicherung und Grobkl�rung
  ATTRIBUTE
    Bypass: (          !! Bypass zur Umleitung des Wassers (z.B. w�hrend Unterhalt oder  im Havariefall)
      nicht_vorhanden,
      unbekannt,
      vorhanden
    );
    Funktion: (          !! Art der Nutzung
      abflussloseGrube,  !! Abflusslose Grube
      Absturzbauwerk,  !! Ein Absturzschacht ist ein spezielles Bauwerk im Kanalisationsnetz zur �berwindung von H�henunterschieden auf kurze Entfernung bei gleichzeitiger Energieumwandlung
      Abwasserfaulraum,  !! Abwasserfaulraum: 3 Kammern
      andere,  !! Nur verwenden, wenn kein anderer Wert zutrifft. Die Funktion des Bauwerkes im Feld Bemerkung beschreiben
      Be_Entlueftung,  !! Vorrichtung zum gew�nschten Luftaustausch in Abwasserbauwerken
      Duekerkammer,  !! Spezialbauwerk bei einem Abwasserd�ker zur Entleerung der Leitungen am tiefsten Punkt
      Duekeroberhaupt,  !! Bauwerk zur Aufteilung des Abflusses auf mehrere D�kerrohre
      Faulgrube,  !! Faulgrube: 2 Kammern
      Gelaendemulde,  !! Nat�rliche oder k�nstliche Vertiefung im Boden, um abfliessendes Wasser zur�ckzuhalten
      Geschiebefang,  !! Spezialbauwerk zur Aufnahme von im Wasser mitgef�hrten Material. H�ufig am �bergang zu einem eingedolten Abschnitt
      Guellegrube,  !! G�lle- bzw. Jauchegrube
      Klaergrube,  !! Eine Kl�rgrube (1 Kammer) dient der Entw�sserung einer Liegenschaft, die nicht an die �ffentliche Kanalisation angeschlossen ist. Eine Kl�rgrube ist �blicherweise ein beckenartiges, unterirdisches Bauwerk, in dem sich die festen Stoffe am Boden absetzen, Kl�rgruben m�ssen periodisch geleert werden.
      Kontrollschacht,  !! Bauwerk, das den Zugang f�r Unterhalts- und Kontrollzwecke zu Abwasser- und Sickerleitungen erm�glicht (VSS, SN 640 364)
      Oelabscheider,  !! Ein �labscheider ist ein spezielles Bauwerk zum Abscheiden von Leichtfl�ssigkeiten von Abwasser. Es verhindert das Einleiten von �l in den Vorfluter. Die Funktionsweise basiert auf dem Dichteunterschied von Wasser und Benzin, das zum Aufschwimmen des �ls f�hrt.
      Pumpwerk,  !! Anlage zum Heben von Abwasser innerhalb eines Kanalnetzes
      Regenbecken_Durchlaufbecken,  !! Bauwerk in Mischabwassernetzen zur Absetzung von partikul�ren Stoffen und zur Speicherung von Mischabwasser (Sekund�rwirkung, es k�nnen nur kleine Regenmengen gespeichert werden)
      Regenbecken_Fangbecken,  !! Regen�berlaufbecken, dass zum Fangen des ersten Schmutzstosses dient
      Regenbecken_Fangkanal,  !! Speicherleitung mit oberhalb liegendem �berlauf ins Gew�sser
      Regenbecken_Regenklaerbecken,  !! Absetzbecken f�r Regenabwasser im Trennsystem
      Regenbecken_Regenrueckhaltebecken,  !! Speicherraum f�r Regenabflussspitzen im Misch- oder Regenabwassernetz. Er dient der Entlastung der Kanalisation bei starkem Regen und hat im Gegensatz zu Regen�berlaufbecken keinen �berlauf oder nur einen Not�berlauf zum Gew�sser
      Regenbecken_Regenrueckhaltekanal,  !! Speicherkanal mit der gleichen Funktionsweise wie das Regenr�ckhaltebecken
      Regenbecken_Stauraumkanal,  !! Speicherleitung mit unterhalb liegendem �berlauf ins Gew�sser
      Regenbecken_Verbundbecken,  !! Kombination von Fangbecken und Kl�rbecken
      Regenueberlauf,  !! Sonderbauwerk, welches Mischabwasser auftrennt und einen Teil davon direkt dem Gewaesser zuf�hrt.
      Schwimmstoffabscheider,  !! Ein Schwimmstoffabscheider ist ein Schlammsammler entweder mit einem verl�ngerten Tauchbogen oder einer Tauchwand. Wird insbesondere bei Versickerungsanlagen als Vorbehandlung gebraucht
      seitlicherZugang,  !! Ebenerdiger Zugang zu einem Bauwerk
      Spuelschacht,  !! Schacht, der zu Sp�lzwecken ben�tigt wird
      Trennbauwerk,  !! Bauwerk, welches Abwasser im System auftrennt, aber nicht aus dem System entlastet. Ein oder mehrere Zul�ufe, zwei oder mehr Abl�ufe
      unbekannt,
      Wirbelfallschacht  !! Bauwerk zur m�glichst schadlosen, gef�hrten Ableitung von Wasser �ber eine gewisse  H�henstufe. Das Bauwerk besteht aus Drallkammer, Fallrohr, Toskammer und Rezirkulationsbel�ftungsrohr
    );
    Notueberlauf: (          !! Das Attribut beschreibt, wohin die das Volumen �bersteigende Menge abgeleitet wird (bei Regenr�ckhaltebecken / Regenr�ckhaltekanal).
      andere,
      inMischabwasserkanalisation,
      inRegenabwasserkanalisation,
      inSchmutzabwasserkanalisation,
      keiner,
      unbekannt
    );
    Regenbecken_Anordnung: (          !! Anordnung des Regenbeckens im System. Zus�tzlich zu erfassen falls Spezialbauwerk.Funktion = Regenbecken_*
      Hauptschluss,  !! Durchfluss des Beckens bei Trockenwetter und teilweiser Durchfluss bei Regenwetter
      Nebenschluss,  !! Durchfluss des Beckens nur bei Regenwetter
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Spezialbauwerk;

CLASS Versickerungsanlage EXTENDS Abwasserbauwerk =  
!! Einbringen von Reinabwasser und wenig verschmutztem Regenabwasser in den Untergrund (Definition gem�ss VSA Richtlinie Regenwasserentsorgung 2002)
  ATTRIBUTE
    Art: (          !! Arten von Versickerungsmethoden.
      andere_mit_Bodenpassage,
      andere_ohne_Bodenpassage,
      Flaechenfoermige_Versickerung,  !! fl�chenf�rmige Versickerung
      Kieskoerper,
      Kombination_Schacht_Strang,
      MuldenRigolenversickerung,
      unbekannt,
      Versickerung_ueber_die_Schulter,
      Versickerungsbecken,
      Versickerungsschacht,
      Versickerungsstrang_Galerie
    );
    Beschriftung: (          !! Kennzeichnung der Schachtdeckel der Anlage als Versickerungsanlage.  Nur bei Anlagen mit Sch�chten.
      beschriftet,
      nichtbeschriftet,
      unbekannt
    );
    Dimension1: SIA405_Base.Abmessung;  !! Dimension1 der Versickerungsanlage (gr�sstes Innenmass) bei der Verwendung von Normbauteilen. Sonst leer lassen und mit Detailgeometrie beschreiben.
    Dimension2: SIA405_Base.Abmessung;  !! Dimension2 der Versickerungsanlage (kleinstes Innenmass) bei der Verwendung von Normbauteilen. Sonst leer lassen und mit Detailgeometrie beschreiben.
    GWDistanz: 0.00 .. 30000.00 [m];  !! Flurabstand (Vertikale Distanz Terrainoberfl�che zum Grundwasserleiter).
    Maengel: (          !! Gibt die aktuellen M�ngel der Versickerungsanlage an (IST-Zustand).
      keine,
      unwesentliche,  !! "unwesentliche" heisst, dass keine Nachkontrolle n�tig ist
      wesentliche  !! "wesentliche" heisst, dass eine Nachkontrolle n�tig ist
    );
    Notueberlauf: (          !! Endpunkt allf�lliger Verrohrung des Not�berlaufes der Versickerungsanlage
      inMischwasserkanalisation,  !! "inMischwasserkanalisation" heisst, dass die Versickerung direkt verrohrt ist und nicht frei �ber das Gel�nde zwischendurch l�uft (unerw�nschter Zustand)
      inRegenwasserkanalisation,  !! "inRegenwasserkanalisation" heisst, dass die Versickerung direkt verrohrt ist und nicht frei �ber das Gel�nde  zwischendurch l�uft (unerw�nschter Zustand)
      inVorfluter,  !! Direkte Rohrverbindung zu einem Vorfluter (unerw�nschte Konstruktion)
      keiner,
      oberflaechlichausmuendend,  !! Das Wasser �berfliesst beim Einstau �ber die Versickerungsanlage hinaus an die Oberfl�che (gew�nschter Zustand / Hinweis auf verstopfte Anlage).
      unbekannt
    );
    Saugwagen: (          !! Zug�nglichkeit f�r Saugwagen. Sie bezieht sich auf die gesamte Versickerungsanlage / Vorbehandlungsanlagen und kann in den Bemerkungen weiter spezifiziert werden
      unbekannt,
      unzugaenglich,
      zugaenglich
    );
    Schluckvermoegen: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Schluckverm�gen des Bodens.
    Versickerungswasser: (          !! Arten des zu versickernden Wassers.
      Regenabwasser,  !! Wasser aus nat�rlichem Niederschalg, das nicht durch Gebrauch verunreinigt wurde. Die Zuordnung zu verschmutztem oder unverschmutztem Abwasser erfolgt nach der Gew�sserschutzgesetzgebung bzw. nach Anleitung der Richtlinie "Regenwasserentsorgung"
      Reinabwasser,
      unbekannt
    );
    Wasserdichtheit: (          !! Wasserdichtheit gegen Oberfl�chenwasser.  Nur bei Anlagen mit Sch�chten.
      nichtwasserdicht,
      unbekannt,
      wasserdicht
    );
    Wirksameflaeche: 0.00 .. 100000.00 [Units.m2];  !! F�r den Abfluss wirksame Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Versickerungsanlage;

ASSOCIATION Versickerungsanlage_GrundwasserleiterAssoc =    !! Assoziation
  GrundwasserleiterRef  -- {0..1} Grundwasserleiter; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Versickerungsanlage_GrundwasserleiterAssocRef -- {0..*} Versickerungsanlage; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Versickerungsanlage_GrundwasserleiterAssoc;

CLASS ARABauwerk EXTENDS Abwasserbauwerk =  
!! Reinigungsbecken einer Kl�ranlage
  ATTRIBUTE
    Art: (          !! Art des Beckens oder Verfahrens im ARA Bauwerk
      Absetzbecken,
      andere,
      Belebtschlammbecken,
      Festbettreaktor,
      Tauchtropfkoerper,
      Tropfkoerper,
      unbekannt,
      Vorklaerbecken
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END ARABauwerk;

CLASS Erhaltungsereignis EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Aussagen zu betrieblichem und baulichem Unterhalt eines Abwasserbauwerkes
  ATTRIBUTE
    Art: (          !! Art des Ereignisses
      andere,
      Erneuerung,  !! Herstellung neuer Abwasserkan�le in der bisherigen oder anderer Linienf�hrung, wobei die neuen Anlagen die Funktion der urspr�nglichen Abwasserkan�le einbeziehen (SN EN 752).
      Reinigung,  !! Reinigung oder Entleerung
      Renovierung,  !! Massnahmen zur Verbesserung der aktuellen Funktionsf�higkeit von Abwasserkan�len unter vollst�ndiger oder teilweiser Einbezug ihrer urspr�nglichen Substanz  (SN EN 752). In �lteren Normen und Richtlinien wird diese Massnahme mit "Sanierung" bezeichnet.
      Reparatur,  !! Massnahmen zur Behebung �rtlich begrenzter Sch�den (SN EN 752). In �lteren Normen und Richtlinien wird diese Massnahme mit "Instandsetzung" bezeichnet.
      Sanierung,  !! Alle Massnahmen zur Wiederherstellung oder Verbesserung von vorhandenen Entw�sserungsanlagen. Die Massnahmen umfassen Reparatur, Renovierung und Erneuerung  (SN EN 752). In �lteren Normen und Richtlinien wird dieser Begriff mit "Erhaltung" bezeichnet.
      unbekannt,
      Untersuchung
    );
    Ausfuehrender: TEXT*50;  !! Sachbearbeiter Firma oder Verwaltung
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Datengrundlage: TEXT*50;  !! Z.B. Schadensprotokoll
    Dauer: 0 .. 10000 [Units.d];  !! Dauer des Ereignisses in Tagen
    Detaildaten: TEXT*50;  !! Ort, wo sich weitere Detailinformationen zum Ereignis finden (z.B. Nr. eines Videobandes);
    Ergebnis: TEXT*50;  !! Resultat oder wichtige Bemerkungen aus Sicht des Bearbeiters
    Grund: TEXT*50;  !! Ursache f�r das Ereignis
    Kosten: 0.00 .. 99999999.99 [Units.CHF];
    Status: (          !! Phase in der sich das Erhaltungsereignis befindet
      ausgefuehrt,
      geplant,
      nicht_moeglich,  !! Falls eine geplante Untersuchung nicht durchgef�hrt werden konnte.
      unbekannt
    );
    Zeitpunkt: INTERLIS_1_DATE;  !! Zeitpunkt des Ereignisses
END Erhaltungsereignis;

ASSOCIATION Erhaltungsereignis_AbwasserbauwerkAssoc =    !! Assoziation
  AbwasserbauwerkRef  -- {0..*} Abwasserbauwerk; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Erhaltungsereignis_AbwasserbauwerkAssocRef -- {0..*} Erhaltungsereignis; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Erhaltungsereignis_AbwasserbauwerkAssoc;

ASSOCIATION Erhaltungsereignis_Ausfuehrender_FirmaAssoc =    !! Assoziation
  Ausfuehrender_FirmaRef  -- {0..1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Erhaltungsereignis_Ausfuehrender_FirmaAssocRef -- {0..1} Erhaltungsereignis; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Erhaltungsereignis_Ausfuehrender_FirmaAssoc;

CLASS Zone (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! F�r bestimmte Zwecke ausgeschiedene Bereiche
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
END Zone;

CLASS Planungszone EXTENDS Zone =  
!! Zonen gem�ss Bauordnung
  ATTRIBUTE
    Art: (          !! Art der Bauzone
      andere,
      Gewerbezone,
      Industriezone,
      Landwirtschaftszone,
      unbekannt,
      Wohnzone
    );
    Perimeter: Gebietseinteilung;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Planungszone;

CLASS Versickerungsbereich EXTENDS Zone =  
!! Bereiche nach Versickerungsm�glichkeit
  ATTRIBUTE
    Perimeter: Gebietseinteilung;  !! Begrenzungspunkte der Fl�che
    Versickerungsmoeglichkeit: (          !! Versickerungsm�glichkeit im Bereich
      gut,
      keine,
      maessig,
      schlecht,
      unbekannt,
      unzulaessig
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Versickerungsbereich;

CLASS Entwaesserungssystem EXTENDS Zone =  
!! Art und Weise, wie ein bestimmtes Gebiet entw�ssert werden soll. (dss)
  ATTRIBUTE
    Art: (          !! Art des Entw�sserungssystems in dem ein bestimmtes Gebiet entw�ssert werden soll (SOLL Zustand)
      Melioration,
      Mischsystem,  !! Im Mischsystem werden h�usliches, gewerbliches und industrielles Schmutzwasser und das Niederschlagswasser im Gegensatz zur Trennkanalisation gemeinsam in einer Kanalisation abgeleitet. Aufgrund der begrenzten Leistungsf�higkeit der Kl�ranlage und um aus technischen und wirtschaftlichen Erfordernissen den Kanalquerschnitt zu begrenzen, werden im Mischsystem an geeigneten Stellen Regenentlastungsbauwerke oder Regenr�ckhalter�ume angeordnet. Durch Regen�berl�ufe in den Hauptkan�len gelangen vor allem in der Anfangsphase von Starkniederschl�gen wegen der Sp�lwirkung hohe Schmutzmengen in die Kl�ranlage. Deshalb werden verst�rkt Regenr�ckhaltebecken gebaut, die diesen "Sp�lsto�" auffangen und allm�hlich an die Kl�ranlage abgeben sollen. Unverschmutztes Wasser - wie Abfluss von Au�engebieten, Dr�nagewasser, Quellen, Brunnen, usw. - darf nicht in den Mischwasserkanal eingeleitet werden. Dies wird am Entstehungsort oder nach Ableitung verrieselt, versickert oder direkt in ein Oberfl�chengew�sser eingeleitet.
      ModifiziertesSystem,  !! Entw�sserungssystem, �blicherweise bestehend aus zwei Leitungssystemen f�r die getrennte Ableitung von Misch- und Regenabwasser. Das niederschlagsabh�ngige Abwasser von Strassen und Pl�tzen wird zusammen mit dem Schmutzabwasser abgeleitet. Unverschmutztes Dach- und Sickerwasser wird in die Regenabwasserkanalisation abgeleitet. (dss)
      nicht_angeschlossen,
      Trennsystem,  !! Entw�sserungssystem, �blicherweise bestehend aus zwei Leitungs-/Kanalsystemen f�r die getrennte Ableitung von Schmutz- und Regenwasser
      unbekannt
    );
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Entwaesserungssystem;

CLASS Gewaesserschutzbereich EXTENDS Zone =  
!! Definiertes Gebiet, welches die Art des Schutzes bez�glich Gef�hrdung der Oberfl�chengew�sser und des Grundwassers definiert.
  ATTRIBUTE
    Art: (          !! Art des Schutzbereiches f�r  oberfl�chliches Gew�sser und Grundwasser bez�glich Gef�hrdung
      A,  !! Alte Klassifizierung vor 1998
      Ao,  !! Der Gew�sserschutzbereich Ao umfasst das oberirdische Gew�sser und desser Uferbereiche, soweit dies zur Gew�hrleistung einer besonderen Nutzung erforderlich ist (GSchV 1998, Anhang 4, 112)
      Au,  !! Der Gew�sserschutzbereich Au umfasst die nutzbaren unterirdischen Gew�sser sowie die zu ihrem Schutz notwendigen Randgebiete (GSchV 1998 Anhang 4, 111)
      B,  !! Alte Klassifizierung vor 1998
      C,  !! Alte Klassifizierung vor 1998
      unbekannt,
      Zo,  !! Der Zustr�mbereich Zo umfasst das Einzugsgebiet, aus dem der gr�sste Teil der Verunreinigungen des oberirdischen Gew�ssers stammt (GSchV 1998, Anhang 4, 114)
      Zu  !! Der Zustr�mbereich Zu umfasst das Gebeit, aus dem bei niedrigem Wasserstand etwa 90 Prozent des Grundwasser, das bei einer Grundwasserfassung h�chstens entnommen werden darf, stammt. (GSchV 1998)
    );
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Gewaesserschutzbereich;

CLASS Grundwasserschutzareal EXTENDS Zone =  
!! Areale, die f�r die k�nftige Nutzung und Anreicherung von Grundwasservorkommen von Bedeutung sind
  ATTRIBUTE
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Grundwasserschutzareal;

CLASS Grundwasserschutzzone EXTENDS Zone =  
!! Definiertes Gebiet, welches die im �ffentlichen Interesse liegenden Grundwasserfassungen und Anreicherungsanlagen definiert und die notwendigen Eigentumsbeschr�nkungen festlegt.
  ATTRIBUTE
    Art: (          !! Zonenarten. Grundwasserschutzzonen bestehen aus dem Fassungsbereich (Zone S1), der Engeren Schutzzone (Zone S2) und der Weiteren Schutzzone (Zone S3).
      S1,  !! Fassungsbereich
      S2,  !! Engere Schutzzone
      S3,  !! Weitere Schutzzone
      unbekannt
    );
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Grundwasserschutzzone;

CLASS Rohrprofil EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Form des Fliessquerschnittes mit Angabe der Dimension
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    HoehenBreitenverhaeltnis: Verhaeltnis_H_B;  !! Verh�ltnis der H�he zur Breite
    Profiltyp: (          !! Typ des Profils
      Eiprofil,  !! Nur f�r Norm-Eiprofile gem�ss DIN 4263 mit H�henbreitenverh�ltnis von 1.5 verwenden. Andere Eiprofile, auch solche mit Einbauten, sind als �Spezialprofil� zu attributieren und die Profildefinition ist mitzuliefern.
      Kreisprofil,  !! Nur f�r reine Kreisprofile ohne Trockenwetterrinne oder andere Einbauten verwenden. Sonst als �Spezialprofil� attributieren und die Profildefinition mitliefern.
      Maulprofil,  !! Nur f�r Norm-Maulprofile gem�ss DIN 4263 verwenden. Abweichende Varianten, auch solche mit Einbauten, sind als �Spezialprofil� zu attributieren und die Profildefinition ist mitzuliefern.
      offenes_Profil,  !! F�r offene Profile. Profildefinition mitliefern
      Rechteckprofil,  !! Nur f�r reine Rechteckprofile ohne Trockenwetterrinne oder andere Einbauten verwenden. Sonst als �Spezialprofil� attributieren und die Profildefinition mitliefern.
      Spezialprofil,  !! F�r geschlossene nicht-Normprofile. Profildefinition mitliefern.
      unbekannt
    );
END Rohrprofil;

CLASS ARAEnergienutzung EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Betriebsdaten zur Energienutzung auf der ARA
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Gasmotor: 0 .. 100000 [SIA405_Base.kW];  !! elektrische Leistung
    Turbinierung: 0 .. 100000 [SIA405_Base.kW];  !! Energienutzung aufgrund des Gasanfalls auf der ARA
    Waermepumpe: 0 .. 100000 [SIA405_Base.kW];  !! Energienutzung aufgrund des W�rmeanfalls auf der ARA
END ARAEnergienutzung;

ASSOCIATION ARAEnergienutzung_AbwasserreinigungsanlageAssoc =    !! Komposition
  AbwasserreinigungsanlageRef  -<#> {1} Abwasserreinigungsanlage; !! Rolle1 - Klasse1 / R�le1 - Classe1
  ARAEnergienutzung_AbwasserreinigungsanlageAssocRef -- {0..*} ARAEnergienutzung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END ARAEnergienutzung_AbwasserreinigungsanlageAssoc;

CLASS Abwasserbehandlung EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Gezielte Ver�nderung der Abwasserbeschaffenheit z.B. durch Reinigen, Neutralisation auf einer ARA
  ATTRIBUTE
    Art: (          !! Verfahren f�r die Abwasserbehandlung
      andere,
      biologisch,
      chemisch,
      Filtration,
      mechanisch,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
END Abwasserbehandlung;

ASSOCIATION Abwasserbehandlung_AbwasserreinigungsanlageAssoc =    !! Komposition
  AbwasserreinigungsanlageRef  -<#> {1} Abwasserreinigungsanlage; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Abwasserbehandlung_AbwasserreinigungsanlageAssocRef -- {0..*} Abwasserbehandlung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Abwasserbehandlung_AbwasserreinigungsanlageAssoc;

CLASS Schlammbehandlung EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Daten zur Schlammbehandlung auf der ARA
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    EntwaessertKlaerschlammstapelung: 0.00 .. 10000000.00 [Units.m3];  !! Dimensionierungswert
    Entwaesserung: 0.00 .. 10000.00 [SIA405_Base.m3h];  !! Dimensionierungswert
    Faulschlammverbrennung: 0.00 .. 10000.00 [SIA405_Base.m3h];  !! Dimensionierungswert der Verbrennungsanlage
    Fluessigklaerschlammstapelung: 0.00 .. 10000000.00 [Units.m3];  !! Dimensionierungswert
    Frischschlammverbrennung: 0.00 .. 10000.00 [SIA405_Base.m3h];  !! Dimensionierungswert der Verbrennungsanlage
    Hygienisierung: 0.00 .. 10000.00 [SIA405_Base.m3h];  !! Dimensionierungswert
    Kompostierung: 0.00 .. 10000.00 [SIA405_Base.m3h];  !! Dimensionierungswert
    Mischschlammvoreindickung: 0.00 .. 10000000.00 [Units.m3];  !! Dimensionierungswert
    PrimaerschlammVoreindickung: 0.00 .. 10000000.00 [Units.m3];  !! Dimensionierungswert
    Stabilisierung: (          !! Art der Schlammstabilisierung
      aerobkalt,
      aerobthermophil,
      anaerobkalt,
      anaerobmesophil,
      anaerobthermophil,
      andere,
      unbekannt
    );
    Trocknung: 0.00 .. 10000.00 [SIA405_Base.m3h];  !! Leistung thermische Trocknung
    Ueberschusschlammvoreindickung: 0.00 .. 10000000.00 [Units.m3];  !! Dimensionierungswert
END Schlammbehandlung;

ASSOCIATION Schlammbehandlung_AbwasserreinigungsanlageAssoc =    !! Komposition
  AbwasserreinigungsanlageRef  -<#> {1} Abwasserreinigungsanlage; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Schlammbehandlung_AbwasserreinigungsanlageAssocRef -- {0..*} Schlammbehandlung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Schlammbehandlung_AbwasserreinigungsanlageAssoc;

CLASS Steuerungszentrale EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Gegenstelle zu Absperr_Drosselorgan / Ueberlauf  (Hydr_Einbaute) mit Signal�bermittlung
  ATTRIBUTE
    Bezeichnung: MANDATORY TEXT*20;
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
END Steuerungszentrale;

CLASS Gewaesserverbauung (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Punktuelle Verbauung am oder im Gew�sser wie Schwellen etc.
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
END Gewaesserverbauung;

ASSOCIATION Gewaesserverbauung_GewaesserabschnittAssoc =    !! Assoziation
  GewaesserabschnittRef  -- {0..1} Gewaesserabschnitt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gewaesserverbauung_GewaesserabschnittAssocRef -- {0..*} Gewaesserverbauung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gewaesserverbauung_GewaesserabschnittAssoc;

CLASS Furt EXTENDS Gewaesserverbauung =  
!! Sohlengleiche Kreuzung eines Verkehrsweges mit einem Gew�sser mit k�nstlicher Sohle in diesem Bereich
  ATTRIBUTE
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Furt;

CLASS GewaesserAbsturz EXTENDS Gewaesserverbauung =  
!! Senkrechter Absturz von Wasser in einem Gew�sser
  ATTRIBUTE
    Absturzhoehe: 0.00 .. 30000.00 [m];  !! Differenz des Wasserspiegels vor und nach dem Absturz
    Material: (          !! Material aus welchem der Absturz besteht
      andere,
      Beton_Steinpflaesterung,
      Fels_Steinbloecke,
      Holz,
      natuerlich_kein,
      unbekannt
    );
    Typ: (          !! Art des Absturzes
      kuenstlich,
      natuerlich,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END GewaesserAbsturz;

CLASS Schleuse EXTENDS Gewaesserverbauung =  
!! K�nstliche Wasserkammer mit regulierbarem internem Wasserspiegel
  ATTRIBUTE
    Absturzhoehe: 0.00 .. 30000.00 [m];  !! Differenz im Wasserspiegel oberhalb und unterhalb der Schleuse
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Schleuse;

CLASS Durchlass EXTENDS Gewaesserverbauung =  
!! Eindolungen unter Strassen, Wegen u.a. mit einer L�nge von unter 15m (ansonsten Gew�sserabschnitt eingedolt)
  ATTRIBUTE
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Durchlass;

CLASS Geschiebesperre EXTENDS Gewaesserverbauung =  
!! Querbauwerke mit �ffnungen, welche den Geschiebetransport bei Hochwasser zur�ckhalten
  ATTRIBUTE
    Absturzhoehe: 0.00 .. 30000.00 [m];  !! Differenz des Wasserspiegels vor und nach der Sperre
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Geschiebesperre;

CLASS GewaesserWehr EXTENDS Gewaesserverbauung =  
!! Wehr im Gew�sser
  ATTRIBUTE
    Absturzhoehe: 0.00 .. 30000.00 [m];  !! Differenz des Wasserspiegels vor und nach dem Absturz
    Art: (          !! Art des Wehres
      Stauwehr,
      Streichwehr,
      Talsperre,
      Tirolerwehr,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END GewaesserWehr;

CLASS Sohlrampe EXTENDS Gewaesserverbauung =  
!! Fl�chige Sohlbefestigungen im Gew�sser
  ATTRIBUTE
    Absturzhoehe: 0.00 .. 30000.00 [m];  !! Differenz des Wasserspiegels vor und nach dem Absturz
    Befestigung: (          !! Befestigungsart der Sohlrampe
      andere_glatt,
      andere_rauh,
      Betonrinne,
      Blockwurf,
      gepflaestert,
      Holzbalken,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Sohlrampe;

CLASS Fischpass EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Anlage, die Fischen das �berwinden einer Sohlenstufe erm�glicht
  ATTRIBUTE
    Absturzhoehe: 0.00 .. 30000.00 [m];  !! Differenz des Wasserspiegels vor und nach dem Fischpass
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
END Fischpass;

ASSOCIATION Fischpass_GewaesserverbauungAssoc =    !! Assoziation
  GewaesserverbauungRef  -- {0..1} Gewaesserverbauung; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Fischpass_GewaesserverbauungAssocRef -- {0..1} Fischpass; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Fischpass_GewaesserverbauungAssoc;

CLASS Badestelle EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Badestelle eines Gew�ssers
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
END Badestelle;

ASSOCIATION Badestelle_OberflaechengewaesserAssoc =    !! Assoziation
  OberflaechengewaesserRef  -- {0..1} Oberflaechengewaesser; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Badestelle_OberflaechengewaesserAssocRef -- {0..*} Badestelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Badestelle_OberflaechengewaesserAssoc;

CLASS Hydr_Geometrie EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Beschreibt die hydraulische Geometrie eines Knotens
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Nutzinhalt: 0.00 .. 10000000.00 [Units.m3];  !! Inhalt der Kammer unterhalb Not�berlauf oder Bypass (maximal mobilisierbares Volumen, inkl. Stauraum im Zulaufkanal). F�r RRB und RRK. F�r R�B Nutzinhalt_Fangteil und Nutzinhalt_Klaerteil benutzen. Zus�tzlich auch Stauraum erfassen.
    Nutzinhalt_Fangteil: 0.00 .. 10000000.00 [Units.m3];  !! Inhalt der Kammer unterhalb der Wehrkrone ohne Stauraum im Zulaufkanal. Letzterer wird unter dem Attribut Stauraum erfasst (bei Anordnung im Hauptschluss auf der Stammkarte des Hauptbauwerkes, bei Anordnung im Nebenschluss auf der Stammkarte des vorgelagerten Trennbauwerkes oder Regen�berlaufs);
    Nutzinhalt_Klaerteil: 0.00 .. 10000000.00 [Units.m3];  !! Inhalt der Kammer unterhalb der Wehrkrone inkl. Einlaufbereich, Auslaufbereich und Sedimentationsbereich, ohne Stauraum im Zulaufkanal. Letzterer wird unter dem Attribut Stauraum erfasst (bei Anordnung im Hauptschluss auf der Stammkarte des Hauptbauwerkes, bei Anordnung im Nebenschluss auf der Stammkarte des vorgelagerten Trennbauwerkes oder Regen�berlaufs);
    Stauraum: 0.00 .. 10000000.00 [Units.m3];  !! Speicherinhalt im Becken und im Zulauf zwischen Wehrkrone und dem Wasserspiegel bei Qan. Bei Regenbecken�berlaufbecken im Nebenschluss ist der Stauraum beim vorgelagerten Trennbauwerk bzw. Regen�berlauf zu erfassen (vgl. Erl�uterungen Inhalt_Fangteil reps. _Klaerteil). Bei Pumpen: Speicherinhalt im Zulaufkanal unter dem Wasserspiegel beim Einschalten der Pumpe (h�chstes Einschaltniveau bei mehreren Pumpen);
    Volumen_Pumpensumpf: 0.00 .. 10000000.00 [Units.m3];  !! Volumen des Pumpensumpfs von der Sohle bis zur maximal m�glichen Wasserspiegellage (inkl. Kanalspeichervolumen im Zulaufkanal).
END Hydr_Geometrie;

CLASS Abwassernetzelement (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Modelltechnischer Begriff f�r Abwasserknoten und Haltungen in der VSA-DSS
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
END Abwassernetzelement;

ASSOCIATION Abwassernetzelement_AbwasserbauwerkAssoc =    !! Assoziation
  AbwasserbauwerkRef  -- {0..1} Abwasserbauwerk; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Abwassernetzelement_AbwasserbauwerkAssocRef -- {0..*} Abwassernetzelement; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Abwassernetzelement_AbwasserbauwerkAssoc;

CLASS Haltungspunkt EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Anfangs- oder Endpunkt einer Haltung mit Detailinformationen zur Verbindung zwischen Abwassernetzelementen.
  ATTRIBUTE
    Auslaufform: (          !! Art des Auslaufs
      abgerundet,
      blendenfoermig,
      keine_Querschnittsaenderung,
      scharfkantig,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Hoehengenauigkeit: (          !! Quantifizierung der Genauigkeit der H�henlage der Kote in Relation zum H�henfixpunktnetz (z.B. Grundbuchvermessung oder Landesnivellement).
      groesser_6cm,  !! Dies ist der Bereich der H�hengenauigkeit aller Punkte, die nur gesch�tzt sind
      plusminus_1cm,  !! Dies ist der Bereich der H�hengenauigkeit eines nivellierten Punktes
      plusminus_3cm,  !! Dies ist der Bereich der H�hengenauigkeit eines mit GPS eingemessenen Punktes
      plusminus_6cm,  !! Dies ist die H�hengenauigkeit eines mit Vermessungswerkzeugen (Theodolit) eingemessenen Punktes
      unbekannt
    );
    Kote: Base.Hoehe;  !! Sohlenh�he des Haltungsendes
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
    Lage_Anschluss: Ziffernblatt;  !! Anschlussstelle bezogen auf Querschnitt im Kanal; in Fliessrichtung  (f�r Haus- und Strassenanschl�sse);
END Haltungspunkt;

ASSOCIATION Haltungspunkt_AbwassernetzelementAssoc =    !! Assoziation
  AbwassernetzelementRef  -- {0..1} Abwassernetzelement; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Haltungspunkt_AbwassernetzelementAssocRef -- {0..*} Haltungspunkt; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Haltungspunkt_AbwassernetzelementAssoc;

CLASS Abwasserknoten EXTENDS Abwassernetzelement =  
!! Verbindung zwischen zwei Haltungen, hydraulischer Bezugspunkt des Abwasserbauwerks (dss)
  ATTRIBUTE
    Lage: Base.LKoord;  !! Lage des Knotens, massgebender Bezugspunkt f�r die Kanalnetzberechnung. (In der Regel Lage des Pickellochs oder Lage des Trockenwetterauslaufs);
    Rueckstaukote: Base.Hoehe;  !! 1. Massgebende R�ckstaukote bezogen auf den Berechnungsregen (dss)  2. H�he, unter der innerhalb der Grundst�cksentw�sserung besondere Massnahmen gegen R�ckstau zu treffen sind. (DIN 4045);
    Sohlenkote: Base.Hoehe;  !! Tiefster Punkt des Abwasserbauwerks
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Abwasserknoten;

ASSOCIATION Abwasserknoten_Hydr_GeometrieAssoc =    !! Assoziation
  Hydr_GeometrieRef  -- {0..1} Hydr_Geometrie; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Abwasserknoten_Hydr_GeometrieAssocRef -- {0..1} Abwasserknoten; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Abwasserknoten_Hydr_GeometrieAssoc;

CLASS Haltung EXTENDS Abwassernetzelement =  
!! Hydraulisch homogenes Transportelement des Kanalnetzes, Berechnungsabschnitt einer Abflusssimulation.
  ATTRIBUTE
    Innenschutz: (          !! Schutz der Innenw�nde des Kanals
      andere,
      Anstrich_Beschichtung,
      Kanalklinkerauskleidung,
      Steinzeugauskleidung,
      unbekannt,
      Zementmoertelauskleidung
    );
    LaengeEffektiv: 0.00 .. 30000.00 [m];  !! Tats�chliche schr�ge L�nge (d.h. nicht in horizontale Ebene projiziert)  inklusive Kanalkr�mmungen
    Lagebestimmung: (          !! Definiert die Lagegenauigkeit der Verlaufspunkte.
      genau,  !! +/- 10 cm, bei der Lagebestimmung aus unterschiedlichen Messungen das Dreifache, d.h. +/- 30 cm (Norm SIA405)
      unbekannt,
      ungenau  !! Siehe genau
    );
    Lichte_Hoehe: Lichte_Hoehe;  !! Maximale Innenh�he des Kanalprofiles
    Material: (          !! Rohrmaterial
      andere,
      Asbestzement,
      Beton_Normalbeton,
      Beton_Ortsbeton,
      Beton_Pressrohrbeton,
      Beton_Spezialbeton,
      Beton_unbekannt,
      Faserzement,
      Gebrannte_Steine,
      Guss_duktil,
      Guss_Grauguss,
      Kunststoff_Epoxydharz,
      Kunststoff_Hartpolyethylen,
      Kunststoff_Polyester_GUP,
      Kunststoff_Polyethylen,
      Kunststoff_Polypropylen,
      Kunststoff_Polyvinilchlorid,  !! Ein Polymerisatkunstoff, der hart, weich oder niedrig�molekular eingestellt werden kann. In der Abwassertechnik als Rohstoff f�r Rohre verwendet. (arb)
      Kunststoff_unbekannt,  !! Kunststoff unbekannter Art
      Stahl,
      Stahl_rostfrei,
      Steinzeug,
      Ton,
      unbekannt,
      Zement
    );
    Plangefaelle: Gefaelle_Promille;  !! Auf dem alten Plan eingezeichnetes Plangef�lle [%o]. Nicht kontrolliert im Feld. Kann nicht f�r die hydraulische Berechnungen �bernommen werden. F�r Liegenschaftsentw�sserung und Meliorationsleitungen. Darstellung als z.B. 3.5%oP auf Pl�nen.
    Reibungsbeiwert: Strickler;  !! Hydraulische Kenngr�sse zur Beschreibung der Beschaffenheit der Kanalwandung. Beiwert f�r die Formeln nach Manning-Strickler (K oder kstr);
    Reliner_Art: (          !! Art des Relinings
      ganze_Haltung,
      partiell,
      unbekannt
    );
    Reliner_Bautechnik: (          !! Bautechnik f�r das Relining. Zus�tzlich wird der Einbau des Reliners als  Erhaltungsereignis abgebildet: Erhaltungsereignis.Art = Reparatur f�r Partieller_Liner, sonst Renovierung.
      andere,
      Close_Fit_Relining,
      Kurzrohrrelining,
      Noppenschlauchrelining,
      Partieller_Liner,
      Rohrstrangrelining,
      Schlauchrelining,
      unbekannt,
      Wickelrohrrelining
    );
    Reliner_Material: (          !! Material des Reliners
      andere,
      Epoxidharz_Glasfaserlaminat,  !! Epoxidharz Glasfaserlaminat
      Epoxidharz_Kunststofffilz,  !! Epoxidharz Kunststofffilz
      GUP_Rohr,  !! Rohr aus glasfaserverst�rktem, unges�ttigtem Polyester : GUP oder GF-UP
      HDPE,
      Isocyanatharze_Glasfaserlaminat,  !! Isocynatharze Glasfaserlaminat
      Isocyanatharze_Kunststofffilz,  !! Isocyanatharze_Kunststofffilz
      Polyesterharz_Glasfaserlaminat,  !! Polyesterharz Glasfaserlaminat
      Polyesterharz_Kunststofffilz,  !! Polyesterharz Kunststofffilz
      Polypropylen,
      Polyvinilchlorid,
      Sohle_mit_Schale_aus_Polyesterbeton,  !! Sohle mit Schale aus Polyesterbeton
      unbekannt,
      UP_Harz_LED_Synthesefaserliner,  !! Synthesefaserliner mit unges�ttigtes Polyesterharz (UP Harz), H�rtung mit UV-LED
      Vinylesterharz_Glasfaserlaminat,  !! Vinylesterharz Glasfaserlaminat
      Vinylesterharz_Kunststofffilz  !! Vinylesterharz Kunststofffilz
    );
    Reliner_Nennweite: Lichte_Hoehe;  !! Profilh�he des Inliners (innen). Beim Export in Hydrauliksoftware m�sste dieser Wert statt Haltung.Lichte_Hoehe �bernommen werden um korrekt zu simulieren.
    Ringsteifigkeit: 0 .. 16;  !! Ringsteifigkeitsklasse - Druckfestigkeit gegen Belastungen von aussen (gem�ss ISO 13966 );
    Verlauf: Base.Polyline;  !! Anfangs-, Knick- und Endpunkte der Leitung
    Wandrauhigkeit: Prandtl;  !! Hydraulische Kenngr�sse zur Beschreibung der Beschaffenheit der Kanalwandung. Beiwert f�r die Formeln nach Prandtl-Colebrook (ks oder kb);
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Haltung;

CLASS Haltung_Text EXTENDS SIA405_Base.SIA405_TextPos =
END Haltung_Text;

ASSOCIATION Haltung_TextAssoc =   !! Komposition
  HaltungRef -<#> {1} Haltung;
  Text -- {0 .. *} Haltung_Text;
END Haltung_TextAssoc;

CLASS Haltung_AlternativVerlauf EXTENDS Base.BaseClass =
   Verlauf: Base.Polyline;  !!  Anfangs-, Knick- und Endpunkte des Alternativ-Verlaufs der Leitung im gew�hlten Plantyp (z.B. Uebersichtsplan)
   Plantyp: SIA405_Base.Plantyp;   !! Default: Uebersichtsplan
END Haltung_AlternativVerlauf;

ASSOCIATION Haltung_AlternativVerlaufAssoc =   !! Komposition
  HaltungRef -<#> {1} Haltung;
  Alternativverlauf -- {0 .. *} Haltung_AlternativVerlauf;
END Haltung_AlternativVerlaufAssoc;

ASSOCIATION Haltung_vonHaltungspunktAssoc =    !! Assoziation
  vonHaltungspunktRef  -- {1} Haltungspunkt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Haltung_vonHaltungspunktAssocRef -- {0..1} Haltung; !! {XOR (Haltung)}, Rolle2 - Klasse2 / R�le2 - Classe2
END Haltung_vonHaltungspunktAssoc;

ASSOCIATION Haltung_nachHaltungspunktAssoc =    !! Assoziation
  nachHaltungspunktRef  -- {1} Haltungspunkt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Haltung_nachHaltungspunktAssocRef -- {0..1} Haltung; !! {XOR (Haltung)}, Rolle2 - Klasse2 / R�le2 - Classe2
END Haltung_nachHaltungspunktAssoc;

ASSOCIATION Haltung_RohrprofilAssoc =    !! Assoziation
  RohrprofilRef  -- {0..1} Rohrprofil; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Haltung_RohrprofilAssocRef -- {0..*} Haltung; !! {XOR (Haltung)}, Rolle2 - Klasse2 / R�le2 - Classe2
END Haltung_RohrprofilAssoc;

CLASS Rohrprofil_Geometrie EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Geometrie des Rohrprofils als x/y-Punkte mit Lichte_Hoehe = 1
  ATTRIBUTE
    Position: Position;  !! Position der Detailpunkte der Geometrie
    x: Number;
    y: Number;
END Rohrprofil_Geometrie;

ASSOCIATION Rohrprofil_Geometrie_RohrprofilAssoc =    !! Komposition
  RohrprofilRef  -<#> {1} Rohrprofil; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Rohrprofil_Geometrie_RohrprofilAssocRef -- {0..*} Rohrprofil_Geometrie; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Rohrprofil_Geometrie_RohrprofilAssoc;

CLASS Hydr_GeomRelation EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Tripel aus benetztem Querschnitt, benetzter Fl�che und Kote
  ATTRIBUTE
    BenetzteQuerschnittsflaeche: 0.00 .. 100000.00 [Units.m2];  !! Hydraulisch wirksamer Querschnitt f�r Verlustberechnungen
    Wasseroberflaeche: 0.00 .. 100000.00 [Units.m2];  !! Freie Wasserspiegelfl�che; f�r Speicherfunktionen massgebend
    Wassertiefe: 0.00 .. 30000.00 [m];  !! Massgebende Wassertiefe
END Hydr_GeomRelation;

ASSOCIATION Hydr_GeomRelation_Hydr_GeometrieAssoc =    !! Assoziation
  Hydr_GeometrieRef  -- {1} Hydr_Geometrie; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Hydr_GeomRelation_Hydr_GeometrieAssocRef -- {0..*} Hydr_GeomRelation; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Hydr_GeomRelation_Hydr_GeometrieAssoc;

CLASS MechanischeVorreinigung EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Behandlungsanlage von Versickerungsanlage (gem�ss VSA Richtlinie Regenwasserentsorgung 2002)
  ATTRIBUTE
    Art: (          !! Arten der mechanischen Vorreinigung / Behandlung (gem�ss VSA Richtlinie Regenwasserentsorgung (2002))
      Filtersack,
      KuenstlicherAdsorber,
      MuldenRigolenSystem,  !! Versickerunganlage, in der das unverschmutzte Regenabwasser in einer Mulde gesammelt und anschliessend �ber eine humusietre Bodenschicht in eine tieferliegende Sickerleitung versickert wird. (gem�ss VSA Richtlinie Regenwasserentsorgung (Ausgabe 2002))
      Schlammsammler,  !! 3. Bei Versickerungsanlage gem�ss VSA Richtlinie Regenwasserentsorgung (Ausgabe 2002)
      Schwimmstoffabscheider,  !! Baute zum Abscheiden von Schwimmstoffen (gem�ss VSA Richtlinie Regenwasserentsorgung (Ausgabe 2002))
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
END MechanischeVorreinigung;

ASSOCIATION MechanischeVorreinigung_VersickerungsanlageAssoc =    !! Komposition
  VersickerungsanlageRef  -<#> {1} Versickerungsanlage; !! Rolle1 - Klasse1 / R�le1 - Classe1
  MechanischeVorreinigung_VersickerungsanlageAssocRef -- {0..*} MechanischeVorreinigung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END MechanischeVorreinigung_VersickerungsanlageAssoc;

ASSOCIATION MechanischeVorreinigung_AbwasserbauwerkAssoc =    !! Assoziation
  AbwasserbauwerkRef  -- {0..1} Abwasserbauwerk; !! Rolle1 - Klasse1 / R�le1 - Classe1
  MechanischeVorreinigung_AbwasserbauwerkAssocRef -- {0..*} MechanischeVorreinigung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END MechanischeVorreinigung_AbwasserbauwerkAssoc;

CLASS Retentionskoerper EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Retentionsk�rper einer Versickerungsanlage
  ATTRIBUTE
    Art: (          !! Arten der Retention
      andere,
      Biotop,
      Dachretention,
      Parkplatz,
      Staukanal,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Retention_Volumen: 0.00 .. 10000000.00 [Units.m3];  !! Nutzbares Volumen des Retentionsk�rpers
END Retentionskoerper;

ASSOCIATION Retentionskoerper_VersickerungsanlageAssoc =    !! Komposition
  VersickerungsanlageRef  -<#> {1} Versickerungsanlage; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Retentionskoerper_VersickerungsanlageAssocRef -- {0..*} Retentionskoerper; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Retentionskoerper_VersickerungsanlageAssoc;

CLASS Ueberlaufcharakteristik EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Quantitative Angaben zum Ueberlauf
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Kennlinie_digital: (          !! Falls Kennlinie_digital = ja m�ssen die Attribute f�r die Q-Q oder H-Q Beziehung in HQ_Relation ausgef�llt sein.
      ja,
      nein,
      unbekannt
    );
    Kennlinie_Typ: (          !! Die Kennlinie ist als Q /Q- (bei Boden�ffnungen) oder als H/Q-Tabelle (bei Streichwehren) zu dokumentieren. Bei einer freien Aufteilung muss die Kennlinie nicht dokumentiert werden. Bei Abflussverh�ltnissen in Einstaubereichen ist die Funktion separat in einer Beilage zu beschreiben.
      HQ,  !! H-Q Beziehung: Hoehe (H) und Durchfluss (Q) Richtung ARA abf�llen
      QQ,  !! Q-Q-Beziehung: Zufluss (Q1) und Durchfluss Richtung ARA (Q2) abf�llen
      unbekannt
    );
END Ueberlaufcharakteristik;

CLASS HQ_Relation EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Korrelation von Wasserspiegelh�he in Funktion des Abflusses. Die Kennlinie beschreibt den Verlauf der Menge in Prim�rrichtung des Trennbauwerkes bei verschiedenen Zufluss resp. Einstau-Verh�ltnissen. Sie muss aus mindestens 2 St�tzpunkten bestehen. Kann zus�tzlich als Tabelle / Ausdruck aus dem Berechnungsmodell oder als Tabelle abgegeben werden.
  ATTRIBUTE
    Abfluss: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Abflussmenge (Q2) Richtung ARA
    Hoehe: Base.Hoehe;  !! Zum Abfluss (Q2) korrelierender Wasserspiegel (h);
    Zufluss: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Zufluss (Q1);
END HQ_Relation;

ASSOCIATION HQ_Relation_UeberlaufcharakteristikAssoc =    !! Assoziation
  UeberlaufcharakteristikRef  -- {1} Ueberlaufcharakteristik; !! Rolle1 - Klasse1 / R�le1 - Classe1
  HQ_Relation_UeberlaufcharakteristikAssocRef -- {0..*} HQ_Relation; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END HQ_Relation_UeberlaufcharakteristikAssoc;

CLASS BauwerksTeil (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Bauliche Bestandteile und Einrichtungen eines Abwasserbauwerkes
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Instandstellung: (          !! Zustandsinformation zum Bauwerksteil
      nicht_notwendig,
      notwendig,
      unbekannt
    );
END BauwerksTeil;

ASSOCIATION BauwerksTeil_AbwasserbauwerkAssoc =    !! Komposition
  AbwasserbauwerkRef  -<#> {1} Abwasserbauwerk; !! Rolle1 - Klasse1 / R�le1 - Classe1
  BauwerksTeil_AbwasserbauwerkAssocRef -- {0..*} BauwerksTeil; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END BauwerksTeil_AbwasserbauwerkAssoc;

CLASS Trockenwetterfallrohr EXTENDS BauwerksTeil =  
!! Fallrohr in einem Absturzschacht zur Ableitung des Zuflusses bei Trockenwetter und Schwachregen
  ATTRIBUTE
    Durchmesser: SIA405_Base.Abmessung;  !! Abmessung des Deckels (bei eckigen Deckeln minimale Abmessung);
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Trockenwetterfallrohr;

CLASS Einstiegshilfe EXTENDS BauwerksTeil =  
!! Element, welches den Zugang zu einem Abwasserbauwerk erm�glicht.
  ATTRIBUTE
    Art: (          !! Art des Einstiegs in das Bauwerk
      andere,
      Drucktuere,
      keine,
      Leiter,
      Steigeisen,
      Treppe,
      Trittnischen,
      Tuere,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Einstiegshilfe;

CLASS Trockenwetterrinne EXTENDS BauwerksTeil =  
!! Bauliche Einengung des Kanalquerschnittes zwecks Erh�hung der Fliessgeschwindigkeit f�r den Trockenwetteranfall
  ATTRIBUTE
    Material: (          !! Material der Ausbildung oder Auskleidung der Trockenwetterrinne
      andere,
      kombiniert,
      Kunststoff,
      Steinzeug,
      unbekannt,
      Zementmoertel
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Trockenwetterrinne;

CLASS Deckel EXTENDS BauwerksTeil =  
!! Abnehmbare Abdeckung eines Schachtbauwerkes
  ATTRIBUTE
    Deckelform: (          !! Form des Deckels
      andere,
      eckig,
      rund,
      unbekannt
    );
    Durchmesser: SIA405_Base.Abmessung;  !! Abmessung des Deckels (bei eckigen Deckeln minimale Abmessung);
    Entlueftung: (          !! Deckel mit L�ftungsl�chern versehen
      entlueftet,
      nicht_entlueftet,
      unbekannt
    );
    Fabrikat: TEXT*50;  !! Name der Herstellerfirma
    Kote: Base.Hoehe;  !! Deckelh�he
    Lage: Base.LKoord;  !! Lage des Deckels (Pickelloch);
    Lagegenauigkeit: (          !! Quantifizierung der Genauigkeit der Lage des Deckels (Pickelloch)
      groesser_50cm,
      plusminus_10cm,
      plusminus_3cm,
      plusminus_50cm,
      unbekannt
    );
    Material: (          !! Deckelmaterial
      andere,
      Beton,
      Guss,
      Guss_mit_Belagsfuellung,
      Guss_mit_Betonfuellung,
      unbekannt
    );
    Schlammeimer: (          !! Angabe, ob der Deckel mit einem Schlammeimer versehen ist oder nicht
      nicht_vorhanden,
      unbekannt,
      vorhanden
    );
    Verschluss: (          !! Befestigungsart des Deckels
      nicht_verschraubt,
      unbekannt,
      verschraubt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Deckel;

CLASS ElektrischeEinrichtung EXTENDS BauwerksTeil =  
!! Elektrische Installationen und Ger�te in einem Abwasserbauwerk
  ATTRIBUTE
    Art: (          !! Elektrische Installationen und Ger�te
      andere,
      Beleuchtung,
      Fernwirkanlage,
      Funk,
      Telephon,
      unbekannt
    );
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten der elektromechanischen Ausr�stung
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr, in dem die Lebensdauer der elektrischen Einrichtung voraussichtlich ausl�uft
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END ElektrischeEinrichtung;

CLASS ElektromechanischeAusruestung EXTENDS BauwerksTeil =  
!! Elektromechanische Teile eines Bauwerks eines Abwasserbauwerks
  ATTRIBUTE
    Art: (          !! Elektromechanische Teile eines Bauwerks
      andere,
      Leckwasserpumpe,
      Luftentfeuchter,
      Raeumeinrichtung,  !! f�r Details siehe neue Klasse Beckenreinigung
      unbekannt
    );
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten der elektromechanischen Ausr�stung
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr in dem die Lebensdauer der elektromechanischen Ausr�stung voraussichtlich abl�uft
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END ElektromechanischeAusruestung;

CLASS Bankett EXTENDS BauwerksTeil =  
!! Bankett im Kanal oder Schacht
  ATTRIBUTE
    Art: (        
      andere,
      beidseitig,
      einseitig,
      kein,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Bankett;

CLASS Anschlussobjekt (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Sammelbegriff f�r an die Kanalisation angeschlossenen Objekte
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Fremdwasseranfall: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Durchschnittlicher Fremdwasseranfall f�r Fremdwasserquellen wie Laufbrunnen oder Reservoir�berlauf
END Anschlussobjekt;

ASSOCIATION Anschlussobjekt_AbwassernetzelementAssoc =    !! Assoziation
  AbwassernetzelementRef  -- {0..1} Abwassernetzelement; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Anschlussobjekt_AbwassernetzelementAssocRef -- {0..*} Anschlussobjekt; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Anschlussobjekt_AbwassernetzelementAssoc;

ASSOCIATION Anschlussobjekt_EigentuemerAssoc =    !! Assoziation
  EigentuemerRef  -- {0..1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Anschlussobjekt_EigentuemerAssocRef -- {0..*} Anschlussobjekt; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Anschlussobjekt_EigentuemerAssoc;

ASSOCIATION Anschlussobjekt_BetreiberAssoc =    !! Assoziation
  BetreiberRef  -- {0..1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Anschlussobjekt_BetreiberAssocRef -- {0..*} Anschlussobjekt; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Anschlussobjekt_BetreiberAssoc;

CLASS Gebaeude EXTENDS Anschlussobjekt =  
!! Geb�ude
  ATTRIBUTE
    Hausnummer: TEXT*50;  !! Hausnummer gem�ss Grundbuch
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
    Referenzpunkt: Base.LKoord;  !! Landeskoordinate Ost/Nord (massgebender Bezugspunkt f�r z.B. Adressdaten );
    Standortname: TEXT*50;  !! Strassenname oder Ortsbezeichnung
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Gebaeude;

CLASS Reservoir EXTENDS Anschlussobjekt =  
!! Reservoir
  ATTRIBUTE
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
    Standortname: TEXT*50;  !! Strassenname oder Ortsbezeichnung
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Reservoir;

CLASS Einzelflaeche EXTENDS Anschlussobjekt =  
!! Zusammenh�ngende Gebiete mit gleicher Oberfl�chencharakteristik
  ATTRIBUTE
    Befestigung: (          !! Art der Befestigung
      andere,
      befestigt,
      bestockt,
      humusiert,
      unbekannt,
      vegetationslos
    );
    Funktion: (          !! Art der Nutzung der Fl�che
      andere,
      Bahnanlagen,
      DachflaecheIndustrieundGewerbebetriebe,
      DachflaecheWohnundBuerogebaeude,
      Erschliessungs_Sammelstrassen,
      Parkplaetze,
      UmschlagundLagerplaetze,
      unbekannt,
      Verbindungs_Hauptverkehrs_Hochleistungsstrassen,
      VorplaetzeZufahrten
    );
    Neigung: Neigung_Promille;  !! Mittlere Neigung der Oberfl�che in Promill
    Perimeter: Base.Surface;  !! Begrenzungspunkte der Fl�che
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Einzelflaeche;

CLASS Brunnen EXTENDS Anschlussobjekt =  
!! Brunnen
  ATTRIBUTE
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
    Standortname: TEXT*50;  !! Strassenname oder Ortsbezeichnung
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Brunnen;

CLASS Gefahrenquelle EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Quelle abwassergef�hrdender Soffe
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
END Gefahrenquelle;

ASSOCIATION Gefahrenquelle_AnschlussobjektAssoc =    !! Assoziation
  AnschlussobjektRef  -- {0..1} Anschlussobjekt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gefahrenquelle_AnschlussobjektAssocRef -- {0..*} Gefahrenquelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gefahrenquelle_AnschlussobjektAssoc;

ASSOCIATION Gefahrenquelle_EigentuemerAssoc =    !! Assoziation
  EigentuemerRef  -- {0..1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Gefahrenquelle_EigentuemerAssocRef -- {0..*} Gefahrenquelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Gefahrenquelle_EigentuemerAssoc;

CLASS Unfall EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Unfall, dessen Folgen das Grundwasser, das Gew�sser, den ARA- und Kanalnetzbetrieb gef�hrden k�nnen
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Datum: INTERLIS_1_DATE;  !! Datum des Ereignisses
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord des Unfallortes
    Ort: TEXT*50;  !! Adresse der Unfallstelle
    Verursacher: TEXT*50;  !! Name Adresse des Verursachers
END Unfall;

ASSOCIATION Unfall_GefahrenquelleAssoc =    !! Assoziation
  GefahrenquelleRef  -- {0..1} Gefahrenquelle; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Unfall_GefahrenquelleAssocRef -- {0..*} Unfall; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Unfall_GefahrenquelleAssoc;

CLASS Stoff EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Wassergef�hrdender Stoff
  ATTRIBUTE
    Art: TEXT*50;  !! Liste der wassergef�hrdenden Stoffe
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Lagerung: TEXT*50;  !! Art der Lagerung der abwassergef�hrdenden Stoffe
END Stoff;

ASSOCIATION Stoff_GefahrenquelleAssoc =    !! Komposition
  GefahrenquelleRef  -<#> {1} Gefahrenquelle; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Stoff_GefahrenquelleAssocRef -- {1..*} Stoff; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Stoff_GefahrenquelleAssoc;

CLASS Einzugsgebiet EXTENDS SIA405_Base.SIA405_BaseClass =  
!! 1. Definiertes Gebiet, welches in einen bestimmten Abwasserknoten oder in eine bestimmte Haltung entw�ssert (Teileinzugsgebiet) . (dss) 2. Gebiet mit Abfluss zu einer Abwasserleitung, einem Abwasserkanal oder einem Gew�sser. (DIN 752)
  ATTRIBUTE
    Abflussbegrenzung_geplant: 0.0 .. 999.9 [lsha];  !! Abflussbegrenzung, falls eine entsprechende Auflage aus dem Entw�sserungskonzept vorliegt. Dieses Attribut hat Auflagecharakter. Es ist verbindlich f�r die Beurteilung von Baugesuchen
    Abflussbegrenzung_Ist: 0.0 .. 999.9 [lsha];  !! Abflussbegrenzung, falls eine entsprechende Auflage bereits umgesetzt ist.
    Abflussbeiwert_RW_geplant: 0.00 .. 100.00 [Units.Percent];  !! Abflussbeiwert f�r den Regenabwasseranschluss im Planungszustand
    Abflussbeiwert_RW_Ist: 0.00 .. 100.00 [Units.Percent];  !! Abflussbeiwert f�r den Regenabwasseranschluss im Ist-Zustand
    Abflussbeiwert_SW_geplant: 0.00 .. 100.00 [Units.Percent];  !! Abflussbeiwert f�r den Schmutz- oder Mischabwasseranschluss im Planungszustand
    Abflussbeiwert_SW_Ist: 0.00 .. 100.00 [Units.Percent];  !! Abflussbeiwert f�r den Schmutz- oder Mischabwasseranschluss im Ist-Zustand
    Befestigungsgrad_RW_geplant: 0.00 .. 100.00 [Units.Percent];  !! Befestigungsgrad f�r den Regenabwasseranschluss im Planungszustand
    Befestigungsgrad_RW_Ist: 0.00 .. 100.00 [Units.Percent];  !! Befestigungsgrad f�r den Regenabwasseranschluss im Ist-Zustand
    Befestigungsgrad_SW_geplant: 0.00 .. 100.00 [Units.Percent];  !! Befestigungsgrad f�r den Schmutz- oder Mischabwasseranschluss im Planungszustand
    Befestigungsgrad_SW_Ist: 0.00 .. 100.00 [Units.Percent];  !! Befestigungsgrad f�r den Schmutz- oder Mischabwasseranschluss im Ist-Zustand
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Direkteinleitung_in_Gewaesser_geplant: (          !! Das Regenabwasser wird in Zukunft ganz oder teilweise �ber eine SAA-Leitung in ein Gew�sser eingeleitet
      ja,
      nein,
      unbekannt
    );
    Direkteinleitung_in_Gewaesser_Ist: (          !! Das Regenabwasser wird ganz oder teilweise �ber eine SAA-Leitung in ein Gew�sser eingeleitet
      ja,
      nein,
      unbekannt
    );
    Einwohnerdichte_geplant: Einwohnerdichte;  !! Dichte der (physischen) Einwohner im Planungszustand
    Einwohnerdichte_Ist: Einwohnerdichte;  !! Dichte der (physischen) Einwohner im Ist-Zustand
    Entwaesserungssystem_geplant: (          !! Entw�sserungsart im Planungszustand (nach Umsetzung des Entw�sserungskonzepts). Dieses Attribut hat Auflagecharakter. Es ist verbindlich f�r die Beurteilung von Baugesuchen
      Mischsystem,  !! Das Schmutzabwasser und das nicht versickerbare Regenabwasser sind an das Mischabwassernetz anzuschliessen. Verbindung zu SW/MW-Knoten obligatorisch, Verbindung zu RW-Knoten nicht zul�ssig.
      ModifiziertesSystem,  !! Im Unterschied zum reinen Trennsystem, wird beim modifizierten System nicht nur der minimale Anteil an �verschmutztem� Regenabwasser auf die Abwasserreinigungsanlage abgeleitet (gem�ss der aktuellen Gew�sserschutzgesetzgebung vorgeschriebenen Anteil) sondern zus�tzlich auch noch ein Teil �nicht verschmutztes� Regenabwasser. Verbindung zu SW/MW-Knoten ist obligatorisch. Verbindung zu RW-Knoten ist zul�ssig.
      nicht_angeschlossen,  !! Teileinzugsgebiet, das entw�ssert wird, aber (auch in Zukunft) nicht an eine PAA angeschlossen ist. Z.B. eine Fl�che, die �ber eine SAA direkt in ein Gew�sser entw�ssert wird, oder eine Fl�che mit Versickerung �ber die Schulter. Keine Verbindung mit dem Kanalnetz zul�ssig.
      nicht_entwaessert,  !! Fl�che innerhalb des �ffentlichen Kanalisationsbereichs, die auch in Zukunft nicht erschlossen wird (seltener Fall). Keine Verbindung mit dem Kanalnetz zul�ssig.
      Trennsystem,  !! Entw�sserungssystem, �blicherweise bestehend aus zwei Leitungs-/Kanalsystemen f�r die getrennte Ableitung von Schmutz- und Regenabwasser. Schmutzabwasser und Regenabwasser welches gem�ss aktueller Gesetzgebung als verschmutzt gilt, sind an das Schmutzabwassernetz anzuschliessen; nicht verschmutztes Regenabwasser, das nicht versickert werden kann, an das Regenabwassernetz. Verbindung zu SW/MW-Knoten ist obligatorisch. Verbindung zu RW-Knoten ist zul�ssig.
      unbekannt  !! Dieser Wert ist nur bei einer noch nicht abgeschlossenen GEP-Bearbeitung zul�ssig. Keine Regeln bez�glich Verbindung zum Kanalnetz.
    );
    Entwaesserungssystem_Ist: (          !! Effektive Entw�sserungsart im Ist-Zustand
      Mischsystem,  !! Schmutz- und Regenabwasser sind an das Mischabwassernetz angeschlossen. Verbindung zu SW/MW-Knoten obligatorisch, Verbindung zu RW-Knoten nicht zul�ssig.
      ModifiziertesSystem,  !! Im Unterschied zum reinen Trennsystem, ist beim modifizierten System nicht nur der minimale Anteil an �verschmutztem� Regenabwasser auf die Abwasserreinigungsanlage abgeleitet (gem�ss der aktuellen Gew�sserschutzgesetzgebung vorgeschriebenen Anteil) sondern zus�tzlich auch noch ein Teil �nicht verschmutztes� Regenabwasser. Verbindung zu SW/MW-Knoten ist obligatorisch. Verbindung zu RW-Knoten zul�ssig.
      nicht_angeschlossen,  !! Teileinzugsgebiet das entw�ssert wird, aber nicht an eine PAA angeschlossen ist. Z.B. eine Fl�che, die �ber eine SAA direkt in ein Gew�sser entw�ssert wird, oder eine Fl�che mit Versickerung �ber die Schulter. Keine Verbindung mit dem Kanalnetz zul�ssig.
      nicht_entwaessert,  !! Entw�sserungstechnisch (noch) nicht erschlossene Fl�che innerhalb des �ffentlichen Kanalisationsbereichs. Z.B. noch nicht �berbaute Parzelle innerhalb der Bauzone. Keine Verbindung mit dem Kanalnetz zul�ssig.
      Trennsystem,  !! Entw�sserungssystem, �blicherweise bestehend aus zwei Leitungs-/Kanalsystemen f�r die getrennte Ableitung von Schmutz- und Regenabwasser. Schmutzabwasser und Regenabwasser welches gem�ss aktueller Gesetzgebung als verschmutzt gilt, sind an das Schmutzabwassernetz angeschlossen, nicht verschmutztes Regenabwasser an das Regenabwassernetz. Verbindung zu SW/MW-Knoten ist obligatorisch. Verbindung zu RW-Knoten zul�ssig.
      unbekannt  !! Das Entw�sserungssystem ist noch nicht bekannt. Dieser Wert ist nur bei einer noch nicht abgeschlossenen GEP-Bearbeitung zul�ssig. Keine Regeln bez�glich Verbindung zum Kanalnetz.
    );
    Flaeche: 0.0000 .. 100000.0000 [Units.ha];  !! Redundantes Attribut Flaeche, welches die aus dem Perimeter errechnete Flaeche [ha] enth�lt
    Fremdwasseranfall_geplant: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Mittlerer Fremdwasseranfall, der im Planungszustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird.
    Fremdwasseranfall_Ist: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Mittlerer Fremdwasseranfall, der im Ist-Zustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird
    Perimeter: Base.Surface;  !! Begrenzungspunkte des Teileinzugsgebiets
    Retention_geplant: (          !! Das Regen- oder Mischabwasser wird in Zukunft �ber R�ckhalteeinrichtungen verz�gert ins Kanalnetz eingeleitet.
      ja,
      nein,
      unbekannt
    );
    Retention_Ist: (          !! Das Regen- oder Mischabwasser wird �ber R�ckhalteeinrichtungen verz�gert ins Kanalnetz eingeleitet.
      ja,
      nein,
      unbekannt
    );
    Schmutzabwasseranfall_geplant: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Mittlerer Schmutzabwasseranfall, der im Planungszustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird.
    Schmutzabwasseranfall_Ist: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Mittlerer Schmutzabwasseranfall, der im Ist-Zustand in die Schmutz- oder Mischabwasserkanalisation eingeleitet wird
    Versickerung_geplant: (          !! Das Regenabwasser wird in Zukunft ganz oder teilweise einer Versickerungsanlage zugef�hrt
      ja,
      nein,
      unbekannt
    );
    Versickerung_Ist: (          !! Das Regenabwasser wird ganz oder teilweise einer Versickerungsanlage zugef�hrt
      ja,
      nein,
      unbekannt
    );
END Einzugsgebiet;

CLASS Einzugsgebiet_Text EXTENDS SIA405_Base.SIA405_TextPos =
END Einzugsgebiet_Text;

ASSOCIATION Einzugsgebiet_TextAssoc =   !! Komposition
  EinzugsgebietRef -<#> {1} Einzugsgebiet;
  Text -- {0 .. *} Einzugsgebiet_Text;
END Einzugsgebiet_TextAssoc;

ASSOCIATION Einzugsgebiet_Abwassernetzelement_RW_IstAssoc =    !! Assoziation
  Abwassernetzelement_RW_IstRef  -- {0..1} Abwassernetzelement; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Einzugsgebiet_Abwassernetzelement_RW_IstAssocRef -- {0..*} Einzugsgebiet; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Einzugsgebiet_Abwassernetzelement_RW_IstAssoc;

ASSOCIATION Einzugsgebiet_Abwassernetzelement_RW_geplantAssoc =    !! Assoziation
  Abwassernetzelement_RW_geplantRef  -- {0..1} Abwassernetzelement; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Einzugsgebiet_Abwassernetzelement_RW_geplantAssocRef -- {0..*} Einzugsgebiet; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Einzugsgebiet_Abwassernetzelement_RW_geplantAssoc;

ASSOCIATION Einzugsgebiet_Abwassernetzelement_SW_geplantAssoc =    !! Assoziation
  Abwassernetzelement_SW_geplantRef  -- {0..1} Abwassernetzelement; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Einzugsgebiet_Abwassernetzelement_SW_geplantAssocRef -- {0..*} Einzugsgebiet; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Einzugsgebiet_Abwassernetzelement_SW_geplantAssoc;

ASSOCIATION Einzugsgebiet_Abwassernetzelement_SW_IstAssoc =    !! Assoziation
  Abwassernetzelement_SW_IstRef  -- {0..1} Abwassernetzelement; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Einzugsgebiet_Abwassernetzelement_SW_IstAssocRef -- {0..*} Einzugsgebiet; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Einzugsgebiet_Abwassernetzelement_SW_IstAssoc;

CLASS Oberflaechenabflussparameter (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Kennzahlen zur Beschreibung des Oberfl�chenabflusses wie z.B. Benutzungs- oder Muldenverluste
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Benetzungsverlust: Verlust;  !! Verlust durch Haftung des Niederschlages an Pflanzen- und andere Oberfl�che
    Bezeichnung: MANDATORY TEXT*20;
    Muldenverlust: Verlust;  !! Verlust durch Muldenf�llung
    Verdunstungsverlust: Verlust;  !! Verlust durch Verdunstung
    Versickerungsverlust: Verlust;  !! Verlust durch Infiltration
END Oberflaechenabflussparameter;

ASSOCIATION Oberflaechenabflussparameter_EinzugsgebietAssoc =    !! Assoziation
  EinzugsgebietRef  -- {1} Einzugsgebiet; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Oberflaechenabflussparameter_EinzugsgebietAssocRef -- {0..1} Oberflaechenabflussparameter; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Oberflaechenabflussparameter_EinzugsgebietAssoc;

CLASS Messstelle EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Ort an welchem zusammenh�gende Messungen erhoben werden, z.B. benthosbiologische Untersuchungsstelle
  ATTRIBUTE
    Art: TEXT*50;  !! Art der Untersuchungsstelle ( Regenmessungen, Abflussmessungen, etc.);
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Lage: Base.LKoord;  !! Landeskoordinate Ost/Nord
    Staukoerper: (        
      andere,
      keiner,
      Ueberfallwehr,  !! Alle Formen wie Dreieckwehr etc.
      unbekannt,
      Venturieinschnuerung
    );
    Zweck: (          !! Zweck der Messung
      beides,  !! Kostenverteilung und technischer Zweck
      Kostenverteilung,
      technischer_Zweck,  !! Technischer Zweck, z.B. zur Steuerung
      unbekannt
    );
END Messstelle;

ASSOCIATION Messstelle_ReferenzstelleAssoc =    !! Assoziation
  ReferenzstelleRef  -- {0..*} Messstelle; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messstelle_ReferenzstelleAssocRef -- {0..*} Messstelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messstelle_ReferenzstelleAssoc;

ASSOCIATION Messstelle_BetreiberAssoc =    !! Assoziation
  BetreiberRef  -- {0..1} Organisation; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messstelle_BetreiberAssocRef -- {0..*} Messstelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messstelle_BetreiberAssoc;

ASSOCIATION Messstelle_AbwasserreinigungsanlageAssoc =    !! Assoziation
  AbwasserreinigungsanlageRef  -- {0..1} Abwasserreinigungsanlage; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messstelle_AbwasserreinigungsanlageAssocRef -- {0..*} Messstelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messstelle_AbwasserreinigungsanlageAssoc;

ASSOCIATION Messstelle_AbwasserbauwerkAssoc =    !! Assoziation
  AbwasserbauwerkRef  -- {0..1} Abwasserbauwerk; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messstelle_AbwasserbauwerkAssocRef -- {0..*} Messstelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messstelle_AbwasserbauwerkAssoc;

ASSOCIATION Messstelle_GewaesserabschnittAssoc =    !! Assoziation
  GewaesserabschnittRef  -- {0..1} Gewaesserabschnitt; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messstelle_GewaesserabschnittAssocRef -- {0..*} Messstelle; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messstelle_GewaesserabschnittAssoc;

CLASS Messgeraet EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Ger�t mit welchem gemessen wird
  ATTRIBUTE
    Art: (          !! Typ des Messger�tes
      andere,
      Drucksonde,
      Lufteinperlung,
      MID_teilgefuellt,  !! Magnetisch-induktives Durchflussmesssger�t f�r teilgef�llte Rohre
      MID_vollgefuellt,  !! Magnetisch-induktives Durchflussmesssger�t f�r vollgef�llte Rohre
      Radar,
      Schwimmer,
      Ultraschall,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Fabrikat: TEXT*50;  !! Name des Herstellers
    Seriennummer: TEXT*50;
END Messgeraet;

ASSOCIATION Messgeraet_MessstelleAssoc =    !! Assoziation
  MessstelleRef  -- {0..1} Messstelle; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messgeraet_MessstelleAssocRef -- {0..*} Messgeraet; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messgeraet_MessstelleAssoc;

CLASS Messreihe EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Zusammenfassung von Messresultaten eines bestimmten Types  (z.B. Abflussmessungen im Schacht NS234.)
  ATTRIBUTE
    Art: (          !! Art der Messreihe
      andere,
      kontinuierlich,
      Regenwetter,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Dimension: TEXT*50;  !! Messtypen (Einheit);
END Messreihe;

ASSOCIATION Messreihe_MessstelleAssoc =    !! Assoziation
  MessstelleRef  -- {0..1} Messstelle; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messreihe_MessstelleAssocRef -- {0..*} Messreihe; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messreihe_MessstelleAssoc;

CLASS Messresultat EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Ergebnis einer Messung
  ATTRIBUTE
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Messart: (          !! Art der Messung, z.B zeit- oder mengenproportional
      andere,
      Durchfluss,
      Niveau,
      unbekannt
    );
    Messdauer: 0 .. 1000000 [s];  !! Dauer der Messung in Sekunden
    Wert: Number;  !! Gemessene Gr�sse
    Zeit: INTERLIS_1_DATE;  !! Zeitpunkt des Messbeginns
END Messresultat;

ASSOCIATION Messresultat_MessgeraetAssoc =    !! Assoziation
  MessgeraetRef  -- {0..1} Messgeraet; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messresultat_MessgeraetAssocRef -- {0..*} Messresultat; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messresultat_MessgeraetAssoc;

ASSOCIATION Messresultat_MessreiheAssoc =    !! Komposition
  MessreiheRef  -<#> {1} Messreihe; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Messresultat_MessreiheAssocRef -- {0..*} Messresultat; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Messresultat_MessreiheAssoc;

CLASS Ueberlauf (ABSTRACT) EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Bauteil in Abwasserbauwerken zum Ableiten von Abwasser in einen anderen Knoten
  ATTRIBUTE
    Antrieb: (          !! Antrieb der Einbaute
      andere,
      Benzinmotor,
      Dieselmotor,
      Elektromotor,
      hydraulisch,
      keiner,
      manuell,
      pneumatisch,
      unbekannt
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten
    Einleitstelle: TEXT*41;  !! Bezeichnung der Einleitstelle in die der Ueberlauf entlastet (redundantes Attribut zur Netzverfolgung oder Resultat davon). Muss nur erfasst werden, wenn das Abwasser vom Not�berlauf in ein Gew�sser eingeleitet wird (direkt oder �ber eine Regenabwasserleitung). Verkn�pfung mit Fremdschl�ssel zu Einleitstelle in Klasse Gesamteinzugsgebiet in Erweiterung Stammkarte.
    Fabrikat: TEXT*50;  !! Hersteller der elektro-mechanischen Ausr�stung oder Einrichtung
    Funktion: (          !! Teil des Mischwasserabflusses, der aus einem �berlauf in einen Vorfluter oder in ein Abwasserbauwerk abgeleitet wird
      andere,
      intern,  !! Interner Weiterfluss ohne Verzweigung (v.a. bei Pumpen)
      Notentlastung,  !! Bauwerk zur Ableitung von Wasser bei einem Betriebsversagen
      Regenueberlauf,  !! Ueberlauf zur Entlastung von Mischabwasser beim �berschreiten des Dimensionierungsabflusses in einen Vorfluter
      Trennueberlauf,  !! interne Entlastung im Kanalnetz, z.B. in ein Becken oder in einen anderen Kanal.
      unbekannt
    );
    Qan_dim: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Wassermenge, bei welcher der �berlauf gem�ss Dimensionierung anspringt
    Signaluebermittlung: (          !! Signal�bermittlung von und zu einer Fernwirkanlage
      empfangen,
      senden,
      senden_empfangen,
      unbekannt
    );
    Steuerung: (          !! Steuer- und Regelorgan f�r die Einbaute
      geregelt,  !! Die Regelung ist ein Vorgang in einem System, bei dem die zu regelnde Gr��e fortlaufend gemessen und mit dem Sollwert verglichen wird. Bei Abweichungen wird dieser korrigiert bzw. angepasst.
      gesteuert,  !! Steuern nennt man einen Vorgang, bei dem eine Eingangsgr�sse, durch bestimmte Gesetzm�ssigkeiten im System, eine Ausgangsgr�sse beeinflusst.
      keine,
      unbekannt
    );
    Subventionen: 0.00 .. 99999999.99 [Units.CHF];  !! Staats- und Bundesbeitr�ge
    Verstellbarkeit: (          !! M�glichkeit zur Verstellung
      fest,
      unbekannt,
      verstellbar
    );
END Ueberlauf;

ASSOCIATION Ueberlauf_AbwasserknotenAssoc =    !! Assoziation
  AbwasserknotenRef  -- {1} Abwasserknoten; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Ueberlauf_AbwasserknotenAssocRef -- {0..*} Ueberlauf; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Ueberlauf_AbwasserknotenAssoc;

ASSOCIATION Ueberlauf_UeberlaufNachAssoc =    !! Assoziation
  UeberlaufNachRef  -- {0..1} Abwasserknoten; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Ueberlauf_UeberlaufNachAssocRef -- {0..*} Ueberlauf; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Ueberlauf_UeberlaufNachAssoc;

ASSOCIATION Ueberlauf_UeberlaufcharakteristikAssoc =    !! Assoziation
  UeberlaufcharakteristikRef  -- {0..1} Ueberlaufcharakteristik; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Ueberlauf_UeberlaufcharakteristikAssocRef -- {0..1} Ueberlauf; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Ueberlauf_UeberlaufcharakteristikAssoc;

ASSOCIATION Ueberlauf_SteuerungszentraleAssoc =    !! Assoziation
  SteuerungszentraleRef  -- {0..1} Steuerungszentrale; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Ueberlauf_SteuerungszentraleAssocRef -- {0..*} Ueberlauf; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Ueberlauf_SteuerungszentraleAssoc;

CLASS Absperr_Drosselorgan EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Absperr- oder Drosselorgan
  ATTRIBUTE
    Antrieb: (          !! Antrieb der Einbaute
      andere,
      Benzinmotor,
      Dieselmotor,
      Elektromotor,
      hydraulisch,
      keiner,
      manuell,
      pneumatisch,
      unbekannt
    );
    Art: (          !! Art der Durchflussregulierung
      andere,
      Blende,
      Dammbalken,
      Drosselklappe,  !! Abflussregulator
      Drosselschieber,  !! Abflussregulator
      Drosselstrecke,  !! Zugeh�riger Kanal mit FunktionHydraulisch=Drosselleitung attributieren (Erfassungsregel)
      Leapingwehr,  !! Zus�tzlich ist ein Leapingwehr zu erfassen
      Pumpe,  !! Zus�tzlich ist ein Foerderaggregat zu erfassen
      Rueckstauklappe,
      Schieber,  !! Siehe auch Absperrorgan, Drosselorgan
      Schlauchdrossel,  !! Abflussregulator
      Schuetze,
      Stauschild,
      unbekannt,
      Wirbeldrossel  !! Abflussregulator
    );
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten
    Drosselorgan_Oeffnung_Ist: Lichte_Hoehe;  !! Folgende Werte sind anzugeben: Leapingwehr: Schr�gdistanz der Blech- resp. Boden�ffnung. Drosselstrecke: keine zus�tzlichen Angaben. Schieber / Sch�tz: lichte H�he der �ffnung (ab Sohle bis UK Schieberplatte, tiefster Punkt). Abflussregulator: keine zus�tzlichen Angaben. Pumpe: zus�tzlich in Stammkarte Pumpwerk erfassen
    Drosselorgan_Oeffnung_Ist_optimiert: Lichte_Hoehe;  !! Folgende Werte sind anzugeben: Leapingwehr: Schr�gdistanz der Blech- resp. Boden�ffnung. Drosselstrecke: keine zus�tzlichen Angaben. Schieber / Sch�tz: lichte H�he der �ffnung (ab Sohle bis UK Schieberplatte, tiefster Punkt). Abflussregulator: keine zus�tzlichen Angaben. Pumpe: zus�tzlich in Stammkarte Pumpwerk erfassen
    Fabrikat: TEXT*50;  !! Hersteller der elektro-mech. Ausr�stung oder Einrichtung
    Querschnitt: 0.00 .. 100000.00 [Units.m2];  !! Geometrischer Drosselquerschnitt: Fgeom
    Signaluebermittlung: (          !! Signal�bermittlung von und zu einer Fernwirkanlage
      empfangen,
      senden,
      senden_empfangen,
      unbekannt
    );
    Steuerung: (          !! Steuer- und Regelorgan f�r die Einbaute
      geregelt,  !! Die Regelung ist ein Vorgang in einem System, bei dem die zu regelnde Gr��e fortlaufend gemessen und mit dem Sollwert verglichen wird. Bei Abweichungen wird dieser korrigiert bzw. angepasst.
      gesteuert,  !! Steuern nennt man einen Vorgang, bei dem eine Eingangsgr�sse, durch bestimmte Gesetzm�ssigkeiten im System, eine Ausgangsgr�sse beeinflusst.
      keine,
      unbekannt
    );
    Subventionen: 0.00 .. 99999999.99 [Units.CHF];  !! Staats- und Bundesbeitr�ge
    Verstellbarkeit: (          !! M�glichkeit zur Verstellung
      fest,
      unbekannt,
      verstellbar
    );
    Wirksamer_QS: 0.00 .. 100000.00 [Units.m2];  !! Wirksamer Drosselquerschnitt : Fid
END Absperr_Drosselorgan;

ASSOCIATION Absperr_Drosselorgan_AbwasserknotenAssoc =    !! Assoziation
  AbwasserknotenRef  -- {1} Abwasserknoten; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Absperr_Drosselorgan_AbwasserknotenAssocRef -- {0..*} Absperr_Drosselorgan; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Absperr_Drosselorgan_AbwasserknotenAssoc;

ASSOCIATION Absperr_Drosselorgan_SteuerungszentraleAssoc =    !! Assoziation
  SteuerungszentraleRef  -- {0..1} Steuerungszentrale; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Absperr_Drosselorgan_SteuerungszentraleAssocRef -- {0..*} Absperr_Drosselorgan; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Absperr_Drosselorgan_SteuerungszentraleAssoc;

ASSOCIATION Absperr_Drosselorgan_UeberlaufAssoc =    !! Assoziation
  UeberlaufRef  -- {0..1} Ueberlauf; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Absperr_Drosselorgan_UeberlaufAssocRef -- {0..1} Absperr_Drosselorgan; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Absperr_Drosselorgan_UeberlaufAssoc;

CLASS Streichwehr EXTENDS Ueberlauf =  
!! Baute zur Entnahme von Wasser �ber eine Wehrkrone die parallel oder nahezu parallel zur Fliessrichtung angeordnet ist
  ATTRIBUTE
    HydrUeberfalllaenge: 0.00 .. 30000.00 [m];  !! Hydraulisch wirksame Wehrl�nge
    KoteMax: Base.Hoehe;  !! H�he des h�chsten Punktes der �berfallkante
    KoteMin: Base.Hoehe;  !! H�he des tiefsten Punktes der �berfallkante
    Ueberfallkante: (          !! Ausbildung der �berfallkante
      andere,
      rechteckig,
      rund,
      scharfkantig,
      unbekannt
    );
    Wehr_Art: (          !! Art der Wehrschwelle des Streichwehrs
      hochgezogen,  !! Streichwehr mit hochgezogener Wehrschwelle
      niedrig  !! Streichwehr mit niedriger Wehrschwelle
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Streichwehr;

CLASS FoerderAggregat EXTENDS Ueberlauf =  
!! Einrichtung zum Transport von Fl�ssigkeiten
  ATTRIBUTE
    Arbeitspunkt: 0.00 .. 10000000.00 [Units.m3];  !! F�rdermenge f�r Pumpen mit fixem Arbeitspunkt
    AufstellungAntrieb: (          !! Art der Aufstellung des Motors
      nass,
      trocken,
      unbekannt
    );
    AufstellungFoerderaggregat: (          !! Art der Aufstellung der Pumpe
      horizontal,
      unbekannt,
      vertikal
    );
    Bauart: (          !! Pumpenarten
      andere,
      Druckluftanlage,
      Kolbenpumpe,
      Kreiselpumpe,
      Schneckenpumpe,
      unbekannt,
      Vakuumanlage
    );
    FoerderstromMax_einzel: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Maximaler F�rderstrom der Pumpe (einzeln als Bauwerkskomponente). Tritt in der Regel bei der minimalen F�rderh�he ein.
    FoerderstromMin_einzel: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Minimaler F�rderstrom der Pumpe (einzeln als Bauwerkskomponente). Tritt in der Regel bei der maximalen F�rderh�he ein.
    KoteStart: Base.Hoehe;  !! Kote des Wasserspiegels im Pumpensumpf, bei der die Pumpe eingeschaltet wird (Einschaltkote);
    KoteStop: Base.Hoehe;  !! Kote des Wasserspiegels im Pumpensumpf, bei der die Pumpe ausgeschaltet wird (Ausschaltkote);
    Nutzungsart_Ist: (          !! Nutzungsart_Ist des gepumpten Abwassers.
      andere,
      Bachwasser,  !! Wasser eines Fliessgew�ssers, das gem�ss seinem nat�rlichen Zustand oberfl�chlich, aber an einigen Orten auch in unterirdischen Leitungen abfliesst.
      entlastetes_Mischabwasser,  !! Wasser aus einem Entlastungsbauwerk, welches zum Vorfluter gef�hrt wird. In diesen Kanal darf kein Schmutzabwasser eingeleitet werden.
      Industrieabwasser,  !! Unter Industrieabwasser werden alle Abw�sser verstanden, die bei Produktions- und Verarbeitungsprozessen in der Industrie anfallen. Industrieabw�sser m�ssen i.d.R. vorbehandelt werden, bevor sie in �ffentliche Kl�ranlagen eingeleitet werden k�nnen (siehe Indirekteinleiter). Bei direkter Einleitung in Gew�sser (siehe Direkteinleiter) ist eine umfangreiche Reinigung in speziellen werkseigenen Kl�ranlagen erforderlich.
      Mischabwasser,  !! 1. Mischung von Schmutz- und Regenabwasser, die gemeinsam abgeleitet werden 2. Abwasser welches aus einer Mischung von Schmutzabwasser und Regenabwasser besteht
      Regenabwasser,  !! Wasser aus nat�rlichem Niederschlag, das nicht durch Gebrauch verunreinigt wurde. Die Zuordnung zu verschmutztem oder unverschmutztem Abwasser erfolgt nach der Gew�sserschutzgesetzgebung bzw. nach Anleitung der VSA-Richtlinie "Regenwasserentsorgung"
      Reinabwasser,  !! Sicker-, Grund-, Quell- und Brunnenwasser sowie K�hlwasser aus Durchlaufk�hlungen. Gem�ss Gew�sserschutzgesetz gilt Reinabwasser als unverschmutztes Abwasser (SN 592 000).
      Schmutzabwasser,  !! Durch Gebrauch ver�ndertes Wasser (h�usliches, gewerbliches oder industrielles Abwasser), das in eine Entw�sserungsanlage eingeleitet und einer Abwasserbehandlung zugef�hrt werden muss. Schmutzabwasser gilt als verschmutztes Abwasser im Sinne des Gew�sserschutzgesetzes (SN 592 000)
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END FoerderAggregat;

CLASS Leapingwehr EXTENDS Ueberlauf =  
!! Regen�berlauf mit Boden�ffnung
  ATTRIBUTE
    Breite: 0.00 .. 30000.00 [m];  !! Maximale Abmessung der Boden�ffnung quer zur Fliessrichtung
    Laenge: 0.00 .. 30000.00 [m];  !! Maximale Abmessung der Boden�ffnung in Fliessrichtung
    Oeffnungsform: (          !! Form der  Boden�ffnung
      andere,
      Kreis,
      Parabel,
      Rechteck,
      unbekannt
    );
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Leapingwehr;

CLASS Hydr_Kennwerte EXTENDS SIA405_Base.SIA405_BaseClass =  
!! Aggregierte Eigenschaften zur Hydraulik
  ATTRIBUTE
    Aggregatezahl: Aggregatezahl;
    Bemerkung: TEXT*80;  !! Allgemeine Bemerkungen
    Bezeichnung: MANDATORY TEXT*20;
    Foerderaggregat_Nutzungsart_Ist: (          !! Nutzungsart_Ist des gepumpten Abwassers.
      andere,
      Bachwasser,  !! Wasser eines Fliessgew�ssers, das gem�ss seinem nat�rlichen Zustand oberfl�chlich, aber an einigen Orten auch in unterirdischen Leitungen abfliesst.
      entlastetes_Mischabwasser,  !! Wasser aus einem Entlastungsbauwerk, welches zum Vorfluter gef�hrt wird. In diesen Kanal darf kein Schmutzabwasser eingeleitet werden.
      Industrieabwasser,  !! Unter Industrieabwasser werden alle Abw�sser verstanden, die bei Produktions- und Verarbeitungsprozessen in der Industrie anfallen.Industrieabw�sser m�ssen i.d.R. vorbehandelt werden, bevor sie in �ffentliche Kl�ranlagen eingeleitet werden k�nnen (siehe Indirekteinleiter). Bei direkter Einleitung in Gew�sser (siehe Direkteinleiter) ist eine umfangreiche Reinigung in speziellen werkseigenen Kl�ranlagen erforderlich.
      Mischabwasser,  !! 1. Mischung von Schmutz- und Regenabwasser, die gemeinsam abgeleitet werden 2. Abwasser welches aus einer Mischung von Schmutzabwasser und Regenabwasser besteht
      Regenabwasser,  !! Wasser aus nat�rlichem Niederschlag, das nicht durch Gebrauch verunreinigt wurde. Die Zuordnung zu verschmutztem oder unverschmutztem Abwasser erfolgt nach der Gew�sserschutzgesetzgebung bzw. nach Anleitung der VSA-Richtlinie "Regenwasserentsorgung"
      Reinabwasser,  !! Sicker-, Grund-, Quell- und Brunnenwasser sowie K�hlwasser aus Durchlaufk�hlungen. Gem�ss Gew�sserschutzgesetz gilt Reinabwasser als unverschmutztes Abwasser  (SN 592 000).
      Schmutzabwasser,  !! Durch Gebrauch ver�ndertres Wasser (h�usliches, gewerbliches oder industrielles Abwasser), das in eine Entw�sserungsanlage eingeleitet und einer Abwasserbehandlung zugef�hrt werden muss. Schmutzabwasser gilt als verschmutztes Abwasser im Sinne des Gew�sserschutzgesetzes (SN 592 000)
      unbekannt
    );
    Foerderhoehe_geodaetisch: Foerderhoehe;
    FoerderstromMax: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Maximaler F�rderstrom der Pumpen (gesamtes Bauwerk). Tritt in der Regel bei der minimalen F�rderh�he ein.
    FoerderstromMin: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Minimaler F�rderstrom der Pumpen zusammen (gesamtes Bauwerk). Tritt in der Regel bei der maximalen F�rderh�he ein.
    Hauptwehrart: (          !! Art des Hauptwehrs am Knoten, falls mehrere �berl�ufe
      Leapingwehr,
      Streichwehr_hochgezogen,  !! Streichwehr mit hochgezogener Wehrschwelle
      Streichwehr_niedrig  !! Streichwehr mit niedriger Wehrschwelle
    );
    Mehrbelastung: 0.00 .. 100.00 [Units.Percent];  !! Ist: Mehrbelastung der untenliegenden Kan�le beim Dimensionierungsereignis = 100 * (Qab � Qan) / Qan 	[%]. Verh�ltnis zwischen der abgeleiteten Abwassermengen Richtung ARA beim Anspringen des Entlastungsbauwerkes (Qan) und Qab (Abwassermenge, welche beim Dimensionierungsereignis (z=5) weiter im Kanalnetz Richtung Abwasserreinigungsanlage abgeleitet wird). Beispiel: Qan = 100 l/s, Qab = 150 l/s -> Mehrbelastung = 50%; Ist_optimiert: Optimale Mehrbelastung im Ist-Zustand vor der Umsetzung von allf�lligen weiteren Massnahmen; geplant: Optimale Mehrbelastung nach der Umsetzung der Massnahmen.
    Pumpenregime: (          !! Bei speziellen Betriebsarten ist die Funktion separat zu dokumentieren und der Stammkarte beizulegen.
      alternierend,
      andere,
      einzeln,
      parallel,
      unbekannt
    );
    Qab: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Qab gem�ss GEP
    Qan: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Wassermenge, bei welcher der �berlauf anspringt
    Springt_an: (          !! Angabe, ob die Entlastung beim Dimensionierungsereignis anspringt
      ja,
      nein,
      unbekannt
    );
    Status: (          !! Planungszustand der Hydraulischen Kennwerte (zwingend). Ueberlaufcharakteristik und Gesamteinzugsgebiet kann f�r verschiedene Stati gebildet werden und leitet sich aus dem Status der Hydr_Kennwerte ab.
      geplant,  !! Optimaler Zustand nach der Umsetzung der Massnahmen
      Ist,
      Ist_optimiert  !! Optimierter Ist-Zustand vor der Umsetzung von allf�lligen weiteren Massnahmen
    );
    Ueberlaufdauer: 0.0 .. 10000.0 [Units.h];  !! Mittlere �berlaufdauer pro Jahr. Bei Ist_Zustand: Berechnung mit geplanten Massnahmen. Bei Ist_optimiert:  Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von allf�lligen weiteren Massnahmen. Planungszustand: Berechnung mit geplanten Massnahmen
    Ueberlauffracht: Fracht;  !! Mittlere Ueberlaufschmutzfracht pro Jahr
    Ueberlaufhaeufigkeit: Ueberlaufhaeufigkeit;  !! Mittlere �berlaufh�ufigkeit pro Jahr. Ist Zustand: Durchschnittliche �berlaufh�ufigkeit pro Jahr von Entlastungsanlagen gem�ss Langzeitsimulation (Dauer mindestens 10 Jahre). Ist optimiert: Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von allf�lligen weiteren Massnahmen. Planungszustand: Berechnung mit Einstellungen nach der Umsetzung der Massnahmen
    Ueberlaufmenge: 0.00 .. 10000000.00 [Units.m3];  !! Mittlere �berlaufwassermenge pro Jahr. Durchschnittliche �berlaufmenge pro Jahr von Entlastungsanlagen gem�ss Langzeitsimulation (Dauer mindestens 10 Jahre). Ist optimiert: Berechnung mit optimierten Einstellungen im Ist-Zustand vor der Umsetzung von allf�lligen weiteren Massnahmen. Planungszustand: Berechnung mit Einstellungen nach der Umsetzung der Massnahmen
END Hydr_Kennwerte;

ASSOCIATION Hydr_Kennwerte_AbwasserknotenAssoc =    !! Assoziation
  AbwasserknotenRef  -- {1} Abwasserknoten; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Hydr_Kennwerte_AbwasserknotenAssocRef -- {0..*} Hydr_Kennwerte; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Hydr_Kennwerte_AbwasserknotenAssoc;

ASSOCIATION Hydr_Kennwerte_UeberlaufcharakteristikAssoc =    !! Assoziation
  UeberlaufcharakteristikRef  -- {0..1} Ueberlaufcharakteristik; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Hydr_Kennwerte_UeberlaufcharakteristikAssocRef -- {0..1} Hydr_Kennwerte; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Hydr_Kennwerte_UeberlaufcharakteristikAssoc;

CLASS Rueckstausicherung EXTENDS BauwerksTeil =  
!! Die R�ckstausicherung verhindert den R�ckfluss von Wasser aus dem Gew�sser in das Abwassernetz. Das Attribut wird bei demjenigen Sonderbauwerk erfasst, in dem es eingebaut ist. Ist keine R�ckstausicherung vorhanden, wird kein Datensatz erfasst.
  ATTRIBUTE
    Art: (          !!  Ist keine R�ckstausicherung vorhanden, wird keine Rueckstausicherung erfasst
      andere,
      Pumpe,
      Rueckstauklappe,
      Stauschild
    );
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr in dem die Lebensdauer der R�ckstausicherung voraussichtlich abl�uft
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Rueckstausicherung;

ASSOCIATION Rueckstausicherung_Absperr_DrosselorganAssoc =    !! Assoziation
  Absperr_DrosselorganRef  -- {0..1} Absperr_Drosselorgan; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Rueckstausicherung_Absperr_DrosselorganAssocRef -- {0..1} Rueckstausicherung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Rueckstausicherung_Absperr_DrosselorganAssoc;

ASSOCIATION Rueckstausicherung_FoerderAggregatAssoc =    !! Assoziation
  FoerderAggregatRef  -- {0..1} FoerderAggregat; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Rueckstausicherung_FoerderAggregatAssocRef -- {0..1} Rueckstausicherung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Rueckstausicherung_FoerderAggregatAssoc;

CLASS Feststoffrueckhalt EXTENDS BauwerksTeil =  
!! Elektromechanische Teile eines Bauwerks und Vorrichtung zum Feststoffr�ckhalt eines Abwasserbauwerks
  ATTRIBUTE
    Anspringkote: Base.Hoehe;  !! Anspringkote Feststoffr�ckhalt in m.�.M.
    Art: (          !! (Elektromechanische) Teile zum Feststoffr�ckhalt eines Bauwerks
      andere,
      Feinrechen,  !! auch Siebrechen genannt
      Grobrechen,  !! Stababstand > 10mm
      Sieb,  !! Lochblech
      Tauchwand,
      unbekannt
    );
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten der elektromechnischen Ausr�stung f�r die Beckenentleerung
    Dimensionierungswert: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Wassermenge, Dimensionierungswert des Feststoffr�ckhaltes
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr in dem die Lebensdauer der elektromechanischen Ausr�stung voraussichtlich abl�uft
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Feststoffrueckhalt;

CLASS Beckenreinigung EXTENDS BauwerksTeil =  
!! Elektromechanische Teile eines Bauwerks und Vorrichtung zur Beckenreinigung eines Abwasserbauwerks
  ATTRIBUTE
    Art: (        
      Air_Jet,  !! Druckluftstrom, auch Injektorpumpe genannt
      andere,
      keine,
      Schwallspuelung,
      Spuelkippe
    );
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten der elektromechnischen Ausr�stung f�r die Beckenreinigung
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr in dem die Lebensdauer der elektromechanischen Ausr�stung voraussichtlich abl�uft
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Beckenreinigung;

CLASS Beckenentleerung EXTENDS BauwerksTeil =  
!! Vorrichtung zur Beckenentleerung
  ATTRIBUTE
    Art: (        
      andere,
      keine,  !! Der Wert �keine� wird verwendet, wenn das Bauwerk ohne Hilfsbetrieb entleert wird.
      Pumpe,
      Schieber
    );
    Bruttokosten: 0.00 .. 99999999.99 [Units.CHF];  !! Brutto Erstellungskosten der elektromechnischen Ausr�stung f�r die Beckenentleerung
    Ersatzjahr: SIA405_Base.Jahr;  !! Jahr in dem die Lebensdauer der elektromechanischen Ausr�stung voraussichtlich abl�uft
    Leistung: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Bei mehreren Pumpen / Schiebern muss die maximale Gesamtmenge erfasst werden.
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END Beckenentleerung;

ASSOCIATION Beckenentleerung_Absperr_DrosselorganAssoc =    !! Assoziation
  Absperr_DrosselorganRef  -- {0..1} Absperr_Drosselorgan; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Beckenentleerung_Absperr_DrosselorganAssocRef -- {0..1} Beckenentleerung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Beckenentleerung_Absperr_DrosselorganAssoc;

ASSOCIATION Beckenentleerung_UeberlaufAssoc =    !! Assoziation
  UeberlaufRef  -- {0..1} FoerderAggregat; !! Rolle1 - Klasse1 / R�le1 - Classe1
  Beckenentleerung_UeberlaufAssocRef -- {0..1} Beckenentleerung; !! , Rolle2 - Klasse2 / R�le2 - Classe2
END Beckenentleerung_UeberlaufAssoc;

CLASS EZG_PARAMETER_ALLG EXTENDS Oberflaechenabflussparameter =  
!! Oberfl�chenparameter welche zu keinem speziellen Modell geh�ren
  ATTRIBUTE
    Einwohnergleichwert: EGW;
    Flaeche: 0.00 .. 100000.00 [Units.m2];  !! Fl�che des Einzugsgebietes f�r MOUSE1
    Fliessweggefaelle: Neigung_Promille;  !! Fliessweggef�lle [%o]
    Fliessweglaenge: 0.00 .. 30000.00 [m];  !! Fliesswegl�nge
    Trockenwetteranfall: 0.000 .. 100000.000 [SIA405_Base.ls];
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END EZG_PARAMETER_ALLG;

CLASS EZG_PARAMETER_MOUSE1 EXTENDS Oberflaechenabflussparameter =  
!! Oberfl�chenabflussparameter gem�ss Modell MOUSE
  ATTRIBUTE
    Einwohnergleichwert: EGW;
    Flaeche: 0.00 .. 100000.00 [Units.m2];  !! Parameter zur Bestimmung des Oberfl�chenabflusses f�r das Oberfl�chenabflussmodell A1 von MOUSE
    Fliessweggefaelle: Neigung_Promille;  !! Parameter zur Bestimmung des Oberfl�chenabflusses f�r das Oberfl�chenabflussmodell A1 von MOUSE [%o]
    Fliessweglaenge: 0.00 .. 30000.00 [m];  !! Parameter zur Bestimmung des Oberfl�chenabflusses f�r das Oberfl�chenabflussmodell A1 von MOUSE
    Nutzungsart: TEXT*50;  !! Klassifikation gem�ss Oberfl�chenabflussmodell von MOUSE 2000/2001
    Trockenwetteranfall: 0.000 .. 100000.000 [SIA405_Base.ls];  !! Parameter zur Bestimmung des Oberfl�chenabflusses f�r das Oberfl�chenabflussmodell A1 von MOUSE
UNIQUE 
    Bezeichnung, Metaattribute->Datenherr;  !! Neben UNIQUE OBJ_ID zus�tzlich auch Kombination Bezeichnung, Datenherr, damit mit VSA-DSS-Mini kompatibel (Wegleitung GEP-Daten 2013)
END EZG_PARAMETER_MOUSE1;


END Siedlungsentwaesserung;   !! Ende des Topics / Fin du topic
END DSS_2015.   !! Ende des Modells / Fin du mod�le
', '2015-12-17 20:25:44.622');
INSERT INTO sia405abwasser.t_ili2db_model (file, iliversion, modelname, content, importdate) VALUES ('SIA405_Base.ili', '2.3', 'SIA405_Base{ Base Units INTERLIS}', '!! SIA405_Base.ili 

INTERLIS 2.3;

TYPE MODEL SIA405_Base (de) AT "http://www.sia.ch/405" 
  VERSION "18.6.2014" =

  IMPORTS UNQUALIFIED INTERLIS;		!! neu 8.11.2004, importiert INTERLIS 2 Basisunits
  IMPORTS Base;
  IMPORTS Units;

!! Copyright 2003 - 2014 SIA

!! Die Nutzung dieser INTERLIS-Datei ist lizenzpflichtig!
!! �nderungen und Erg�nzungen d�rfen zum Eigengebrauch get�tigt werden. 
!! Sie m�ssen innerhalb der Datei so dokumentiert sein, dass sichtbar wird, 
!! welche �nderungen get�tigt wurden (Einf�gen von INTERLIS Kommentar). 
!! Die Originalmodelldatei SIA405_Base.ili und darauf basierende 
!! abge�nderte Versionen d�rfen nicht weiterverkauft werden. 
!! Die Weitergabe der Originaldatei (als Ganzes oder Teile davon) ist nur 
!! zusammen mit dem Erwerb einer Lizenz beim sia (www.sia.ch) durch den Empf�nger erlaubt.

!! Geprueft mit Compiler Version 4.5.3 vom 4.4.2014
!! Sachbearbeiter: Stefan Burckhardt / SIA 405 Kommission

!! 20.8.2010 Anpassungen im Layout und in den Kommentaren
!! 23.9.2010 Anpassung Textinhalt neu 80 Zeichen
!! 23.9.2010 / 1.7.2011 Anpassung Status
!! 22.11.2010 Anpassung Reihenfolge Status neu alphabetisch
!! 01.07.2011 MTEXT statt TEXT f�r Textinhalt
!! 29.8.2011 Textinhalt neu MANDATORY, damit f�r Erzeugung von dxf ab INTERLIS in Inhalt vorhanden ist.
!! 25.1.2012 Neue SIA405_BaseClass geerbt von Base.ili
!! 21.2.2012 Neuer Datentyp Maechtigkeit
!! 21.2.2012 Neuer Datentyp Abmessung
!! 21.2.2012 OrganisationBezeichnung: TEXT*80;  !! Neuer Datentyp f�r Eigentuemer, Betreiber, Datenherr, Datenlieferant, etc.
!! 21.2.2012 Neu Datentyp Ueberdeckung - Einheit kl�ren
!! 21.2.2012 Neu Datentyp Nennweite 
!! 22.2.2012 OBJ_ID statt OID - VSA nennt das schon seit 1999 OBJ_ID, andere Medienmodelle haben dieses Attribut bisher nicht, was den Aufwand f�r einen neuen Namen im Abwasser nicht rechtfertigt -> Modellkonsistenz.
!! TO DO 28.7.2011 Neue Referenz f�r Kommentar zu Genauigkeit 
!! 14.3.2012 neu STRUCTURE ManagementAttributes
!! 14.3.2012 OBJ_ID STANDARDOID
!! 4.2.2012 Ueberdeckung 0.0 .. 999.9 [INTERLIS.m] - ein Kilometer �berdeckung reicht, eine Nachkommastelle reicht
!! 4.2.2012 Umbenennung ManagementAttribute neu Metaattribute
!! 14.5.2012 Defiition Datenherr, Datenlieferant, Letzte_Aenderung erg�nzt
!! 23.5.2012 Kommentar zu OrganisationBezeichnung - UID  
!! 8.6.2012 Metaattribute: MANDATORY Metaattribute; (neu MANDATORY)
!! 11.6.2012 Maechtigkeit  = -99999 .. 99999 [Units.mm]; neu positiv und negativ, Die M�chtigkeit ergibt sich aus der Differenz aus KoteRef und KoteZ und kann entweder einen negativen oder positiven Wert annehmen."
!! 11.6.2012 Breite maximal 4 m /4000 mm - dar�ber als Fl�che abbilden, siehe Merkblatt 2015, 2.5.3 Geometrietypen und Abbildung 2D 
!! 11.6.2012 Abmessung maximal 4 m / 4000 mm dar�ber als Fl�che abbilden, siehe Merkblatt 2015, 2.5.3 Geometrietypen und Abbildung 2D
!! 18.4.2014 Korrekturen Beschreibungen Schreibweise
!! 10./11./18.6.2014 Neue Subwerte f�r Plantyp = Uebersichtsplan (UeP2, UeP5, UeP10)  


  UNIT

    KiloWatt [kW] = 1000 [Units.W];
    Liter_pro_Sekunde [ls] = (Units.L/s);
    Liter_pro_Tag [ld] = (Units.L/Units.d);
    Gramm_pro_Kubikmeter [gm3] = (Units.g/Units.m3);
    Kubikmeter_pro_Sekunde [m3s] = (Units.m3/s);
    Kubikmeter_pro_Tag [m3d] = (Units.m3/Units.d);
    Kubikmeter_pro_Stunde [m3h] = (Units.m3/Units.h);
    Meter_pro_Sekunde [ms] EXTENDS Units.Velocity = (m/s);
    Quadrat_Zentimeter [cm2] EXTENDS Units.Area = (Units.cm*Units.cm);

  DOMAIN

    !! Allgemeine Typen fuer alle SIA405 Medien
!! neu 21.2.2012
    Abmessung = 0 .. 4000 [Units.mm];    !! Einheit Milimeter [mm]
    Breite = 0 .. 4000 [Units.mm];    !! Einheit Milimeter [mm]
    Genauigkeit = (   !! Definiert die Lage- und H�hengenauigkeit eines Objektes. Falls ein Verlauf definiert ist, ist dieser immer [genau]. 
                   genau,  !! +/- 10 cm, bei der Lagebestimmung aus unterschiedlichen Messungen das dreifache, d.h. +/- 30 cm (Norm SIA405 2012 XXXX)
                   unbekannt,
                   ungenau  !! siehe genau
                   );
    Jahr = 1800 .. 2100;  !! unbekannt = 1800 (niedrigster Wert des Wertebereiches)
!! neu 21.2.2012 / 10.6.2012
!!   Maechtigkeit  = 0 .. 99999 [Units.mm]; !! 
    Maechtigkeit  = -99999 .. 99999 [Units.mm]; !! 11.6.2012, neu positiv und negativ, Die M�chtigkeit ergibt sich aus der Differenz aus KoteRef und KoteZ und kann entweder einen negativen oder positiven Wert annehmen."

!! neu 21.2.2012
    Nennweite = TEXT*10;  !! als TEXT, da zum Teil auch Doppelwerte mit Schr�gstrich
!! neu 21.2.2012
    OrganisationBezeichnung = TEXT*80;  !! Neuer Datentyp f�r Eigentuemer, Betreiber, Datenherr, Datenlieferant, etc. L�nge vorbereitet f�r Bezeichnung bei UID (www.uid.admin.ch)
    Plantyp = (   !! Plantyp, f�r welchen die TextPos / SymbolPos definiert ist
               Leitungskataster, 
               Werkplan, 
               Uebersichtsplan (
                  UeP10,  !! 1:10''000
                  UeP2,  !! 1:2''000
                  UeP5  !! 1:10''000
                  )
               );
    Status= (   !! Betriebs- und Planungszustand. neu 2010: Erweiterungen dazu in den einzelnen Medien definieren
             ausser_Betrieb,  
             in_Betrieb,
             tot,  
             unbekannt, 
             weitere 
            );
    Ueberdeckung = 0.0 .. 999.9 [INTERLIS.m];   !! mittlerer Wert eines Objektes (Schutzrohr / Wasser / Fernw�rme)

	STRUCTURE Metaattribute =
	!! Metainformationen - bitte auch auf www.geocat.ch erfassen
      Datenherr: MANDATORY OrganisationBezeichnung;  !! Datenherr, also diejenige Person oder Stelle, die berechtigt ist, diesen Datensatz zu l�schen, zu �ndern, zu verwalten. Falls ein Ingenieurb�ro dies im Auftrag einer Gemeinde wahrnimmt, so ist die Gemeinde als Datenherr einzusetzen und nicht das Ingenieurb�ro. Dieses wird dann unter Datenlieferant aufgef�hrt.
      Datenlieferant: MANDATORY OrganisationBezeichnung;  !! Organisation, die diesen Datensatz erzeugt hat (siehe auch Datenherr und Letzte_Aenderung)
      Letzte_Aenderung: MANDATORY INTERLIS.INTERLIS_1_DATE;  !! ! Datum der letzten �nderung dieses Datensatzes, falls diese Information vorhanden ist. Falls nicht vorhanden Datum der Erzeugung des Transferdatensatzes einsetzen.
	END Metaattribute;
	
	
!! neu 25.1.2012	
   CLASS SIA405_BaseClass (ABSTRACT) EXTENDS Base.BaseClass =
   !! BaseClass f�r alle Oberklassen (Superclass) mit Metaattributen
   	  OID AS STANDARDOID;  !! gew�hlte Option f�r Definition ANYOID aus base.ili. Weitere Infos siehe Merkblatt 2015, Kapitel 2.1.3.8 Objektidentifikatoren (OID) 
      !! Als Attribut OBJ_ID zus�tzlich redundant zu OID und den Bedingungen f�r die TID ausmodelliert, damit R�ckw�rtskompatibilit�t mit INTERLIS 1 m�glich. Attribut soll in Datenbank verwaltet werden oder stabil beim Export/Import verwaltet werden k�nnen. 
	  ATTRIBUTE
		OBJ_ID: TEXT*16; !! neu 23.5.2012 OID (STANDARDOID) zus�tzlich redundant als Attribut modelliert (siehe SIA 405 Merkblatt 2015, Kapitel 2.3.
		!! Metadatenattribute zentral einf�hren durch die STRUCTURE ManagementAttributes
		Metaattribute: MANDATORY Metaattribute;
      UNIQUE OBJ_ID;
   END SIA405_BaseClass;  
 
   CLASS SIA405_TextPos (ABSTRACT) EXTENDS Base.TextPos =
      Plantyp: MANDATORY Plantyp;
      Textinhalt: MANDATORY MTEXT*80; !! aus Attributen berechneter Wert, neu 80 statt 40 Zeichen und MTEXT statt TEXT, damit auch mehrzeilige Texte verarbeitet werden k�nnen.
      Bemerkung: TEXT*80; !! f�r bilaterale weitere Spezifikationen
  END SIA405_TextPos; 

!! neu 30.8.2011 - f�r Fernw�rme / 21.2.2012 Symbolskalierung hierher verschoben statt in Base.ili
   CLASS SIA405_SymbolPos (ABSTRACT) EXTENDS Base.SymbolPos =
      Plantyp: MANDATORY Plantyp;
      SymbolskalierungLaengs: 0.0 .. 9.9;
      SymbolskalierungHoch: 0.0 .. 9.9;
   END SIA405_SymbolPos; 

END SIA405_Base.
', '2015-12-17 20:25:44.622');
INSERT INTO sia405abwasser.t_ili2db_model (file, iliversion, modelname, content, importdate) VALUES ('Base.ili', '2.3', 'Base{ Units INTERLIS}', '!! Base.ili

INTERLIS 2.3;

TYPE MODEL Base (de) AT "http://www.sia.ch/405" 
  VERSION "18.4.2014" =

    IMPORTS UNQUALIFIED INTERLIS;		!! neu 8.11.2004, importiert INTERLIS 2.3. Basisunits
    IMPORTS Units;
  !! IMPORTS CoordSys;
  !! REFSYSTEM BASKET BCoordSys ~ CoordSys.CoordsysTopic; 

!! Copyright 2003 - 2014 SIA

!! Die Nutzung dieser INTERLIS-Datei ist lizenzpflichtig!
!! �nderungen und Erg�nzungen d�rfen zum Eigengebrauch get�tigt werden. 
!! Sie m�ssen innerhalb der Datei so dokumentiert sein, dass sichtbar wird, 
!! welche �nderungen get�tigt wurden (Einf�gen von INTERLIS Kommentar). 
!! Die Originalmodelldatei Base.ili und darauf basierende 
!! abge�nderte Versionen d�rfen nicht weiterverkauft werden. 
!! Die Weitergabe der Originaldatei (als Ganzes oder Teile davon) ist nur 
!! zusammen mit dem Erwerb einer Lizenz beim sia (www.sia.ch) durch den Empf�nger erlaubt.

!! Geprueft mit Compiler Version 4.5.3 vom 4.4.2014
!! Sachbearbeiter: Stefan Burckhardt / SIA 405 Kommission  
  
!! 18.4.2014 Korrektur Wertebereich f�r LKKoord / HKoord f�r Bezugsrahmen LV95 (1070000.000 statt 170000.000 .. 1300000.000)
  
  DOMAIN
    !! Allgemeine Typen fuer alle Modelle

    Orientierung = 0.0 .. 359.9 CIRCULAR [Units.Angle_Degree];  !! Anpassen auf Geobasisdatendefinition?

    LKoord = COORD 480000.000 .. 840000.000 [m], !!{CHLV03/1}, 
                   70000.000 .. 300000.000 [m],  !!{CHLV03/2},
                   ROTATION 2 -> 1;

    HKoord = COORD 480000.000 .. 840000.000 [m], !!{CHLV03/1},
                   70000.000 .. 300000.000 [m], !!{CHLV03/2}, 
                   -200.000 .. 5000.000 [m], !!{SwissOrthometricAlt},
                   ROTATION 2 -> 1;

!! falls Bezugsrahmen LV95 folgende Definition verwenden (Kommentarzeichen !! l�schen hier und LV03 auskommentieren)
!! 18.4.2014
!!    LKoord = COORD 2480000.000 .. 2840000.000 [m], !!{CHLV95/1}, 
!!                   1070000.000 .. 1300000.000 [m],  !!{CHLV95/2},
!!                   ROTATION 2 -> 1;
 
!!    HKoord = COORD 2480000.000 .. 2840000.000 [m], !!{CHLV03/1},
!!                   1070000.000 .. 1300000.000 [m], !!{CHLV03/2}, 
!!                   -200.000 .. 5000.000 [m], !!{SwissOrthometricAlt},
!!                   ROTATION 2 -> 1;

    Hoehe = -200.000 .. 5000.000 [m]; !!{SwissOrthometricAlt};

    Polyline = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX LKoord;

!! neu 23.5.2012	
!!    Surface = SURFACE WITH (STRAIGHTS, ARCS) VERTEX LKoord WITHOUT OVERLAPS > 0.000;  !! Einzelfl�chen
	Surface = SURFACE WITH (STRAIGHTS, ARCS) VERTEX LKoord WITHOUT OVERLAPS > 0.050;  !! Einzelfl�chen

!! neu 2.8.2011
    Polyline3D = POLYLINE WITH (STRAIGHTS, ARCS) VERTEX HKoord;
	
!! neu 23.5.2012
!!    Surface3D = SURFACE WITH (STRAIGHTS, ARCS) VERTEX HKoord WITHOUT OVERLAPS > 0.000;
    Surface3D = SURFACE WITH (STRAIGHTS, ARCS) VERTEX HKoord WITHOUT OVERLAPS > 0.050;

!! neu 25.1.2012
   CLASS BaseClass (ABSTRACT) =
   !! BaseClass f�r alle Subklassen (Subclass - Vererbung)

   END BaseClass;  

!! neu 4.8.2011 / 21.2.2012 (geerbt von BaseClass)
   CLASS TextPos (ABSTRACT) EXTENDS BaseClass =
!!      OID AS ANYOID; !! Hier definiert als ANY. Genaue Definition und Wahl durch die Transfergemeinschaft gem�ss folgenden Varianten: Objektidentifikation gem�ss INTERLIS 2 Definition f�r OID (entweder als UUIDOID nach ISO 11578 oder INTERLIS 2 STANDARDOID), siehe auch INTERLIS 2 Referenzhandbuch www.interlis.ch
      TextPos: MANDATORY LKoord; 
      TextOri: MANDATORY Orientierung;
      TextHAli: MANDATORY HALIGNMENT;
      TextVAli: MANDATORY VALIGNMENT;
   END TextPos; 

!! neu 30.8.2011 / 21.2.2012 (geerbt von BaseClass)
   CLASS SymbolPos (ABSTRACT) EXTENDS BaseClass =
!!      OID AS ANYOID; !! Hier definiert als ANY. Genaue Definition und Wahl durch die Transfergemeindschaft gem�ss folgenden Varianten: Objektidentifikation gem�ss INTERLIS 2 Definition f�r OID (entweder als INTERLIS 2 STANDARD-OID oder UUID-OID nach ISO 11578), siehe auch INTERLIS 2 Referenzhandbuch www.interlis.ch
      SymbolPos: MANDATORY LKoord;  !! Landeskoordinate Ost/Nord, 2D Koordinaten 
      SymbolOri: MANDATORY Orientierung;  !! Default: 90 Grad
!! 21.2.2012 verschoben in SIA405_Base.ili
!!      SymbolskalierungLaengs: 0.0..9.9;
!!      SymbolskalierungHoch: 0.0..9.9;
   END SymbolPos; 

END Base.
', '2015-12-17 20:25:44.622');
INSERT INTO sia405abwasser.t_ili2db_model (file, iliversion, modelname, content, importdate) VALUES ('Units.ili', '2.3', 'Units', '!! File Units.ili Release 2012-02-20

INTERLIS 2.3;

!! 2012-02-20 definition of "Bar [bar]" corrected
!!@precursorVersion = 2005-06-06

CONTRACTED TYPE MODEL Units (en) AT "http://www.interlis.ch/models"
  VERSION "2012-02-20" =

  UNIT
    !! abstract Units
    Area (ABSTRACT) = (INTERLIS.LENGTH*INTERLIS.LENGTH);
    Volume (ABSTRACT) = (INTERLIS.LENGTH*INTERLIS.LENGTH*INTERLIS.LENGTH);
    Velocity (ABSTRACT) = (INTERLIS.LENGTH/INTERLIS.TIME);
    Acceleration (ABSTRACT) = (Velocity/INTERLIS.TIME);
    Force (ABSTRACT) = (INTERLIS.MASS*INTERLIS.LENGTH/INTERLIS.TIME/INTERLIS.TIME);
    Pressure (ABSTRACT) = (Force/Area);
    Energy (ABSTRACT) = (Force*INTERLIS.LENGTH);
    Power (ABSTRACT) = (Energy/INTERLIS.TIME);
    Electric_Potential (ABSTRACT) = (Power/INTERLIS.ELECTRIC_CURRENT);
    Frequency (ABSTRACT) = (INTERLIS.DIMENSIONLESS/INTERLIS.TIME);

    Millimeter [mm] = 0.001 [INTERLIS.m];
    Centimeter [cm] = 0.01 [INTERLIS.m];
    Decimeter [dm] = 0.1 [INTERLIS.m];
    Kilometer [km] = 1000 [INTERLIS.m];

    Square_Meter [m2] EXTENDS Area = (INTERLIS.m*INTERLIS.m);
    Cubic_Meter [m3] EXTENDS Volume = (INTERLIS.m*INTERLIS.m*INTERLIS.m);

    Minute [min] = 60 [INTERLIS.s];
    Hour [h] = 60 [min];
    Day [d] = 24 [h];

    Kilometer_per_Hour [kmh] EXTENDS Velocity = (km/h);
    Meter_per_Second [ms] = 3.6 [kmh];
    Newton [N] EXTENDS Force = (INTERLIS.kg*INTERLIS.m/INTERLIS.s/INTERLIS.s);
    Pascal [Pa] EXTENDS Pressure = (N/m2);
    Joule [J] EXTENDS Energy = (N*INTERLIS.m);
    Watt [W] EXTENDS Power = (J/INTERLIS.s);
    Volt [V] EXTENDS Electric_Potential = (W/INTERLIS.A);

    Inch [in] = 2.54 [cm];
    Foot [ft] = 0.3048 [INTERLIS.m];
    Mile [mi] = 1.609344 [km];

    Are [a] = 100 [m2];
    Hectare [ha] = 100 [a];
    Square_Kilometer [km2] = 100 [ha];
    Acre [acre] = 4046.873 [m2];

    Liter [L] = 1 / 1000 [m3];
    US_Gallon [USgal] = 3.785412 [L];

    Angle_Degree = 180 / PI [INTERLIS.rad];
    Angle_Minute = 1 / 60 [Angle_Degree];
    Angle_Second = 1 / 60 [Angle_Minute];

    Gon = 200 / PI [INTERLIS.rad];

    Gram [g] = 1 / 1000 [INTERLIS.kg];
    Ton [t] = 1000 [INTERLIS.kg];
    Pound [lb] = 0.4535924 [INTERLIS.kg];

    Calorie [cal] = 4.1868 [J];
    Kilowatt_Hour [kWh] = 0.36E7 [J];

    Horsepower = 746 [W];

    Techn_Atmosphere [at] = 98066.5 [Pa];
    Atmosphere [atm] = 101325 [Pa];
    Bar [bar] = 100000 [Pa];
    Millimeter_Mercury [mmHg] = 133.3224 [Pa];
    Torr = 133.3224 [Pa]; !! Torr = [mmHg]

    Decibel [dB] = FUNCTION // 10**(dB/20) * 0.00002 // [Pa];

    Degree_Celsius [oC] = FUNCTION // oC+273.15 // [INTERLIS.K];
    Degree_Fahrenheit [oF] = FUNCTION // (oF+459.67)/1.8 // [INTERLIS.K];

    CountedObjects EXTENDS INTERLIS.DIMENSIONLESS;

    Hertz [Hz] EXTENDS Frequency = (CountedObjects/INTERLIS.s);
    KiloHertz [KHz] = 1000 [Hz];
    MegaHertz [MHz] = 1000 [KHz];

    Percent = 0.01 [CountedObjects];
    Permille = 0.001 [CountedObjects];

    !! ISO 4217 Currency Abbreviation
    USDollar [USD] EXTENDS INTERLIS.MONEY;
    Euro [EUR] EXTENDS INTERLIS.MONEY;
    SwissFrancs [CHF] EXTENDS INTERLIS.MONEY;

END Units.

', '2015-12-17 20:25:44.622');


-- SET search_path = vsadss2015_2_d_251, pg_catalog;

--
-- TOC entry 6136 (class 0 OID 149612)
-- Dependencies: 872
-- Data for Name: sia405abwasser.t_ili2db_model; Type: TABLE DATA; Schema: vsadss2015_2_d_251; Owner: postgres
--



-- Completed on 2016-01-20 22:39:54

--
-- PostgreSQL database dump complete
--

