DROP TABLE tbl_shop_configuration CASCADE CONSTRAINTS;
DROP TABLE tbl_customers CASCADE CONSTRAINTS;
DROP TABLE tbl_customer_address CASCADE CONSTRAINTS;
DROP TABLE tbl_services CASCADE CONSTRAINTS;
DROP TABLE tbl_service_assignments CASCADE CONSTRAINTS;
DROP TABLE tbl_categories CASCADE CONSTRAINTS;
DROP TABLE tbl_suppliers CASCADE CONSTRAINTS;
DROP TABLE tbl_parts CASCADE CONSTRAINTS;
DROP TABLE tbl_shippers CASCADE CONSTRAINTS;
DROP TABLE tbl_orders CASCADE CONSTRAINTS;
DROP TABLE tbl_order_details CASCADE CONSTRAINTS;


-- ************************************************************
-- LOAD THE SMALL ENGINE SHOP DATABASE TABLES:
--              tbl_shop_configuration
--              table tbl_customers;
--              tbl_customer_address;
--              tbl_services;
--              tbl_service_assignments;
--              tbl_categories;
--              tbl_suppliers;
--              tbl_parts;
--              tbl_shippers;
--              tbl_orders;
--              tbl_order_details;
--  I use the employees table from HR database to repalce the table which records
--  this database employees' data.  
-- ************************************************************

-- Create table tbl_shop_configuration     
CREATE TABLE tbl_shop_configuration (
	shop_id NUMBER(2) NOT NULL,
	shop_name VARCHAR2(30) NOT NULL,
	manager_id NUMBER(6,0) NOT NULL,
	street_address VARCHAR2(40) NOT NULL,
	postal_code NUMBER(5) NOT NULL,
	city VARCHAR2(30) NOT NULL,
  state CHAR(2) NOT NULL,
  phone_number VARCHAR2(20) NOT NULL,
  fax VARCHAR2(20) NOT NULL
);

ALTER TABLE tbl_shop_configuration
	ADD CONSTRAINT pk_shop PRIMARY KEY (shop_id);
  
INSERT INTO tbl_shop_configuration VALUES
  (01, 'Chicago shop', 100, '3200 South Federal Street', 60616, 'Chicago', 'IL', '312.567.2000', '312.567.2001'); 
INSERT INTO tbl_shop_configuration VALUES
  (02, 'Naperville shop', 101, '800 Wildflower Circle', 60540, 'Naperville', 'IL', '630.857.9100', '630.857.9101'); 
  
ALTER TABLE tbl_shop_configuration 
	ADD CONSTRAINT fk_shop_manager_id 
	FOREIGN KEY (manager_id) 
	REFERENCES employees (employee_id);
  
  
  
-- Create table tbl_customer  
CREATE TABLE tbl_customers (
  customer_id NUMBER NOT NULL, 
  first_name VARCHAR2(30)NOT NULL,
  last_name VARCHAR2(30) NOT NULL,
  email VARCHAR2(25)NOT NULL,
  phone_number VARCHAR2(20) NOT NULL,
  fax VARCHAR2(20) 
);

ALTER TABLE tbl_customers
	ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);

INSERT INTO tbl_customers	VALUES 
  (1,'Denton','Snow','desnow23@hotmail.com','515.123.8181',null);
INSERT INTO tbl_customers	VALUES  
 (2,'Glenna','Freeman','gfreman554@yahoo.com','515.123.8080','515.123.8000');
INSERT INTO tbl_customers	VALUES  
 (3,'Baxter','Rosario','brosario24@gmail.com','603.123.6666',null);
INSERT INTO tbl_customers	VALUES 
 (4,'Iris','Lindsey','rilindsey53@yahoo.com','515.123.5555',null);
INSERT INTO tbl_customers	VALUES  
 (5,'Oliver','Roberts','rpberr35@hotmail.com','515.123.4444','515.123.4445');
INSERT INTO tbl_customers	VALUES 
 (6,'Jenna','Ford','jennaer49@gmail.com','650.507.9844',null);
INSERT INTO tbl_customers	VALUES  
 (7,'Lev','Mcfadden','levmcdf98@yahoo.com','650.507.9833',null);
INSERT INTO tbl_customers	VALUES 
 (8,'Kimberley','Waller','kimberwal35@hotmail.com','603.123.6666',null);

