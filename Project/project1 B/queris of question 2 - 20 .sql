--2.	Select all customers with or without orders, for customers with orders list all order information
--Solutoin:
         SELECT first_name,
                last_name,
                tbl_orders.*
           FROM tbl_customers 
LEFT OUTER JOIN tbl_orders
             ON tbl_customers.customer_id = tbl_orders.customer_id;
             
             

--3.	List customers with orders only.
--Solution 1:
        SELECT first_name,
               last_name,
               tbl_orders.* 
          FROM tbl_customers 
    INNER JOIN tbl_orders
            ON tbl_customers.customer_id = tbl_orders.customer_id;
--Solution 2:
SELECT first_name,
       last_name,
       tbl_orders.*
  FROM tbl_customers, 
       tbl_orders
 WHERE tbl_customers.customer_id = tbl_orders.customer_id;
--Solution 3:
          SELECT first_name,
                 last_name,
                 tbl_orders.*
            FROM tbl_customers 
Right OUTER JOIN tbl_orders
              ON tbl_customers.customer_id = tbl_orders.customer_id;



--4.	Find a Cartesian product of the customer and order tables
--Solution 1: 
    SELECT *
      FROM tbl_customers 
CROSS JOIN tbl_orders;
--Solution 2:
SELECT *
  FROM tbl_customers, tbl_orders;



--5.	List all items that have not been ordered yet.
--Solution 1:
SELECT part_number,
       part_name
  FROM tbl_parts 
 WHERE part_number NOT IN (
                          SELECT part_number 
                            FROM tbl_part_details);
--Solution 2:
         SELECT p.part_number,
                p.part_name,
                d.order_id
           FROM tbl_parts p
LEFT OUTER JOIN tbl_part_details d
             ON p.part_number = d.part_number
          WHERE d.order_id IS NULL;




--6.	List all ordered items 
--Solution 1:
SELECT part_number,
       part_name
  FROM tbl_parts 
 WHERE part_number IN (
                      SELECT part_number 
                      FROM tbl_part_details);
--Solution 2:
         SELECT p.part_number,
                p.part_name,
                d.order_id
           FROM tbl_parts p
LEFT OUTER JOIN tbl_part_details d
             ON p.part_number = d.part_number
          WHERE d.order_id IS NOT NULL;
--Solution 3:
SELECT part_number, 
       part_name, 
       order_id,
       order_time
  FROM tbl_orders
  JOIN tbl_part_details USING (order_id)
  JOIN tbl_parts USING (part_number)
 ORDER BY 1;
 

--7.	List all orders that the customer did not pay for.
--Solution:
SELECT o.*,
       p.paid_amount
  FROM tbl_orders o
  JOIN tbl_payments p 
    ON o.order_id = p.order_id
 WHERE p.paid_amount = 0;

--8.	List all orders paid with a check (assume you have a separate payment table)
--Solution 1:
SELECT order_id,
       customer_id,
       order_time,
       price,
       order_status,
       paid_amount,
       method_name
  FROM tbl_orders
  JOIN tbl_payments USING (order_id)
  JOIN tbl_payment_methods USING (method_id)
 WHERE method_name = 'check';
--Solution 2: 
          SELECT o.*
            FROM tbl_orders o
RIGHT OUTER JOIN tbl_payments p
              ON o.order_id = p.order_id
           WHERE p.method_id IN (
                                       SELECT method_id 
                                         FROM tbl_payments 
                                 NATURAL JOIN tbl_payment_methods
                                        WHERE method_name = 'check');




--9.	Give all ordered items in Jan 2014 and not in Jan 2013.
--Solution:
SELECT order_id, 
       order_time, 
       price, 
       part_number, 
       part_name
 FROM tbl_orders
 JOIN tbl_part_details USING (order_id)
 JOIN tbl_parts USING (part_number)
WHERE TRUNC(tbl_orders.order_time) 
         BETWEEN '01-JAN-2014' AND '31-JAN-2014'
  AND TRUNC(tbl_orders.order_time) 
         NOT BETWEEN '01-JAN-2013' AND '31-JAN-2013';
  


--10.	List customer names and phone numbers from Texas with orders over $1000.
--Solution:
SELECT first_name, 
       last_name, 
       phone_number
  FROM tbl_customers
  JOIN tbl_customer_address USING (customer_id)
  JOIN tbl_orders USING (address_id)
 WHERE tbl_customer_address.state = 'TX'
   AND tbl_orders.price > 1000;
   


