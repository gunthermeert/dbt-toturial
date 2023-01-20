with
cte_dh_shop_products as (
    select * from {{ ref('stg_dh_shop__products') }}
)
select *
from cte_dh_shop_products

