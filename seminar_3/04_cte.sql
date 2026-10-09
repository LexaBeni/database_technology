-- exercise 1
with daily_sales as (select sale_date, sum(total_amount) as total_daily_sales from flourmills_sales group by sale_date
) select * from daily_sales where total_daily_sales > 3000000 order by total_daily_sales desc;

-- exercise 2
with category_sales as (select product_category, sum(total_amount) as sum_total_amount from flourmills_sales group by product_category
) select * from category_sales order by sum_total_amount desc;

-- exercise 3
with product_sales as (select product_name, product_category, sum(total_amount) as total_product_sales from flourmills_sales group by product_name, product_category
), ranked_products as (select product_sales.*, rank() over(partition by product_category order by total_product_sales desc) as category_rank from product_sales
) select * from ranked_products where category_rank between 1 and 3 order by product_category, category_rank;

-- exercise 4
with customer_type_sales as (select customer_type, sum(total_amount) as revenue from flourmills_sales group by customer_type
) select customer_type, revenue, sum(revenue) over() as total_revenue, round((revenue/sum(revenue) over()) * 100, 2) as revenue_percentage from customer_type_sales order by revenue desc;

-- exercise 5
with ranked_sales as (select customer_id, product_name, sale_date, total_amount, row_number() over(partition by customer_id order by sale_date desc) as sale_rank from flourmills_sales
) select customer_id, product_name, sale_date, total_amount from ranked_sales where sale_rank = 1 order by customer_id;

-- exercise 6
with recursive dates as(
    select min(sale_date)::date as sale_date from flourmills_sales

    union all

    select (sale_date + interval '1 day')::date from dates where sale_date < (select max(sale_date)::date from flourmills_sales)
)
select * from dates order by sale_date asc;

-- exercise 7
with recursive monthly_sales as (select date_trunc('month', sale_date) as month, sum(total_amount) as revenue from flourmills_sales group by date_trunc('month', sale_date)
), numbered_months as (select monthly_sales.*, row_number() over(order by month asc) as rn from monthly_sales
), cumulative_sales as (
    select rn, month, revenue, revenue as cumulative_revenue from numbered_months where rn = 1

    union all

    select next_month.rn, next_month.month, next_month.revenue, cumulative_sales.cumulative_revenue + next_month.revenue
    from cumulative_sales join numbered_months next_month on cumulative_sales.rn + 1 = next_month.rn
    where cumulative_sales.cumulative_revenue < 500000
)
select * from cumulative_sales order by rn;
