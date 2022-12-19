

create or replace view points_brief_comments as
select point_id, updated_on, comment, rate from point_brief_comments
join point_brief_comments_brief_comments m2m
    on point_brief_comments.point_id = m2m.point_brief_comments_id
join brief_comment bc on m2m.brief_comment_id = bc.id;


create or replace view user_group_and_credentials as
select username, first_name, last_name, email, name as group_name, card_number from user_
join user_groups ug
    on user_.id = ug.user_id
join auth_group ag
    on ug.group_id = ag.id
join payment_method pm
    on user_.id = pm.user_id;


create or replace view company_point_statistics as
select company_name, name as point_name, address, book_table, online_order, current_delta, result_delta,
       current_money, result_money
from company
join point p on company.id = p.company_id
join profit_evaluation pe on p.id = pe.point_id
join point_statistics ps on p.id = ps.point_id