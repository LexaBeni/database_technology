with cte1 as (select customer_type, sum(total_amount) as revenue from flourmills_sales group by customer_type
),
cte2 as(select cte1.*, sum(revenue) over() as total_revenue, round((revenue/sum(revenue) over()) * 100, 2) as revenue_percentage from cte1)
select * from cte2 order by revenue desc;