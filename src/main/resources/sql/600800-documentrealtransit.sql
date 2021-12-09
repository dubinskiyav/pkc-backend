CREATE TABLE documentrealtransit(
	documentrealtransit_id INTEGER NOT NULL,
	documentreal_id INTEGER NOT NULL,
	documenttransit_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	documentrealtransit_date TIMESTAMP NOT NULL,
	documentrealtransit_remark VARCHAR(128),
	documentrealtransit_dateset TIMESTAMP NOT NULL,
	documentrealtransit_flag INTEGER NOT NULL,
    PRIMARY KEY (documentrealtransit_id)
);
CREATE SEQUENCE documentrealtransit_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentrealtransit_id_gen OWNED BY documentrealtransit.documentrealtransit_id;

CREATE VIEW ft_documentrealtransit
AS
SELECT
	documentrealtransit_id,
	CAST(
		trim(to_char(documentrealtransit_date, 'DD.MM.YYYY'))||' '||coalesce(documentrealtransit_remark,'')||' '||trim(to_char(documentrealtransit_dateset, 'DD.MM.YYYY'))||' '||trim(cast(documentrealtransit_flag as varchar))
		AS varchar(206)
	) AS fulltext
FROM documentrealtransit;

