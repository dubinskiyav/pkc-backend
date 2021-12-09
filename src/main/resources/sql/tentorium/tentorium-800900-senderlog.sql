create table senderlog (
    senderlog_id integer not null,
    senderlog_datetime timestamp not null,
    entity_id integer not null,
    senderlog_message_id varchar(100),
    senderlog_status integer,
    senderlog_error_message varchar(1024),
    senderlog_type_id integer not null,
    constraint senderlog_pk primary key (senderlog_id),
    constraint senderlog_fk1 foreign key (senderlog_type_id) references capcode(capcode_id)
);
CREATE SEQUENCE senderlog_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE senderlog_id_gen OWNED BY senderlog.senderlog_id;

INSERT INTO CAPCODETYPE VALUES (2153,'2153','Тип сообщения',NULL);

INSERT INTO CAPCODE VALUES (21531,2153,'01','Отправка заказа в статусе на Согласование','001');
INSERT INTO CAPCODE VALUES (21532,2153,'02','Перевод в состояние В Резерве','002');
INSERT INTO CAPCODE VALUES (21533,2153,'03','Перевод в состояние К открузке','003');
INSERT INTO CAPCODE VALUES (21534,2153,'04','Заказ принят и Принят с расхождениями','004');
