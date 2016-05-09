/*1.	Create a stored procedure (name it sp_employees) 
that will insert a record into the employees table. 
This SP should take as arguments: 
o	EMPLOYEE ID, 
o	EMPLOYEE NAME, 
o	DEPARTMENT ID,
o	SALARY of the employee.
*/
CREATE OR REPLACE PROCEDURE SP_EMPLOYEES (
        p_employee_id IN employees.employee_id%TYPE,
        p_first_name IN employees.first_name%TYPE,
        p_last_name IN employees.last_name%TYPE,
        P_email IN employees.email%TYPE,
        P_hire_date IN employees.hire_date%TYPE,
        P_job_id IN employees.job_id%TYPE,
        p_department_id IN employees.department_id%TYPE,
        p_salary IN employees.salary%TYPE)
AS 
BEGIN
  INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, department_id, salary)
  VALUES (p_employee_id, p_first_name, p_last_name, p_email, p_hire_date, p_job_id, p_department_id, p_salary);
END SP_EMPLOYEES;
/

/*Call it:*/
BEGIN
  SP_EMPLOYEES (207, 'Hong', 'Zhang', 'HZHANG', '17-JUN-13', 'AD_PRES', 90, 13000);
END;

/*2.	Create a stored procedure (name it sp_departments) 
that will insert a record into the department table. 
This SP should take as arguments: 
o	DEPARTMENT_ID 
o	DEPARTMENT_ NAME, 
o	MANAGER_ID, 
o	LOCATION_ID
*/
create or replace PROCEDURE SP_DEPARTMENTS(
     p_department_id IN departments.department_id%TYPE,
	   p_department_name IN departments.department_name%TYPE,
	   p_manager_id IN departments. manager_id%TYPE,
	   p_location_id IN departments.location_id%TYPE
) AS 
BEGIN
  INSERT INTO departments 
                 (department_id, department_name, manager_id, location_id)
  VALUES (p_department_id, p_department_name, p_manager_id, p_location_id);
END SP_DEPARTMENTS;
/

/*Call it:*/
BEGIN
  SP_DEPARTMENTS (280, 'hr', null, 1700);
END;
    
/*3.	Create a stored procedure (name it sp_emps_dep) 
to list all employees in a certain department (pick one)
*/
--Solution 1: 
CREATE OR REPLACE PROCEDURE SP_EMPS_DEP 
AS 
BEGIN
  FOR emps IN (SELECT * FROM employees WHERE department_id = 50)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Employee_name: ' || emps.first_name 
                                      ||' '|| emps.last_name);
  END LOOP;
END SP_EMPS_DEP;
/

/*Call it:*/
BEGIN
  SP_EMPS_DEP;
END;

--Solution 2:
CREATE OR REPLACE PROCEDURE SP_EMPS_DEP 
  (p_depart IN employees.department_id%TYPE,
   o_first_name OUT employees.first_name%TYPE,
   o_last_name OUT employees.last_name%TYPE)
AS 
  CURSOR c1 IS
    SELECT first_name, last_name 
    FROM employees 
    WHERE department_id = p_depart;
BEGIN
  OPEN c1;
  LOOP
  FETCH c1 INTO o_first_name, o_last_name;
    EXIT WHEN c1%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE('First name = ' || o_first_name ||', Last name = ' || o_last_name);
  END LOOP;
  CLOSE c1;
END SP_EMPS_DEP;
/

/*Call it:*/
DECLARE
o_first_name employees.first_name%TYPE;
o_last_name employees.last_name%TYPE;
BEGIN
  SP_EMPS_DEP(90, o_first_name, o_last_name);
END;

--Solution 3:
/* Create package */
CREATE OR REPLACE PACKAGE types
AS
type cursorType is ref cursor;
END;
/

/* Create procedure*/
CREATE OR REPLACE PROCEDURE SP_EMPS_DEP 
  (p_depart      IN NUMBER,
  p_ResultSet  OUT  TYPES.cursorType)
AS 
BEGIN
OPEN p_ResultSet FOR
    SELECT employee_id, first_name, last_name, department_id 
    FROM employees 
    WHERE department_id = p_depart
    ORDER BY employee_id;
END SP_EMPS_DEP;    
/

/*Call it:*/
VARIABLE resultSet  REFCURSOR
EXEC SP_EMPS_DEP(50, :resultSet);
PRINT :resultSet;
