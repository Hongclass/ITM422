/****************************
 * EmployeesSetup.sql
 * CIS-2720
 *
 * Creates an Employee table and a dependents table
 ****************************/


DROP TABLE dependents;

DROP TABLE employees;
   
CREATE TABLE employees (
	emp_id NUMBER(8,0) NOT NULL,
	last_name VARCHAR2(30) NOT NULL,
	first_name VARCHAR2(30) NOT NULL,
	birthdate DATE NOT NULL,
	ssn NUMBER(9,0) NOT NULL,
	employee_nbr NUMBER(6,0) NOT NULL
);


ALTER TABLE employees
	ADD CONSTRAINT pk_employees PRIMARY KEY (emp_id);


ALTER TABLE employees
	ADD CONSTRAINT uc_employees_ssn  UNIQUE (ssn);



ALTER TABLE employees
	ADD CONSTRAINT uc_employees_employeeNbr  UNIQUE (employee_nbr);



CREATE TABLE dependents (
	emp_id NUMBER(8,0) NOT NULL,
	dependent_nbr NUMBER(3,0) NOT NULL,
	last_name VARCHAR2(30) NOT NULL,
	first_name VARCHAR2(30) NOT NULL,
	birthdate DATE NOT NULL,
	ssn NUMBER(9,0) NOT NULL
);

ALTER TABLE dependents
	ADD CONSTRAINT pk_Dependents PRIMARY KEY (emp_id,dependent_nbr);


ALTER TABLE dependents
	ADD CONSTRAINT uc_Dependents_SSN  UNIQUE (ssn);



ALTER TABLE dependents 
	ADD CONSTRAINT fk_Dependents_Employees 
	FOREIGN KEY (emp_id) 
	REFERENCES employees (emp_id);




 
INSERT INTO employees VALUES (1,'Olivarez','Angela','6-NOV-1954',477115334,5198);
INSERT INTO employees VALUES (2,'Slayton','Samuel','12-OCT-1985',211526453,3354);
INSERT INTO employees VALUES (3,'Pooler','Andrea','15-JAN-1964',629987882,9387);
INSERT INTO employees VALUES (4,'Brown','Bobette','15-MAY-1954',368086454,807);
INSERT INTO employees VALUES (5,'Carroll','Robert','23-JAN1950',764440042,8096);
INSERT INTO employees VALUES (6,'Drinnon','Albert','18-MAY-1982',213327924,1184);
INSERT INTO employees VALUES (7,'Cedeno','James','30-JAN-1971',325226620,7526);
INSERT INTO employees VALUES (8,'McKenzie','Madeline','20-MAY-1942',437328348,8422);
INSERT INTO employees VALUES (9,'Ely','Charles','11-JUN-1951',354942680,8841);

	 

INSERT INTO dependents VALUES (1,1,'Green','Paula','26-MAY-1949',220181048);
INSERT INTO dependents VALUES (1,2,'Culp','Jessica','26-FEB-1971',647167285);
INSERT INTO dependents VALUES (4,1,'Hoffman','Frederic','17-APR-1950',452318014);
INSERT INTO dependents VALUES (4,2,'Short','Irene','25-SEP-1959',495769883);
INSERT INTO dependents VALUES (4,3,'Davis','Maritza','8-NOV-1942',320326770);
INSERT INTO dependents VALUES (4,4,'Toler','John','24-JUN-1950',466696198);
INSERT INTO dependents VALUES (6,1,'Passmore','Daryl','25-SEP-1943',527436142);
INSERT INTO dependents VALUES (7,1,'Thompson','Adrianna','22-JAN-1960',319407853);
INSERT INTO dependents VALUES (8,1,'Rivas','Diane','13-JAN-1946',439392918);
INSERT INTO dependents VALUES (8,2,'Campos','Karen','15-MAR1975',515467254); 
INSERT INTO dependents VALUES (8,4,'Smith','Suzanne','19-FEB-1979',589224304);
INSERT INTO dependents VALUES (8,3,'Hall','John','18-AUG-1970',498066149);
INSERT INTO dependents VALUES (8,5,'Little','Eric','3-APR-1985',296187483);
INSERT INTO dependents VALUES (9,1,'Coe','Brandi','13-JUN-s1979',402327740);


COMMIT;
