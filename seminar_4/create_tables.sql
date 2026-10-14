-- Active: 1790175047279@@127.0.0.1@5432@retail
create database retail;

create table retail_sales(
    invoice_no varchar(20),
    stock_code varchar(50),
    description text,
    quantity INTEGER,
    invoice_date TIMESTAMP,
    unit_price NUMERIC(10, 2),
    customer_id INTEGER,
    country varchar(100)
)