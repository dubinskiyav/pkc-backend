CREATE TABLE documentreal(
	documentreal_id INTEGER NOT NULL,
	document_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	clusterdocumentreal_id INTEGER NOT NULL,
    DOCUMENTTYPE_ID INTEGER NOT NULL,
	documentreal_name VARCHAR(128) NOT NULL,
	documentreal_code VARCHAR(10),
	documentreal_number VARCHAR(50),
	documentreal_date TIMESTAMP NOT NULL,
	documentreal_remark VARCHAR(2000),
	documentreal_level INTEGER NOT NULL,
	documentreal_datebeg TIMESTAMP,
	documentreal_dateend TIMESTAMP,
	documentreal_repkey VARCHAR(40),
	documentreal_status INTEGER NOT NULL,
	lastproguser_id INTEGER,
	documentreal_datecreate TIMESTAMP,
	documentreal_datemodify TIMESTAMP,
	parent_id INTEGER NOT NULL,
    PRIMARY KEY (documentreal_id)
);

CREATE SEQUENCE documentreal_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentreal_id_gen OWNED BY documentreal.documentreal_id;

CREATE VIEW ft_documentreal
AS
SELECT
	documentreal_id,
	CAST(
		trim(documentreal_name)||' '||coalesce(documentreal_code,'')||' '||coalesce(documentreal_number,'')||' '||trim(to_char(documentreal_date, 'DD.MM.YYYY'))||' '||coalesce(documentreal_remark,'')||' '||coalesce(to_char(documentreal_datebeg, 'DD.MM.YYYY'),'')||' '||coalesce(to_char(documentreal_dateend, 'DD.MM.YYYY'),'')||' '||trim(cast(documentreal_status as varchar))||' '||coalesce(cast(lastproguser_id as varchar),'')||' '||coalesce(to_char(documentreal_datecreate, 'DD.MM.YYYY'),'')||' '||coalesce(to_char(documentreal_datemodify, 'DD.MM.YYYY'),'')
		AS varchar(2423)
	) AS fulltext
FROM documentreal;

CREATE TABLE clusterdocumentreal (
    clusterdocumentreal_id int4 NOT NULL,
    CONSTRAINT clusterdocumentreal_pk PRIMARY KEY (clusterdocumentreal_id)
);

CREATE SEQUENCE clusterdocumentreal_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE clusterdocumentreal_id_gen OWNED BY clusterdocumentreal.clusterdocumentreal_id;

CREATE TABLE documentrealcluster (
    documentreal_id int4 NOT NULL,
    clusterdocumentreal_id int4 NOT NULL,
    CONSTRAINT documentrealcluster_ak1 UNIQUE (clusterdocumentreal_id),
    CONSTRAINT documentrealcluster_pk PRIMARY KEY (documentreal_id),
    CONSTRAINT documentrealcluster_fk1 FOREIGN KEY (documentreal_id) REFERENCES documentreal(documentreal_id),
    CONSTRAINT documentrealcluster_fk2 FOREIGN KEY (clusterdocumentreal_id) REFERENCES clusterdocumentreal(clusterdocumentreal_id)
);

CREATE TABLE documentcluster (
    document_id int4 NOT NULL,
    clusterdocumentreal_id int4 NOT NULL,
    CONSTRAINT documentcluster_ak1 UNIQUE (clusterdocumentreal_id),
    CONSTRAINT documentcluster_pk PRIMARY KEY (document_id),
    CONSTRAINT documentcluster_fk1 FOREIGN KEY (clusterdocumentreal_id) REFERENCES clusterdocumentreal(clusterdocumentreal_id),
    CONSTRAINT documentcluster_fk2 FOREIGN KEY (document_id) REFERENCES document(document_id)
);
