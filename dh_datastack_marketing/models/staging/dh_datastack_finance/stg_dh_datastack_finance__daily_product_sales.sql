with source as (
    select * from {{ source('dh_datastack_finance','DAILY_PRODUCT_SALES') }}
),
daily_product_sales as (
    select
    order_date,
    product,
    quantity,
    revenue
    from source
)
select * from daily_product_sales