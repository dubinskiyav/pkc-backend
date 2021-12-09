CREATE TABLE application(
	application_id INTEGER NOT NULL,
	application_type INTEGER NOT NULL,
	application_code VARCHAR(50),
	application_name VARCHAR(50) NOT NULL,
	application_exe VARCHAR(255) NOT NULL,
	application_blob bytea,
	application_desc VARCHAR(255),
    PRIMARY KEY (application_id)
);
CREATE SEQUENCE application_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE application_id_gen OWNED BY application.application_id;
--ALTER TABLE application ADD UNIQUE (application_exe);
ALTER TABLE application ADD UNIQUE (application_name);

CREATE TABLE applicationrole (
    applicationrole_id INTEGER NOT NULL,
    accessrole_id INTEGER NOT NULL,
    application_id INTEGER NOT NULL,
    CONSTRAINT applicationrole_ak1 UNIQUE (accessrole_id, application_id),
    CONSTRAINT applicationrole_pk PRIMARY KEY (applicationrole_id),
    CONSTRAINT applicationrole_fk1 FOREIGN KEY (accessrole_id) REFERENCES accessrole(accessrole_id),
    CONSTRAINT applicationrole_fk2 FOREIGN KEY (application_id) REFERENCES application(application_id)
);
CREATE INDEX applicationrole_if1 ON applicationrole USING btree (accessrole_id);
CREATE INDEX applicationrole_if2 ON applicationrole USING btree (application_id);

CREATE SEQUENCE applicationrole_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE applicationrole_id_gen OWNED BY applicationrole.applicationrole_id;


CREATE VIEW ft_application
AS
SELECT
	application_id,
	CAST(
		coalesce(application_code,'')||' '||trim(application_name)||' '||trim(application_exe)||' '||coalesce(application_desc,'')
		AS varchar(630)
	) AS fulltext
FROM application;

