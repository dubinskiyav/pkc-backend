CREATE TABLE documentrealagreeuser(
	documentrealagreeuser_id INTEGER NOT NULL,
	documentrealagree_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	docrealagreeuser_datebeg DATE NOT NULL,
	docrealagreeuser_dateend DATE NOT NULL,
	docrealagreeuser_dateset DATE NOT NULL,
    PRIMARY KEY (documentrealagreeuser_id)
);
CREATE SEQUENCE documentrealagreeuser_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentrealagreeuser_id_gen OWNED BY documentrealagreeuser.documentrealagreeuser_id;
ALTER TABLE documentrealagreeuser ADD UNIQUE (documentrealagree_id,proguser_id);

CREATE VIEW ft_documentrealagreeuser
AS
SELECT
	documentrealagreeuser_id,
	CAST(
		trim(to_char(docrealagreeuser_datebeg, 'DD.MM.YYYY'))||' '||trim(to_char(docrealagreeuser_dateend, 'DD.MM.YYYY'))||' '||trim(to_char(docrealagreeuser_dateset, 'DD.MM.YYYY'))
		AS varchar(49)
	) AS fulltext
FROM documentrealagreeuser;

