CREATE TABLE requestagree (
    requestagree_id integer not null,
    request_id integer not null,
    requestagree_pickupflag integer not null,
    addresss_id integer,
    requestagreeaddress_text varchar(255),
    consignee_id integer,
    transporter_id integer,
    formpayment_id integer,
    deliverykind_id integer,
    requestagree_loadoperflag integer not null,
    request_tempregflag integer not null,
    constraint requestagree_ak1 unique (request_id),
    constraint requestagree_pk primary key (requestagree_id),
    constraint requestagree_fk1 foreign key (requestagree_id) references documentreal(documentreal_id),
    constraint requestagree_fk2 foreign key (request_id) references request(request_id),
    constraint requestagree_fk3 foreign key (addresss_id) references address(addresss_id),
    constraint requestagree_fk4 foreign key (consignee_id) references company(company_id),
    constraint requestagree_fk5 foreign key (transporter_id) references company(company_id),
    constraint requestagree_fk6 foreign key (formpayment_id) references capclass(capclass_id),
    constraint requestagree_fk7 foreign key (deliverykind_id) references capclass(capclass_id)
);

CREATE SEQUENCE requestagree_id_gen AS INTEGER START WITH 1 INCREMENT BY 1;
ALTER SEQUENCE requestagree_id_gen OWNED BY requestagree.requestagree_id;
ALTER TABLE requestagree ADD UNIQUE (request_id);
