CREATE TABLE orders(
    order_id VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) REFERENCES customers(customer_id),
    product_id VARCHAR(20) REFERENCES products(product_id),
    order_date TIMESTAMPTZ,
    ship_date TIMESTAMPTZ,
    sales NUMERIC(10, 2),
    quantity INTEGER CHECK(quantity >= 0),
    discount DECIMAL(3, 2) CHECK (discount between 0 and 1),
    profit DECIMAL(10, 2)
);

alter table orders
alter column discount type decimal(3, 2)