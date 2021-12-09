CREATE TABLE constantvalue(
	constantvalue_id INTEGER NOT NULL,
	constant_id INTEGER NOT NULL,
	constantvalue_datebeg DATE NOT NULL,
	constantvalue_display VARCHAR(255) NOT NULL,
    PRIMARY KEY (constantvalue_id)
);
CREATE SEQUENCE constantvalue_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE constantvalue_id_gen OWNED BY constantvalue.constantvalue_id;
ALTER TABLE constantvalue ADD UNIQUE (constantvalue_datebeg,constant_id);

CREATE TABLE cv_integer (
    constantvalue_id int4 NOT NULL,
    cv_value int4 NOT NULL,
    CONSTRAINT cv_integer_pk PRIMARY KEY (constantvalue_id),
    CONSTRAINT cv_integer_fk1 FOREIGN KEY (constantvalue_id) REFERENCES constantvalue(constantvalue_id) ON DELETE CASCADE
);
CREATE TABLE cv_boolean (
    constantvalue_id int4 NOT NULL,
    cv_value int4 NOT NULL,
    CONSTRAINT cv_boolean_pk PRIMARY KEY (constantvalue_id),
    CONSTRAINT cv_boolean_fk1 FOREIGN KEY (constantvalue_id) REFERENCES constantvalue(constantvalue_id) ON DELETE CASCADE
);
CREATE TABLE cv_date (
    constantvalue_id int4 NOT NULL,
    cv_value date NOT NULL,
    CONSTRAINT cv_date_pk PRIMARY KEY (constantvalue_id),
    CONSTRAINT cv_date_fk1 FOREIGN KEY (constantvalue_id) REFERENCES constantvalue(constantvalue_id) ON DELETE CASCADE
);
CREATE TABLE cv_float (
    constantvalue_id int4 NOT NULL,
    cv_value float8 NOT NULL,
    CONSTRAINT cv_float_pk PRIMARY KEY (constantvalue_id),
    CONSTRAINT cv_float_fk1 FOREIGN KEY (constantvalue_id) REFERENCES constantvalue(constantvalue_id) ON DELETE CASCADE
);
CREATE TABLE cv_money (
    constantvalue_id int4 NOT NULL,
    cv_value numeric(16,2) NOT NULL,
    CONSTRAINT cv_money_pk PRIMARY KEY (constantvalue_id),
    CONSTRAINT cv_money_fk1 FOREIGN KEY (constantvalue_id) REFERENCES constantvalue(constantvalue_id) ON DELETE CASCADE
);
CREATE TABLE cv_string (
    constantvalue_id int4 NOT NULL,
    cv_value varchar(255) NOT NULL,
    CONSTRAINT cv_string_pk PRIMARY KEY (constantvalue_id),
    CONSTRAINT cv_string_fk1 FOREIGN KEY (constantvalue_id) REFERENCES constantvalue(constantvalue_id) ON DELETE CASCADE
);

CREATE VIEW ft_constantvalue
AS
SELECT
	constantvalue_id,
	CAST(
		trim(to_char(constantvalue_datebeg, 'DD.MM.YYYY'))||' '||trim(constantvalue_display)
		AS varchar(278)
	) AS fulltext
FROM constantvalue;

