with recursive cte as(
	select min(sale_date)::date as sale_date from flourmills_sales

	union all

	select (sale_date + interval '1 day')::date from cte where sale_date < (select max(sale_date)::date from flourmills_sales)
) 
select * from cte order by sale_date asc