ALTER TABLE tbl_customers
ADD CONSTRAINT unique_customers_full_name
   UNIQUE (first_name, last_name);
   
   
  
-- Create table tbl_customer_address     
CREATE TABLE tbl_customer_address (
	address_id NUMBER NOT NULL,
	customer_id NUMBER NOT NULL,
	street_address VARCHAR2(40) NOT NULL,
	postal_code NUMBER(5) NOT NULL,
	city VARCHAR2(30) NOT NULL,
  state CHAR(2) NOT NULL,
  address_type VARCHAR2(20) NOT NULL
);

ALTER TABLE tbl_customer_address
	ADD CONSTRAINT pk_address PRIMARY KEY (address_id);
  
INSERT INTO tbl_customer_address VALUES
  (1001, 1, '2732 Baker Blvd.',97403,'Eugene','OR', 'mailling');
INSERT INTO tbl_customer_address VALUES
  (1002, 1, 'City Center Plaza',97827,'Elgin','OR', 'billing');
INSERT INTO tbl_customer_address VALUES
  (1003, 2, '12 Orchestra Terrace',99362,'Walla Walla','WA', 'billing');  
INSERT INTO tbl_customer_address VALUES
  (1004, 3, '87 Polk St.',94117,'San Francisco','CA', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1005, 4, '89 Chiaroscuro Rd.',97219,'Portland','OR', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1006, 5, '2743 Bering St.',99508,'Anchorage','AK', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1007, 6, '2817 Milton Dr.',87110,'Albuquerque','NM', 'billing');
INSERT INTO tbl_customer_address VALUES
  (1008, 7, '187 Suffolk Ln.',83720,'Boise','ID', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1009, 8, 'P.O. Box 555',82520,'Lander','WY', 'billing');  
INSERT INTO tbl_customer_address VALUES
  (10010, 4, '89 Jefferson Way',82520,'Portland','OR', 'billing');  

ALTER TABLE tbl_customer_address 
	ADD CONSTRAINT fk_address_customer_id 
	FOREIGN KEY (customer_id) 
	REFERENCES tbl_customers (customer_id);
  

-- Create table tbl_services     
CREATE TABLE tbl_services (
	service_id CHAR(2),
  service_name VARCHAR2(30) NOT NULL,
  price NUMBER(6,2) NOT NULL
);

ALTER TABLE tbl_services
	ADD CONSTRAINT pk_sevices PRIMARY KEY (service_id);
  
INSERT INTO tbl_services VALUES
  ('OC', 'oil change', 299.99);
INSERT INTO tbl_services VALUES
  ('TU', 'tune up', 99.99);
INSERT INTO tbl_services VALUES
  ('ER', 'electrical repair', 599.99);
INSERT INTO tbl_services VALUES
  ('BR', 'blade replacement', 199.99);
  
  
--- Creat table tbl_service_assignments
CREATE TABLE tbl_service_assignments (
  assignment_id NUMBER NOT NULL,
	service_id CHAR(2) NOT NULL,
  customer_id NUMBER NOT NULL,
  employee_id NUMBER(6,0) NOT NULL,
  start_date DATE,
  delivery_datetime DATE
);

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY';

ALTER TABLE tbl_service_assignments
	ADD CONSTRAINT pk_assignment PRIMARY KEY (assignment_id);

INSERT INTO tbl_service_assignments VALUES
  (10001, 'OC', 1, 103, '01-JAN-2014', TO_DATE('01-JAN-2014 13:45:32', 'DD-MON-YYYY hh24:mi:ss'));
INSERT INTO tbl_service_assignments VALUES
  (10002, 'OC', 4, 104, '02-JAN-2014',TO_DATE('02-JAN-2014 11:55:00', 'DD-MON-YYYY hh24:mi:ss'));
INSERT INTO tbl_service_assignments VALUES
  (10003, 'TU', 5, 103, '05-JAN-2014',TO_DATE('05-JAN-2014 16:45:32', 'DD-MON-YYYY hh24:mi:ss'));
INSERT INTO tbl_service_assignments VALUES
  (10004, 'ER', 6, 104, '07-JAN-2014',TO_DATE('08-JAN-2014 9:45:32', 'DD-MON-YYYY hh24:mi:ss'));
INSERT INTO tbl_service_assignments VALUES
  (10005, 'ER', 7, 104, '09-JAN-2014',TO_DATE('10-JAN-2014 8:45:32', 'DD-MON-YYYY hh24:mi:ss'));
