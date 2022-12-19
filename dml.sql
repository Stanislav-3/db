-- truncate public.company cascade;
-- truncate public.admin_account cascade;


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
for i in 1..6 loop
    rank := 1;
    for j in i+1..i+3 loop
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


-- Point_related_point table
do $$
declare rank int;
begin
for i in 1..20 loop
    rank := 1;
    for j in i+1..i+4 loop
        insert into public.point_related_point (rank, point_id, related_point_id)
        values (rank, i, j);
        rank = rank + 1;
    end loop;
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

insert into public.user_groups (user_id, group_id) values (1 , 1);
insert into public.user_groups (user_id, group_id) values (1 , 2);
insert into public.user_groups (user_id, group_id) values (1 , 3);
insert into public.user_groups (user_id, group_id) values (2 , 1);
insert into public.user_groups (user_id, group_id) values (3 , 3);


-- Auth_permission table
insert into public.auth_permission (name, codename) values ('Permission name 1', 'Permission codename 1');
insert into public.auth_permission (name, codename) values ('Permission name 2', 'Permission codename 2');
insert into public.auth_permission (name, codename) values ('Permission name 3', 'Permission codename 2');

insert into public.auth_group_permissions (group_id, permission_id) values (1, 1);
insert into public.auth_group_permissions (group_id, permission_id) values (2, 2);
insert into public.auth_group_permissions (group_id, permission_id) values (3, 1);
insert into public.auth_group_permissions (group_id, permission_id) values (3, 2);
insert into public.auth_group_permissions (group_id, permission_id) values (3, 3);


-- Brief_comment table
insert into public.brief_comment (comment, rate) values ('awful service', -0.8);
insert into public.brief_comment (comment, rate) values ('good service', 0.7);
insert into public.brief_comment (comment, rate) values ('disgusting food', -0.9);
insert into public.brief_comment (comment, rate) values ('awesome food', 0.9);

-- Point_brief_comments table
insert into point_brief_comments (updated_on, point_id) values ('2022-12-19 14:18:00', 1);
insert into point_brief_comments (updated_on, point_id) values ('2022-12-19 14:18:00', 2);
insert into point_brief_comments (updated_on, point_id) values ('2022-12-19 14:18:00', 3);


-- Point_brief_comments_brief_comments table
insert into point_brief_comments_brief_comments (point_brief_comments_id, brief_comment_id)
values (1, 1);
insert into point_brief_comments_brief_comments (point_brief_comments_id, brief_comment_id)
values (1, 3);
insert into point_brief_comments_brief_comments (point_brief_comments_id, brief_comment_id)
values (2, 2);
insert into point_brief_comments_brief_comments (point_brief_comments_id, brief_comment_id)
values (2, 4);
insert into point_brief_comments_brief_comments (point_brief_comments_id, brief_comment_id)
values (3, 1);
insert into point_brief_comments_brief_comments (point_brief_comments_id, brief_comment_id)
values (3, 4);


-- Product_name table
do $$ begin
    for i in 1..50 loop
        insert into public.product_name (name)
        values (concat('Product name ', i));
    end loop;
end;
$$;


-- Product table
do $$
    declare bar_code_counter int = 1;
begin
    for i in 1..30 loop
        for j in 1..50 loop
            insert into public.product (name_id, point_id, bar_code, price, loaylty_coeff)
            values (j, i, concat('code ', bar_code_counter), i + j, 0.3);
            bar_code_counter = bar_code_counter + 1;
        end loop;
    end loop;
end;
$$;


-- Change_product_recommendation table
insert into public.change_product_recommendation (recommendation, point_id, product_id)
values ('Lower the price by 2.5%', 25, 20);
insert into public.change_product_recommendation (recommendation, point_id, product_id)
values ('Add plant based milk as an alternative', 5, 12);
insert into public.change_product_recommendation (recommendation, point_id, product_id)
values ('Lower the sugar in the composition of a product', 1, 25);


