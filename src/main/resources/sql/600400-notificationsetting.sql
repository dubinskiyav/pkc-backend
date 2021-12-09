CREATE TABLE notificationsetting(
	notificationsetting_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	eventnotification_id INTEGER NOT NULL,
	channelnotification_id INTEGER NOT NULL,
    PRIMARY KEY (notificationsetting_id)
);
CREATE SEQUENCE notificationsetting_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE notificationsetting_id_gen OWNED BY notificationsetting.notificationsetting_id;
ALTER TABLE notificationsetting ADD UNIQUE (proguser_id,eventnotification_id,channelnotification_id);