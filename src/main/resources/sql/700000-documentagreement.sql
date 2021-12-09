CREATE TABLE documentagreement(
	documentagreement_id INTEGER NOT NULL,
	document_id INTEGER NOT NULL,
	subjectwg_id INTEGER,
	documentagreement_number INTEGER NOT NULL,
	documentagreement_name VARCHAR(50) NOT NULL,
	documentagreement_level INTEGER NOT NULL,
	documentagreement_required INTEGER NOT NULL,
	documentagreement_days INTEGER,
	documentagreement_hours INTEGER,
    PRIMARY KEY (documentagreement_id)
);
CREATE SEQUENCE documentagreement_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentagreement_id_gen OWNED BY documentagreement.documentagreement_id;
ALTER TABLE documentagreement ADD UNIQUE (document_id,documentagreement_number);

CREATE VIEW ft_documentagreement
AS
SELECT
	documentagreement_id,
	CAST(
		trim(cast(documentagreement_number as varchar))||' '||trim(documentagreement_name)||' '||trim(cast(documentagreement_level as varchar))||' '||trim(cast(documentagreement_required as varchar))||' '||coalesce(cast(documentagreement_days as varchar),'')||' '||coalesce(cast(documentagreement_hours as varchar),'')
		AS varchar(110)
	) AS fulltext
FROM documentagreement;

