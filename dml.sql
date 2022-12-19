truncate public.company cascade;
truncate public.admin_account cascade;


-- Log table
do $$ begin
for i in 1..100 loop
    insert into public.log (level, text, time)
    values (10, concat('Something happened...  ', i), '2022-12-19 14:18:00');
end loop;
end;
$$;


-- Company table
do $$ begin
for i in 1..10 loop
    insert into public.company (company_name, business_email, interface_color, is_active)
    values (concat('Company ', i), concat(concat('BusinessEmail', i), '@gmail.com'), 'dark', True);
end loop;
end;
$$;


-- Company_related_company table
do $$
declare rank int;
begin
for i in 1..8 loop
    rank := 1;
    for j in i..i+2 loop
        insert into public.company_related_company (rank, company_id, related_company_id)
        values (rank, i, j);
        rank = rank + 1;
    end loop;
end loop;
end;
$$;


-- Post table
do $$ begin
    for i in 1..5 loop
        insert into public.post (title, slug, content, created_on, updated_on, company_id)
        values (concat('Title ', i), concat('Slug', i), concat('Content', i),
                '2022-12-19 14:18:00', '2022-12-19 14:18:00', i);
    end loop;
end;
$$;


-- Offer table
do $$ begin
    for i in 1..5 loop
        insert into public.offer (description, content, created_on, updated_on, company_id)
        values (concat('Description ', i), concat('Content', i), '2022-12-19 14:18:00', '2022-12-19 14:18:00', i);
    end loop;
end;
$$;


-- Point table
do $$
declare company_id int := 1;
begin
    for i in 1..30 loop
        insert into public.point (name, address, book_table, online_order, company_id)
        values (concat('Point ', i), concat('Address ', i), true, true,  company_id);
        if company_id < 10 - 1 then
            company_id = company_id + 1;
        else
            company_id = 1;
        end if;
    end loop;
end;
$$;


-- Admin_account table
do $$
declare start int = 1;
begin
for i in 1..10 loop
    for j in start..start+2 loop
        insert into admin_account (is_moderator, company_id, point_id)
        values (true, i, j);
    end loop;
    start = start + 3;
end loop;
end;
$$;


-- User_ table
do $$ begin
    for i in 1..30 loop
    insert into public.user_ (password, last_login, username, is_active, first_name,
                              last_name, email, date_joined, is_platform_admin, admin_access_id)
    values ('very secure password', '2022-12-17 14:18:00', concat('username ', i), true, concat('firstname ', i),
            concat('lastname ', i), concat(concat('EmailPoint', i), '@gmail.com'), '2021-12-17 14:18:00', false, i);
end loop;

for i in 31..50 loop
    insert into public.user_ (password, last_login, username, is_active, first_name,
                              last_name, email, date_joined, is_platform_admin, admin_access_id)
    values ('very secure password', '2022-12-17 14:18:00', concat('username ', i), true, concat('firstname ', i),
            concat('lastname ', i), concat(concat('Email', i), '@gmail.com'), '2021-12-17 14:18:00', false, null);
end loop;

end;
$$;


-- Auth_group table
insert into public.auth_group (name) values ('group 1');
insert into public.auth_group (name) values ('group 2');
insert into public.auth_group (name) values ('group 3');



-- Auth_permission table
insert into public.auth_permission (name, codename) values ('Permission name 1', 'Permission codename 1');
insert into public.auth_permission (name, codename) values ('Permission name 2', 'Permission codename 2');
insert into public.auth_permission (name, codename) values ('Permission name 3', 'Permission codename 2');


-- Product_name table
do $$ begin
    for i in 1..50 loop
        insert into public.product_name (name)
        values (concat('Product name ', i));
    end loop;
end;
$$;


