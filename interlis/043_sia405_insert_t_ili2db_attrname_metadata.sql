-- add metadata in table t_ili2db_attrname

-- INSERT INTO sia405abwasser.t_ili2db_attrname (iliname, sqlname) 
-- VALUES ('SIA405_Base.SIA405_BaseClass.Metaattribute', 'SIA405_Base_SIA405_BaseClass_Metaattribute');

-- Table: qtest.t_ili2db_attrname

DROP TABLE sia405abwasser.t_ili2db_attrname;

CREATE TABLE sia405abwasser.t_ili2db_attrname
(
  iliname character varying(1024) NOT NULL,
  sqlname character varying(1024) NOT NULL
  -- owner character varying(1024) NOT NULL,
  -- target character varying(1024),
  -- CONSTRAINT t_ili2db_attrname_pkey PRIMARY KEY (sqlname, owner),
  -- CONSTRAINT t_ili2db_attrname_sqlname_owner_key UNIQUE (sqlname, owner)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE sia405abwasser.t_ili2db_attrname
  OWNER TO postgres;


INSERT INTO sia405abwasser.t_ili2db_attrname (iliname, sqlname) 
VALUES ('SIA405_Base.SIA405_BaseClass.Metaattribute', 'SIA405_Base_SIA405_BaseClass_Metaattribute');
