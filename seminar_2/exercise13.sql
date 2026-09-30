select distinct product_category from flourmills_sales as t1 where not exists(select 1 from flourmills_sales as t2 where t1.product_category = t2.product_category and t2.total_amount > 500000);


