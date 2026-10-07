-- Active: 1790175047279@@127.0.0.1@5432@superstore
create or replace view high_value_customers as 
select c.customer_id, c.customer_name, sum(o.sales) as total_sales
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name having sum(sales) > 2000;

select * from high_value_customers;