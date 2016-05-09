CREATE TABLE Invoice
(
INVOICE_NUMBER      NUMBER(9) NOT NULL,
INVOICE_DATE        DATE NOT NULL,
CLIENT_ID           NUMBER(9)     NOT NULL,
INVOICE_AMT         NUMBER(9,2) DEFAULT 0 NOT NULL,
PAID_FLAG           NUMBER(1) DEFAULT 0 NOT NULL,
CONSTRAINT PK_INVOICE PRIMARY KEY(INVOICE_NUMBER)
);
/

CREATE SEQUENCE INVOICE_SEQ
START WITH 1
CACHE 100;

INSERT INTO INVOICE(Invoice_Number, Invoice_date, client_ID, Invoice_Amt)
VALUES(INVOICE_SEQ.NEXTVAL, sysdate,101,1100.00);

INSERT INTO INVOICE(Invoice_Number, Invoice_date, client_ID, Invoice_Amt)
VALUES(INVOICE_SEQ.NEXTVAL, sysdate,102,1100.00);

INSERT INTO INVOICE(Invoice_Number, Invoice_date, client_ID, Invoice_Amt)
VALUES(INVOICE_SEQ.NEXTVAL, sysdate,103,1100.00);

INSERT INTO INVOICE(Invoice_Number, Invoice_date, client_ID, Invoice_Amt)
VALUES(INVOICE_SEQ.NEXTVAL, sysdate,104,1100.00);

/* Create package */
CREATE OR REPLACE PACKAGE types
AS
type cursorType is ref cursor;
END;
/

CREATE OR REPLACE PROCEDURE DEC_RTN_RECORDSET
(
p_InvoiceDate      IN   DATE,
p_ResultSet        OUT  TYPES.cursorType
)
AS
BEGIN
OPEN p_ResultSet FOR
SELECT Invoice_Number, Invoice_Date, Client_ID, Invoice_Amt
FROM Invoice
WHERE Invoice_date <= p_InvoiceDate
ORDER BY Invoice_number;

END DEC_RTN_RECORDSET;
/

VARIABLE resultSet  REFCURSOR
EXEC DEC_RTN_RECORDSET(sysdate, :resultSet);
PRINT :resultSet;
