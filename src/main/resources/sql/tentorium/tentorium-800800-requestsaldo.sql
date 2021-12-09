CREATE TABLE requestsaldo(
	requestsaldo_id INTEGER NOT NULL,
	requestsaldo_date TIMESTAMP NOT NULL,
	company_id INTEGER NOT NULL,
	partner_id INTEGER NOT NULL,
	contract_id INTEGER NOT NULL,
	requestsaldo_summa NUMERIC(16,2) NOT NULL,
    CONSTRAINT requestsaldo_pk PRIMARY KEY (requestsaldo_id)
);
CREATE SEQUENCE requestsaldo_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE requestsaldo_id_gen OWNED BY requestsaldo.requestsaldo_id;

CREATE VIEW ft_requestsaldo
AS
SELECT
	requestsaldo_id,
	CAST(
		trim(to_char(requestsaldo_date, 'DD.MM.YYYY'))||' '||trim(cast(requestsaldo_summa as varchar))
		AS varchar(29)
	) AS fulltext
FROM requestsaldo;

CREATE TABLE subjectdogovor (
	SUBJECTDOGOVOR_ID INTEGER NOT NULL,
	SUBJECTDOGOVORTYPE_ID INTEGER NOT NULL,
	SUBJECT_ID1 INTEGER NOT NULL,
	SUBJECT_ID2 INTEGER NOT NULL,
	SUBJECTDOGOVOR_NUMBER VARCHAR(20) NOT NULL,
	SUBJECTDOGOVOR_DATE TIMESTAMP NOT NULL,
	SUBJECTDOGOVOR_NOTE VARCHAR(100)
);

INSERT INTO subjectdogovor VALUES(1, 7, 6, 1, '1', '12.10.2012', 'null');

