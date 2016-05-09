--create package
CREATE OR REPLACE PACKAGE pkg_natural_join
AS 
    PROCEDURE sp_natural_join;
END;
/

--create package body
CREATE OR REPLACE PACKAGE BODY pkg_natural_join
AS
PROCEDURE sp_natural_join
    AS
       CURSOR a_cursor IS
           SELECT * FROM tbl_customer_address
     ORDER BY customer_id;
  r_a a_cursor%ROWTYPE;
  CURSOR b_cursor IS
     SELECT * FROM tbl_customers
     WHERE customer_id = r_a.customer_id
     ORDER BY customer_id;
    r_b b_cursor%ROWTYPE;
  BEGIN
     OPEN a_cursor;
     LOOP
       FETCH a_cursor INTO r_a;
       EXIT WHEN a_cursor%NOTFOUND;
       IF b_cursor%ISOPEN THEN
         CLOSE b_cursor;
       END IF;
       OPEN b_cursor;
       LOOP
         FETCH b_cursor INTO r_b;
         EXIT WHEN b_cursor%NOTFOUND;
       END LOOP;
       IF r_a.customer_id = r_b.customer_id THEN
       DBMS_OUTPUT.put_line ('customer_id: ' ||r_b.customer_id ||' first_name: ' || r_b. first_name ||
                             ' last_name: '||r_b.last_name ||' email: '||r_b.email ||
                             ' phone_number: '||r_b.phone_number ||' fax: '||r_b.fax ||
                             ' address_id: '||r_a.address_id ||' street_address: '||r_a.street_address ||
                             ' postal_code: '||r_a.postal_code ||' city: '||r_a.city ||
                             ' state: '||r_a.state ||' address_type: '||r_a.address_type);
       END IF;
       CLOSE b_cursor;
     END LOOP;
     CLOSE a_cursor;
     EXCEPTION
     WHEN OTHERS THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END sp_natural_join;
END pkg_natural_join;

--create package
CREATE OR REPLACE PACKAGE pkg_left_join
AS 
    PROCEDURE sp_left_join;
END;
/

--create package body
CREATE OR REPLACE PACKAGE BODY pkg_left_join
AS
PROCEDURE sp_left_join
    AS
       CURSOR a_cursor IS
           SELECT * FROM tbl_customer_address
     ORDER BY customer_id;
  r_a a_cursor%ROWTYPE;
  CURSOR b_cursor IS
     SELECT * FROM tbl_customers
     WHERE customer_id = r_a.customer_id
     ORDER BY customer_id;
    r_b b_cursor%ROWTYPE;
  BEGIN
     OPEN a_cursor;
     LOOP
       FETCH a_cursor INTO r_a;
       EXIT WHEN a_cursor%NOTFOUND;
       IF b_cursor%ISOPEN THEN
         CLOSE b_cursor;
       END IF;
       OPEN b_cursor;
       LOOP
         FETCH b_cursor INTO r_b;
         EXIT WHEN b_cursor%NOTFOUND;
       END LOOP;
       IF r_a.customer_id = r_b.customer_id THEN
       DBMS_OUTPUT.put_line ('customer_id: ' ||r_b.customer_id ||' first_name: ' || r_b. first_name ||
                             ' last_name: '||r_b.last_name ||' email: '||r_b.email ||
                             ' phone_number: '||r_b.phone_number ||' fax: '||r_b.fax ||
                             ' address_id: '||r_a.address_id ||'customer_id: ' ||r_b.customer_id ||
                             ' street_address: '||r_a.street_address ||
                             ' postal_code: '||r_a.postal_code ||' city: '||r_a.city ||
                             ' state: '||r_a.state ||' address_type: '||r_a.address_type);
       ELSE
       DBMS_OUTPUT.put_line ('customer_id: ' ||r_b.customer_id ||' first_name: ' || r_b. first_name ||
                             ' last_name: '||r_b.last_name ||' email: '||r_b.email ||
                             ' phone_number: '||r_b.phone_number ||' fax: '||r_b.fax );
       END IF;
       CLOSE b_cursor;
     END LOOP;
     CLOSE a_cursor;
     EXCEPTION
     WHEN OTHERS THEN raise_application_error(-20001,'An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
END sp_left_join;
END pkg_left_join;

