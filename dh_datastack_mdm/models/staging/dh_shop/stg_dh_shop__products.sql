with source as (
    select * from {{ source('dh_shop','products') }}
),
products as (
    select
    index as product_id,
    product,
    category,
    sub_category,
    brand,
    sale_price,
    market_price,
    type as product_type,
    rating,
    description,
    current_timestamp() as loaded_at
    from source
)
select * from products