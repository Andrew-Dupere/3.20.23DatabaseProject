--create seller, customer, aircraft and mechanic tables first 
--because these tables do not require foreign keys for creation

CREATE TABLE seller(
	seller_id SERIAL PRIMARY KEY,
	name_ VARCHAR(25),
	country VARCHAR (25),
	address VARCHAR (50),
	phone INTEGER,
	email VARCHAR (50)
);



CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	name_ VARCHAR(25),
	contry VARCHAR (25),
	address VARCHAR (50),
	phone INTEGER,
	email VARCHAR (50)
);


CREATE TABLE aircraft(
	aircraft_id SERIAL PRIMARY KEY,
	model VARCHAR(25)
);

CREATE TABLE mechanic(
	mechanic_id SERIAL PRIMARY KEY,
	name_ VARCHAR(25),
	contry VARCHAR (25),
	address VARCHAR (50),
	phone INTEGER,
	email VARCHAR (50)
);

--create invoice and service ticket table
--these tables take in foreign keys from seller, customer, aircraft and mechanic

CREATE TABLE invoice(
	invoice_number SERIAL PRIMARY KEY,
	invoice_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	price NUMERIC(12,2),
	seller_id INTEGER,
	FOREIGN KEY(seller_id) REFERENCES seller(seller_id),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	aircraft_id INTEGER,
	FOREIGN KEY(aircraft_id) REFERENCES aircraft(aircraft_id)
);

CREATE TABLE service_ticket(
	ticket_id SERIAL PRIMARY KEY,
	service_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	price NUMERIC(12,2),
	customer_id INTEGER,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	aircraft_id INTEGER,
	FOREIGN KEY(aircraft_id) REFERENCES aircraft(aircraft_id),
	mechanic_id INTEGER,
	FOREIGN KEY(mechanic_id) REFERENCES mechanic(mechanic_id)
);

--Create stored procedures to add data to seller, customer, aircraft and mechanic TABLES

--seller
CREATE OR REPLACE PROCEDURE add_seller(name_ varchar,country varchar, address varchar, 
phone integer, email varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO seller(name_, country, address, phone, email)
	VALUES (name_, country, address, phone, email);
END;
$$;


CALL add_seller ('Airbus','Greece','129 Greek Circle',223344344,'main@airbus.com');

CALL add_seller ('Northrop Grumman','Yucutan','129 Yucutan Circle',223999344,'main@ng.com');

SELECT * FROM seller;

--aircraft

CREATE OR REPLACE PROCEDURE add_aircraft(model varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO aircraft(model)
	VALUES (model);
END;
$$;

CALL add_aircraft('C130');
CALL add_aircraft('SR71');
CALL add_aircraft('F16');
CALL add_aircraft('A380');

SELECT * FROM aircraft;

--customer

CREATE OR REPLACE PROCEDURE add_customer(name_ varchar, country varchar, address varchar, phone integer, email varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO customer(name_, country, address, phone, email)
	VALUES (name_, country, address, phone, email);
END;
$$;


CALL add_customer ('Airforce of Angola','Angola','129 Africa Circle',223344344,'main@aoa.com');

CALL add_customer ('Airforce of Egypt','Egypt','133 Africa Circle',224345344,'main@aoe.com');

CALL add_customer ('Airforce of Spain','Spain','123 Europe Circle',222345344,'main@aos.com');


SELECT * FROM customer;

--mechanic

CREATE OR REPLACE PROCEDURE add_mechanic(name_ varchar,country varchar,address varchar,phone integer,email varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO mechanic(name_, country, address, phone, email)
	VALUES (name_, country, address, phone, email);
END;
$$;

SELECT * FROM mechanic;


CALL add_mechanic ('Express Repair','Chile','123 Street',1234567891,'pr@pr.com');

CALL add_mechanic ('Easy Repair','El Salvador','123 Street',1234567891,'er@er.com');

--insert into invoice and service_ticket

INSERT INTO invoice(invoice_date, price, seller_id, customer_id, aircraft_id)
values(now(), 823473, 7, 1, 1);

INSERT INTO invoice(invoice_date, price, seller_id, customer_id, aircraft_id)
values(now(), 1000000, 8, 2, 2);

INSERT INTO service_ticket(service_date, price, customer_id, aircraft_id, mechanic_id)
values(now(), 34567, 2, 2, 2);

INSERT INTO service_ticket(service_date, price, customer_id, aircraft_id, mechanic_id)
values(now(), 322101, 1, 3, 3);



