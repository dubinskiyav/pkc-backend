CREATE TABLE uniquetype(
	uniquetype_id INTEGER NOT NULL,
	uniquetype_name VARCHAR(20) NOT NULL,
    PRIMARY KEY (uniquetype_id)
);
ALTER TABLE uniquetype ADD UNIQUE (uniquetype_name);

INSERT INTO uniquetype (uniquetype_id,uniquetype_name) VALUES
(1,'Нет уникальности'),
(2,'Сквозная'),
(3,'Год'),
(4,'Квартал'),
(5,'Месяц'),
(6,'День');

CREATE TABLE uniquetypedocument (
    document_id int4 NOT NULL,
    uniquetype_id int4 NOT NULL,
    CONSTRAINT uniquetypedocument_pk PRIMARY KEY (document_id),
    CONSTRAINT uniquetypedocument_fk1 FOREIGN KEY (uniquetype_id) REFERENCES uniquetype(uniquetype_id),
    CONSTRAINT uniquetypedocument_fk2 FOREIGN KEY (document_id) REFERENCES document(document_id)
);
CREATE INDEX uniquetypedocument_if1 ON uniquetypedocument USING btree (uniquetype_id);
CREATE INDEX uniquetypedocument_if2 ON uniquetypedocument USING btree (document_id);

