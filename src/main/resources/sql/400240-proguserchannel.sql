CREATE TABLE proguserchannel(
	proguserchannel_id INTEGER NOT NULL,
	proguser_id INTEGER NOT NULL,
	channelnotification_id INTEGER NOT NULL,
	proguserchannel_address VARCHAR(125),
    PRIMARY KEY (proguserchannel_id)
);
CREATE SEQUENCE proguserchannel_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE proguserchannel_id_gen OWNED BY proguserchannel.proguserchannel_id;
ALTER TABLE proguserchannel ADD UNIQUE (proguser_id,channelnotification_id);
