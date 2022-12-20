drop table if exists log cascade ;
drop table if exists comment cascade;
drop table if exists offer cascade;
drop table if exists post cascade;
drop table if exists order_audit cascade;
drop table if exists order_payment cascade;
drop table if exists payment_method cascade;
drop table if exists product_order cascade;
drop table if exists order_ cascade;
drop table if exists user_related_user cascade;
drop table if exists point_related_point cascade;
drop table if exists company_related_company cascade;
drop table if exists product_related_product cascade;
drop table if exists user_recommended_point cascade;
drop table if exists user_recommended_product cascade;
drop table if exists user_statistics cascade;
drop table if exists point_statistics cascade;
drop table if exists change_product_recommendation cascade;
drop table if exists product cascade;
drop table if exists product_name cascade;
drop table if exists profit_evaluation cascade;
drop table if exists brief_comment cascade;
drop table if exists point_brief_comments_brief_comments cascade;
drop table if exists point_brief_comments cascade;
drop table if exists auth_group_permissions cascade;
drop table if exists auth_permission cascade;
drop table if exists user_groups cascade;
drop table if exists user_user_groups cascade;
drop table if exists user_ cascade;
drop table if exists admin_account cascade;
drop table if exists point cascade;
drop table if exists company cascade;
drop table if exists auth_group cascade;
drop table if exists test cascade;
drop table if exists rating cascade;

drop function if exists order_trigger_function() cascade;
drop function if exists product_order_trigger_function() cascade;

DROP TRIGGER if exists order_audit_trigger ON public.order_ cascade;
DROP TRIGGER if exists product_order_statistics_trigger ON public.product_order cascade;



