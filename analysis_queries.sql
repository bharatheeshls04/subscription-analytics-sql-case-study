/* =========================================================
   Subscription Analytics SQL Case Study
   Database: subscription_app
   Tool: MySQL Workbench
========================================================= */

/* Task 1 — Subscription roster */

select user_name, country, plan_name, start_date, end_date from subscriptions s
join users u on u.user_id = s.user_id 
join plans p on p.plan_id = s.plan_id 
order by s.subscription_id;


/* Task 2 — Paid revenue by country (include 0 revenue countries) */

select u.country, sum( case when i.status ='Paid' then i.amount else 0 end) as Paid_revenue from users u
left join subscriptions s on s.user_id = u.user_id 
left join invoice i on i.subscription_id = s.subscription_id 
group by u.country
order by Paid_revenue desc, u.country;


/* Task 3 — Users with no subscription */

select u.user_name, u.user_id  from users u
left join subscriptions s on u.user_id = s.user_id 
where s.subscription_id is null;

# another version  for task 3 (not exists) 
select u.user_id, u.user_name from users u
where not exists ( select 1 from subscriptions s where u.user_id = s.user_id);


/* Task 4 — Subscriptions with no payments recorded */

select   s.subscription_id, s.user_id, s.plan_id, s.start_date, s.end_date from subscriptions s
where not exists (select 1 from invoice i where i.subscription_id = s.subscription_id)
ORDER BY s.subscription_id;


/* Task 5 — Active subscriptions as of 2025-03-15 */

select u.user_name, p.plan_name, s.start_date, s.end_date from subscriptions s
join users u on u.user_id = s.user_id
join plans p on s.plan_id = p.plan_id
where s.start_date <= '2025-03-15' and (s.end_date is null or s.end_date > '2025-03-15')
order by u.user_name, p.plan_name;


/* Task 6 — Users who subscribed but never successfully paid */

select u.user_name from users u
where exists ( select 1 from subscriptions s where s.user_id = u.user_id)
and not exists ( select 1 from subscriptions s 
join invoice i on i.subscription_id = s.subscription_id where s.user_id = u.user_id
and i.status ='Paid')
order by u.user_name;


/* Task 7 — Plans ranked by paid revenue */

select p.plan_id, p.plan_name, sum(case when i.status='Paid' then i.amount else 0 end ) as paid_revenue from plans p   
left join subscriptions s on  p.plan_id = s.plan_id
left join invoice i on i.subscription_id = s.subscription_id 
group by p.plan_id, p.plan_name
order by paid_revenue desc;


/* Task 8 — Risk list: Failed payments AND no Paid ever */

select u.user_id, u.user_name, u.country, 
sum(case when i.status = 'Failed' then 1 else 0 end) as failed_payments_count from users u
join subscriptions s on  u.user_id = s.user_id
join invoice i on i.subscription_id = s.subscription_id 
group by u.user_id,u.user_name, u.country
having sum(case when i.status = 'Failed' then 1 else 0 end) > 0 and
sum(case when i.status = 'Paid' then 1 else 0 end) = 0
order by failed_payments_count desc, u.user_name;
