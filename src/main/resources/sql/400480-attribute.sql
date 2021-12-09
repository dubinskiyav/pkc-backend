CREATE TABLE attribute(
	attribute_id INTEGER NOT NULL,
	attributegroup_id INTEGER NOT NULL,
	capcode_id INTEGER NOT NULL,
	capclasstype_id INTEGER,
	attribute_historicity INTEGER NOT NULL,
	subject_id INTEGER,
    PRIMARY KEY (attribute_id)
);

