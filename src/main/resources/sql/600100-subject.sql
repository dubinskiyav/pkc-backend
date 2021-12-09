CREATE TABLE clusterr(
    cluster_id INTEGER NOT NULL,
    PRIMARY KEY (cluster_id)
);
CREATE SEQUENCE clusterr_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE clusterr_id_gen OWNED BY clusterr.cluster_id;

CREATE TABLE subject(
	subject_id INTEGER NOT NULL,
	cluster_id INTEGER NOT NULL,
	subjecttype_id INTEGER NOT NULL,
	subject_name VARCHAR(255) NOT NULL,
	subject_datebeg TIMESTAMP NOT NULL,
	subject_dateend TIMESTAMP NOT NULL,
	subject_code VARCHAR(30) NOT NULL,
	subject_description VARCHAR(2000),
	subject_status INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	subject_datecreate TIMESTAMP NOT NULL,
	lastproguser_id INTEGER NOT NULL,
	subject_datemodify TIMESTAMP NOT NULL,
	subject_remark VARCHAR(255),
	rootsubject_id INTEGER NOT NULL,
    parent_id INTEGER NOT NULL,
    PRIMARY KEY (subject_id),
    CONSTRAINT subject_fk1 FOREIGN KEY (cluster_id)
        REFERENCES clusterr (cluster_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT subject_fk2 FOREIGN KEY (subjecttype_id)
        REFERENCES subjecttype (subjecttype_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT subject_fk5 FOREIGN KEY (rootsubject_id)
        REFERENCES subject (subject_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT subject_fk6 FOREIGN KEY (parent_id)
        REFERENCES subject (subject_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
CREATE SEQUENCE subject_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE subject_id_gen OWNED BY subject.subject_id;

CREATE VIEW ft_subject
AS
SELECT
	subject_id,
	CAST(
		trim(subject_name)||' '||trim(to_char(subject_datebeg, 'DD.MM.YYYY'))||' '||trim(to_char(subject_dateend, 'DD.MM.YYYY'))||' '||trim(subject_code)||' '||coalesce(subject_description,'')||' '||trim(to_char(subject_datecreate, 'DD.MM.YYYY'))||' '||trim(to_char(subject_datemodify, 'DD.MM.YYYY'))||' '||coalesce(subject_remark,'')
		AS varchar(2726)
	) AS fulltext
FROM subject;

CREATE TABLE subcluster
(
    subject_id integer NOT NULL,
    cluster_id integer NOT NULL,
    CONSTRAINT subcluster_pk PRIMARY KEY (subject_id),
    CONSTRAINT subcluster_ak1 UNIQUE (cluster_id),
    CONSTRAINT subcluster_fk1 FOREIGN KEY (subject_id)
        REFERENCES subject (subject_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT subcluster_fk2 FOREIGN KEY (cluster_id)
        REFERENCES clusterr (cluster_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);


INSERT INTO clusterr VALUES (-1);
INSERT INTO subject VALUES (-1,-1,1,'Корневой уровень','01.01.1900','01.01.2099','',NULL,0,1,now(),1,now(),null,-1,-1);
INSERT INTO subject VALUES (-2,-1,2,'Не задан','01.01.1900','01.01.2099','',NULL,0,1,now(),1,now(),null,-2,-1);
INSERT INTO subcluster VALUES (-1,-1);

create table progusersubject (
    proguser_id integer not null,
    subject_id integer not null,
    constraint progusersubject_pk primary key (proguser_id),
    constraint progusersubject_fk1 foreign key (proguser_id) references proguser(proguser_id),
    constraint progusersubject_fk2 foreign key (subject_id) references subject(subject_id)
);

CREATE TABLE subjectattributevalue (
    subjectattributevalue_id integer NOT NULL,
    subject_id integer NOT NULL,
    attribute_id integer NOT NULL,
    subjectattributevalue_value varchar(255) NULL,
    subjectattributevalue_float float8 NULL,
    subjectattributevalue_integer integer NULL,
    subjectattributevalue_date date NULL,
    subjectattributevalue_string varchar(255) NULL,
    subjectattributevalue_blob bytea NULL,
    subject_id_value integer NULL,
    capclass_id integer NULL,
    subjectattributevalue_valdate date NULL,
    CONSTRAINT subjectattributevalue_ak1 UNIQUE (attribute_id, subject_id, subjectattributevalue_valdate),
    CONSTRAINT subjectattributevalue_pk PRIMARY KEY (subjectattributevalue_id),
    CONSTRAINT subjectattributevalue_fk1 FOREIGN KEY (subject_id) REFERENCES subject(subject_id),
    CONSTRAINT subjectattributevalue_fk2 FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id),
    CONSTRAINT subjectattributevalue_fk3 FOREIGN KEY (subject_id_value) REFERENCES subject(subject_id),
    CONSTRAINT subjectattributevalue_fk4 FOREIGN KEY (capclass_id) REFERENCES capclass(capclass_id)
);