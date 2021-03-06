CREATE TABLE address(
    addresss_id INTEGER NOT NULL,
    streets_id INTEGER NOT NULL,
    addresss_building VARCHAR(10) NOT NULL,
    addresss_korpus VARCHAR(10),
    ADDRESSS_INDEX VARCHAR(6),
    ADDRESSS_CODE VARCHAR(19),
    BUILDINGTYPE_ID INTEGER,
    KORPUSTYPE_ID INTEGER,
    FLATTYPE_ID INTEGER,
    address_aoid VARCHAR(36),
    address_aoguid VARCHAR(36),
    address_upddate TIMESTAMP NOT NULL,
    addresss_flat VARCHAR(10),
    CONSTRAINT address_pk PRIMARY KEY (addresss_id)
);
CREATE SEQUENCE address_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE address_id_gen OWNED BY address.addresss_id;
ALTER TABLE address ADD UNIQUE (streets_id,addresss_building,addresss_korpus);

CREATE TABLE SUBJECTADDRESSS (
     SUBJECT_ID INTEGER NOT NULL,
     ADDRESSS_ID INTEGER,
     FACTADDRESSS_ID INTEGER,
     CONSTRAINT SUBJECTADDRESSS_PK PRIMARY KEY (SUBJECT_ID),
     CONSTRAINT SUBJECTADDRESSS_FK1 FOREIGN KEY (SUBJECT_ID) REFERENCES SUBJECT(SUBJECT_ID),
     CONSTRAINT SUBJECTADDRESSS_FK2 FOREIGN KEY (ADDRESSS_ID) REFERENCES ADDRESS(ADDRESSS_ID),
     CONSTRAINT SUBJECTADDRESSS_FK3 FOREIGN KEY (FACTADDRESSS_ID) REFERENCES ADDRESS(ADDRESSS_ID)
);


CREATE TABLE ADDRESSINDEX (
    ADDRESSS_ID INTEGER NOT NULL,
    ADDRESSINDEX_TEXT VARCHAR(255) NOT NULL,
    ADDRESS_FIELD1 VARCHAR(30),
    ADDRESS_FIELD2 VARCHAR(30),
    ADDRESS_FIELD3 VARCHAR(30),
    ADDRESS_FIELD4 VARCHAR(30),
    ADDRESS_FIELD5 VARCHAR(30),
    ADDRESS_FIELD6 VARCHAR(30),
    ADDRESS_FIELD7 VARCHAR(30),
    ADDRESS_FIELD8 VARCHAR(30),
    ADDRESS_FIELD9 VARCHAR(30),
    ADDRESS_FIELD10 VARCHAR(30),
    CONSTRAINT ADDRESSINDEX_PK PRIMARY KEY (ADDRESSS_ID)
);
CREATE INDEX ADDRESSINDEXTEXT ON ADDRESSINDEX (ADDRESSINDEX_TEXT);
/* нужна для тестов */
INSERT INTO ADDRESSINDEX (ADDRESSS_ID,ADDRESSINDEX_TEXT,ADDRESS_FIELD1,ADDRESS_FIELD2,ADDRESS_FIELD3,ADDRESS_FIELD4,ADDRESS_FIELD5,ADDRESS_FIELD6,ADDRESS_FIELD7)
VALUES (1,'РОССИЯ ПЕРМСКИЙ КРАЙ, Г.ПЕРМЬ УЛ.ЛЕНИНА 55 КВАРТИРА 5','РОССИЯ','ПЕРМСКИЙ','КРАЙ','ПЕРМЬ','ЛЕНИНА','55','5');