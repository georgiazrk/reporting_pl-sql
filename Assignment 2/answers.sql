/* ------------ 1.1 ------------ */

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\qone-one.csv';

DECLARE
    CURSOR prod_cursor IS SELECT customers.C_ID, customers.C_FNAME, customers.C_LNAME, customers.C_ADDRESS3, 
    sales_purchases.V_REGNO, vehicles.v_make, vehicles.v_model,lu_colours.c_colour,sales_purchases.SP_Total 
    from CUSTOMERS 
    inner join SALES_PURCHASES on customers.C_ID = sales_purchases.C_ID 
    inner join VEHICLES on sales_purchases.V_REGNO = vehicles.V_REGNO
    inner join LU_COLOURS on vehicles.C_NO = Lu_colours.C_NO;

prod_row    prod_cursor%ROWTYPE; 
BEGIN
DBMS_OUTPUT.PUT_LINE('ID,' || 'FirstName,' || 'Lastname,' || 'City,' || 'VehicleReg,' || 'Make,' || 'Model,' || 'Colour,' || 'SP_Total');
FOR prod_row IN prod_cursor
Loop
dbms_output.put_line(prod_row.c_id || ',' || prod_row.c_fname || ',' || prod_row.c_lname || ',' || prod_row.c_address3 || ',' || prod_row.v_regno || ',' || prod_row.v_make || ',' || prod_row.v_model || ',' || prod_row.c_colour || ',' || prod_row.sp_total);
end loop;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/
SET SERVEROUTPUT OFF;

/* ------------ 1.2. ------------ */

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qone-two.csv';

DECLARE
    CURSOR purch_cursor IS SELECT sales_purchases.sp_invoice, customers.c_id, customers.C_FNAME, customers.C_LNAME, customers.C_PH, 
    sales_purchases.V_REGNO, vehicles.v_make, vehicles.v_model, vehicles.v_year, sales_persons.SP_ID, sales_persons.SP_Fname, sales_persons.sp_lname,
    sales_persons.sp_sup
    from SALES_PURCHASES 
    inner join CUSTOMERS on sales_purchases.C_ID = customers.C_ID
    inner join VEHICLES on sales_purchases.V_REGNO = vehicles.V_REGNO
    inner join SALES_PERSONS on sales_purchases.sp_id = sales_persons.sp_id;

purch_row    purch_cursor%ROWTYPE; 
BEGIN
DBMS_OUTPUT.PUT_LINE('InvoiceNumber,' || 'CustomerID,' || 'CustFirstName,' || 'CustLastName,' || 'CustPhone,' || 'RegNo,' || 'Make,' || 'Model,' || 'Year,' || 'SalesPersonID,' || 'SPFirstName,' || 'SPLastName,' || 'SPSupervisorCode');
FOR purch_row IN purch_cursor
Loop
dbms_output.put_line(purch_row.sp_invoice || ',' || purch_row.c_id || ',' || purch_row.c_fname || ',' || purch_row.c_lname || ',' || purch_row.c_ph || ',' || purch_row.v_regno || ',' || purch_row.v_make || ',' || purch_row.v_model || ',' || purch_row.v_year || ',' || purch_row.sp_id || ',' || purch_row.sp_fname || ',' || purch_row.sp_lname || ',' || purch_row.sp_sup);
end loop;
EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line(SQLERRM);
END;
/
SET SERVEROUTPUT OFF;

/* ------------ 2.1 ------------ */

CREATE OR REPLACE PROCEDURE SalesByMake(
    IN_V_MAKE IN VEHICLES.V_MAKE%TYPE
)
IS
CURSOR vmake_cursor IS SELECT VEHICLES.V_MAKE, VEHICLES.V_MODEL, VEHICLES.V_REGNO
FROM VEHICLES
WHERE VEHICLES.V_MAKE = IN_V_MAKE;

