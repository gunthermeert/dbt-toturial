with source as (
    select * from {{ source('dh_datastack_sales_mdm','STG_DH_DATASTACK_MDM__PRODUCTS') }}
),
products as (
    select
    product_id,
    product,
    category,
    sub_category,
    brand,
    sale_price,
    market_price,
    product_type,
    rating,
    description
    from source
)
select * from products