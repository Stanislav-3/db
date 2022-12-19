

-- Order_audit function
create or replace function order_trigger_function()
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
    before insert or update on public.order_
    for each row
    execute procedure order_trigger_function();



-- Point_statistics & User_statistics function
create or replace function product_order_trigger_function()
    returns trigger
    language plpgsql
as $$
    declare
        _point_id bigint;
        _user_id bigint;
        _price numeric(6, 2);
        _time_ordered timestamp with time zone;
        _hour integer;
        _morning_orders_amount integer = 0;
        _afternoon_orders_amount integer = 0;
        _evening_orders_amount integer = 0;
        _morning_money numeric(6, 2) = 0;
        _afternoon_money numeric(6, 2) = 0;
        _evening_money numeric(6, 2) = 0;
        _day_of_week integer;
        _month_of_year integer;
begin
    select point_id, user_id, time_ordered
    into _point_id, _user_id, _time_ordered
    from order_
    where id = new.order_id;

    select price
    into _price
    from product
    where id = new.product_id;

    _month_of_year := extract(month from _time_ordered);
    _day_of_week := extract(dow from _time_ordered);
    _hour := extract(hour from _time_ordered);
    if _hour <= 12 then
        _morning_money := _price * new.quantity;
        _morning_orders_amount := new.quantity;
    elsif _hour <= 18 then
        _afternoon_money := _price * new.quantity;
        _afternoon_orders_amount := new.quantity;
    else
        _evening_money := _price * new.quantity;
        _evening_orders_amount := new.quantity;
    end if;

    --  update Order total_price
    update order_ set total_price = (total_price + _price * new.quantity) where order_.id = new.order_id;


    --  insert or update User_statistics
    if (select count(*)
        from public.user_statistics
        where point_id = _point_id and product_id = new.product_id and user_id = _user_id) = 0 then
            insert into public.user_statistics (point_id, product_id, user_id, amount, money)
            values (_point_id, new.product_id, _user_id, new.quantity, _price * new.quantity);
    else
        update public.user_statistics
        set amount = amount + new.quantity, money = money + _price * new.quantity
        where point_id = _point_id and product_id = new.product_id and user_id = _user_id;
    end if;


    --  insert or update Point_statistics
    if (select count(*)
        from public.point_statistics
        where point_id = _point_id and product_id = new.product_id and day_of_week = _day_of_week and
              month_of_year = _month_of_year) = 0 then
            insert into public.point_statistics (point_id, product_id, day_of_week, month_of_year, visitor_count,
                                                 morning_orders_amount, morning_money, afternoon_orders_amount,
                                                 afternoon_money, evening_orders_amount, evening_money)
            values (_point_id, new.product_id, _day_of_week, _month_of_year, 1, _morning_orders_amount, _morning_money,
                    _afternoon_orders_amount, _afternoon_money, _evening_orders_amount, _evening_money);
    else
        update public.point_statistics
        set visitor_count = visitor_count + 1, morning_orders_amount = morning_orders_amount + _morning_orders_amount,
            morning_money = morning_money + _morning_money, afternoon_money = afternoon_money + _afternoon_money,
            afternoon_orders_amount = afternoon_orders_amount + _afternoon_orders_amount,
            evening_orders_amount = evening_orders_amount + _evening_orders_amount,
            evening_money = evening_money + _evening_money
        where point_id = _point_id and product_id = new.product_id and day_of_week = _day_of_week and
              month_of_year = _month_of_year;
    end if;

    return new;
end;
$$;


-- Point_statistics & User_statistics trigger
create or replace trigger product_order_statistics_trigger
    before insert on public.product_order
    for each row
    execute procedure product_order_trigger_function();
