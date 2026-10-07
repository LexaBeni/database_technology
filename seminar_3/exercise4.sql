create index idx_orders_customer_id on orders(customer_id);

select * from orders where customer_id = 'C001';