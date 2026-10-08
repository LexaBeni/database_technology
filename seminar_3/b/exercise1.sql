-- Active: 1790175047279@@127.0.0.1@5432@datacraftinglab_db
with cte as(select sale_date, sum(total_amount) as total_daily_sales from flourmills_sales group by sale_date
)select * from cte where total_daily_sales > 3000000 order by total_daily_sales desc;