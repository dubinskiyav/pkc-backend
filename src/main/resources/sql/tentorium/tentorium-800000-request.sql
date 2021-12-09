CREATE TABLE request(
	request_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	provider_id INTEGER NOT NULL,
	request_avbalance NUMERIC(16,2),
	request_pickupflag INTEGER NOT NULL,
	addresss_id INTEGER,
	consignee_id INTEGER,
	transporter_id INTEGER,
	formpayment_id INTEGER NOT NULL,
	deliverykind_id INTEGER NOT NULL,
	request_loadoperflag INTEGER NOT NULL,
	request_tempregflag INTEGER NOT NULL,
    requestout_number VARCHAR(50),
    requestout_pk  INTEGER,
    CONSTRAINT request_pk PRIMARY KEY (request_id)
);
CREATE SEQUENCE request_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE request_id_gen OWNED BY request.request_id;

CREATE VIEW ft_request
AS
SELECT
	request_id,
	CAST(
		coalesce(cast(request_avbalance as varchar),'')||' '||trim(cast(request_pickupflag as varchar))||' '||trim(cast(request_loadoperflag as varchar))||' '||trim(cast(request_tempregflag as varchar))
		AS varchar(40)
	) AS fulltext
FROM request;