INSERT INTO tbl_service_assignments VALUES
  (10006, 'BR', 8, 103, '11-JAN-2014',TO_DATE('11-JAN-2014 17:45:32', 'DD-MON-YYYY hh24:mi:ss'));
  
ALTER TABLE tbl_service_assignments 
	ADD CONSTRAINT fk__assignment_service_id
	FOREIGN KEY (service_id) 
	REFERENCES tbl_services (service_id);
  
ALTER TABLE tbl_service_assignments 
	ADD CONSTRAINT fk__assignment_customer_id
	FOREIGN KEY (customer_id) 
	REFERENCES tbl_customers (customer_id);
  
ALTER TABLE tbl_service_assignments 
	ADD CONSTRAINT fk__assignment_employee_id
	FOREIGN KEY (employee_id) 
	REFERENCES employees (employee_id);
  

-- Create table tbl_categories     
CREATE TABLE tbl_categories (
	category_id CHAR(2) NOT NULL,
  category_name VARCHAR2(30) NOT NULL,
  category_descripton VARCHAR2(150) 
);

ALTER TABLE tbl_categories
	ADD CONSTRAINT pk_categories PRIMARY KEY (category_id);
  
INSERT INTO tbl_categories VALUES
  ('AC', 'accessories', 'covers, gan cans, hour meters, wheel covers, lawn stripings');
INSERT INTO tbl_categories VALUES
  ('EG', 'engines', 'Briggs and Stratton engines, Honda engines, Kawasaki engines, Kohler engines, Ryobi engines');
INSERT INTO tbl_categories VALUES
  ('SE', 'small engine parts', 'air filters, battery parts, breathers, camshafts, fuel lines, gas caps');
