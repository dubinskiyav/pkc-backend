CREATE TABLE notification(
	notification_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	channelnotification_id INTEGER NOT NULL,
	eventnotification_id INTEGER NOT NULL,
	notification_address VARCHAR(125),
	notification_text VARCHAR(2000) NOT NULL,
	notification_date TIMESTAMP NOT NULL,
	notification_status INTEGER NOT NULL,
	notification_datesend TIMESTAMP,
	notification_subj VARCHAR(255),
	notification_linkobj_id INTEGER,
	notification_dateread TIMESTAMP,
	notification_senderror VARCHAR(255),
	notification_sendcounter INTEGER NOT NULL,
    PRIMARY KEY (notification_id)
);
CREATE SEQUENCE notification_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE notification_id_gen OWNED BY notification.notification_id;

CREATE VIEW ft_notification
AS
SELECT
	notification_id,
	CAST(
		coalesce(notification_address,'')||' '||trim(notification_text)||' '||trim(to_char(notification_date, 'DD.MM.YYYY'))||' '||trim(cast(notification_status as varchar))||' '||coalesce(to_char(notification_datesend, 'DD.MM.YYYY'),'')||' '||coalesce(notification_subj,'')||' '||coalesce(cast(notification_linkobj_id as varchar),'')||' '||coalesce(to_char(notification_dateread, 'DD.MM.YYYY'),'')||' '||coalesce(notification_senderror,'')
		AS varchar(2752)
	) AS fulltext
FROM notification;

