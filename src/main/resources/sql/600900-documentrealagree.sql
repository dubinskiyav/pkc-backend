CREATE TABLE documentrealagree(
	documentrealagree_id INTEGER NOT NULL,
	documentreal_id INTEGER NOT NULL,
	proguser_id INTEGER,
	documentrealagreelink_id INTEGER,
	progusercreate_id INTEGER,
	documentrealagree_number INTEGER NOT NULL,
	documentrealagree_date TIMESTAMP,
	documentrealagree_remark VARCHAR(255),
	subjectwg_id INTEGER,
	documentrealagree_name VARCHAR(50) NOT NULL,
	documentrealagree_level INTEGER NOT NULL,
	documentrealagree_required INTEGER NOT NULL,
	documentrealagree_status INTEGER,
	documentrealagree_notagree INTEGER,
	documentrealagree_datereq DATE,
    PRIMARY KEY (documentrealagree_id)
);
CREATE SEQUENCE documentrealagree_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentrealagree_id_gen OWNED BY documentrealagree.documentrealagree_id;
ALTER TABLE documentrealagree ADD UNIQUE (documentreal_id,documentrealagree_number);

CREATE VIEW ft_documentrealagree
AS
SELECT
	documentrealagree_id,
	CAST(
		trim(cast(documentrealagree_number as varchar))||' '||coalesce(to_char(documentrealagree_date, 'DD.MM.YYYY'),'')||' '||coalesce(documentrealagree_remark,'')||' '||trim(documentrealagree_name)||' '||trim(cast(documentrealagree_level as varchar))||' '||trim(cast(documentrealagree_required as varchar))||' '||coalesce(cast(documentrealagree_status as varchar),'')||' '||coalesce(cast(documentrealagree_notagree as varchar),'')||' '||coalesce(to_char(documentrealagree_datereq, 'DD.MM.YYYY'),'')
		AS varchar(407)
	) AS fulltext
FROM documentrealagree;

