select distinct region from flourmills_sales as t1 where not exists(select 1 from flourmills_sales as t2 where t1.region = t2.region and t2.product_category = 'Flour');