--11.	List all customers names along with their cities weather the customer has a city or not.
--Solution:
SELECT first_name, 
       last_name, 
       city
  FROM tbl_customers
  JOIN tbl_customer_address USING (customer_id);
  
  
  

--12.	List all customers with cancelled orders.
--Solution 1:
SELECT first_name,
       last_name,
       order_id,
       order_time,
       price,
       order_status
FROM tbl_customers
JOIN tbl_orders USING (customer_id)
WHERE order_status = 'cancell';
--Solution 2: 
          SELECT c.first_name,
                 c.last_name,
                 o.*
            FROM tbl_customers c
RIGHT OUTER JOIN tbl_orders o
              ON c.customer_id = o.customer_id
WHERE o.order_status = 'cancell';

--13.	List all vendors and their items (list vendors only who has items in the database.  Assume we have a separate table for vendors)
--Solution:
SELECT company_name, 
       contact_name, 
       part_number, 
       part_name
  FROM tbl_suppliers
  JOIN tbl_supply_details USING (supplier_id)
  JOIN tbl_parts USING (part_number);
  
  
  
  
--14.	List sales total per month 
--Solution:
  SELECT TO_CHAR(order_time, 'YYYY') year,
         TO_CHAR(order_time, 'MONTH') month,
         SUM(price) total_sales
    FROM tbl_orders
GROUP BY TO_CHAR(order_time, 'YYYY'), 
         TO_CHAR(order_time, 'MONTH'),
         TO_CHAR(order_time, 'MM')
ORDER BY TO_CHAR(order_time, 'YYYY'),
         TO_CHAR(order_time, 'MM');




--15.	List the customer with the highest order total
--Solution:
    SELECT c.*, 
           o.total
      FROM tbl_customers c
INNER JOIN (
            SELECT customer_id, 
                   sum(price) AS total
              FROM tbl_orders
          GROUP BY customer_id) o
                ON c.customer_id = o.customer_id
WHERE o.total = (SELECT max(sum(price)) 
                   FROM tbl_orders 
               GROUP BY customer_id);
               
               
 
--16.	List the address and name of the customers who placed at least 2 orders
--Solution:
    SELECT c.first_name, 
           c.last_name, 
           a.street_address,
           a.postal_code,
           a.city,
           a.state,
           a.address_type,
           o.order_numbers
      FROM tbl_customer_address a 
INNER JOIN tbl_customers c
        ON a.customer_id = c.customer_id 
      JOIN (
             SELECT COUNT(order_id) AS order_numbers, 
                    customer_id 
               FROM tbl_orders
           GROUP BY customer_id
           ORDER BY customer_id) o
       ON c.customer_id = o.customer_id
    WHERE order_numbers >= 2;





--17.	List the average order total for all customers from Chicago
--Solution:
    SELECT c.first_name, 
           c.last_name, 
           a.street_address,
           a.postal_code,
           a.city,
           a.state,
           o.average_price
      FROM tbl_customer_address a 
INNER JOIN tbl_customers c
        ON a.customer_id = c.customer_id 
      JOIN (
              SELECT customer_id,
                     avg(price) as average_price
                FROM tbl_orders
            GROUP BY customer_id
            ORDER BY customer_id) o
        ON c.customer_id = o.customer_id
    WHERE a.city = 'Chicago';

--18.	For each item list customers’ names who ordered it
--Solution:
SELECT part_number,
       part_name, 
       first_name,
       last_name
  FROM tbl_parts 
  JOIN tbl_part_details USING (part_number)
  JOIN tbl_orders USING (order_id)
  JOIN tbl_customers USING (customer_id);
  
  

--19.	List the number of orders for each state (customer’s state).
--Solution:
         SELECT a.state,
                COUNT(o.order_id) AS order_numbers
           FROM tbl_customer_address a 
LEFT OUTER JOIN tbl_orders o
             ON o.address_id = a.address_id 
       GROUP BY a.state
       ORDER BY a.state;



--20.	List the name of your favorite professor.
--Solution:
SELECT first_name, last_name
FROM course 
WHERE course_id = ‘ITM 422’

 
 