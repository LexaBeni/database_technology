with customer_sales as (
	select customer_id, sum(quantity * unit_price) as total_amount
	from retail_sales
	where customer_id is not null
	group by customer_id
)
select customer_id, total_amount,
	   ntile(4) over(order by total_amount desc) as sales_quartile
from customer_sales
order by total_amount desc;