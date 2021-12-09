CREATE TABLE documentagreementuser(
	documentagreementuser_id INTEGER NOT NULL,
	documentagreement_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	docagreementuser_datebeg DATE NOT NULL,
	docagreementuser_dateend DATE NOT NULL,
	docagreementuser_dateset DATE NOT NULL,
    PRIMARY KEY (documentagreementuser_id)
);
CREATE SEQUENCE documentagreementuser_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE documentagreementuser_id_gen OWNED BY documentagreementuser.documentagreementuser_id;
ALTER TABLE documentagreementuser ADD UNIQUE (documentagreement_id,proguser_id);

CREATE VIEW ft_documentagreementuser
AS
SELECT
	documentagreementuser_id,
	CAST(
		trim(to_char(docagreementuser_datebeg, 'DD.MM.YYYY'))||' '||trim(to_char(docagreementuser_dateend, 'DD.MM.YYYY'))||' '||trim(to_char(docagreementuser_dateset, 'DD.MM.YYYY'))
		AS varchar(49)
	) AS fulltext
FROM documentagreementuser;

