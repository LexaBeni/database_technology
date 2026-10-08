with cte1 as(select product_name, product_category, sum(total_amount) as total_product_sales from flourmills_sales group by product_name, product_category
), cte2 as (select cte1.*, rank() over(partition by product_category order by total_product_sales desc) as category_rank from cte1
)select * from cte2 where category_rank between 1 and 3 order by product_category, category_rank;