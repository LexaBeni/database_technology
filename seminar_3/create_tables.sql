-- Active: 1790175047279@@127.0.0.1@5432@retail_sales
create database retail_sales;

create table orders(
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) not null,
    product_id VARCHAR(20) not null,
    order_date TIMESTAMPTZ not null,
    region VARCHAR(20) not null,
    category VARCHAR(50) not null,
    ship_mode VARCHAR(30) not null,
    sales DECIMAL(10, 2) not null,
    profit DECIMAL(10, 2) not null
);

alter database retail_sales
set datestyle = "ISO, MDY";

select * from orders;