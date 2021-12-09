CREATE TABLE capjob(
	capjob_id INTEGER NOT NULL,
	capresource_id INTEGER NOT NULL,
	capjobtype_id INTEGER NOT NULL,
	capjob_name VARCHAR(255) NOT NULL,
	capjob_flagactive INTEGER NOT NULL,
	capjob_failiterationcount INTEGER NOT NULL,
	capjob_failiterationinterval INTEGER,
	capjob_remark VARCHAR(512),
	period_id INTEGER NOT NULL,
	capjob_interval INTEGER NOT NULL,
	capjob_datebeg TIMESTAMP NOT NULL,
	capjob_dateend TIMESTAMP,
	capjob_iterationcount INTEGER,
	capjob_days VARCHAR(128),
	daycal_id INTEGER,
	capjob_weeknumber INTEGER,
	dayofweek_id INTEGER,
	monthcal_id INTEGER,
    CONSTRAINT capjob_pk PRIMARY KEY (capjob_id)
);
CREATE SEQUENCE capjob_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capjob_id_gen OWNED BY capjob.capjob_id;
ALTER TABLE capjob ADD UNIQUE (capjob_name);

CREATE VIEW ft_capjob
AS
SELECT
	capjob_id,
	CAST(
		trim(capjob_name)||' '||trim(cast(capjob_flagactive as varchar))||' '||trim(cast(capjob_failiterationcount as varchar))||' '||coalesce(cast(capjob_failiterationinterval as varchar),'')||' '||coalesce(capjob_remark,'')||' '||trim(cast(capjob_interval as varchar))||' '||trim(to_char(capjob_datebeg, 'DD.MM.YYYY'))||' '||coalesce(to_char(capjob_dateend, 'DD.MM.YYYY'),'')||' '||coalesce(cast(capjob_iterationcount as varchar),'')||' '||coalesce(capjob_days,'')||' '||coalesce(cast(capjob_weeknumber as varchar),'')
		AS varchar(1023)
	) AS fulltext
FROM capjob;

