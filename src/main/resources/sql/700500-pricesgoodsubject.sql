CREATE TABLE pricesgoodsubject(
	pricesgoodsubject_id INTEGER NOT NULL,
	pricecluster_id INTEGER NOT NULL,
	sgood_id INTEGER NOT NULL,
	subject_id INTEGER NOT NULL,
	pricesgoodsubject_value DOUBLE PRECISION NOT NULL,
	pricesgoodsubject_date TIMESTAMP NOT NULL,
    CONSTRAINT pricesgoodsubject_pk PRIMARY KEY (pricesgoodsubject_id)
);

CREATE SEQUENCE pricesgoodsubject_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE pricesgoodsubject_id_gen OWNED BY pricesgoodsubject.pricesgoodsubject_id;
ALTER TABLE pricesgoodsubject ADD UNIQUE (pricecluster_id,sgood_id,subject_id,pricesgoodsubject_date);
