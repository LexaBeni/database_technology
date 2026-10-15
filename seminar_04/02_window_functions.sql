-- exercise 1
-- active: 1790175047279@@127.0.0.1@5432@superstore
with cte as (select customer_name, order_id, order_date, row_number() over(partition by customer_name order by order_date desc) as order_number from customers c join orders o on o.customer_id = c.customer_id
) select cte.* from cte where order_number between 1 and 2 order by customer_name, order_number;

-- exercise 2
with cte1 as(select c.region, c.customer_name, sum(o.profit) as total_profit from customers c join orders o on c.customer_id = o.customer_id group by c.region, c.customer_name
) select cte1.*, rank() over(partition by region order by total_profit desc) as profit_rank, dense_rank() over(partition by region order by total_profit desc) as dense_profit_rank from cte1 order by region, total_profit desc, customer_name;

-- exercise 3
with cte as(select date_trunc('month', o.order_date) as month, sum(o.sales) as monthly_sales from orders o group by date_trunc('month', o.order_date)
) select cte.*, lag(monthly_sales, 1) over(w) as prev_month_sales, lead(monthly_sales, 1) over(w) as next_month_sales from cte window w as(order by month) order by month asc;

-- exercise 4
with cte as(select p.category, p.product_name, sum(o.sales) as product_sales from products p join orders o on p.product_id = o.product_id group by p.category, p.product_name
) select cte.*, sum(product_sales) over(partition by category) as category_total, round(product_sales * 100 / sum(product_sales) over(partition by category), 2) as pct_of_category from cte;

-- exercise 5
with cte as (select c.customer_id, c.customer_name, max(o.order_date) over(partition by c.customer_id) as last_order_date from customers c join orders o on c.customer_id = o.customer_id
) select distinct cte.* from cte where last_order_date < (select max(order_date) - interval '90 days' from orders) order by last_order_date;

-- exercise 6
with cte as(select date_trunc('month', order_date) as month, sum(sales) as monthly_sales from orders group by date_trunc('month', order_date)
) select cte.*, lag(monthly_sales) over(order by month) as prev_month_sales, monthly_sales - lag(monthly_sales) over(order by month) as sales_change, round((monthly_sales - lag(monthly_sales) over(order by month)) / lag(monthly_sales) over(order by month) * 100, 2) as growth_percentage from cte order by month asc;

-- exercise 7
with cte as(select c.customer_id, date_trunc('month', min(o.order_date)) as first_order_month from customers c join orders o on c.customer_id = o.customer_id group by c.customer_id
) select cte.* from cte where first_order_month = '2024-06-01' and exists(select 1 from orders o where o.customer_id = cte.customer_id and date_trunc('month', o.order_date) > date '2024-06-01');

-- exercise 8
with cte as(select c.customer_name, sum(o.sales) as total_sales from customers c join orders o on c.customer_id = o.customer_id group by c.customer_id, c.customer_name
) select cte.*, ntile(4) over(order by total_sales desc) as sales_quartile from cte;
