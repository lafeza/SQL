SELECT * FROM public."Customer"

copy public."Customer" from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Captsone Project\Microfinance Table 1.csv' delimiter ',' csv header;

--creating Banktransactions Table
create table Banktransactions_Table(
transactions_id VARCHAR,
cutomer_id INT,
transaction_date date,
transaction_type VARCHAR,
transaction_detail VARCHAR,
amount INT,
status VARCHAR);

select * from Banktransactions_table
order by transaction_date desc;
	

--Importing data into the Banktransaction table
copy public.banktransactions_table
from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Captsone Project\banktransactions table.csv'
delimiter ',' csv header;

--making transaction id the primary key of the category table
alter table banktransactions_table add constraint cutomer_pkey primary key (cutomer_id); 

--creating loans tracking Table
create table loans_tracking(
loan_id VARCHAR,
loan_date date,
customer_id INT,
amount INT,
due_date date);

--Importing data into the loan tracking table
copy public.loans_tracking
from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Captsone Project\loans tracking.csv'
delimiter ',' csv header;

select * from loans_tracking



--creating loans payment Table
create table loan_payment(
payment_id VARCHAR,
loan_id VARCHAR,
payment_date date);

select * from loan_payment 

--Importing data into the loan payment table
copy public.loan_payment
from 'C:\Users\LENOVO\Desktop\Lafeza\Amdor Analytics\SQL Training\Captsone Project\loan payment.csv'
delimiter ',' csv header;

--Query to categorize payment into ontime, late or overdue payment


SELECT 
    lt.due_date, 
    lp.payment_date,
    CASE 
        WHEN lp.payment_date <= lt.due_date THEN 'On_time'
        WHEN lp.payment_date > lt.due_date THEN 'late_payment'     
        ELSE 'overdue'
    END AS payment_category
FROM 
    loans_tracking lt
JOIN 
    loan_payment lp ON lt.loan_id = lp.loan_id;

SELECT 
    lt.loan_id,
    lt.due_date, 
    lp.payment_date,
    'overdue' AS payment_category
FROM 
    loans_tracking lt
JOIN 
    loan_payment lp ON lt.loan_id = lp.loan_id
WHERE 
    lp.payment_date > lt.due_date;

select
count (case WHEN lp.payment_date <= lt.due_date THEN 'On_time' end) as on_time,
count (case WHEN lp.payment_date > lt.due_date THEN 'late_payment' end) as late_payment
FROM loans_tracking lt;

SELECT
    SUM(CASE WHEN lp.payment_date <= lt.due_date THEN 1 ELSE 0 END) AS on_time,
    SUM(CASE WHEN lp.payment_date > lt.due_date THEN 1 ELSE 0 END) AS late_payment
FROM 
    loans_tracking lt
JOIN 
    loan_payment lp ON lt.loan_id = lp.loan_id;

--1. query to create a view for credit orders

SELECT *
FROM Banktransactions_table
WHERE TRIM(LOWER(transaction_type)) = 'credit'
AND transaction_date BETWEEN '2020-05-20' AND '2024-03-30';

--2. query to create a view for debit orders
SELECT *
FROM Banktransactions_table
WHERE TRIM(LOWER(transaction_type)) = 'debit'
AND transaction_date BETWEEN '2020-05-20' AND '2024-03-30';

--3. procedure to update customer phone number
CREATE OR REPLACE PROCEDURE insert_new_phone_number(new_number numeric, name varchar)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO public."Customer" (phone_number, name)
	VALUES(new_number, name);
END;
$$;


CALL insert_new_phone_number('2348095256163', 'John Doe');


select * from public."Customer" 

DROP PROCEDURE IF EXISTS insert_new_phone_number(numeric, VARCHAR);

CREATE OR REPLACE PROCEDURE update_customer_phone_number(
    p_customer_id INT,
    p_new_phone_number NUMERIC
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE public."Customer"
    SET phone_number = p_new_phone_number
    WHERE customer_id = p_customer_id;
END;
$$;

CALL update_customer_phone_number(1001, 2348095256163);

--3. procedure to update customer email address

CREATE OR REPLACE PROCEDURE update_customer_Email(
    p_customer_id INT,
    p_new_Email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE public."Customer"
    SET Email = p_new_Email
    WHERE customer_id = p_customer_id;
END;
$$;

CALL update_customer_Email(1002, 'jane.smith@lafeza.com');

SELECT * FROM public."Customer"

DROP PROCEDURE IF EXISTS update_customer_email(INT, VARCHAR);

CREATE OR REPLACE PROCEDURE update_customer_Email(
    p_customer_id INT,
    p_new_Email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE public."Customer"
    SET Email = p_new_Email
    WHERE customer_id = p_customer_id;
END;
$$;

CALL update_customer_Email(1002, 'jane.smith@lafeza.com');

DROP PROCEDURE IF EXISTS update_customer_email(INT, VARCHAR);

CREATE OR REPLACE PROCEDURE update_Email(
    p_customer_id INT,
    p_new_Email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE public."Customer"
    SET "Email" = p_new_Email
    WHERE customer_id = p_customer_id;
END;
$$;

CALL update_Email(1002, 'jane.smith@lafeza.com');

select * from public."Customer"

