-- Active: 1790175047279@@127.0.0.1@5432@superstore
CREATE DATABASE superstore;

CREATE TABLE customers(
    customer_id VARCHAR(20) PRIMARY KEY,
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    region VARCHAR(50)
);
