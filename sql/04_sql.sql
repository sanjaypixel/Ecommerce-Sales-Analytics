USE SAKILA;
-- AGGREGATE FUNCTIONS

/*
Function	Purpose
COUNT()	    Counts records or non-NULL values
SUM()	    Calculates the total
AVG()	    Calculates the average
MIN()	    Finds the minimum value
MAX()	    Finds the maximum value
*/

-- COUNT
/*
COUNT()
The COUNT() function counts rows or non-NULL values in a specified column.
SELECT COUNT(*)
FROM table_name;
*/

-- COUNT(*)

SELECT COUNT(*) FROM customer;

-- COUNT (column name)
/*
Counts only the non-NULL values in the specified column.
SELECT COUNT(column_name)
FROM table_name;
*/

SELECT COUNT(email) FROM customer;

-- COUNT(DISTINCT column name)
/*
Counts only unique non-NULL values.

Function	            What it counts
COUNT(*)	            All rows
COUNT(column)	        Non-NULL values
COUNT(DISTINCT column)	Unique non-NULL values

Important: COUNT(column) ignores NULL values, but COUNT(*) does not.
*/

SELECT COUNT(DISTINCT customer_id) 
FROM payment;


#Count unique customers who made payments
SELECT
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM payment;

#Count unique customers per staff member
SELECT
    staff_id,
    COUNT(DISTINCT customer_id) AS Unique_Customers
FROM payment
GROUP BY staff_id;

SELECT
    COUNT(DISTINCT rating) AS Unique_Ratings
FROM film;

SELECT RATING FROM FILM;

-- SUM
/*
The SUM() function calculates the total of numeric values in a column.

Syntax:
SELECT SUM(column_name)
FROM table_name;
*/


#Calculate total revenue

SELECT 
	SUM(amount) AS TOTAL_AMOUNT 
FROM payment;

#Total payment for a specific customer

SELECT 
	SUM(amount) AS TOTAL_AMOUNT 
FROM payment
WHERE customer_id = 1;

-- AVERAGE

/*
The AVG() function calculates the arithmetic mean of numeric values.
SELECT AVG(column_name)
FROM table_name;
*/

-- Average payment amount
SELECT AVG(amount)
FROM payment;

-- Average payment with alias
SELECT
    AVG(amount) AS Average_Payment
FROM payment;

-- Average payment for a specific customer
SELECT 
	CUSTOMER_ID,
    AVG(AMOUNT) AS AVERAGE_AMOUNT
FROM PAYMENT
WHERE CUSTOMER_ID = 2;

-- MAIN() and MAX()

/*
MIN()
Returns the minimum value.
Syntax:
SELECT MIN(column_name)
FROM table_name;
*/

SELECT MIN(amount) 
FROM payment;

SELECT MAX(amount)
FROM payment;

/*
MIN and MAX also work with dates
Find the earliest rental date:
*/

SELECT MIN(rental_date)
FROM rental;

SELECT MAX(rental_date)
FROM rental;

# GROUP BY (IMPORTANT)

/*
The GROUP BY clause groups rows that have the 
same values in one or more columns.

It is commonly used with aggregate functions 
to calculate summaries for each group.

syntax
SELECT
    column_name,
    AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name;
*/
SELECT COUNT(DISTINCT CUSTOMER_ID) FROM PAYMENT;

SELECT customer_id,
		SUM(amount) AS TOTAL_AMOUNT
FROM payment
GROUP BY customer_id;


#Count payments for each customer
SELECT
    customer_id,
    COUNT(*) AS Total_Payments
FROM payment
GROUP BY customer_id;

#Total payment for each customer
SELECT
    customer_id,
    SUM(amount) AS Total_Amount
FROM payment
GROUP BY customer_id;

# AVERAGE PAYMENT FOR EACH COUSTOMER
SELECT
	customer_id,
    AVG(amount) as AVG_AMOUNT
FROM payment
GROUP BY customer_id;


#Highest payment for each customer
SELECT
	customer_id,
    MAX(amount) as MAX_AMOUNT
FROM payment
GROUP BY customer_id;

-- Minimum payment for each customer
SELECT
	customer_id,
    MIN(amount) as MIN_AMOUNT
FROM payment
GROUP BY customer_id;

/*
Important rules of GROUP BY
1. GROUP BY creates groups based on matching values.
2. It is commonly used with aggregate functions.
3. NULL values in the grouping column form their own group.
4. In standard SQL, selected non-aggregated columns must be included in GROUP BY.
5. GROUP BY does not automatically sort the output.
*/


-- HAVING

/*
The HAVING clause filters grouped results.

Syntax:
SELECT
    column_name,
    AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name
HAVING condition;
*/

#Customers whose total payments exceed 100
SELECT
    customer_id,
    SUM(amount) AS Total_Payment
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

