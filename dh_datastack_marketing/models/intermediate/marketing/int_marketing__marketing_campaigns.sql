with
cte_daily_product_sales as (
    select * from {{ ref('stg_dh_datastack_finance__daily_product_sales') }}
),
cte_customers as
(
    select * from {{ ref('stg_dh_datastack_mdm__customers') }}
),
cte_products as
(
    select * from {{ ref('stg_dh_datastack_mdm__products') }}
),
cte_campaigns as
(
    select * from {{ ref('stg_dh_datastack_marketing__campaigns') }}
)
, cte_final as (
    select *
    from cte_daily_product_sales
)
select *
from cte_final

