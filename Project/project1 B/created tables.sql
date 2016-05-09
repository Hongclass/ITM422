DROP TABLE tbl_shop_configuration CASCADE CONSTRAINTS;
DROP TABLE tbl_customers CASCADE CONSTRAINTS;
DROP TABLE tbl_customer_address CASCADE CONSTRAINTS;
DROP TABLE tbl_orders CASCADE CONSTRAINTS;
DROP TABLE tbl_payment_methods CASCADE CONSTRAINTS;
DROP TABLE tbl_payments CASCADE CONSTRAINTS;
DROP TABLE tbl_services CASCADE CONSTRAINTS;
DROP TABLE tbl_service_details CASCADE CONSTRAINTS;
DROP TABLE tbl_categories CASCADE CONSTRAINTS;
DROP TABLE tbl_suppliers CASCADE CONSTRAINTS;
DROP TABLE tbl_parts CASCADE CONSTRAINTS;
DROP TABLE tbl_supply_details CASCADE CONSTRAINTS;
DROP TABLE tbl_part_details CASCADE CONSTRAINTS;
DROP TABLE tbl_children CASCADE CONSTRAINTS;



-- ************************************************************
-- LOAD THE SMALL ENGINE SHOP DATABASE TABLES:
--              tbl_shop_configuration
--              table tbl_customers;
--              tbl_customer_address;
--              tbl_orders;
--              tbl_payment_method;
--              tbl_payments;
--              tbl_services;
--              tbl_service_assignments;
--              tbl_categories;
--              tbl_suppliers;
--              tbl_parts;
--              tbl_supply_details;
--              tbl_part_details;
--              tbl_children;
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
	street_address VARCHAR2(40),
	postal_code NUMBER(5),
	city VARCHAR2(30),
  state CHAR(2),
  address_type VARCHAR2(20)
);

ALTER TABLE tbl_customer_address
	ADD CONSTRAINT pk_address PRIMARY KEY (address_id);
  
INSERT INTO tbl_customer_address VALUES
  (1001, 1, '2732 Baker Blvd.',97403,'Eugene','TX', 'mailling');
INSERT INTO tbl_customer_address VALUES
  (1002, 1, 'City Center Plaza',97827,'Elgin','OR', 'billing');
INSERT INTO tbl_customer_address VALUES
  (1003, 2, '12 Orchestra Terrace',99362,'Walla Walla','WA', 'billing');  
INSERT INTO tbl_customer_address VALUES
  (1004, 3, '87 Polk St.',94117,'San Francisco','CA', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1005, 4, '89 Chiaroscuro Rd.',97219,'Portland','OR', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1006, 5, '2743 Bering St.',99508, null, null, null);  
INSERT INTO tbl_customer_address VALUES
  (1007, 6, '2817 Milton Dr.',87110,'Albuquerque','NM', 'billing');
INSERT INTO tbl_customer_address VALUES
  (1008, 7, '187 Suffolk Ln.',83720,'Chicago','IL', 'mailling');  
INSERT INTO tbl_customer_address VALUES
  (1009, 8, 'P.O. Box 555',82520,'Lander','WY', 'billing');  
INSERT INTO tbl_customer_address VALUES
  (10010, 4, '89 Jefferson Way',82520,'Portland','OR', 'billing');  

ALTER TABLE tbl_customer_address 
	ADD CONSTRAINT fk_address_customer_id 
	FOREIGN KEY (customer_id) 
	REFERENCES tbl_customers (customer_id);







--- Creat table tbl_orders
CREATE TABLE tbl_orders (
  order_id NUMBER NOT NULL,
  customer_id NUMBER NOT NULL,
  employee_id NUMBER(6,0) NOT NULL,
  order_time TIMESTAMP,
  price NUMBER(6,2),
  order_status char(7),
  order_type char(2),   
  address_id NUMBER NOT NULL
);

ALTER TABLE tbl_orders
	ADD CONSTRAINT pk_orders PRIMARY KEY (order_id);

INSERT INTO tbl_orders VALUES
  (100001, 1, 103, '03-JAN-2013 1:03:32 PM', 1456.23,'process', 'P' ,1001);
