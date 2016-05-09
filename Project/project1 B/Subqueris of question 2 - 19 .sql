--SUBQUERY:

--2.	Select all customers with or without orders, for customers with orders list all order information
--Solutoin:

--3.	List customers with orders only.
--Solutoin 1:
SELECT *
  FROM tbl_customers
 WHERE EXISTS (
              SELECT order_id 
                FROM tbl_orders 
               WHERE tbl_customers.customer_id = tbl_orders.customer_id);

--Solution 2:
SELECT *
  FROM tbl_customers
 WHERE customer_id IN (
                      SELECT customer_id
                        FROM tbl_orders);

--4.	Find a Cartesian product of the customer and order tables
--Solution:
SELECT c.*,
       o.*
FROM tbl_customers c,
     (SELECT * FROM tbl_orders) o;

--5.	List all items that have not been ordered yet.
--Solution:
SELECT part_number,
       part_name
  FROM tbl_parts 
 WHERE part_number NOT IN (
                          SELECT part_number 
                            FROM tbl_part_details);

--6.	List all ordered items 
SELECT part_number,
       part_name
  FROM tbl_parts 
 WHERE part_number IN (
                      SELECT part_number 
                      FROM tbl_part_details);

--7.	List all orders that the customer did not pay for.
--Solution:
SELECT *
  FROM tbl_orders 
 WHERE order_id IN (
                    SELECT order_id
                      FROM tbl_payments 
                     WHERE paid_amount = 0);

--8.	List all orders paid with a check (assume you have a separate payment table)
--Solution: 
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
SELECT *
FROM tbl_parts 
WHERE part_number IN (
                      SELECT part_number
                        FROM tbl_part_details
                       WHERE order_id IN (
                                          SELECT order_id
                                            FROM tbl_orders
                                           WHERE order_time >= 
                                                   to_date('01-01-2014','dd-mm-yyyy') 
                                             AND order_time <= 
                                                   to_date('31-01-2014','dd-mm-yyyy')
                                           )
                      );

--10.	List customer names and phone numbers from Texas with orders over $1000.
--Solution:
SELECT *
FROM tbl_customers 
WHERE customer_id IN (
                      SELECT customer_id
                        FROM tbl_customer_address
                       WHERE tbl_customer_address.state = 'TX'
                      )
  AND customer_id IN (
                      SELECT customer_id
                        FROM tbl_orders
                       WHERE tbl_orders.price > 1000
                      );                       
 
--11.	List all customers names along with their cities weather the customer has a city or not.
--Solution:
 
--12.	List all customers with cancelled orders.
--Solution: 
SELECT first_name, last_name
  FROM tbl_customers
 WHERE customer_id IN ( 
                       SELECT customer_id
                         FROM tbl_orders
                        WHERE order_status = 'cancell');


--13.	List all vendors and their items (list vendors only who has items in the database.  Assume we have a separate table for vendors)
--Solution:
 
--14.	List sales total per month 
--Solution:

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

--19.	List the number of orders for each state (customer’s state).
--Solution:
    
    