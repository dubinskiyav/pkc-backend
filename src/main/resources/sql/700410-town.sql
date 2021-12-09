CREATE TABLE townsubordinate (
    townsubordinate_id int4 NOT NULL,
    townsubordinate_name varchar(50) NOT NULL,
    CONSTRAINT townsubordinate_ak1 UNIQUE (townsubordinate_name),
    CONSTRAINT townsubordinate_pk PRIMARY KEY (townsubordinate_id)
);

CREATE TABLE towntype (
    towntype_id int4 NOT NULL,
    towntype_name varchar(50) NOT NULL,
    towntype_code varchar(20) NOT NULL,
    CONSTRAINT towntype_ak1 UNIQUE (towntype_name),
    CONSTRAINT towntype_ak2 UNIQUE (towntype_code),
    CONSTRAINT towntype_pk PRIMARY KEY (towntype_id)
);

CREATE TABLE town(
	town_id INTEGER NOT NULL,
	towntype_id INTEGER NOT NULL,
	town_name VARCHAR(50) NOT NULL,
	town_code VARCHAR(20) NOT NULL,
	town_index VARCHAR(10),
	town_aoid VARCHAR(36),
	town_aoguid VARCHAR(36),
	town_upddate TIMESTAMP NOT NULL,
	town_startdate TIMESTAMP,
	town_enddate TIMESTAMP,
	country_id INTEGER NOT NULL,
	townsubordinate_id INTEGER NOT NULL,
	town_phonecode VARCHAR(10),
    CONSTRAINT town_pk PRIMARY KEY (town_id)
);
CREATE SEQUENCE town_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE town_id_gen OWNED BY town.town_id;
ALTER TABLE town ADD UNIQUE (town_code);


INSERT INTO townsubordinate (townsubordinate_id,townsubordinate_name) VALUES
(1,'Без подчиненности'),
(2,'Столица региона'),
(3,'Регионального подчинения'),
(4,'Районный центр'),
(5,'Районного подчинения'),
(6,'Городского подчинения');

INSERT INTO towntype (towntype_id,towntype_name,towntype_code) VALUES
(1,'ГОРОД','Г'),
(2,'СЕЛО','С'),
(3,'ДЕРЕВНЯ','Д'),
(4,'АУЛ','АУЛ'),
(126,'ВОЛОСТЬ','ВОЛОСТЬ'),
(127,'ДАЧНЫЙ ПОСЕЛОК','ДП'),
(128,'КУРОРТНЫЙ ПОСЕЛОК','КП'),
(129,'ПОЧТОВОЕ ОТДЕЛЕНИЕ','П/О'),
(130,'ПОСЕЛОК ГОРОДСКОГО ТИПА','ПГТ'),
(131,'РАБОЧИЙ ПОСЕЛОК','РП');

INSERT INTO towntype (towntype_id,towntype_name,towntype_code) VALUES
(132,'СЕЛЬСКАЯ АДМИНИСТРАЦИЯ','С/А'),
(133,'СЕЛЬСКОЕ МУНИЦИПАЛЬНОЕ ОБРАЗО','С/МО'),
(134,'СЕЛЬСКИЙ ОКРУГ','С/О'),
(135,'СЕЛЬСКОЕ ПОСЕЛЕНИЕ','С/П'),
(136,'СЕЛЬСОВЕТ','С/С'),
(137,'ТЕРРИТОРИЯ','ТЕР'),
(139,'АРБАН','АРБАН'),
(141,'ВЫСЕЛКИ(ОК)','ВЫСЕЛ'),
(142,'ГОРОДОК','ГОРОДОК'),
(144,'ЖЕЛЕЗНОДОРОЖНАЯ БУДКА','Ж/Д Б-КА');

INSERT INTO towntype (towntype_id,towntype_name,towntype_code) VALUES
(145,'ЖЕЛЕЗНОДОРОЖНАЯ КАЗАРМА','Ж/Д_КАЗАРМ'),
(146,'Ж/Д ОСТАНОВ. (ОБГОННЫЙ) ПУНКТ','Ж/Д_ОП'),
(147,'ЖЕЛЕЗНОДОРОЖНАЯ ПЛАТФОРМА','Ж/Д_ПЛАТФ'),
(148,'ЖЕЛЕЗНОДОРОЖНЫЙ ПОСТ','Ж/Д_ПОСТ'),
(149,'ЖЕЛЕЗНОДОРОЖНЫЙ РАЗЪЕЗД','Ж/Д_РЗД'),
(150,'ЖЕЛЕЗНОДОРОЖНАЯ СТАНЦИЯ','Ж/Д_СТ'),
(151,'ЗАИМКА','ЗАИМКА'),
(152,'КАЗАРМА','КАЗАРМА'),
(153,'КВАРТАЛ','КВ-Л'),
(154,'КОРДОН','КОРДОН');

INSERT INTO towntype (towntype_id,towntype_name,towntype_code) VALUES
(156,'ЛЕСПРОМХОЗ','ЛПХ'),
(157,'МЕСТЕЧКО','М'),
(158,'МИКРОРАЙОН','МКР'),
(159,'НАСЕЛЕННЫЙ ПУНКТ','НП'),
(160,'ОСТРОВ','ОСТРОВ'),
(161,'ПОСЕЛОК','П'),
(163,'ПЛАНИРОВОЧНЫЙ РАЙОН','П/Р'),
(164,'ПОСЕЛОК И(ПРИ) СТАНЦИЯ(И)','П/СТ'),
(166,'ПОГОСТ','ПОГОСТ'),
(167,'ПОЧИНОК','ПОЧИНОК');

INSERT INTO towntype (towntype_id,towntype_name,towntype_code) VALUES
(168,'ПРОМЫШЛЕННАЯ ЗОНА','ПРОМЗОНА'),
(169,'РАЗЪЕЗД','РЗД'),
(171,'СЛОБОДА','СЛ'),
(172,'САДОВОЕ НЕКОМ-Е ТОВАРИЩЕСТВО','СНТ'),
(173,'СТАНЦИЯ','СТ'),
(174,'СТАНИЦА','СТ-ЦА'),
(176,'УЛУС','У'),
(177,'ХУТОР','Х'),
(178,'АВТОДОРОГА','АВТОДОРОГА'),
(179,'МАССИВ','МАССИВ');

INSERT INTO towntype (towntype_id,towntype_name,towntype_code) VALUES
(180,'ЖИЛОЙ РАЙОН','ЖИЛРАЙОН'),
(181,'ЖИЛАЯ ЗОНА','ЖИЛЗОНА'),
(184,'МЕСТНОСТЬ','МЕСТНОСТЬ'),
(205,'ГОРОДСКОЙ ПОСЕЛОК','ГП'),
(138,'ААЛ','ААЛ');

CREATE VIEW ft_town
AS
SELECT
	town_id,
	CAST(
		trim(town_name)||' '||trim(town_code)||' '||coalesce(town_index,'')||' '||coalesce(town_phonecode,'')
		AS varchar(259)
	) AS fulltext
FROM town;

