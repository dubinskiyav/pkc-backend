CREATE TABLE document(
	document_id INTEGER NOT NULL,
	document_name VARCHAR(50) NOT NULL,
	document_shortname VARCHAR(10),
	document_historyflag INTEGER NOT NULL,
	document_lockflag INTEGER NOT NULL,
    PRIMARY KEY (document_id)
);
CREATE SEQUENCE document_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE document_id_gen OWNED BY document.document_id;
ALTER TABLE document ADD UNIQUE (document_name);

CREATE VIEW ft_document
AS
SELECT
	document_id,
	CAST(
		trim(document_name)||' '||coalesce(document_shortname,'')
		AS varchar(90)
	) AS fulltext
FROM document;