INSERT INTO tbl_orders VALUES
  (100002, 3, 105, '05-JAN-2014 2:11:37 PM', 256.76, 'process', 'S', 1004);
INSERT INTO tbl_orders VALUES
  (100003, 4, 104, '06-JAN-2014 10:33:12 AM', 326.00, 'process', 'PS', 1005);
INSERT INTO tbl_orders VALUES
  (100004, 5, 103, '09-JAN-2014 3:53:02 PM', 242.43, 'process', 'S', 1006);
INSERT INTO tbl_orders VALUES
  (100005, 7, 104, '11-JAN-2014 12:24:09 PM', 352.54, 'cancell', 'p', 1008);    
INSERT INTO tbl_orders VALUES
  (100006, 4, 103, '22-JAN-2014 12:24:09 AM', 63.25, 'process', 'S', 1005);
INSERT INTO tbl_orders VALUES
  (100007, 2, 105,'01-FEB-2014 09:18:49 AM', 44.65, 'process', 'PS', 1002);  
  
ALTER TABLE tbl_orders
	ADD CONSTRAINT fk__orders_customer_id
	FOREIGN KEY (customer_id) 
	REFERENCES tbl_customers (customer_id);
  
ALTER TABLE tbl_orders
	ADD CONSTRAINT fk_orders_employee_id
	FOREIGN KEY (employee_id) 
	REFERENCES employees (employee_id);

ALTER TABLE tbl_orders
	ADD CONSTRAINT fk__orders_address_id
	FOREIGN KEY (address_id) 
	REFERENCES tbl_customer_address (address_id);




-- Create table tbl_payment_methods
CREATE TABLE tbl_payment_methods (
  method_id CHAR(2) NOT NULL,
  method_name VARCHAR(20) NOT NULL
);

ALTER TABLE tbl_payment_methods
	ADD CONSTRAINT pk_methods PRIMARY KEY (method_id);

INSERT INTO tbl_payment_methods VALUES
  ('CS', 'cash');
INSERT INTO tbl_payment_methods VALUES
  ('CK', 'check');
INSERT INTO tbl_payment_methods VALUES
  ('CT', 'credit card');
INSERT INTO tbl_payment_methods VALUES
  ('RB', 'rebeat');





-- Create table tbl_payments
CREATE TABLE tbl_payments (
  payment_id NUMBER NOT NULL,
  order_id NUMBER NOT NULL,       
  paid_amount NUMBER(6,2),
  method_id CHAR(2) NOT NULL
);

ALTER TABLE tbl_payments
	ADD CONSTRAINT pk_payments PRIMARY KEY (payment_id);

INSERT INTO tbl_payments VALUES
  (1, 100001, 789.25, 'CS');
INSERT INTO tbl_payments VALUES
  (2, 100002, 753.24, 'CK');
INSERT INTO tbl_payments VALUES
  (3, 100003, 246.25, 'CT');
INSERT INTO tbl_payments VALUES
  (4, 100004, 0.00, 'CS');
INSERT INTO tbl_payments VALUES
  (5, 100005, 76.25, 'CK'); 
  
ALTER TABLE tbl_payments 
	ADD CONSTRAINT fk__payments_order_id
	FOREIGN KEY (order_id) 
	REFERENCES tbl_orders (order_id);
  
ALTER TABLE tbl_payments 
	ADD CONSTRAINT fk__payments_method_id
	FOREIGN KEY (method_id) 
	REFERENCES tbl_payment_methods (method_id);






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





  
  
--- Creat table tbl_service_details
CREATE TABLE tbl_service_details (
  sv_detail_id NUMBER NOT NULL,
  order_id NUMBER NOT NULL,
	service_id CHAR(2) NOT NULL
);

ALTER TABLE tbl_service_details
	ADD CONSTRAINT pk_sv PRIMARY KEY (sv_detail_id);

INSERT INTO tbl_service_details VALUES
  (10001, 100002, 'OC');
INSERT INTO tbl_service_details VALUES
  (10002, 100003, 'ER');
