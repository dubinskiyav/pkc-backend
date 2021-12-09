CREATE TABLE subjecttype(
	subjecttype_id INTEGER NOT NULL,
	subjecttype_name VARCHAR(30) NOT NULL,
	subjecttype_sortcode VARCHAR(10),
    PRIMARY KEY (subjecttype_id)
);
CREATE SEQUENCE subjecttype_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE subjecttype_id_gen OWNED BY subjecttype.subjecttype_id;
ALTER TABLE subjecttype ADD UNIQUE (subjecttype_name);

CREATE VIEW ft_subjecttype
AS
SELECT
	subjecttype_id,
	CAST(
		trim(subjecttype_name)||' '||coalesce(subjecttype_sortcode,'')
		AS varchar(50)
	) AS fulltext
FROM subjecttype;

INSERT INTO subjecttype VALUES (1,'Уровень','1');
INSERT INTO subjecttype VALUES (2,'Элемент','2');


