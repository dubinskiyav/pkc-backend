CREATE TABLE testrequest(
	testrequest_id INTEGER NOT NULL,
	capclass_id INTEGER NOT NULL,
    PRIMARY KEY (testrequest_id)
);
CREATE SEQUENCE testrequest_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE testrequest_id_gen OWNED BY testrequest.testrequest_id;

CREATE VIEW ft_testrequest
AS
SELECT
    tr.testrequest_id,
	CAST(
		cc.fulltext||' '||dr.fulltext
		AS varchar(2600)
	) AS fulltext
FROM testrequest tr
    inner join ft_capclass cc on cc.capclass_id=tr.capclass_id
    inner join ft_documentreal dr on dr.documentreal_id=tr.testrequest_id;

