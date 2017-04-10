rem ili2Pg avm Abwasser 18.03.16
rem set PATH=%PATH%;C:\Program Files (x86)\Java\jre1.8.0_25\bin
rem DSS Daten Frauenfeld von SBU
rem IMPORT
rem 1.Schritt import ili 
rem nächste Zeile mit Version 3.0.3
rem java -jar ili2pg.jar --schemaimport --trace --log im_sia405.log --dbhost localhost --dbport 5432 --dbdatabase qgep --dbschema sia405 --dbusr postgres --dbpwd post$gres SIA405_Abwasser_2015_2_d.ili
rem java -jar ili2pg.jar --schemaimport --trace --log im_2015.log --dbhost localhost --dbport 5432 --dbdatabase qgep --dbschema sia2015 --dbusr postgres --dbpwd post$gres VSA_DSS_2015_2_d.ili
rem 2. Schritt
rem Länge des Feldes Abwasserbauwerk.Bezeichnung von 20 auf 80 vergrössern
rem obwohl der Fehler in Zeile 136633 erfolgt, ist ja Tabelle Kanal
rem 3. Schritt import itf
rem java -jar ili2pg.jar --import --log im_avm.log --dbhost localhost --dbport 5432 --dbdatabase 4401_arbon --dbschema avm_bw --dbusr postgres --dbpwd post$gres avm_bauwerke.xtf
rem java -jar ili2pg.jar --import --trace --log im_avm.log --dbhost localhost --dbport 5432 --dbdatabase 4401_arbon --dbschema avm_insp --dbusr postgres --dbpwd post$gres avm_inspektionen.xtf
rem sqlenablenull wg Objekt 51720 auf Zeile 120578
rem
rem EXPORT
rem nächste Zeile mit Version 2.3.1
java -jar ili2pg.jar --trace --export --log ex_ab3.log --models SIA405_Abwasser --dbhost localhost --dbport 5432 --dbdatabase qgep --dbschema sia405abwasser --dbusr postgres --dbpwd post$gres export_arbon_small_sia405abwasser_2014_d.xtf
rem java -jar ili2pg.jar --export --trace --log 2015ex_ab.log --models DSS_2015 --dbhost localhost --dbport 5432 --dbdatabase qgep --dbschema sia405abwasser --dbusr postgres --dbpwd post$gres 2015ab.xtf