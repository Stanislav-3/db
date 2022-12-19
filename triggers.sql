

-- Order_audit function
create or replace function order_audit_function()
    returns trigger
    language plpgsql
as $$
begin
    insert into public.order_audit (order_id, old_status, new_status, time_ordered, total_price)
    values (new.id, old.status, new.status, new.time_ordered, new.total_price);

    return new;
end;
$$;


-- Order_audit trigger
create or replace trigger order_audit_trigger
    after insert or update on public.order_
    for each row
    execute procedure order_audit_function();



-- Point_statistics & User_statistics function
create or replace function product_order_statistics_function()
    returns trigger
    language plpgsql
as $$
    declare
        _point_id bigint;
        _user_id bigint;
        _money numeric(6, 2);
        _time_ordered timestamp with time zone;
        _hour integer;
        _morning_orders_amount integer = 0;
        _afternoon_orders_amount integer = 0;
        _evening_orders_amount integer = 0;
        _morning_money numeric(6, 2) = 0;
        _afternoon_money numeric(6, 2) = 0;
        _evening_money numeric(6, 2) = 0;
        prev_money numeric(6, 2) = 0;
        prev_total_price numeric(6, 2) = 0;


begin
    select (point_id, user_id, time_ordered) into _point_id, _user_id, _time_ordered
        from order_ where id = new.order_id;
    select price into _money from product where id = new.product_id;

--  update Order total_price
--     select (total_price) into prev_total_price from order_ where id == new.order_id;
    update order_ set total_price = cast((total_price + _money * new.quantity) as numeric(8, 2))
                  where order_.id = new.order_id;
--
--     _hour := extract(hour from _time_ordered);
--     if _hour <= 12 then
--         _morning_money := _money;
--         _morning_orders_amount := new.quantity;
--     elsif _hour <= 18 then
--         _afternoon_money := _money;
--         _afternoon_orders_amount := new.quantity;
--     else
--         _evening_money := _money;
--         _evening_orders_amount := new.quantity;
--     end if;

--     select (amount, _money) from public.user_statistics
--     where public.user_statistics.user_id == user_id and public.user_statistics.product_id == product_id and
--           public.user_statistics.point_id == point_id


    --  User statistics
--     if count((select * from public.user_statistics where public.user_statistics.user_id = _user_id and
--                                                         public.user_statistics.point_id = product_id)) then
--         insert into public.user_statistics (amount, money, point_id, product_id, user_id)
--         values (new.quantity, _money, point_id, new.product_id, user_id);
--     else
--         update public.user_statistics set (amount, money) = (amount + new.quantity, money + _money);
--     end if;

--     --  Points statistics
--     insert into public.point_statistics (day_of_week, month_of_year, visitor_count, morning_orders_amount,
--                                          morning_money, afternoon_orders_amount, afternoon_money,
--                                          evening_orders_amount, evening_money, point_id, product_id)
--     values ((select extract(dow from time_ordered)), (select extract(month from time_ordered)), 1,
--             morning_orders_amount, morning_money, afternoon_orders_amount, afternoon_money,
--             evening_orders_amount, evening_money, point_id, user_id)
--
    return new;
end;
$$;


-- Point_statistics & User_statistics trigger
create or replace trigger product_order_statistics_trigger
    after insert on public.product_order
    for each row
    execute procedure product_order_statistics_function();
