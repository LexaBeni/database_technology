with cte as(select customer_id, invoice_no, invoice_date, stock_code, description, quantity, unit_price,
row_number() over(partition by customer_id order by invoice_date asc, invoice_no) as order_number from retail_sales
) select customer_id, invoice_no, invoice_date, stock_code, description, quantity, unit_price from cte where order_number = 1 order by customer_id asc;