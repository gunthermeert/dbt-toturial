with source as (
    select * from {{ source('dh_datastack_finance_dh_shop','orderlines') }}
),
orderlines as (
    select
    orderline_id,
    order_id,
    product_id,
    quantity as amount_sold
    from source
)
select * from orderlines