-- USE ALIAS AS HAVING FILTER
SELECT
    customer_id,
    SUM(amount) AS Total_Payment
FROM payment
GROUP BY customer_id
HAVING Total_Payment > 100;

SELECT 
	CUSTOMER_ID,
    COUNT(*) AS TOTAL_PAYMENT
FROM PAYMENT
GROUP BY CUSTOMER_ID
HAVING TOTAL_PAYMENT >30;

SELECT 
	customer_id,
    AVG(AMOUNT) AS TOTAL_AMOUNT
FROM PAYMENT
GROUP BY CUSTOMER_ID 
HAVING TOTAL_AMOUNT >4;

SELECT 
	CUSTOMER_ID,
    SUM(AMOUNT) AS TOTAL_PAYMENT
FROM PAYMENT
GROUP BY CUSTOMER_ID
HAVING TOTAL_PAYMENT BETWEEN 140 and 150;

/*
WHERE vs HAVING
This is one of the most important SQL interview questions.

Both WHERE and HAVING filter data, but they work at different stages.
WHERE	                                     HAVING
Filters individual rows	                     Filters groups
Applied before GROUP BY	                     Applied after GROUP BY
Usually used with normal column conditions	 Commonly used with aggregate conditions
Cannot directly use aggregate                Can use aggregate functions
functions in its condition	
Reduces rows before grouping	             Reduces groups after grouping
*/

SELECT 
	CUSTOMER_ID,
    SUM(AMOUNT) AS TOTAL_AMOUNT
FROM PAYMENT
WHERE AMOUNT >=5
GROUP BY CUSTOMER_ID
HAVING TOTAL_AMOUNT > 100;


-- GROUPING BY MULTIPLE COLUMNS
/*
You can group records using more than one column.
SELECT
    column1,
    column2,
    AGGREGATE_FUNCTION(column3)
FROM table_name
GROUP BY column1, column2;
*/

SELECT
    customer_id,
    staff_id,
    count(*) as total_payment
FROM payment
GROUP BY customer_id,staff_id;

SELECT 
	CUSTOMER_ID,
    STAFF_ID,
    SUM(AMOUNT) AS TOTAL_PAYMENT
FROM PAYMENT
GROUP BY CUSTOMER_ID,STAFF_ID;

SELECT * FROM FILM;

#Count films by rating and rental duration
SELECT 
	RATING,
   RENTAL_DURATION,
   COUNT(*) AS TOTAL_FLIMS
FROM FILM
WHERE RATING IN ('PG','G','R')
GROUP BY RATING,RENTAL_DURATION;

#Average rental rate by rating and replacement cost
SELECT
    rating,
    replacement_cost,
    AVG(rental_rate) AS Average_Rental_Rate
FROM film
GROUP BY rating, replacement_cost;

-- CASE WHEN 

/*
Before learning conditional aggregation, understand CASE WHEN.

CASE WHEN is used to apply conditional logic in SQL.
CASE
    WHEN condition THEN result
    ELSE result
END

*/

SELECT
    payment_id,
    amount,
    CASE
        WHEN amount > 5 THEN 'High Payment'
        ELSE 'Low Payment'
    END AS Payment_Category
FROM payment;

SELECT
    COUNT(
        CASE
            WHEN amount > 5 THEN 1
        END
    ) AS High_Payment_Count
FROM payment;

SELECT
    SUM(
        CASE
            WHEN amount > 5 THEN amount
            ELSE 0
        END
    ) AS High_Payment_Total
FROM payment;

SELECT 
	COUNT(*) AS TOTAL_PAYMENT,
    SUM(
		CASE
			WHEN AMOUNT > 5 THEN '1'
            ELSE '0'
		END) AS HIGH_PAYMENT,
        
	SUM(
		CASE
			WHEN AMOUNT <= 5 THEN '1'
            ELSE '0'
		END) AS LOW_PAYMENT
FROM PAYMENT;

SELECT
    customer_id,

    SUM(
        CASE
            WHEN amount > 5 THEN 1
            ELSE 0
        END
    ) AS High_Payments,

    SUM(
        CASE
            WHEN amount <= 5 THEN 1
            ELSE 0
        END
    ) AS Low_Payments

FROM payment
GROUP BY customer_id;

select 
		staff_id,
        
	count(
		case
			when amount > 5 then '1'
		end) as high_count,
        
	count(
		case
			when amount <= 5 then '1'
		end) as low_count
from payment 
group by staff_id;

SELECT
    staff_id,
    count(*) as total_count,
    COUNT(CASE
        WHEN amount > 5 THEN 1
    END) AS High_Payments,

    COUNT(CASE
        WHEN amount <= 5 THEN 1
    END) AS Low_Payments

FROM payment
GROUP BY staff_id;
