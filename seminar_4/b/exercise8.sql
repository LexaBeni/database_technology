with cte as(select c.customer_id, date_trunc('month', min(o.order_date)) as first_order_month from customers c join orders o on c.customer_id = o.customer_id group by c.customer_id
) select cte.* from cte where first_order_month = '2024-06-01' and exists(select 1 from orders o where o.customer_id = cte.customer_id and date_trunc('month', o.order_date) > date '2024-06-01');

