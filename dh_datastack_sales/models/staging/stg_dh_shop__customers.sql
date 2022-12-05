with source as (
    select * from {{ source('dh_datastack_sales_mdm','STG_DH_DATASTACK_MDM__CUSTOMERS') }}
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
        first_phone,
        second_phone,
        email
    from source
)
select * from customers