INSERT INTO tbl_service_details VALUES
  (10003, 100004, 'TU');

  
ALTER TABLE tbl_service_details 
	ADD CONSTRAINT fk__sv_order_id
	FOREIGN KEY (order_id) 
	REFERENCES tbl_orders (order_id);
  
ALTER TABLE tbl_service_details 
	ADD CONSTRAINT fk__sv_service_id
	FOREIGN KEY (service_id) 
	REFERENCES tbl_services (service_id);
  



  

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
  category_id CHAR(2) NOT NULL,
  uint_price NUMBER(6,2),
  qty_in_stock NUMBER(6)
);

ALTER TABLE tbl_parts
	ADD CONSTRAINT pk_parts PRIMARY KEY (part_number);
  
INSERT INTO tbl_parts VALUES
  (12467127, 'cover', 'AC', 2.99, 10);
INSERT INTO tbl_parts VALUES
  (12467234, 'gan can', 'AC', 50.00, 10);
INSERT INTO tbl_parts VALUES
  (12478234, 'hour meter', 'AC', 19.99, null);
INSERT INTO tbl_parts VALUES
  (12478235, 'wheel cover', 'AC', 99.99, 8);  
INSERT INTO tbl_parts VALUES
  (12478236, 'lawn striping', 'AC', 49.99, 7); 
INSERT INTO tbl_parts VALUES
  (13478231, 'Briggs and Stratton engine', 'EG', 599.99, null);   
INSERT INTO tbl_parts VALUES
  (13478232, 'Honda engine', 'EG', 499.99, null);   
INSERT INTO tbl_parts VALUES
  (13478233, 'Kawasaki engine', 'EG', 549.99, 1);   
INSERT INTO tbl_parts VALUES
  (13478234, 'Kohler engine', 'EG', 519.99, null);  
INSERT INTO tbl_parts VALUES
  (13478235, 'Ryobi engine', 'EG', 619.99, null);    
INSERT INTO tbl_parts VALUES
  (14478231, 'air filter', 'SE', 19.99, 5);      
INSERT INTO tbl_parts VALUES
  (14478232, 'battery part', 'SE', 29.99, 5);   
INSERT INTO tbl_parts VALUES
  (14478233, 'breather', 'SE', 9.99, 5); 
INSERT INTO tbl_parts VALUES
  (14478234, 'camshaft', 'SE', 39.99, 5);   
INSERT INTO tbl_parts VALUES
  (14478235, 'fuel line', 'SE', 29.99, 5);
INSERT INTO tbl_parts VALUES
  (14478236, 'gas cap', 'SE', 9.99, 5);
INSERT INTO tbl_parts VALUES
  (15478231, 'air compressor', 'OP', 89.99, 5);  
INSERT INTO tbl_parts VALUES
  (15478232, 'chainsaw', 'OP', 119.99, 5);  
INSERT INTO tbl_parts VALUES
  (15478233, 'edger', 'OP', 139.99, 5);  
INSERT INTO tbl_parts VALUES
  (15478234, 'lawn morwer', 'OP', 449.99, 5);    
INSERT INTO tbl_parts VALUES
  (15478235, 'leaf blowerr', 'OP', 89.99, 5);     
INSERT INTO tbl_parts VALUES
  (15478236, 'snow blower', 'OP', 449.99, 5);  
INSERT INTO tbl_parts VALUES
  (15478237, 'pressure washer', 'OP', 109.99, 5);    

ALTER TABLE tbl_parts
ADD CONSTRAINT unique_part_name
   UNIQUE (part_name);

  
ALTER TABLE tbl_parts
	ADD CONSTRAINT fk__parts_category_id
	FOREIGN KEY (category_id) 
	REFERENCES tbl_categories (category_id);
  






-- Create table tbl_supply_details
CREATE TABLE tbl_supply_details (
  sp_detail_id NUMBER(4) NOT NULL,
  part_number NUMBER(9) NOT NULL,
  sp_uint_price NUMBER(6,2),
  sp_quantity NUMBER,
  supplier_id NUMBER(2) NOT NULL
);

