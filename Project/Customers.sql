/****************************
 * Customers.sql
 * CIS-2720
 *
 * Creates and populates the customers table
 ****************************/

DROP TABLE customers;

CREATE TABLE customers (
  customer_id NUMBER, 
  first_name VARCHAR2(30) NOT NULL,
  last_name VARCHAR2(30) NOT NULL,
  city VARCHAR2(50) NOT NULL,
  state VARCHAR2(2) NOT NULL,
  zip_code VARCHAR2(5)  NOT NULL
);


ALTER TABLE customers
	ADD CONSTRAINT pk_customers PRIMARY KEY (customer_id);
  
  

INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (1,'Denton','Snow','FOX LAKE','WI','53933');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (2,'Glenna','Freeman','MIAMI','FL','33152');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (3,'Baxter','Rosario','TALLULAH FALLS','GA','30573');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (4,'Iris','Lindsey','SANTAQUIN','IL','84655');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (5,'Oliver','Roberts','NORTH WALES','PA','19454');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code)
	VALUES (6,'Jenna','Ford','MINNETONKA','MN','56330');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (7,'Lev','Mcfadden','PAPILLION','NE','68046');
INSERT INTO Customers (customer_id,first_name,last_name,city,state,zip_code) 
	VALUES (8,'Kimberley','Waller','CAIRO','NE','68824');
  
  
