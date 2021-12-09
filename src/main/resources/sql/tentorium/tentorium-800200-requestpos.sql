CREATE TABLE requestpos(
	requestpos_id INTEGER NOT NULL,
	documentreal_id INTEGER NOT NULL,
	requestpos_number INTEGER NOT NULL,
	requestpos_plancount NUMERIC(16,2) NOT NULL,
	requestpos_price NUMERIC(16,2) NOT NULL,
	requestpos_boxcount NUMERIC(16,2) NOT NULL,
	requestpos_note VARCHAR(255),
	sgood_id INTEGER NOT NULL,
	pricesgoodsubjectprice_id INTEGER,
	requestpos_points INTEGER,
	pricesgoodsubjectpoints_id INTEGER,
    character_id integer,
    requestpos_remains NUMERIC(16,2),
    CONSTRAINT requestpos_pk PRIMARY KEY (requestpos_id)
);
CREATE SEQUENCE requestpos_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE requestpos_id_gen OWNED BY requestpos.requestpos_id;
ALTER TABLE requestpos ADD UNIQUE (documentreal_id,sgood_id);
ALTER TABLE requestpos ADD UNIQUE (documentreal_id,requestpos_number);

CREATE VIEW ft_requestpos
AS
SELECT
	requestpos_id,
	CAST(
		trim(cast(requestpos_number as varchar))||' '||trim(cast(requestpos_plancount as varchar))||' '||trim(cast(requestpos_price as varchar))||' '||trim(cast(requestpos_boxcount as varchar))||' '||coalesce(requestpos_note,'')||' '||coalesce(cast(requestpos_points as varchar),'')
		AS varchar(285)
	) AS fulltext
FROM requestpos;

