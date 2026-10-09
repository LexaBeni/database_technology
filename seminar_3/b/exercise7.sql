with recursive cte1 as (select date_trunc('month', sale_date) as month, sum(total_amount) as revenue from flourmills_sales group by date_trunc('month', sale_date)
),
cte2 as(select cte1.*, row_number() over(order by month asc) as rn from cte1
),
cte3 as (

	select rn, month, revenue, revenue as cumulative_revenue from cte2 where rn = 1

	union all

	select c2.rn, c2.month, c2.revenue, (c3.cumulative_revenue + c2.revenue) as cumulative_revenue

	from cte3 c3 join cte2 c2 on c3.rn = c2.rn where c3.cumulative_revenue < 500000
	
)

select * from cte3 order by rn;