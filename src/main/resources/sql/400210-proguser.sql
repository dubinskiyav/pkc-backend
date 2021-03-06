CREATE TABLE proguser (
    proguser_id integer NOT NULL,
    progusergroup_id integer NOT NULL,
    proguser_status_id integer NOT NULL,
    proguser_type integer,
    proguser_name varchar(50) NOT NULL,
    proguser_fullname varchar(50),
    proguser_webpassword varchar(128),
    CONSTRAINT proguser_pk PRIMARY KEY (proguser_id),
    CONSTRAINT proguser_ak1 UNIQUE (proguser_name),
    CONSTRAINT proguser_fk1 FOREIGN KEY (progusergroup_id)
        REFERENCES progusergroup (progusergroup_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT proguser_fk2 FOREIGN KEY (proguser_status_id)
        REFERENCES capcode (capcode_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE SEQUENCE proguser_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;

CREATE VIEW ft_proguser
AS
SELECT
    proguser_id,
    CAST(
        trim(proguser_name)||' '||coalesce(proguser_fullname,'')
        AS varchar(268)
        ) AS fulltext
FROM proguser;
