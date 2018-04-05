-- ******************************************************************************
-- Open/view files in qgep
-- ******************************************************************************
--1. ADD fk_data_media : 
-- ******************************************************************************

-- Modification of table od_file --> insert fk_data_media

ALTER TABLE qgep.od_file
ADD COLUMN fk_data_media character varying(16);
-- ******************************************************************************
-- 2. qgep.vw_file : 
-- ******************************************************************************

-- View: qgep.vw_file
-- DROP VIEW qgep.vw_file;

CREATE OR REPLACE VIEW qgep.vw_file AS 
 SELECT f.obj_id,
    f.identifier,
    f.kind AS file_kind,
    f.object,
    f.class,
    -- dm.path,   
    dm.path::text || f.path_relative::text AS _url,
    f.remark
   FROM qgep.od_file f
     LEFT JOIN qgep.od_data_media dm ON dm.obj_id::text = f.fk_data_media::text;

ALTER TABLE qgep.vw_file
  OWNER TO postgres;

-- ******************************************************************************
-- 3. FUNCTIONS : 
-- ******************************************************************************

-- Function: qgep.vw_file_delete()
-- DROP FUNCTION qgep.vw_file_delete();

CREATE OR REPLACE FUNCTION qgep.vw_file_delete()
  RETURNS trigger AS
$BODY$
	BEGIN
		DELETE FROM qgep.od_file WHERE obj_id = OLD.obj_id;
		RETURN NULL;
	END;
	$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION qgep.vw_file_delete()
  OWNER TO postgres;


-- Function: qgep.vw_file_insert()
-- DROP FUNCTION qgep.vw_file_insert();
CREATE OR REPLACE FUNCTION qgep.vw_file_insert()
  RETURNS trigger AS
$BODY$

/* Need to get some variables from both table 
 --> Use the NEW._url to access the od_data_media (already set by admin!) 
 --> postgres will have to compare the NEW._url to the already set od_data_media.path and return the one corresponding.
 -->
*/
DECLARE
	_fk_data_media character varying(16);
	_path_relative character varying(200);
	_path character varying(100);

BEGIN

-- _path
SELECT dm.path into _path
FROM qgep.od_data_media dm, qgep.vw_file
WHERE dm.path like substring(NEW._url, 1, char_length(dm.path)); -- the error might be here

-- _path_relative
SELECT 
	substring(NEW._url, char_length(_path)+1,char_length(NEW._url))
	into _path_relative
FROM qgep.od_data_media dm
WHERE dm.path IN 
	(
	SELECT DISTINCT
		dm.path
	FROM qgep.od_data_media dm, qgep.vw_file

	WHERE dm.path like substring(NEW._url, 1, char_length(dm.path))
	);

-- _foreign key
  SELECT obj_id INTO _fk_data_media
  FROM qgep.od_data_media dm
  WHERE dm.path like substring(NEW._url, 1, char_length(dm.path));

  INSERT INTO  qgep.od_file(

      obj_id,
      class,
      identifier,
      kind,
      object,
      path_relative,
      remark,
      --last_modification,  to be set once the rest is working
      --fk_dataowner,
      --fk_provider,
      fk_data_media
      )
  VALUES
      (qgep.generate_oid('od_file'::text),
      NEW.class,
      NEW.identifier, 
      NEW.file_kind,
      NEW.object,
      _path_relative,
      NEW.remark,
      _fk_data_media
      );
  
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;

ALTER FUNCTION qgep.vw_file_insert()
  OWNER TO postgres;
  -- ******************************************************************************
  
-- Not yet corrected -- waiting for INSERT to work.   
-- Function: qgep.vw_file_update()
-- DROP FUNCTION qgep.vw_file_update();

CREATE OR REPLACE FUNCTION qgep.vw_file_update()
  RETURNS trigger AS
$BODY$

DECLARE
	_fk_data_media character varying(16);
	_path_relative character varying(200);
	_path  character varying(100);
BEGIN
SELECT 
	substring(NEW._url, char_length(dm.path)+1,char_length(NEW._url)),
	path 
	into _path_relative, _path
FROM qgep.od_data_media dm
WHERE dm.path IN 
	(
	SELECT DISTINCT
		dm.path
	FROM qgep.od_data_media dm, qgep.vw_file

	WHERE dm.path like substring(NEW._url, 1, char_length(dm.path))
	);

  UPDATE  qgep.od_file
    SET 
      identifier = NEW.identifier, 
      kind = NEW.file_kind,
      class = NEW.class,
      path_relative=_path_relative,
      --substring(NEW._url, char_length(path)+1,char_length(NEW._url)),

      remark=NEW.remark;
      

--  (select(obj_id
-- 			from qgep.od_data_media
-- 			where od_data_media.path=new.path))
  
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION qgep.vw_file_update()
  OWNER TO postgres;


-- TRIGGERS :
-- ******************************************************************************
-- Trigger: vw_file_delete on qgep.vw_file
-- DROP TRIGGER vw_file_delete ON qgep.vw_file;

CREATE TRIGGER vw_file_delete
  INSTEAD OF DELETE
  ON qgep.vw_file
  FOR EACH ROW
  EXECUTE PROCEDURE qgep.vw_file_delete();

-- Trigger: vw_file_insert on qgep.vw_file
-- DROP TRIGGER vw_file_insert ON qgep.vw_file;

CREATE TRIGGER vw_file_insert
  INSTEAD OF INSERT
  ON qgep.vw_file
  FOR EACH ROW
  EXECUTE PROCEDURE qgep.vw_file_insert();

-- Trigger: vw_file_update on qgep.vw_file
-- DROP TRIGGER vw_file_update ON qgep.vw_file;

CREATE TRIGGER vw_file_update
  INSTEAD OF UPDATE
  ON qgep.vw_file
  FOR EACH ROW
  EXECUTE PROCEDURE qgep.vw_file_update();
-- ******************************************************************************