INSERT INTO tbl_categories VALUES
  ('OP', 'outdoor power equipment', 'air compressors, chainsaws, edgers, lawn morwers, leaf blowers, snow blowers, 
    pressure washers');



-- Create table tbl_suppliers  
CREATE TABLE tbl_suppliers (
	supplier_id NUMBER(2) NOT NULL,
	company_name VARCHAR2(30) NOT NULL,
	contact_name VARCHAR2(30) NOT NULL,
  contact_title VARCHAR2(30),
	street_address VARCHAR2(40) NOT NULL,
	postal_code NUMBER(5) NOT NULL,
	city VARCHAR2(30) NOT NULL,
  state CHAR(2) NOT NULL,
  phone_number VARCHAR2(20) NOT NULL,
  fax VARCHAR2(20)
);

ALTER TABLE tbl_suppliers
	ADD CONSTRAINT pk_suppliers PRIMARY KEY (supplier_id);
  
INSERT INTO tbl_suppliers VALUES
  (11, 'Briggs and Stratton', 'Charlotte Cooper', 'Purchasing Manager', 'P.O. Box 78934', 
    70117, 'New Orleans', 'LA', '(100) 555-4822', null);
INSERT INTO tbl_suppliers VALUES
  (12, 'Honda', 'Yoshi Nagase', 'Marketing Manager', '707 Oxford Rd.' , 48104, 'Ann Arbor', 
    'MI', '(313) 555-5735', '(313) 555-3349');
INSERT INTO tbl_suppliers VALUES
  (13, 'Kawasaki', 'Cheryl Saylor', 'Sales Representative', 'Viale Dante, 75', 48100,
    'Bend', 'OR', '(503) 555-9931', null);
INSERT INTO tbl_suppliers VALUES
  (14, 'Kohler', 'Robb Merchant', 'Sales Representative', '2100 Paul Revere Blvd.', 02134,
    'Boston', 'MA', '(617) 555-3267', '(617) 555-3389');
INSERT INTO tbl_suppliers VALUES
  (15, 'Ryobi', 'Karl Jablonski', 'Sales Manager', 'Rua do Mercado, 12', 08737,
    'Seattle', 'WA', '(206) 555-4112', '(206) 555-4115');
INSERT INTO tbl_suppliers VALUES
  (16, 'Ma Maison', 'Helvetius Nagy', 'Sales Associate', '722 DaVinci Blvd.', 98034,
    'Kirkland', 'WA', '(206) 555-8257', '(206) 555-2174');

    
    

-- Create table tbl_parts     
CREATE TABLE tbl_parts (
	part_number NUMBER(9) NOT NULL,
  part_name VARCHAR2(30) NOT NULL,
  supplier_id NUMBER(2) NOT NULL,
  category_id CHAR(2) NOT NULL,
  uint_price NUMBER(6,2),
  qty_in_stock NUMBER
);

ALTER TABLE tbl_parts
	ADD CONSTRAINT pk_parts PRIMARY KEY (part_number);
  
INSERT INTO tbl_parts VALUES
  (12467127, 'cover', 16, 'AC', 2.99, 45);
INSERT INTO tbl_parts VALUES
  (12467234, 'gan can', 16, 'AC', 50.00, 20);
INSERT INTO tbl_parts VALUES
  (12478234, 'hour meter', 16, 'AC', 19.99, 40);
INSERT INTO tbl_parts VALUES
  (12478235, 'wheel cover', 16, 'AC', 99.99, 30);  
INSERT INTO tbl_parts VALUES
  (12478236, 'lawn striping', 16, 'AC', 49.99, 20); 
INSERT INTO tbl_parts VALUES
  (13478231, 'Briggs and Stratton engine', 11, 'EG', 599.99, 5);   
INSERT INTO tbl_parts VALUES
  (13478232, 'Honda engine', 12, 'EG', 499.99, 5);   
INSERT INTO tbl_parts VALUES
  (13478233, 'Kawasaki engine', 13, 'EG', 549.99, 5);   
INSERT INTO tbl_parts VALUES
  (13478234, 'Kohler engine', 14, 'EG', 519.99, 5);  
INSERT INTO tbl_parts VALUES
  (13478235, 'Ryobi engine', 15, 'EG', 619.99, 5);    
INSERT INTO tbl_parts VALUES
  (14478231, 'air filter', 16, 'SE', 19.99, 50);      
INSERT INTO tbl_parts VALUES
  (14478232, 'battery part', 16, 'SE', 29.99, 50);   
INSERT INTO tbl_parts VALUES
  (14478233, 'breather', 16, 'SE', 9.99, 50); 
INSERT INTO tbl_parts VALUES
  (14478234, 'camshaft', 16, 'SE', 39.99, 50);   
INSERT INTO tbl_parts VALUES
  (14478235, 'fuel line', 16, 'SE', 29.99, 50);
INSERT INTO tbl_parts VALUES
  (14478236, 'gas cap', 16, 'SE', 9.99, 50);
INSERT INTO tbl_parts VALUES
  (15478231, 'air compressor', 16, 'OP', 89.99, 10);  
INSERT INTO tbl_parts VALUES
  (15478232, 'chainsaw', 16, 'OP', 119.99, 10);  
INSERT INTO tbl_parts VALUES
  (15478233, 'edger', 16, 'OP', 139.99, 10);  
INSERT INTO tbl_parts VALUES
  (15478234, 'lawn morwer', 16, 'OP', 449.99, 10);    
INSERT INTO tbl_parts VALUES
  (15478235, 'leaf blowerr', 16, 'OP', 89.99, 10);     
INSERT INTO tbl_parts VALUES
  (15478236, 'snow blower', 16, 'OP', 449.99, 10);  
INSERT INTO tbl_parts VALUES
  (15478237, 'pressure washer', 16, 'OP', 109.99, 10);    

ALTER TABLE tbl_parts
ADD CONSTRAINT unique_part_name
   UNIQUE (part_name);

ALTER TABLE tbl_parts
	ADD CONSTRAINT fk__parts_supplier_id
	FOREIGN KEY (supplier_id) 
	REFERENCES tbl_suppliers (supplier_id);
  
ALTER TABLE tbl_parts
	ADD CONSTRAINT fk__parts_category_id
	FOREIGN KEY (category_id) 
	REFERENCES tbl_categories (category_id);
  


-- Create table tbl_shippers     
CREATE TABLE tbl_shippers (
	shipper_id NUMBER(2) NOT NULL,
  shipper_name VARCHAR2(30) NOT NULL,
  phone_number VARCHAR2(20) NOT NULL
);

ALTER TABLE tbl_shippers
	ADD CONSTRAINT pk_shipper PRIMARY KEY (shipper_id);
  
INSERT INTO tbl_shippers VALUES
  (01, 'Speedy Express', '331.455.6677');
INSERT INTO tbl_shippers VALUES
  (02, 'United Package', '331.455.8989');  
INSERT INTO tbl_shippers VALUES
  (03, 'Federal Shipping', '331.455.1234');    


-- Because one customer can order two or 
-- more than two parts once, I think I should 
-- create two tables. One is order table which 
-- is a customer order once. Another is order 
-- detail table which is this customer order different
-- parts in this order


--- Creat table tbl_orders
CREATE TABLE tbl_orders (
  order_id NUMBER NOT NULL,
  customer_id NUMBER NOT NULL,
  employee_id NUMBER(6,0) NOT NULL,
  order_date DATE,
  required_date DATE,
  shipped_date DATE,
  shipVia NUMBER(2) NOT NULL,
  freight NUMBER(6,2),
  address_id NUMBER NOT NULL
);

ALTER SESSION SET NLS_DATE_FORMAT = 'DD-MON-YY';

ALTER TABLE tbl_orders
	ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

INSERT INTO tbl_orders VALUES
  (100001, 1, 103, TO_DATE('03-JAN-2014 13:03:32', 'DD-MON-YYYY hh24:mi:ss'), '09-JAN-2014',
    '04-JAN-2014', 01, 32.28, 1001);
INSERT INTO tbl_orders VALUES
  (100002, 3, 105, TO_DATE('05-JAN-2014 14:11:37', 'DD-MON-YYYY hh24:mi:ss'), '11-JAN-2014',
    '06-JAN-2014', 03, 52.28, 1004);
INSERT INTO tbl_orders VALUES
  (100003, 4, 104, TO_DATE('06-JAN-2014 10:33:12', 'DD-MON-YYYY hh24:mi:ss'), '14-JAN-2014',
    '07-JAN-2014', 01, 72.48, 1005);
INSERT INTO tbl_orders VALUES
  (100004, 5, 103, TO_DATE('09-JAN-2014 15:53:02', 'DD-MON-YYYY hh24:mi:ss'), '20-JAN-2014',
    '10-JAN-2014', 02, 56.24, 1006);
INSERT INTO tbl_orders VALUES
  (100005, 7, 104, TO_DATE('11-JAN-2014 12:24:09', 'DD-MON-YYYY hh24:mi:ss'), '19-JAN-2014',
    '13-JAN-2014', 03, 82.28, 1008);    
  
ALTER TABLE tbl_orders
	ADD CONSTRAINT fk__orders_customer_id
	FOREIGN KEY (customer_id) 
	REFERENCES tbl_customers (customer_id);
  
ALTER TABLE tbl_orders
	ADD CONSTRAINT fk_orders_employee_id
	FOREIGN KEY (employee_id) 
	REFERENCES employees (employee_id);
  
ALTER TABLE tbl_orders
	ADD CONSTRAINT fk__orders_shipper_id
	FOREIGN KEY (shipVia) 
	REFERENCES tbl_shippers (shipper_id);
  
ALTER TABLE tbl_orders
	ADD CONSTRAINT fk__orders_address_id
	FOREIGN KEY (address_id) 
	REFERENCES tbl_customer_address (address_id);
  
  

--- Creat table tbl_order_details
CREATE TABLE tbl_order_details (
	order_id NUMBER NOT NULL,
  part_number NUMBER(9) NOT NULL,
  quantity NUMBER NOT NULL
);

ALTER TABLE tbl_order_details
	ADD CONSTRAINT pk_order_details PRIMARY KEY (order_id, part_number);
  
INSERT INTO tbl_order_details VALUES
  (100001, 15478235, 1);
INSERT INTO tbl_order_details VALUES
  (100001, 14478233, 1);  
INSERT INTO tbl_order_details VALUES
  (100002, 14478235, 2);
INSERT INTO tbl_order_details VALUES
  (100003, 15478237, 1);
INSERT INTO tbl_order_details VALUES
  (100003, 15478234, 1);
INSERT INTO tbl_order_details VALUES
  (100004, 15478231, 2);
INSERT INTO tbl_order_details VALUES
  (100005, 14478231, 1);
INSERT INTO tbl_order_details VALUES
  (100005, 12467127, 1);
  
ALTER TABLE tbl_order_details
	ADD CONSTRAINT fk__detail_part_number
	FOREIGN KEY (part_number) 
	REFERENCES tbl_parts (part_number);
  
-- ***************************************************
-- END OF LOADING THE SMALL ENGINE SHOP DATABASE
-- ***************************************************

 
  

