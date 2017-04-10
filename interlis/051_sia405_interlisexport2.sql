------ This file is sql code to Export QGEP (Modul SIA405Abwasser) in English to INTERLIS in German on QQIS
------ Second version using tid_generate and tid_lookup
------ For questions etc. please contact Stefan Burckhardt stefan.burckhardt@sjib.ch
------ version 15.03.2016 14:19:45 / modified 20.8.2016 Konradin Fischer

DELETE FROM sia405abwasser.organisation;
DELETE FROM sia405abwasser.abwasserbauwerk;
DELETE FROM sia405abwasser.kanal;
DELETE FROM sia405abwasser.normschacht;
DELETE FROM sia405abwasser.einleitstelle;
DELETE FROM sia405abwasser.spezialbauwerk;
DELETE FROM sia405abwasser.versickerungsanlage;
DELETE FROM sia405abwasser.rohrprofil;
DELETE FROM sia405abwasser.abwassernetzelement;
DELETE FROM sia405abwasser.haltungspunkt;
DELETE FROM sia405abwasser.abwasserknoten;
DELETE FROM sia405abwasser.haltung;
DELETE FROM sia405abwasser.bauwerksteil;
DELETE FROM sia405abwasser.trockenwetterfallrohr;
DELETE FROM sia405abwasser.einstiegshilfe;
DELETE FROM sia405abwasser.trockenwetterrinne;
DELETE FROM sia405abwasser.deckel;
DELETE FROM sia405abwasser.bankett;

DELETE FROM sia405abwasser.metaattribute;
DELETE FROM sia405abwasser.sia405_baseclass;
DELETE FROM sia405abwasser.baseclass;

--- t_key_object initialisieren

UPDATE sia405abwasser.t_key_object SET t_lastuniqueid = 0, t_createdate = current_timestamp, t_user = 'postgres';


--- OK: fk_Attributes
--- OK: JOIN for fk_dataowner / provider
--- in Progress: organisation.fk_part_of data - prepared, but no qgep.table hierarchy and data, dito for all other class - class associations
--- Not tested: if data with reach - reach connection
--- abwasserbauwerk.detailgeometrie and haltung.verlauf commented out as long qgep has not geometry datatypes that allow ARCS



INSERT INTO sia405abwasser.baseclass
(
t_id, t_type, t_ili_tid)
SELECT sia405abwasser.tid_generate('bauwerksteil', obj_id), 'bauwerksteil', obj_id
FROM qgep.od_structure_part;

INSERT INTO sia405abwasser.sia405_baseclass
(
t_id, obj_id)
SELECT sia405abwasser.tid_lookup('bauwerksteil', obj_id), obj_id
FROM qgep.od_structure_part;

INSERT INTO sia405abwasser.baseclass
(
t_id, t_type, t_ili_tid)
SELECT sia405abwasser.tid_generate('haltungspunkt', obj_id), 'haltungspunkt', obj_id
FROM qgep.od_reach_point;

INSERT INTO sia405abwasser.sia405_baseclass
(
t_id, obj_id)
SELECT sia405abwasser.tid_lookup('haltungspunkt', obj_id), obj_id
FROM qgep.od_reach_point;

INSERT INTO sia405abwasser.baseclass
(
t_id, t_type, t_ili_tid)
SELECT sia405abwasser.tid_generate('abwassernetzelement', obj_id), 'abwassernetzelement', obj_id
FROM qgep.od_wastewater_networkelement;

INSERT INTO sia405abwasser.sia405_baseclass
(
t_id, obj_id)
SELECT sia405abwasser.tid_lookup('abwassernetzelement', obj_id), obj_id
FROM qgep.od_wastewater_networkelement;

INSERT INTO sia405abwasser.baseclass
(
t_id, t_type, t_ili_tid)
SELECT sia405abwasser.tid_generate('rohrprofil', obj_id), 'rohrprofil', obj_id
FROM qgep.od_pipe_profile;

INSERT INTO sia405abwasser.sia405_baseclass
(
t_id, obj_id)
SELECT sia405abwasser.tid_lookup('rohrprofil', obj_id), obj_id
FROM qgep.od_pipe_profile;

INSERT INTO sia405abwasser.baseclass
(
t_id, t_type, t_ili_tid)
SELECT sia405abwasser.tid_generate('abwasserbauwerk', obj_id), 'abwasserbauwerk', obj_id
FROM qgep.od_wastewater_structure;

INSERT INTO sia405abwasser.sia405_baseclass
(
t_id, obj_id)
SELECT sia405abwasser.tid_lookup('abwasserbauwerk', obj_id), obj_id
FROM qgep.od_wastewater_structure;

INSERT INTO sia405abwasser.baseclass
(
t_id, t_type, t_ili_tid)
SELECT sia405abwasser.tid_generate('organisation', obj_id), 'organisation', obj_id
FROM qgep.od_organisation;

INSERT INTO sia405abwasser.sia405_baseclass
(
t_id, obj_id)
SELECT sia405abwasser.tid_lookup('organisation', obj_id), obj_id
FROM qgep.od_organisation;