vmake_row    vmake_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('MAKE,' || 'MODEL,' || 'REGNUM');
    for vmake_row in vmake_cursor loop
    dbms_output.put_line(vmake_row.V_MAKE || ',' || vmake_row.V_MODEL || ',' ||  vmake_row.V_REGNO);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE SalesByModel(
    IN_V_MODEL IN VEHICLES.V_MODEL%TYPE
)
IS
CURSOR vmodel_cursor IS SELECT VEHICLES.V_MAKE, VEHICLES.V_MODEL, VEHICLES.V_REGNO
FROM VEHICLES
WHERE VEHICLES.V_Model = IN_V_Model;

vmodel_row    vmodel_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('MAKE,' || 'MODEL,' || 'REGNUM');
    for vmodel_row in vmodel_cursor loop
    dbms_output.put_line(vmodel_row.V_MAKE || ',' || vmodel_row.V_MODEL || ',' ||  vmodel_row.V_REGNO);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qtwo-one.CSV';
ACCEPT vehicle_mm CHAR PROMPT 'Enter vehicle make or model: ';
EXECUTE salesByMake('&vehicle_mm');
EXECUTE salesByModel('&vehicle_mm');
SPOOL OFF;
SET SERVEROUTPUT OFF;

------------------------------------- OR QUERY ON ITEMS ----------------------------------------

CREATE OR REPLACE PROCEDURE SalesByMake(
    IN_I_MAKE IN ITEMS.I_MAKE%TYPE
)
IS
CURSOR imake_cursor IS SELECT ITEMS.I_MAKE, ITEMS.I_MODEL, ITEMS.I_YEAR, ITEMS.I_PRICE
FROM ITEMS
WHERE ITEMS.I_MAKE = IN_I_MAKE;

imake_row    imake_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('Make,' || 'Model,' || 'Year,' || 'Price');
    for imake_row in imake_cursor loop
    DBMS_OUTPUT.PUT_LINE(imake_row.i_make || ',' || imake_row.i_model || ',' ||  imake_row.i_year || ',' || imake_row.i_price);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE SalesByModel(
    IN_I_MODEL IN ITEMS.I_MODEL%TYPE
)
IS
CURSOR imodel_cursor IS SELECT ITEMS.I_MAKE, ITEMS.I_MODEL, ITEMS.I_YEAR, ITEMS.I_PRICE
FROM ITEMS
WHERE ITEMS.i_model = IN_I_MODEL;

imodel_row    imodel_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('Make,' || 'Model,' || 'Year,' || 'Price');
    for imodel_row in imodel_cursor loop
    DBMS_OUTPUT.PUT_LINE(imodel_row.i_make || ',' || imodel_row.i_model || ',' ||  imodel_row.i_year || ',' || imodel_row.i_price);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qtwo-one.CSV';
ACCEPT vehicle_mm CHAR PROMPT 'Enter vehicle make or model: ';
EXECUTE salesByMake('&vehicle_mm');
EXECUTE salesByModel('&vehicle_mm');
SPOOL OFF;
SET SERVEROUTPUT OFF;

/* ------------ 2.2 ------------ */

CREATE OR REPLACE PROCEDURE SalesReport(
    IN_START_DATE IN SALES_PURCHASES.SP_DATESOLD%TYPE,
    IN_END_DATE IN SALES_PURCHASES.SP_DATESOLD%TYPE
)
IS
CURSOR sp_cursor IS SELECT SALES_PURCHASES.SP_INVOICE, SALES_PURCHASES.SP_DATESOLD, SALES_PURCHASES.SP_TOTAL, SALES_PURCHASES.C_ID, SALES_PURCHASES.SP_ID, SALES_PURCHASES.V_REGNO
FROM SALES_PURCHASES
WHERE SALES_PURCHASES.SP_DATESOLD BETWEEN IN_START_DATE AND IN_END_DATE;

sp_row    sp_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('InvoiceNum,' || 'DateSold,' || 'TotalCost,' || 'CustID,' || 'SupervisorID,' || 'VehicleRegNum');
    for sp_row in sp_cursor loop
    dbms_output.put_line(sp_row.sp_invoice || ',' || sp_row.sp_datesold || ',' ||  sp_row.sp_total || ',' || sp_row.c_id || ',' || sp_row.sp_id || ',' || sp_row.v_regno);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qtwo-two.CSV';
