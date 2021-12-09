CREATE TABLE requestacceptpos(
	requestacceptpos_id INTEGER NOT NULL,
	requestaccept_id INTEGER NOT NULL,
	requestagreepos_id INTEGER NOT NULL,
	requestacceptpos_count NUMERIC(16,2),
	requestacceptpos_note VARCHAR(255),
    CONSTRAINT requestacceptpos_pk PRIMARY KEY (requestacceptpos_id)
);
CREATE SEQUENCE requestacceptpos_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE requestacceptpos_id_gen OWNED BY requestacceptpos.requestacceptpos_id;
ALTER TABLE requestacceptpos ADD UNIQUE (requestaccept_id,requestagreepos_id);

