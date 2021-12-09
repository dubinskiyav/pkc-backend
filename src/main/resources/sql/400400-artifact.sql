CREATE TABLE capresource (

     capresource_id int4 NOT NULL,
     resourcetrantype_id int4 NOT NULL,
     resourcetype_id int4 NOT NULL,
     capconfig_id int4 NOT NULL,
     proguser_id int4 NOT NULL,
     lastproguser_id int4 NULL,
     capresource_code varchar(15) NULL,
     capresource_name varchar(128) NOT NULL,
     capresource_active int4 NOT NULL DEFAULT 1,
     capresource_autor varchar(50) NULL,
     capresource_date date NULL DEFAULT CURRENT_DATE,
     capresource_remark bytea NULL,
     capresource_lastmodify timestamp NULL DEFAULT CURRENT_DATE,

    CONSTRAINT capresource_pk PRIMARY KEY (capresource_id),
    CONSTRAINT capresource_fk4 FOREIGN KEY (proguser_id) REFERENCES proguser(proguser_id),
    CONSTRAINT capresource_fk5 FOREIGN KEY (lastproguser_id) REFERENCES proguser(proguser_id)
);

CREATE SEQUENCE capresource_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capresource_id_gen OWNED BY capresource.capresource_id;

CREATE TABLE capresourcerole (
    capresourcerole_id int4 NOT NULL,
    accessrole_id int4 NOT NULL,
    capresource_id int4 NOT NULL,
    capresourcerole_restrictflag int4 NOT NULL,
    CONSTRAINT capresourcerole_ak1 UNIQUE (accessrole_id, capresource_id),
    CONSTRAINT capresourcerole_pk PRIMARY KEY (capresourcerole_id),
    CONSTRAINT capresourcerole_fk1 FOREIGN KEY (accessrole_id) REFERENCES accessrole(accessrole_id),
    CONSTRAINT capresourcerole_fk2 FOREIGN KEY (capresource_id) REFERENCES capresource(capresource_id)
);
CREATE INDEX capresourcerole_if1 ON capresourcerole USING btree (accessrole_id);
CREATE INDEX capresourcerole_if2 ON capresourcerole USING btree (capresource_id);

CREATE SEQUENCE capresourcerole_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capresourcerole_id_gen OWNED BY capresourcerole.capresourcerole_id;

CREATE TABLE capresourceapp (
    capresourceapp_id int4 NOT NULL,
    application_id int4 NOT NULL,
    capresource_id int4 NOT NULL,
    CONSTRAINT capresourceapp_ak1 UNIQUE (capresource_id, application_id),
    CONSTRAINT capresourceapp_pk PRIMARY KEY (capresourceapp_id),
    CONSTRAINT capresourceapp_fk1 FOREIGN KEY (capresource_id) REFERENCES capresource(capresource_id),
    CONSTRAINT capresourceapp_fk2 FOREIGN KEY (application_id) REFERENCES application(application_id)
);

CREATE SEQUENCE capresourceapp_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capresourceapp_id_gen OWNED BY capresourceapp.capresourceapp_id;

CREATE TABLE capresourcenumberdoc (
    capresourcenumberdoc_id int4 NOT NULL,
    capresource_id int4 NOT NULL,
    document_id int4 NOT NULL,
    CONSTRAINT capresourcenumberdoc_ak1 UNIQUE (document_id, capresource_id),
    CONSTRAINT capresourcenumberdoc_pk PRIMARY KEY (capresourcenumberdoc_id),
    CONSTRAINT capresourcenumberdoc_fk1 FOREIGN KEY (document_id) REFERENCES document(document_id),
    CONSTRAINT capresourcenumberdoc_fk2 FOREIGN KEY (capresource_id) REFERENCES capresource(capresource_id)
);

CREATE SEQUENCE capresourcenumberdoc_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capresourcenumberdoc_id_gen OWNED BY capresourcenumberdoc.capresourcenumberdoc_id;

CREATE VIEW ft_capresource
AS
SELECT
    capresource_id,
	CAST(
		trim(capresource_code)||' '||trim(capresource_name)
		AS varchar(315)
	) AS fulltext
FROM capresource;

CREATE VIEW ft_capresourceaccess
AS
SELECT
    capresource_id,
    CAST(
        trim(capresource_code)||' '||trim(capresource_name)
        AS varchar(315)
        ) AS fulltext
FROM capresource;
