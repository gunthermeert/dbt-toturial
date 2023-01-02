with
cte_daily_product_sales as (
    select * from {{ ref('int_marketing__marketing_campaigns') }}
), cte_final as (
    select *
    from cte_daily_product_sales
)
select *
from cte_final

