-- exercise 1
select customer_id, invoice_no, invoice_date, quantity, unit_price,
(quantity * unit_price) as revenue, sum(quantity * unit_price) over(partition by customer_id order by invoice_date range between interval '14 days' preceding and current row) as revenue_last_14_days from retail_sales where customer_id is not null order by customer_id, invoice_date;

-- exercise 2
select stock_code, country, invoice_date, quantity, round(avg(quantity) over (partition by stock_code, country order by invoice_date range between interval '7 days' preceding and current row), 2) as avg_quantity_7_days from retail_sales where quantity > 1 order by stock_code, country, invoice_date;

-- exercise 3
select customer_id, invoice_no, invoice_date, next_invoice_date, extract(day from next_invoice_date - invoice_date) as days_to_next_invoice from (select customer_id, invoice_no, invoice_date, lead(invoice_date) over(partition by customer_id order by invoice_date) as next_invoice_date from retail_sales) as sub where next_invoice_date is not null order by days_to_next_invoice desc;

-- exercise 4
with cte as (select stock_code, invoice_no, invoice_date, unit_price as current_price, lag(unit_price) over(w) as previous_price, unit_price - lag(unit_price) over(w) as price_difference from retail_sales window w as (partition by stock_code order by invoice_date)
) select * from cte where previous_price is not null and price_difference <> 0 order by invoice_date, invoice_no asc;

-- exercise 5
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

-- exercise 6
with cte as (select country, date_trunc('month', invoice_date) as month, sum(quantity * unit_price) as total_amount from retail_sales group by country, date_trunc('month', invoice_date)
) select cte.*, ntile(4) over(partition by country order by total_amount desc) as sales_quartile from cte order by country, month;

-- exercise 7
with cte as(select customer_id, invoice_no, invoice_date, stock_code, description, quantity, unit_price,
row_number() over(partition by customer_id order by invoice_date asc, invoice_no) as order_number from retail_sales
) select customer_id, invoice_no, invoice_date, stock_code, description, quantity, unit_price from cte where order_number = 1 order by customer_id asc;

-- exercise 8
with cte as(select invoice_no, stock_code, description, quantity, unit_price, (quantity * unit_price) as amount, row_number() over(partition by invoice_no order by quantity * unit_price desc) as row_num from retail_sales
) select cte.* from cte where row_num between 1 and 3;

-- exercise 9
with cte1 as(select country, date_trunc('month', invoice_date) as month, customer_id, sum(quantity * unit_price) as total_amount from retail_sales group by country, month, customer_id
), cte2 as(select cte1.*, dense_rank() over(partition by country, month order by total_amount desc) as sales_rank from cte1
) select cte2.* from cte2 where sales_rank between 1 and 5 order by country, month, sales_rank, customer_id;

-- exercise 10
with cte as (select invoice_no, stock_code, description, quantity, unit_price, dense_rank() over (partition by invoice_no order by unit_price desc) as price_rank from retail_sales
) select * from cte where price_rank between 1 and 5 order by invoice_no, price_rank, stock_code;
