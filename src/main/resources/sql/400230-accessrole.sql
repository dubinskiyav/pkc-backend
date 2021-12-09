CREATE TABLE accessrole(
	accessrole_id INTEGER NOT NULL,
	accessrole_name VARCHAR(30) NOT NULL,
	accessrole_note VARCHAR(255),
	accessrole_visible INTEGER NOT NULL,
    PRIMARY KEY (accessrole_id)
);
CREATE SEQUENCE accessrole_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE accessrole_id_gen OWNED BY accessrole.accessrole_id;

CREATE TABLE proguserrole (
    proguserrole_id INTEGER NOT NULL,
    proguser_id INTEGER NOT NULL,
    accessrole_id INTEGER NOT NULL,
    CONSTRAINT proguserrole_ak1 UNIQUE (proguser_id, accessrole_id),
    CONSTRAINT proguserrole_pk PRIMARY KEY (proguserrole_id),
    CONSTRAINT proguserrole_fk1 FOREIGN KEY (proguser_id) REFERENCES proguser(proguser_id),
    CONSTRAINT proguserrole_fk2 FOREIGN KEY (accessrole_id) REFERENCES accessrole(accessrole_id)
);
CREATE SEQUENCE proguserrole_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE proguserrole_id_gen OWNED BY proguserrole.proguserrole_id;

CREATE INDEX proguserrole_if1 ON proguserrole USING btree (proguser_id);
CREATE INDEX proguserrole_if2 ON proguserrole USING btree (accessrole_id);

CREATE TABLE controlobjectrole (
    controlobjectrole_id int4 NOT NULL,
    controlobject_id int4 NOT NULL,
    accessrole_id int4 NOT NULL,
    sqlaction_id int4 NOT NULL,
    CONSTRAINT controlobjectrole_ak1 UNIQUE (controlobject_id, accessrole_id, sqlaction_id),
    CONSTRAINT controlobjectrole_pk PRIMARY KEY (controlobjectrole_id),
    CONSTRAINT controlobjectrole_fk1 FOREIGN KEY (controlobject_id) REFERENCES controlobject(controlobject_id),
    CONSTRAINT controlobjectrole_fk2 FOREIGN KEY (accessrole_id) REFERENCES accessrole(accessrole_id),
    CONSTRAINT controlobjectrole_fk3 FOREIGN KEY (sqlaction_id) REFERENCES sqlaction(sqlaction_id)
);
CREATE INDEX controlobjectrole_if1 ON controlobjectrole USING btree (controlobject_id);
CREATE INDEX controlobjectrole_if2 ON controlobjectrole USING btree (accessrole_id);

CREATE SEQUENCE controlobjectrole_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE controlobjectrole_id_gen OWNED BY controlobjectrole.controlobjectrole_id;


CREATE VIEW ft_accessrole
AS
SELECT
	accessrole_id,
	CAST(
		trim(accessrole_name)||' '||coalesce(accessrole_note,'')
		AS varchar(305)
	) AS fulltext
FROM accessrole;

