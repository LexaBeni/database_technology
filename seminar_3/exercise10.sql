create or replace procedure get_sales_between(p_start_date date, p_end_date date)
language plpgsql as $$
DECLARE
    v_total_sales numeric:= 0;
BEGIN
	if p_start_date > p_end_date then
        raise exception 'Start date (%) cannot be after end date (%)',
            p_start_date, p_end_date;
    end if;
	
    select coalesce(sum(sales), 0) into v_total_sales from orders where order_date between p_start_date and p_end_date;
    raise notice 'Total sales between % and %: %', p_start_date, p_end_date, v_total_sales;
end;
$$;

call get_sales_between('2024-01-01', '2024-03-31');