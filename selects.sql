select * from log;

select * from company;
select * from point;

select * from company_related_company;
select * from point_related_point;
select * from user_related_user;
select * from product_related_product;

select * from offer;
select * from post;


select * from admin_account;
select * from user_;

select * from auth_group;
select * from auth_permission;

select * from brief_comment;
select * from point_brief_comments;
select * from point_brief_comments_brief_comments;

select * from product_name;
select * from product;
select * from change_product_recommendation;

select * from comment;
select * from rating;

select * from payment_method;

select * from profit_evaluation;

select * from user_recommended_product;
select * from user_recommended_point;

select * from order_;
select * from order_audit;

select * from user_statistics;
select * from point_statistics;

delete from product_order;
select * from product_order;


(select (id) from public.payment_method
 where public.payment_method.user_id = (
                                                   select (user_id) from public.order_
                                                   where public.order_.id = cast(1 as bigint)
                                                   ))
