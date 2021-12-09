CREATE TABLE company(
    company_id integer not null,
    town_id integer,  /* not null верменно убрали */
    company_notation varchar(255) not null,
    company_name varchar(310) not null,
    company_address varchar(255),
    company_telefon varchar(50),
    company_inn varchar(20),
    company_note varchar(255),
    company_name1 varchar(50),
    company_flagclient integer not null,
    company_fullname varchar(400),
    company_flagnotresident integer,
    constraint company_ak1 unique (company_notation),
    constraint company_pk primary key (company_id),
    constraint company_fk2 foreign key (company_id) references subject(subject_id)
);
CREATE SEQUENCE company_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE company_id_gen OWNED BY company.company_id;

CREATE TABLE mycompany (
                           company_id int4 NOT NULL,
                           CONSTRAINT mycompany_pk PRIMARY KEY (company_id),
                           CONSTRAINT mycompany_fk1 FOREIGN KEY (company_id) REFERENCES company(company_id)
);

CREATE TABLE companybranch (
                               company_id int4 NOT NULL,
                               companymain_id int4 NOT NULL,
                               CONSTRAINT companybranch_pk PRIMARY KEY (company_id),
                               CONSTRAINT companybranch_fk1 FOREIGN KEY (company_id) REFERENCES company(company_id),
                               CONSTRAINT companybranch_fk2 FOREIGN KEY (companymain_id) REFERENCES company(company_id)
);

CREATE VIEW ft_company
AS
SELECT
    company_id,
    CAST(
        trim(company_name)||' '||trim(company_fullname)||' '||trim(company_address)||' '||coalesce(company_telefon,'')||' '||coalesce(company_note,'')
        AS varchar(1971)
        ) AS fulltext
FROM company;