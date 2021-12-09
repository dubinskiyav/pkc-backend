CREATE TABLE notificationappendix(
	notificationappendix_id INTEGER NOT NULL,
	notification_id INTEGER NOT NULL,
	notificationappendix_name VARCHAR(255) NOT NULL,
	notificationappendix_data bytea,
    PRIMARY KEY (notificationappendix_id)
);
CREATE SEQUENCE notificationappendix_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE notificationappendix_id_gen OWNED BY notificationappendix.notificationappendix_id;

CREATE VIEW ft_notificationappendix
AS
SELECT
	notificationappendix_id,
	CAST(
		trim(notificationappendix_name)
		AS varchar(265)
	) AS fulltext
FROM notificationappendix;