ACCEPT start_date DATE PROMPT 'Enter start date: ';
ACCEPT end_date DATE PROMPT 'Enter end date: ';
EXECUTE SalesReport('&start_date', '&end_date');
SPOOL OFF;
SET SERVEROUTPUT OFF;

/* ------------ 2.3 ------------ */

CREATE OR REPLACE PROCEDURE SearchById(
    IN_CUST_ID IN CUSTOMERS.C_ID%TYPE
)
IS
CURSOR id_cursor IS SELECT CUSTOMERS.C_ID, CUSTOMERS.C_FNAME, CUSTOMERS.C_LNAME, SALES_PURCHASES.SP_TOTAL, SALES_PURCHASES.SP_ID, VEHICLES.V_MAKE, VEHICLES.V_MODEL, VEHICLES.V_YEAR, SALES_PURCHASES.V_REGNO
FROM CUSTOMERS
INNER JOIN SALES_PURCHASES on CUSTOMERS.C_ID = SALES_PURCHASES.C_ID
INNER JOIN VEHICLES on CUSTOMERS.C_ID = VEHICLES.C_NO
WHERE CUSTOMERS.C_ID = IN_CUST_ID;

id_row    id_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('CustomerID,' || 'FirstName,' || 'LastName,' || 'Total,' || 'SupervisorID,' || 'VehicleMake,' || 'VehicleModel,' || 'VehicleYear,' || 'VehicleRegNum');
    for id_row in id_cursor loop
    dbms_output.put_line(id_row.c_id || ',' || id_row.c_fname || ',' ||  id_row.c_lname || ',' || id_row.sp_total || ',' || id_row.sp_id || ',' || id_row.v_make || ',' || id_row.v_model || ',' || id_row.v_year || ',' || id_row.v_regno);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE SearchByLName(
    IN_CUST_LNAME IN CUSTOMERS.C_LNAME%TYPE
)
IS
CURSOR ln_cursor IS SELECT CUSTOMERS.C_ID, CUSTOMERS.C_FNAME, CUSTOMERS.C_LNAME, SALES_PURCHASES.SP_TOTAL, SALES_PURCHASES.SP_ID, VEHICLES.V_MAKE, VEHICLES.V_MODEL, VEHICLES.V_YEAR, SALES_PURCHASES.V_REGNO
FROM CUSTOMERS
INNER JOIN SALES_PURCHASES on CUSTOMERS.C_ID = SALES_PURCHASES.C_ID
INNER JOIN VEHICLES on CUSTOMERS.C_ID = VEHICLES.C_NO
WHERE CUSTOMERS.C_LNAME = IN_CUST_LNAME;

ln_row    ln_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('CustomerID,' || 'FirstName,' || 'LastName,' || 'Total,' || 'SupervisorID,' || 'VehicleMake,' || 'VehicleModel,' || 'VehicleYear,' || 'VehicleRegNum');
    for ln_row in ln_cursor loop
    dbms_output.put_line(ln_row.c_id || ',' || ln_row.c_fname || ',' ||  ln_row.c_lname || ',' || ln_row.sp_total || ',' || ln_row.sp_id || ',' || ln_row.v_make || ',' || ln_row.v_model || ',' || ln_row.v_year || ',' || ln_row.v_regno);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qtwo-three.CSV';
ACCEPT id_input NUM PROMPT 'Enter customer ID: ';
ACCEPT lname_input CHAR PROMPT 'Enter customer Last Name: ';
EXECUTE SearchById(&id_input);
EXECUTE SearchByLName('&lname_input');
SPOOL OFF;
SET SERVEROUTPUT OFF;



/* ------------ 2.4 ------------ */

