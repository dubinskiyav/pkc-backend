CREATE TABLE documenttransit(
	documenttransit_id INTEGER NOT NULL,
	document_id INTEGER NOT NULL,
	documenttransit_number INTEGER NOT NULL,
	documenttransit_name VARCHAR(50) NOT NULL,
	documenttransit_level INTEGER NOT NULL,
	documenttransit_required INTEGER NOT NULL,
	documenttransit_candelete INTEGER NOT NULL,
	documenttransit_useadmin INTEGER NOT NULL,
	documenttransit_canedit INTEGER NOT NULL,
	documenttransit_twicecheck INTEGER NOT NULL,
	documenttransit_flaghistory INTEGER NOT NULL,
	documenttransit_flagone INTEGER NOT NULL,
	documenttransit_locksubj INTEGER NOT NULL,
	documenttransit_agreeedit INTEGER NOT NULL,
    documenttransit_color INTEGER,
    PRIMARY KEY (documenttransit_id)
);
CREATE SEQUENCE documenttransit_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documenttransit_id_gen OWNED BY documenttransit.documenttransit_id;
ALTER TABLE documenttransit ADD UNIQUE (document_id,documenttransit_number);
ALTER TABLE documenttransit ADD UNIQUE (document_id,documenttransit_name);

CREATE TABLE documenttransitrole (
    documenttransitrole_id int4 NOT NULL,
    documenttransit_id int4 NOT NULL,
    accessrole_id int4 NOT NULL,
    CONSTRAINT documenttransitrole_pk PRIMARY KEY (documenttransitrole_id),
    CONSTRAINT documenttransitrole_fk1 FOREIGN KEY (documenttransit_id) REFERENCES documenttransit(documenttransit_id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT documenttransitrole_fk2 FOREIGN KEY (accessrole_id) REFERENCES accessrole(accessrole_id)
);
CREATE SEQUENCE documenttransitrole_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documenttransitrole_id_gen OWNED BY documenttransitrole.documenttransitrole_id;


CREATE TABLE documenttransitlink (
    documenttransitlink_id int4 NOT NULL,
    documenttransitparent_id int4 NOT NULL,
    documenttransitchild_id int4 NOT NULL,
    CONSTRAINT documenttransitlink_ak1 UNIQUE (documenttransitparent_id, documenttransitchild_id),
    CONSTRAINT documenttransitlink_pk PRIMARY KEY (documenttransitlink_id),
    CONSTRAINT documenttransitlink_fk1 FOREIGN KEY (documenttransitparent_id) REFERENCES documenttransit(documenttransit_id)  ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT documenttransitlink_fk2 FOREIGN KEY (documenttransitchild_id) REFERENCES documenttransit(documenttransit_id)  ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE SEQUENCE documenttransitlink_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documenttransitlink_id_gen OWNED BY documenttransitlink.documenttransitlink_id;


CREATE TABLE documenttransitsetting (
    documenttransitsetting_id int4 NOT NULL,
    capcode_id int4 NOT NULL,
    documenttransit_id int4 NOT NULL,
    CONSTRAINT documenttransitsetting_ak1 UNIQUE (documenttransit_id),
    CONSTRAINT documenttransitsetting_ak2 UNIQUE (capcode_id),
    CONSTRAINT documenttransitsetting_pk PRIMARY KEY (documenttransitsetting_id),
    CONSTRAINT documenttransitsetting_fk1 FOREIGN KEY (capcode_id) REFERENCES capcode(capcode_id),
    CONSTRAINT documenttransitsetting_fk2 FOREIGN KEY (documenttransit_id) REFERENCES documenttransit(documenttransit_id)
);
CREATE SEQUENCE documenttransitsetting_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documenttransitsetting_id_gen OWNED BY documenttransitsetting.documenttransitsetting_id;


CREATE VIEW ft_documenttransit
AS
SELECT
	documenttransit_id,
	CAST(
		trim(cast(documenttransit_number as varchar))||' '||trim(documenttransit_name)
		AS varchar(170)
	) AS fulltext
FROM documenttransit;

