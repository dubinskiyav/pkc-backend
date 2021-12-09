CREATE TABLE documentrealagreeinfo(
	documentrealagreeinfo_id INTEGER NOT NULL,
	documentrealagree_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	documentrealagreeinfo_date DATE NOT NULL,
	documentrealagreeinfo_text bytea NOT NULL,
    PRIMARY KEY (documentrealagreeinfo_id)
);
CREATE SEQUENCE documentrealagreeinfo_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentrealagreeinfo_id_gen OWNED BY documentrealagreeinfo.documentrealagreeinfo_id;

CREATE VIEW ft_documentrealagreeinfo
AS
SELECT
	documentrealagreeinfo_id,
	CAST(
		trim(to_char(documentrealagreeinfo_date, 'DD.MM.YYYY'))
		AS varchar(23)
	) AS fulltext
FROM documentrealagreeinfo;

