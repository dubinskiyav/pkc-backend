CREATE TABLE requestagreepos(
    requestagreepos_id integer not null,
    requestagree_id integer not null,
    sgood_id integer not null,
    requestagreepos_number integer not null,
    requestagreepos_count numeric(10,2),
    requestagreepos_order integer not null,
    requestagreepos_price numeric(10,2),
    requestagreepos_points integer,
    requestagreepos_boxcount numeric(10,2) not null,
    requestagreepos_note varchar(255),
    pricesgoodsubjectprice_id integer,
    pricesgoodsubjectpoints_id integer,
    character_id integer,
    requestagreepos_remains numeric(16,2),
    constraint requestagreepos_ak1 unique (sgood_id,requestagree_id),
    constraint requestagreepos_ak2 unique (requestagree_id,requestagreepos_number),
    constraint requestagreepos_pk primary key (requestagreepos_id),
    constraint requestagreepos_fk1 foreign key (requestagree_id) references requestagree(requestagree_id),
    constraint requestagreepos_fk2 foreign key (sgood_id) references sgood(sgood_id),
    constraint requestagreepos_fk3 foreign key (pricesgoodsubjectprice_id) references pricesgoodsubject(pricesgoodsubject_id),
    constraint requestagreepos_fk4 foreign key (pricesgoodsubjectpoints_id) references pricesgoodsubject(pricesgoodsubject_id)
);
CREATE SEQUENCE requestagreepos_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE requestagreepos_id_gen OWNED BY requestagreepos.requestagreepos_id;
ALTER TABLE requestagreepos ADD UNIQUE (sgood_id,requestagree_id);
ALTER TABLE requestagreepos ADD UNIQUE (requestagree_id,requestagreepos_number);

