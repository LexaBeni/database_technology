-- exercise 4
create index idx_orders_customer_id on orders(customer_id);

select * from orders where customer_id = 'C001';

-- exercise 5
create index idx_orders_order_date on orders(order_date);

select date_trunc('month', order_date) as month, sum(sales) as total_sales
from orders group by date_trunc('month', order_date) order by month asc;

-- exercise 6
create index idx_orders_region_category on orders(customer_id, order_date);

select * from orders o join customers c on o.customer_id = c.customer_id
where c.region = 'West' and o.order_date > '2024-01-01';

-- exercise 7
explain analyze
select * from orders where customer_id = 'C001';
