CREATE TABLE streettype (
    streetstype_id int4 NOT NULL,
    streetstype_name varchar(50) NOT NULL,
    streetstype_code varchar(10) NOT NULL,
    CONSTRAINT streetstype_ak1 UNIQUE (streetstype_name),
    CONSTRAINT streetstype_ak2 UNIQUE (streetstype_code),
    CONSTRAINT streettype_pk PRIMARY KEY (streetstype_id)
);


CREATE TABLE street(
	streets_id INTEGER NOT NULL,
	town_id INTEGER NOT NULL,
	streetstype_id INTEGER NOT NULL,
	streets_name VARCHAR(50) NOT NULL,
	streets_code VARCHAR(20) NOT NULL,
    STREETS_INDEX VARCHAR(10),
	street_aoid VARCHAR(36),
	street_aoguid VARCHAR(36),
	street_upddate TIMESTAMP NOT NULL,
    CONSTRAINT street_pk PRIMARY KEY (streets_id)
);
CREATE SEQUENCE street_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE street_id_gen OWNED BY street.streets_id;
ALTER TABLE street ADD UNIQUE (streets_code);

CREATE VIEW ft_street
AS
SELECT
	streets_id,
	CAST(
		trim(streets_name)||' '||trim(streets_code)
		AS varchar(239)
	) AS fulltext
FROM street;

INSERT INTO streettype (streetstype_id,streetstype_name,streetstype_code) VALUES
(-1,'',''),
(1,'УЛИЦА','УЛ'),
(2,'ПЕРЕУЛОК','ПЕР'),
(3,'ПРОСПЕКТ','ПР-КТ');