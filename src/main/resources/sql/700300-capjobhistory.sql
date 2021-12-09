CREATE TABLE capjobhistory(
	capjobhistory_id INTEGER NOT NULL,
	capjob_id INTEGER,
	capjobstate_id INTEGER NOT NULL,
	capjobhistory_datebeg TIMESTAMP NOT NULL,
	capjobhistory_dateend TIMESTAMP,
	capjobhistory_errmsg VARCHAR(2000),
	capjob_name VARCHAR(255),
	capresource_id INTEGER,
    CONSTRAINT capjobhistory_pk PRIMARY KEY (capjobhistory_id)
);
CREATE SEQUENCE capjobhistory_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capjobhistory_id_gen OWNED BY capjobhistory.capjobhistory_id;

CREATE VIEW ft_capjobhistory
AS
SELECT
	capjobhistory_id,
	CAST(
		trim(to_char(capjobhistory_datebeg, 'DD.MM.YYYY'))||' '||coalesce(to_char(capjobhistory_dateend, 'DD.MM.YYYY'),'')||' '||coalesce(capjobhistory_errmsg,'')||' '||coalesce(capjob_name,'')
		AS varchar(2323)
	) AS fulltext
FROM capjobhistory;

