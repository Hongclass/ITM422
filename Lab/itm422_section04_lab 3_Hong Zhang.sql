/*Oracle Lab 3*/

CREATE OR REPLACE TRIGGER EMPLOYEES_BEF_INS 
BEFORE INSERT ON EMPLOYEES 
FOR EACH ROW   
DECLARE 
  rowcont number;
BEGIN
  SELECT COUNT(*) 
  INTO rowcont 
  FROM departments 
  WHERE department_id = :new.department_id;
  IF rowcont = 0 THEN
  SP_DEPARTMENTS (:NEW.department_id, 'Unknown', null, null);
  END IF;
END;
/

/*Test it*/
BEGIN
  SP_EMPLOYEES (209, 'Hong', 'Zhang', 'HZHAN', '17-JUN-13', 'AD_PRES', 300, 13000);
END;

