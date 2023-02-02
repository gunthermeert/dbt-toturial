{{
    config(
        materialized='incremental'
        unique_key='customer_id'
    )
}}
with source as (
    select * from {{ source('dh_shop','customers') }}
),
customers as (
    select
        customer_id,
        first_name,
        last_name,
        company_name,
        address,
        city,
        county,
        postal,
        phone1 as first_phone,
        phone2 as second_phone,
        email,
        current_timestamp() as loaded_at,
        update_ts
    from source
)
select * from customers
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where update_ts > (select max(update_ts) from {{ this }})

{% endif %}