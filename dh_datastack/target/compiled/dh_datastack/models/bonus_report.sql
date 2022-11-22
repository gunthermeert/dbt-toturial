with cte_get_employee_id as (
select min(id) as min_id, max(id) as max_id
from DH_DATASTACK_ANALYTICS.PUBLIC.stg_employee)
, cte_estate_seller as (select *, uniform(1, 5, random()) as employee_id 
from DH_DATASTACK_ANALYTICS.PUBLIC.stg_estate)
, cte_estate_seller_info as (
select * from cte_estate_seller ces 
inner join DH_DATASTACK_ANALYTICS.PUBLIC.stg_employee se 
on ces.employee_id = se.id)
select first_name, last_name, date_trunc('month', date_valued_at) as month, sum(value) as total_amount_sold, sum(value) * 0.01 as bonus 
from cte_estate_seller_info
group by first_name, last_name, date_trunc('month', date_valued_at)
order by date_trunc('month', date_valued_at) desc