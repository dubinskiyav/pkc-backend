CREATE TABLE patternnotification(
	patternnotification_id INTEGER NOT NULL,
	channelnotification_id INTEGER NOT NULL,
	eventnotification_id INTEGER NOT NULL,
	patternnotification_text VARCHAR(2000) NOT NULL,
	patternnotification_subj VARCHAR(255),
    PRIMARY KEY (patternnotification_id)
);
CREATE SEQUENCE patternnotification_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE patternnotification_id_gen OWNED BY patternnotification.patternnotification_id;
ALTER TABLE patternnotification ADD UNIQUE (channelnotification_id,eventnotification_id);

CREATE VIEW ft_patternnotification
AS
SELECT
	patternnotification_id,
	CAST(
		trim(patternnotification_text)||' '||coalesce(patternnotification_subj,'')
		AS varchar(2265)
	) AS fulltext
FROM patternnotification;

