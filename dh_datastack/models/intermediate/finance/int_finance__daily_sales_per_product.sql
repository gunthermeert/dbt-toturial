with
cte_dates as
(
    select * from {{ ref('all_dates') }}
),
cte_customers as
(
    select * from {{ ref('stg_dh_shop__customers') }}
),
cte_products as
(
    select * from {{ ref('stg_dh_shop__products') }}
),
cte_orders as
(
    select * from {{ ref('stg_dh_shop__orders') }}
),
cte_orderlines as
(
    select * from {{ ref('stg_dh_shop__orderlines') }}
)
select *
from cte_dates cd
left join cte_orders co
on cd.date_day = co.order_date;