CREATE OR REPLACE PROCEDURE Payment(
    IN_START_DATE IN PAYMENTS.P_DATE%TYPE,
    IN_END_DATE IN PAYMENTS.P_DATE%TYPE
)
IS
CURSOR p_cursor IS SELECT *
FROM PAYMENTS
WHERE PAYMENTS.P_DATE BETWEEN IN_START_DATE AND IN_END_DATE;

p_row    p_cursor%ROWTYPE;
rec_output  varchar(200);

BEGIN
    DBMS_OUTPUT.PUT_LINE('InvoiceNum,' || 'DatePaid,' || 'AmountPaid,' || 'CustID,' || 'SalesPurchaseInvoice');
    for p_row in p_cursor loop
    dbms_output.put_line(p_row.p_invoice || ',' || p_row.p_date || ',' ||  p_row.p_amount || ',' || p_row.c_id || ',' || p_row.sp_invoice);
    end loop;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qtwo-four.CSV';
ACCEPT start_date DATE PROMPT 'Enter start date: ';
ACCEPT end_date DATE PROMPT 'Enter end date: ';
EXECUTE Payment('&start_date', '&end_date');
SPOOL OFF;
SET SERVEROUTPUT OFF;

/* ------------ 3.1 ------------ */

CREATE OR REPLACE FUNCTION NumberOfDays (
	in_start_date IN DATE,
    in_end_date IN DATE
) RETURN NUMBER
IS
	days NUMBER;
BEGIN
	days := TRUNC (in_end_date - in_start_date);
	RETURN days;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SET sqlformat ansiconsole;
ACCEPT start_date DATE PROMPT 'Enter a start date: ';
ACCEPT end_date DATE PROMPT 'Enter an end date: ';
PROMPT Number of Days Between two dates:
EXECUTE dbms_output.put_line(NumberOfDays('&start_date', '&end_date'));


/* ------------ 3.2 ------------ */ 

CREATE OR REPLACE FUNCTION NumberOfDays (
	in_start_date IN DATE,
    in_end_date IN DATE
) RETURN NUMBER
IS
	days NUMBER;
BEGIN
	days := TRUNC (in_end_date - in_start_date);
	RETURN days;
EXCEPTION
	WHEN OTHERS THEN
		DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

SET SERVEROUTPUT ON;
SPOOL 'C:\Users\GGPC\Documents\Wintec\Data Modelling and SQL\spools\qthree-two.CSV';

DECLARE
	CURSOR days_cursor IS
		SELECT O_ID, O_DATE, O_TOTALQTY, O_TOTAL FROM ORDERS;
	days_row	days_cursor%ROWTYPE;	
BEGIN
    DBMS_OUTPUT.PUT_LINE('OrderID,' || 'OrderDate,' || 'TotalQty,' || 'OrderTotal,' || 'NumberOfDays');
	FOR days_row IN days_cursor LOOP
		DBMS_OUTPUT.PUT_LINE(
            days_row.O_ID || ',' ||
            days_row.O_DATE || ',' ||
            days_row.O_TOTALQTY || ',' ||
            days_row.O_TOTAL || ',' ||
            NumberOfDays(days_row.o_date, SYSDATE));
	END LOOP;
END;
/
SET SERVEROUTPUT OFF;

/* ------------ 4.1 ------------ */

CREATE OR REPLACE PROCEDURE AddPurchaseSale (
    in_sp_datesold IN sales_purchases.sp_datesold%TYPE,
    in_sp_deposit IN sales_purchases.sp_deposit%TYPE,
    in_sp_id IN sales_purchases.sp_id%TYPE,
    in_c_id IN sales_purchases.c_id%TYPE,
    in_v_regno IN sales_purchases.v_regno%TYPE
)
IS

max_inv NUMBER;

