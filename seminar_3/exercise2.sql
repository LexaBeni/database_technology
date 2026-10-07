create or replace view regional_monthly_sales as 
select c.region, date_trunc('month', order_date) as month, sum(o.sales) as monthly_sales
from customers c join orders o on c.customer_id = o.customer_id
group by c.region, month order by region;

drop view regional_monthly_sales;
select * from regional_monthly_sales;