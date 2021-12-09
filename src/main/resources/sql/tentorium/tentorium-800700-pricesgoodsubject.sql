create table pricecluster (
    pricecluster_id integer not null,
    pricecluster_number integer not null,
    pricecluster_name varchar(20) not null,
    pricecluster_note varchar(50),
    pricecluster_fullname varchar(50) not null,
    pricecluster_minvalue double precision,
    pricecluster_maxvalue double precision,
    constraint pricecluster_ak1 unique (pricecluster_number),
    constraint pricecluster_ak2 unique (pricecluster_name),
    constraint pricecluster_pk primary key (pricecluster_id)
);

INSERT INTO PRICECLUSTER VALUES (6,6,'Розничные цены',NULL,'Оптовые цены',NULL,NULL);
INSERT INTO PRICECLUSTER VALUES (9,9,'Баллы',NULL,'Оптовые цены',NULL,NULL);

create table pricesgoodsubject (
    pricesgoodsubject_id integer not null,
    pricecluster_id integer not null,
    sgood_id integer not null,
    subject_id integer not null,
    pricesgoodsubject_value double precision not null,
    pricesgoodsubject_date timestamp not null,
    tnt_character_id INTEGER,
    tnt_pricesgoodsubject_blockflag INTEGER  NOT NULL DEFAULT 0,
    tnt_customer_flag integer default 0 not null,
    tnt_customer_id integer,
    constraint pricesgoodsubject_ak2 unique (pricecluster_id,sgood_id,subject_id,pricesgoodsubject_date),
    constraint pricesgoodsubject_pk primary key (pricesgoodsubject_id),
    constraint pricesgoodsubject_fk1 foreign key (pricecluster_id) references pricecluster(pricecluster_id)
);

INSERT INTO PRICECLUSTER VALUES (1,1,'Оптовые цены',NULL,'Оптовые цены',NULL,NULL);

INSERT INTO PRICESGOODSUBJECT
    VALUES (1,1,4,1,628.0,'01.01.2020',1);

CREATE SEQUENCE pricesgoodsubject_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE pricesgoodsubject_id_gen OWNED BY pricesgoodsubject.pricesgoodsubject_id;

create table inventorypos (
	inventorypos_id integer not null,
	inventory_id integer not null,
	sgood_id integer not null,
	edizm_id integer not null,
	inventorypos_quantity double precision not null,
	inventorypos_price double precision not null,
	inventorypos_remark varchar(255),
	subbill_id integer,
	subject_id integer,
	inventorypos_datediscard timestamp,
	inventorypos_naklinnumber varchar(10),
	inventorypos_naklindate timestamp,
	inventorypos_sgoodname varchar(255),
	constraint inventorypos_pk primary key (inventorypos_id)
);

create view ft_pricesgoodsubject (pricesgoodsubject_id, fulltext) as
select pss.pricesgoodsubject_id,
       coalesce(trim(sg.sgood_code) ,'') || ' ' ||
       coalesce(trim(sg.sgood_name) ,'') || ' ' ||
       coalesce(trim(s.subject_name) ,'') || ' ' ||
       trim(coalesce(cast(pss.pricesgoodsubject_value as varchar(20)),''))  as fulltext
from   pricesgoodsubject pss
           inner join subject s on s.subject_id  = pss.tnt_character_id
           inner join sgood sg on sg.sgood_id  = pss.sgood_id;

CREATE TABLE inventory (
	INVENTORY_ID INTEGER NOT NULL,
	SUBJECT_ID INTEGER NOT NULL,
	INVENTORY_SUMMA NUMERIC(16,2) NOT NULL,
	CAPCODE_ID INTEGER NOT NULL,
	CONSTRAINT INVENTORY_PK PRIMARY KEY (INVENTORY_ID)
);