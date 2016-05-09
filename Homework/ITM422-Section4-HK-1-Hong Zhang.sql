/***********************************************
 * Creates a children table, tbl_children.
 * Insert some tuples to order table, tbl_orders 
 * and order detail table, tbl_order_details.
 * Finally, use tbl_orders, tbl_order_details,
 * tbl_parts, tbl_children and employees to
 * create some views and search the employee  
 * with the highes total sales in January.
 * Then, list this employee's name and his 
 * children's name. 
 ***********************************************/

DROP TABLE tbl_children;

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

-- I already insert some data to tbl_orders 
-- and tbl_order_details. These data include
-- employee_id. It means I assigned orders to
-- employees. Now, I will insert more tuples.

INSERT INTO tbl_orders VALUES
  (100006, 4, 103, TO_DATE('22-JAN-2014 12:24:09', 'DD-MON-YYYY hh24:mi:ss'), '27-JAN-2014',
    '23-JAN-2014', 01, 63.25, 1006);
INSERT INTO tbl_orders VALUES
  (100007, 2, 105, TO_DATE('01-FEB-2014 09:18:49', 'DD-MON-YYYY hh24:mi:ss'), '5-FEB-2014',
    '1-FEB-2014', 02, 44.65, 1002);    
    
INSERT INTO tbl_order_details VALUES
  (100006, 14478232, 3);
INSERT INTO tbl_order_details VALUES
  (100007, 12467127, 1);
INSERT INTO tbl_order_details VALUES
  (100007, 12467234, 1);

-- create orders_Jan_view 
-- conbime order table and order detail talbe to get the data of all orders in January
CREATE OR REPLACE VIEW orders_Jan_view AS
    SELECT a.order_id,
           a.employee_id,
           b.part_number,
           b.quantity
      FROM tbl_orders a
INNER JOIN tbl_order_details b
        ON a.order_id = b.order_id
     WHERE a.order_date BETWEEN '01-JAN-14' AND '31-JAN-14'
  ORDER BY a.order_id;
  
SELECT * FROM orders_Jan_view;

-- create sale_Jan_view
-- combine parts talbe and orders view to get the sale data for each order.
CREATE OR REPLACE VIEW sale_Jan_view AS  
    SELECT a.part_number,
           a.part_name,
           b.order_id,
           b.employee_id,
           a.uint_price,
           b.quantity,
           a.uint_price * b.quantity as total
      FROM tbl_parts a
INNER JOIN orders_Jan_view b
        ON a.part_number = b.part_number
  ORDER BY a.part_number;
  
SELECT * FROM sale_Jan_view;

-- create child_view
-- combine employee table and child table to get their names
CREATE OR REPLACE VIEW child_view AS
    SELECT a.employee_id,
           a.first_name AS father_name,
           b.child_id,
           b.first_name AS child_name,
           b.last_name AS family_name
      FROM employees a
INNER JOIN tbl_children b
        ON a.employee_id = b.employee_id
  ORDER BY employee_id;

SELECT * FROM child_view;

-- create max_sales_Jan_view
-- find the total sales in January for each employee
-- then find the max sales
CREATE OR REPLACE VIEW max_sales_Jan_view AS 
WITH Jan_agg AS (
  SELECT employee_id, SUM(total) AS total_sale
  FROM sale_Jan_view
  GROUP BY employee_id
)
SELECT employee_id, total_sale AS max_total
FROM Jan_agg
WHERE total_sale = (SELECT MAX(total_sale)
                      FROM Jan_agg);
  
SELECT * FROM max_sales_Jan_view;

-- list the children of the employee with highest sales in January
    SELECT a.father_name,
           a.child_name,
           a.family_name
      FROM child_view a
INNER JOIN max_sales_Jan_view b
        ON a.employee_id = b.employee_id
  ORDER BY father_name;


  
