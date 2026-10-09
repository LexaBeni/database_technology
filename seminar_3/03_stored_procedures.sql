-- exercise 8
create or replace procedure get_customer_sales(p_customer_id text)
language plpgsql as $$
declare
    v_total_sales numeric := 0;
begin
    select sum(o.sales) into v_total_sales from orders o where o.customer_id = p_customer_id;
    raise notice 'Total sales for the customer with id %: %', p_customer_id, v_total_sales;
end;
$$;

call get_customer_sales('C001');

-- exercise 9
create or replace procedure apply_regional_discount(p_region_name text, p_discount_rate numeric)
language plpgsql as $$
declare
    v_total_discount numeric := 0;
begin
    update orders o
    set sales = sales * (1 - p_discount_rate)
    from customers c
    where o.customer_id = c.customer_id and c.region = p_region_name;

    select sum(o.sales * p_discount_rate) into v_total_discount
    from orders o join customers c on o.customer_id = c.customer_id
    where c.region = p_region_name;

    raise notice 'Total discount applied: %', v_total_discount;
end;
$$;

call apply_regional_discount('West', 0.1);

-- exercise 10
create or replace procedure get_sales_between(p_start_date date, p_end_date date)
language plpgsql as $$
declare
    v_total_sales numeric := 0;
begin
    if p_start_date > p_end_date then
        raise exception 'Start date (%) cannot be after end date (%)', p_start_date, p_end_date;
    end if;

    select coalesce(sum(sales), 0) into v_total_sales from orders where order_date between p_start_date and p_end_date;
    raise notice 'Total sales between % and %: %', p_start_date, p_end_date, v_total_sales;
end;
$$;

call get_sales_between('2024-01-01', '2024-03-31');
