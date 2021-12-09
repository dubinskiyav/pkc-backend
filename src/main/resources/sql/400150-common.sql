CREATE TABLE capcodetype
(
    capcodetype_id integer NOT NULL,
    capcodetype_code varchar(10) NOT NULL,
    capcodetype_name varchar(50) NOT NULL,
    capcodetype_text bytea,
    CONSTRAINT capcodetype_pk PRIMARY KEY (capcodetype_id),
    CONSTRAINT capcodetype_ak1 UNIQUE (capcodetype_name),
    CONSTRAINT capcodetype_ak2 UNIQUE (capcodetype_code)
);
INSERT INTO capcodetype VALUES (13,'013','Тип статуса пользователя');
INSERT INTO capcodetype VALUES (2148,'2148','Типы аутентификации');
INSERT INTO capcodetype (capcodetype_id,capcodetype_code,capcodetype_name,capcodetype_text) VALUES
	 (4,'004','Тип данных атрибута',NULL);

CREATE TABLE capclasstype (
	capclasstype_id int4 NOT NULL,
	capresource_id int4 NOT NULL,
	capclasstype_code varchar(10) NULL,
	capclasstype_name varchar(128) NOT NULL,
	CONSTRAINT capclasstype_ak1 UNIQUE (capclasstype_name),
	CONSTRAINT capclasstype_ak2 UNIQUE (capresource_id),
	CONSTRAINT capclasstype_pk PRIMARY KEY (capclasstype_id)
);

INSERT INTO capclasstype (capclasstype_id,capresource_id,capclasstype_code,capclasstype_name) VALUES
	 (21,211,'21','Группы констант');
INSERT INTO capclasstype (capclasstype_id,capresource_id,capclasstype_code,capclasstype_name) VALUES
	 (20,39,'20','Группы признаков');

CREATE TABLE capclass (
	capclass_id int4 NOT NULL,
	capclasstype_id int4 NOT NULL,
	capclass_code varchar(20) NOT NULL,
	capclass_name varchar(255) NOT NULL,
	capclass_value float8 NULL,
	capclass_sortcode varchar(10) NULL,
	capclass_text bytea NULL,
	capclass_flag int4 NULL,
	capclass_blockflag int4 NOT NULL,
	capclass_remark varchar(255) NULL,
	CONSTRAINT capclass_ak1 UNIQUE (capclasstype_id, capclass_code),
	CONSTRAINT capclass_pk PRIMARY KEY (capclass_id),
	CONSTRAINT capclass_fk1 FOREIGN KEY (capclasstype_id) REFERENCES capclasstype(capclasstype_id)
);

CREATE SEQUENCE capclass_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE capclass_id_gen OWNED BY capclass.capclass_id;

INSERT INTO capclass (capclass_id,capclasstype_id,capclass_code,capclass_name,capclass_value,capclass_sortcode,capclass_text,capclass_flag,capclass_blockflag,capclass_remark) VALUES
	 (211,21,'01','Группа констант для заявок',NULL,NULL,NULL,NULL,0,NULL),
	 (1268,21,'04','Группа НДС',NULL,NULL,NULL,NULL,0,NULL),
	 (1897,21,'НАЛОГ','Налоги',0.0,'',NULL,NULL,0,NULL);

INSERT INTO capclass (capclass_id,capclasstype_id,capclass_code,capclass_name,capclass_value,capclass_sortcode,capclass_text,capclass_flag,capclass_blockflag,capclass_remark) VALUES
	 (57,20,'01','Сотрудники',NULL,NULL,NULL,NULL,0,NULL);

CREATE VIEW ft_capclass
AS
SELECT
	capclass_id,
	CAST(
		trim(capclass_code)||' '||trim(capclass_name)||' '||coalesce(capclass_sortcode,'')||coalesce(capclass_remark,'')
		AS varchar(570)
	) AS fulltext
FROM capclass;



CREATE TABLE capcode
(
    capcode_id integer NOT NULL,
    capcodetype_id integer NOT NULL,
    capcode_code varchar(10) NOT NULL,
    capcode_name varchar(50) NOT NULL,
    capcode_sortcode varchar(10),
    capcode_text bytea,
    CONSTRAINT capcode_pk PRIMARY KEY (capcode_id),
    CONSTRAINT capcode_ak1 UNIQUE (capcodetype_id, capcode_name),
    CONSTRAINT capcode_ak2 UNIQUE (capcodetype_id, capcode_code),
    CONSTRAINT capcode_fk1 FOREIGN KEY (capcodetype_id)
        REFERENCES capcodetype (capcodetype_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);

INSERT INTO capcode VALUES (1301, 13,'1301','Активный','001');
INSERT INTO capcode VALUES (1302, 13,'1302','Неактивный','002');
INSERT INTO capcode VALUES (21481, 2148,'1302','Аутентификация по паролю','01');
INSERT INTO capcode (capcode_id,capcodetype_id,capcode_code,capcode_name,capcode_sortcode,capcode_text) VALUES
	 (404,4,'404','Строка','004',NULL);

CREATE TABLE sqlaction (
	sqlaction_id int4 NOT NULL,
	sqlaction_sql varchar(10) NOT NULL,
	sqlaction_note varchar(20) NULL,
	CONSTRAINT sqlaction_ak1 UNIQUE (sqlaction_sql),
	CONSTRAINT sqlaction_pk PRIMARY KEY (sqlaction_id)
);

INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (1,'SELECT','Просмотр');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (2,'INSERT','Добавление');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (3,'UPDATE','Изменение');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (4,'DELETE','Удаление');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (5,'SEARCH','Поиск');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (6,'DEBUG','Отладка');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (7,'ABORT','Прерывание');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (8,'CHOWNER','Смена владельца');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (9,'EXECUTE','Выполнение');
INSERT INTO sqlaction (sqlaction_id,sqlaction_sql,sqlaction_note) VALUES (10,'ADMIN','Администрирование');

CREATE TABLE resourcetype (
	resourcetype_id int4 NOT NULL,
	resourcetype_code varchar(10) NULL,
	resourcetype_name varchar(50) NOT NULL,
	CONSTRAINT resourcetype_ak1 UNIQUE (resourcetype_name),
	CONSTRAINT resourcetype_pk PRIMARY KEY (resourcetype_id)
);

INSERT INTO resourcetype (resourcetype_id, resourcetype_code, resourcetype_name) VALUES (1,	'01','Печатные формы');
INSERT INTO resourcetype (resourcetype_id, resourcetype_code, resourcetype_name) VALUES (11, '11','Нумератор');
INSERT INTO resourcetype (resourcetype_id, resourcetype_code, resourcetype_name) VALUES (12, '12','Признак');
INSERT INTO resourcetype (resourcetype_id, resourcetype_code, resourcetype_name) VALUES (13, '13','Константа');
