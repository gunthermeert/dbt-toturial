with cte_estate as (
   select * from DH_DATASTACK_ANALYTICS.PUBLIC.stg_estate
)
select region_name, date_trunc('month', date_valued_at) as date_valued_at, avg(value) as avg_value
from cte_estate
group by region_name, date_trunc('month', date_valued_at)
order by region_name, date_trunc('month', date_valued_at)