-- Comment table
insert into public.comment (text, point_id, user_id, time)
values ('Your service is really good! Definitely is going to return!', 2, 10, '2022-11-19 14:18:00');
insert into public.comment (text, point_id, user_id, time)
values ('yeah, food''s good', 10, 1, '2022-11-19 12:18:00');
insert into public.comment (text, point_id, user_id, time)
values ('Everything''s awful!!!!!!!!!!!', 10, 15, '2022-11-19 14:18:00');
insert into public.comment (text, point_id, user_id, time)
values ('Not bad', 5, 7, '2022-11-19 10:18:00');


-- Rating table
insert into public.rating (rating, point_id, user_id) values (0, 10, 15);
insert into public.rating (rating, point_id, user_id) values (5, 2, 10);
insert into public.rating (rating, point_id, user_id) values (2.5, 7, 14);
insert into public.rating (rating, point_id, user_id) values (4.5, 10, 17);
insert into public.rating (rating, point_id, user_id) values (1.5, 2, 4);


-- User_related_user table
do $$
declare rank int;
begin
for i in 1..20 loop
    rank := 1;
    for j in i+1..i+4 loop
        insert into public.user_related_user (rank, user_id, related_user_id)
        values (rank, i, j);
        rank = rank + 1;
    end loop;
end loop;
end;
$$;


-- Product_related_product table
do $$
declare rank int;
begin
for i in 1..40 loop
    rank := 1;
    for j in i+1..i+5 loop
        insert into public.product_related_product (rank, product_id, related_product_id)
        values (rank, i, j);
        rank = rank + 1;
    end loop;
end loop;
end;
$$;


-- User_payment_method
do $$
    declare users_count int := (select count(*) from user_);
begin
for i in 1..users_count loop
    insert into public.payment_method (user_id, card_number)
    values (i, concat('number ', i));
end loop;
end;
$$;


-- Profit_evaluation table
insert into public.profit_evaluation (current_delta, result_delta, current_money, result_money, point_id)
values (0.03, 0.05, 300, 1200, 5);
insert into public.profit_evaluation (current_delta, result_delta, current_money, result_money, point_id)
values (-0.03, -0.1, 250, 750, 5);
insert into public.profit_evaluation (current_delta, result_delta, current_money, result_money, point_id)
values (0.5, 0.65, 1000, 3000, 5);


-- User_recommended_product table
insert into public.user_recommended_product (user_id, recommended_product_id, rank) values (1, 10, 1);
insert into public.user_recommended_product (user_id, recommended_product_id, rank) values (1, 2, 3);
insert into public.user_recommended_product (user_id, recommended_product_id, rank) values (1, 15, 3);
insert into public.user_recommended_product (user_id, recommended_product_id, rank) values (3, 11, 1);
insert into public.user_recommended_product (user_id, recommended_product_id, rank) values (3, 7, 2);
insert into public.user_recommended_product (user_id, recommended_product_id, rank) values (5, 15, 1);


-- User_recommended_point table
insert into public.user_recommended_point (user_id, recommended_point_id, rank) values (1, 7, 1);
insert into public.user_recommended_point (user_id, recommended_point_id, rank) values (1, 9, 2);
insert into public.user_recommended_point (user_id, recommended_point_id, rank) values (11, 3, 1);
insert into public.user_recommended_point (user_id, recommended_point_id, rank) values (5, 15, 1);
insert into public.user_recommended_point (user_id, recommended_point_id, rank) values (5, 1, 2);
insert into public.user_recommended_point (user_id, recommended_point_id, rank) values (5, 4, 3);


-- Order table
insert into public.order_ (status, time_ordered, total_price, point_id, user_id)
values ('open', '2022-11-19 14:18:00', 0, 3, 5);



-- Order_payment table
insert into public.order_payment (time_accepted, order_id, payment_method_id)
values ('2022-11-19 14:18:00', cast(1 as bigint), (select (id) from payment_method
                                               where public.payment_method.user_id = (
                                                   select (user_id) from public.order_
                                                   where public.order_.id = cast(1 as bigint)
                                                   )));

-- Product_order table
insert into public.product_order (quantity, order_id, product_id)
values (3, 1, 1);


