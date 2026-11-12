CREATE DATABASE IF NOT EXISTS olist_ecommerce;

USE olist_ecommerce;


CREATE TABLE customers (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state CHAR(2),
    PRIMARY KEY (customer_id)
);

SHOW TABLES;

DESCRIBE customers;

LOAD DATA LOCAL INFILE "D:\Ecommerse Dataset"
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW GLOBAL VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = ON;

SHOW GLOBAL VARIABLES LIKE 'local_infile';