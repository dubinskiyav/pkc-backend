CREATE TABLE country(
	country_id INTEGER NOT NULL,
	country_name VARCHAR(100) NOT NULL,
	country_code VARCHAR(5),
    CONSTRAINT country_pk PRIMARY KEY (country_id)
);
CREATE SEQUENCE country_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE country_id_gen OWNED BY country.country_id;

CREATE VIEW ft_country
AS
SELECT
	country_id,
	CAST(
		trim(country_name)||' '||coalesce(country_code,'')
		AS varchar(115)
	) AS fulltext
FROM country;

