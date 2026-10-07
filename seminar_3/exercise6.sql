create index idx_orders_region_category on orders(customer_id, order_date);

select * from orders o join customers c on o.customer_id = c.customer_id
where c.region = 'West' and o.order_date > '2024-01-01'