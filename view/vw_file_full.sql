-------------------------------------
-- view to Open/View an attached file
-- View: qgep.vw_file
-------------------------------------

-- DROP VIEW qgep.vw_file;

CREATE OR REPLACE VIEW qgep.vw_file AS 
 SELECT f.obj_id,
    f.identifier,
    f.kind AS file_kind,
    f.object,
    f.class,
    dm.kind AS data_media_kind,
    dm.path,
    dm.path::text || f.path_relative::text AS _url,
    f.remark
   FROM qgep.od_file f
     LEFT JOIN qgep.od_data_media dm ON dm.obj_id::text = f.fk_data_media::text;

ALTER TABLE qgep.vw_file
  OWNER TO postgres;

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

  -- Trigger: vw_file_delete on qgep.vw_file

-- DROP TRIGGER vw_file_delete ON qgep.vw_file;

CREATE TRIGGER vw_file_delete
  INSTEAD OF DELETE
  ON qgep.vw_file
  FOR EACH ROW
  EXECUTE PROCEDURE qgep.vw_file_delete();


-----------------------------------
-- building INSERT
-- Function: vw_file_insert()
-----------------------------------

CREATE OR REPLACE FUNCTION qgep.vw_file_insert()
  RETURNS trigger AS
  
$BODY$

BEGIN
  INSERT INTO  qgep.od_file(

      obj_id,
      class,
      identifier,
      kind,
      object,
      path_relative,
      remark,
      --last_modification,
      --fk_dataowner,
      --fk_provider,
      fk_data_media
      )
  VALUES
      (NEW.obj_id,
      NEW.class,
      NEW.identifier, 
      NEW.file_kind,
      NEW.object,
      substring(NEW._url, char_length(NEW.path)+1,char_length(NEW._url)),
      NEW.remark,
      qgep.fk_data_media()
      );
  
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION qgep.vw_file_insert()
  OWNER TO postgres;


-----------------------------------
-- building UPDATE
-- Function: qgep.vw_file_update()
-----------------------------------

-- DROP FUNCTION qgep.vw_file_update();

CREATE OR REPLACE FUNCTION qgep.vw_file_update()
  RETURNS trigger AS
$BODY$
BEGIN
  UPDATE  qgep.od_file
    SET 
      identifier = NEW.identifier, 
      kind = NEW.file_kind,
      class = NEW.class,
      path_relative=NEW.substring(_url, char_length(path)+1,char_length(_url)),
      remark=NEW.remark,
      fk_data_media = qgep.fk_data_media();

     --  (select(obj_id
-- 			from qgep.od_data_media
-- 			where od_data_media.path=new.path))
  
  RETURN NEW;
END; $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION qgep.vw_file_update()
  OWNER TO postgres;

-----------------------------------
-- building DELETE
-- Function: qgep.vw_file_delete()
-----------------------------------

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

--------------------------------------------
-- building fk_data_media retrieve function
-- Function : ft_fk_data_media
--------------------------------------------

CREATE OR REPLACE FUNCTION qgep.ft_fk_data_media()
  RETURNS trigger AS
$BODY$

DECLARE
	_fk character varying(16);

BEGIN

  SELECT obj_id INTO _fk
  FROM qgep.od_data_media obj_id
  WHERE NEW.path = od_data_media.path;

RETURN _fk;

END;

$BODY$
  LANGUAGE plpgsql VOLATILE;


