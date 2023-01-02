with
cte_customers as
(
    select * from {{ ref('stg_dh_datastack_mdm__customers') }}
),
cte_products as
(
    select * from {{ ref('stg_dh_datastack_mdm__products') }}
),
cte_orders as
(
    select * from {{ ref('stg_dh_shop__orders') }}
),
cte_orderlines as
(
    select * from {{ ref('stg_dh_shop__orderlines') }}
),
/*cte_campaigns as
(
    select * from {{ ref('stg_dh_datastack_marketing__campaigns') }}
)*/
, cte_final as (
    select col.orderline_id, co.order_id, cp.product_id, cc.customer_id, co.order_date, cp.product, col.amount_sold as quantity, cp.market_price as price
    from cte_orderlines col
    inner join cte_orders co
    on col.order_id = co.order_id
    inner join cte_products cp
    on col.product_id = cp.product_id
    inner join cte_customers cc
    on co.customer_id = cc.customer_id
)
select *
from cte_final

