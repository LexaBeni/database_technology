select category, avg(discount) as avg_discount from products pr join orders o on pr.product_id = o.product_id group by category; 
