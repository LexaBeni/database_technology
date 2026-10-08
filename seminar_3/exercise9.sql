create or replace procedure apply_regional_discount(p_region_name text, p_discount_rate numeric)
language plpgsql as $$
DECLARE
    v_total_discount numeric:= 0;
BEGIN
    update orders o
    set sales = sales * (1 - p_discount_rate)
    from customers c
    where o.customer_id = c.customer_id and
    c.region = p_region_name;

    select sum(o.sales * p_discount_rate) into v_total_discount
    from orders o join customers c on o.customer_id = c.customer_id
    where c.region = p_region_name;

    raise notice 'Total discount applied: %', v_total_discount;
end;
$$;

call apply_regional_discount('West', 0.1)