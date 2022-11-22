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
        email
    from source
)
select * from customers