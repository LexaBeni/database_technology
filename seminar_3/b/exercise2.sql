with category_sales as(select product_category, sum(total_amount) as sum_total_amount from flourmills_sales group by product_category
) select * from category_sales order by sum_total_amount desc;