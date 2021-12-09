CREATE TABLE clustergood (
    clustergood_id INTEGER NOT NULL,
    CONSTRAINT clustergood_pk PRIMARY KEY (clustergood_id)
);
CREATE SEQUENCE clustergood_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE clustergood_id_gen OWNED BY clustergood.clustergood_id;

CREATE TABLE sgood(
	sgood_id INTEGER NOT NULL,
	sgoodtype_id INTEGER NOT NULL,
	clustergood_id INTEGER NOT NULL,
	sgood_code VARCHAR(50) NOT NULL,
	sgood_name VARCHAR(255) NOT NULL,
	sgood_name1 VARCHAR(255),
	sgood_datebeg DATE NOT NULL,
	sgood_dateend DATE NOT NULL,
	sgood_gost VARCHAR(255),
	sgood_description VARCHAR(2000),
	parent_id INTEGER NOT NULL,
    PRIMARY KEY (sgood_id)
);
CREATE SEQUENCE sgood_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE sgood_id_gen OWNED BY sgood.sgood_id;
ALTER TABLE sgood ADD UNIQUE (sgood_code);


CREATE TABLE subclustergood (
    sgood_id INTEGER NOT NULL,
    clustergood_id INTEGER NOT NULL,
    CONSTRAINT subclustergood_ak1 UNIQUE (clustergood_id),
    CONSTRAINT subclustergood_pk PRIMARY KEY (sgood_id),
    CONSTRAINT subclustergood_fk1 FOREIGN KEY (clustergood_id) REFERENCES clustergood(clustergood_id),
    CONSTRAINT subclustergood_fk2 FOREIGN KEY (sgood_id) REFERENCES sgood(sgood_id)
);

INSERT INTO clustergood VALUES (-1);
INSERT INTO sgood VALUES (-1,1,-1,'','Корневой уровень',NULL,'1900-01-01','2099-12-31',NULL,NULL,-1);
INSERT INTO subclustergood VALUES (-1,-1);


CREATE VIEW ft_sgood
AS
SELECT
	sgood_id,
	CAST(
		trim(sgood_code)||' '||trim(sgood_name)||' '||coalesce(sgood_name1,'')||' '||coalesce(sgood_gost,'')||' '||coalesce(sgood_description,'')
		AS varchar(2851)
	) AS fulltext
FROM sgood;

CREATE TABLE sgoodattributevalue(
    sgoodattributevalue_id    INTEGER  NOT NULL,
    sgood_id                  INTEGER  NOT NULL,
    attribute_id              INTEGER  NOT NULL,
    sgoodattributevalue_value varchar(255) NULL,
    CONSTRAINT sgoodattributevalue_ak1 UNIQUE (attribute_id, sgood_id),
    CONSTRAINT sgoodattributevalue_pk PRIMARY KEY (sgoodattributevalue_id),
    CONSTRAINT sgoodattributevalue_fk1 FOREIGN KEY (sgood_id) REFERENCES sgood(sgood_id),
    CONSTRAINT sgoodattributevalue_fk2 FOREIGN KEY (attribute_id) REFERENCES attribute(attribute_id)
);

CREATE TABLE sgoodedizm (
    sgood_id INTEGER NOT NULL,
    edizm_id INTEGER NOT NULL,
    CONSTRAINT SGOODEDIZM_PK PRIMARY KEY (SGOOD_ID),
    CONSTRAINT SGOODEDIZM_FK1 FOREIGN KEY (SGOOD_ID) REFERENCES SGOOD(SGOOD_ID),
    CONSTRAINT SGOODEDIZM_FK2 FOREIGN KEY (EDIZM_ID) REFERENCES EDIZM(EDIZM_ID)
);

create table sgoodparam (
    sgood_id integer not null,
    edizmweight_id integer,
    edizmvolume_id integer,
    sgoodparam_weight double precision,
    sgoodparam_volume double precision,
    sgoodparam_grossweight double precision,
    constraint sgoodparam_pk primary key (sgood_id),
    constraint sgoodparam_fk1 foreign key (sgood_id) references sgood(sgood_id),
    constraint sgoodparam_fk2 foreign key (edizmweight_id) references edizm(edizm_id),
    constraint sgoodparam_fk3 foreign key (edizmvolume_id) references edizm(edizm_id)
);

create table packagegood (
    packagegood_id integer not null,
    package_id integer not null,
    good_id integer,
    packagegood_type integer not null,
    packagegood_quantity double precision not null,
    packagegood_layer integer not null,
    packagegood_flagmain integer not null,
    sgood_id integer not null,
    packagegood_weight double precision,
    packagegood_grossweight double precision,
    packagegood_volume double precision,
    edizmweight_id integer,
    edizmgrossweight_id integer,
    edizmvolume_id integer,
    constraint packagegood_ak2 unique (sgood_id,package_id,packagegood_type),
    constraint packagegood_pk primary key (packagegood_id),
    constraint packagegood_fk3 foreign key (sgood_id) references sgood(sgood_id)
);

CREATE TABLE GOOD (
    GOOD_ID INTEGER NOT NULL,
    GOOD_NAME VARCHAR(255) NOT NULL,
    GOOD_NAME1 VARCHAR(100),
    GOOD_CODEINTERNAL VARCHAR(50),
    GOOD_CODEOKPD VARCHAR(20),
    GOOD_WEIGHTNETTO DOUBLE PRECISION NOT NULL,
    GOOD_WEIGHTBRUTTO DOUBLE PRECISION NOT NULL,
    GOOD_COEFFIN DOUBLE PRECISION NOT NULL,
    GOOD_COEFFOUT DOUBLE PRECISION NOT NULL,
    GOOD_FASFLAG INTEGER NOT NULL,
    GOOD_FULLNAME VARCHAR(400),
    CONSTRAINT GOOD_PK PRIMARY KEY (GOOD_ID)
);

CREATE TABLE SGOODGOOD (
    SGOOD_ID INTEGER NOT NULL,
    GOOD_ID INTEGER NOT NULL,
    CONSTRAINT SGOODGOOD_AK1 UNIQUE (GOOD_ID),
    CONSTRAINT SGOODGOOD_PK PRIMARY KEY (SGOOD_ID),
    CONSTRAINT SGOODGOOD_FK1 FOREIGN KEY (SGOOD_ID) REFERENCES SGOOD(SGOOD_ID),
    CONSTRAINT SGOODGOOD_FK2 FOREIGN KEY (GOOD_ID) REFERENCES GOOD(GOOD_ID)
);