ALTER TABLE tbl_supply_details
	ADD CONSTRAINT pk_sp PRIMARY KEY (sp_detail_id);

INSERT INTO tbl_supply_details VALUES
  (1, 12467127, 2.49, 30, 11);
INSERT INTO tbl_supply_details VALUES
  (2, 12467234, 45.00, 20, 16);
INSERT INTO tbl_supply_details VALUES
  (3, 14478235, 24.99, 50, 16);

ALTER TABLE tbl_supply_details
	ADD CONSTRAINT fk__sp_detail__part_number
	FOREIGN KEY (part_number) 
	REFERENCES tbl_parts (part_number);
  
ALTER TABLE tbl_supply_details
	ADD CONSTRAINT fk__sp_detail__supplier_id
	FOREIGN KEY (supplier_id) 
	REFERENCES tbl_suppliers (supplier_id);




  

--- Creat table tbl_part_details
CREATE TABLE tbl_part_details (
  pt_detail_id NUMBER(4) NOT NULL,
  order_id NUMBER NOT NULL,
  part_number NUMBER(9) NOT NULL,
  quantity NUMBER NOT NULL
);

ALTER TABLE tbl_part_details
	ADD CONSTRAINT pk_pt_details PRIMARY KEY (pt_detail_id);
  
INSERT INTO tbl_part_details VALUES
  (1, 100001, 15478235, 1);
INSERT INTO tbl_part_details VALUES
  (2, 100001, 14478233, 1);  
INSERT INTO tbl_part_details VALUES
  (3, 100003, 15478237, 1);
INSERT INTO tbl_part_details VALUES
  (4, 100005, 12467127, 2);

ALTER TABLE tbl_part_details
	ADD CONSTRAINT fk__pt_order_id
	FOREIGN KEY (order_id) 
	REFERENCES tbl_orders (order_id);
  
ALTER TABLE tbl_part_details
	ADD CONSTRAINT fk__pt_part_number
	FOREIGN KEY (part_number) 
	REFERENCES tbl_parts (part_number);
  





-- create tbl_children
CREATE TABLE tbl_children (
  child_id NUMBER(3,0) NOT NULL,
	employee_id NUMBER(6,0) NOT NULL,
	last_name VARCHAR2(30) NOT NULL,
	first_name VARCHAR2(30) NOT NULL,
	birthdate DATE NOT NULL
);

ALTER TABLE tbl_children
	ADD CONSTRAINT pk_children PRIMARY KEY (child_id);

ALTER TABLE tbl_children
	ADD CONSTRAINT uc_children_fullName UNIQUE (last_name, first_name);

ALTER TABLE tbl_children 
	ADD CONSTRAINT fk_Children_Employees 
	FOREIGN KEY (employee_id) 
	REFERENCES employees (employee_id);
 
INSERT INTO tbl_children VALUES (1, 100, 'King', 'Angela', '6-NOV-1994');
INSERT INTO tbl_children VALUES (2, 101, 'Kochhar', 'Samuel', '12-OCT-1996');
INSERT INTO tbl_children VALUES (3, 101, 'Kochhar', 'Andrea', '15-JAN-1984');
INSERT INTO tbl_children VALUES (4, 102, 'De Haan', 'Bobette', '15-MAY-1987');
INSERT INTO tbl_children VALUES (5, 103, 'Hunold', 'Robert', '23-JAN-1980');
INSERT INTO tbl_children VALUES (6, 103, 'Hunold', 'Albert', '18-MAY-1982');
INSERT INTO tbl_children VALUES (7, 103, 'Hunold', 'James', '30-JAN-1985');
INSERT INTO tbl_children VALUES (8, 104, 'Ernst', 'Madeline', '20-MAY-1992');
INSERT INTO tbl_children VALUES (9, 105, 'Austin', 'Charles', '11-JUN-1999');
INSERT INTO tbl_children VALUES (10, 105, 'Austin', 'Paula', '26-MAY-2002');

COMMIT;

  
-- ***************************************************
-- END OF LOADING THE SMALL ENGINE SHOP DATABASE
-- ***************************************************

 
  

