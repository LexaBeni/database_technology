create or replace procedure get_customer_sales(p_customer_id text)
language plpgsql as $$
DECLARE
    v_total_sales int:= 0;
BEGIN
    select sum(o.sales) into v_total_sales from orders o where o.customer_id = p_customer_id;
    raise notice 'Total sales for the customer with id %: %', p_customer_id, v_total_sales;
end;
$$;

CALL get_customer_sales('C001');
