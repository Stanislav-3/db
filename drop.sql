drop table log;
drop table comment;
drop table rating;
drop table offer;
drop table post;
drop table order_audit;
drop table order_payment;
drop table payment_method;
drop table product_order;
drop table order_;
drop table user_related_user;
drop table point_related_point;
drop table company_related_company;
drop table product_related_product;
drop table user_recommended_point;
drop table user_recommended_product;
drop table user_statistics;
drop table point_statistics;
drop table change_product_recommendation;
drop table product;
drop table product_name;
drop table profit_evaluation;
drop table point_brief_comments_brief_comments;
drop table brief_comment;
drop table point_brief_comments;
drop table auth_group_permissions;
drop table auth_permission;
drop table user_groups;
drop table user_user_groups;
drop table user_;
drop table admin_account;
drop table point;
drop table company;
drop table auth_group;
drop table test;

drop function if exists order_trigger_function();
drop function if exists product_order_trigger_function();

DROP TRIGGER if exists order_audit_trigger ON public.order_;
DROP TRIGGER if exists product_order_statistics_trigger ON public.product_order;