BEGIN
    INSERT INTO sales_purchases(sp_datesold, sp_saleprice, sp_deposit, sp_id, c_id, v_regno) SELECT in_sp_datesold, 
    vehicles.v_price, in_sp_deposit, in_sp_id, in_c_id, in_v_regno 
    FROM vehicles 
    WHERE vehicles.v_regno = in_v_regno;
    
    SELECT MAX(sp_invoice)
    INTO max_inv
    FROM sales_purchases;
    
    UPDATE sales_purchases SET sp_addncost = sp_saleprice * 0.2
    WHERE sp_invoice = max_inv;
    UPDATE sales_purchases SET sp_total = (sp_saleprice + sp_addncost) - sp_deposit
    WHERE sp_invoice = max_inv;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        ROLLBACK;
END;
/

SELECT * FROM SALES_PURCHASES;

EXECUTE AddPurchaseSale('08/06/22', 1000, 'MK201', 10, 'LOL201');

SELECT * FROM SALES_PURCHASES;

ROLLBACK;


/* ------------ 4.2 ------------ */

CREATE OR REPLACE PROCEDURE AddPurchaseOrderItem (
    in_o_id IN order_lines.o_id%TYPE,
    in_ol_qty IN order_lines.ol_qty%TYPE,
    in_i_num IN order_lines.i_no%TYPE

)
IS

max_id NUMBER;

BEGIN

    INSERT INTO order_lines(o_id, i_no, i_make, i_model, i_price, i_year, ol_qty) 
    SELECT in_o_id, in_i_num, items.i_make, items.i_model, items.i_price, items.i_year, in_ol_qty 
    FROM items 
    WHERE items.i_no = in_i_num;
    
    SELECT MAX(o_id)
    INTO max_id
    FROM orders;
    
    UPDATE order_lines SET ol_subtotal = ol_qty * i_price
    WHERE o_id = max_id;
    
    UPDATE orders SET o_total = (SELECT SUM (ol_subtotal) FROM order_lines WHERE orders.o_id = order_lines.o_id)
    WHERE o_id = max_id;
    
    UPDATE orders SET o_totalqty = (SELECT SUM (ol_qty) FROM order_lines WHERE orders.o_id = order_lines.o_id)
    WHERE o_id = max_id;
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
        ROLLBACK;
END;
/

SELECT * FROM ORDERS;

INSERT INTO orders (o_date, s_code, sp_id) VALUES (TO_DATE('08-Jun-2022','dd-mm-yyyy'),'XTRQC','MK201');

SELECT * FROM ORDERS;

EXECUTE AddPurchaseOrderItem(80000023, 2, 12);

SELECT * FROM ORDERS;
SELECT * FROM ORDER_LINES;

ROLLBACK;

/* ------------ 5.1 ------------ */

CREATE OR REPLACE TRIGGER trg_check_supervisor
	BEFORE INSERT OR UPDATE ON sales_persons
FOR EACH ROW
DECLARE
	num_sup NUMBER;
BEGIN
    SELECT COUNT(sp_sup) INTO num_sup
	FROM sales_persons
	WHERE sp_sup = :NEW.sp_sup;

	-- Enforce Business Rule
	IF num_sup >= 2 THEN
		RAISE_APPLICATION_ERROR(-20000,'INSERT DENIED: Supervisor allocated too many staff members');
	END IF;
END trg_check_supervisor;
/
ALTER TRIGGER trg_check_supervisor ENABLE;

INSERT INTO sales_persons (sp_id, sp_fname, sp_lname, sp_startdate, sp_cellph, sp_comrate, sp_sup) VALUES ('GR345', 'Georgia', 'Robinson', '08-Jun-22', '0212145661', 0.15, 'MK201');

INSERT INTO sales_persons (sp_id, sp_fname, sp_lname, sp_startdate, sp_cellph, sp_comrate, sp_sup) VALUES ('MG123', 'Michael', 'Grant', '07-Jun-22', '0213445661', 0.25, 'KK634');
INSERT INTO sales_persons (sp_id, sp_fname, sp_lname, sp_startdate, sp_cellph, sp_comrate, sp_sup) VALUES ('IH765', 'Ivan', 'Heaslip', '09-Jun-22', '0219567661', 0.05, 'KK634');

ROLLBACK;