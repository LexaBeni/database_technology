-- exercise 1
create or replace view high_value_customers as
select c.customer_id, c.customer_name, sum(o.sales) as total_sales
from customers c join orders o on c.customer_id = o.customer_id
group by c.customer_id, c.customer_name having sum(o.sales) > 2000;

select * from high_value_customers;

-- exercise 2
create or replace view regional_monthly_sales as
select c.region, date_trunc('month', o.order_date) as month, sum(o.sales) as monthly_sales
from customers c join orders o on c.customer_id = o.customer_id
group by c.region, month order by region;

select * from regional_monthly_sales;

-- exercise 3
create or replace view analyst_orders as
select order_id, customer_id, product_id, sales, quantity, discount
from orders;

select * from analyst_orders;
