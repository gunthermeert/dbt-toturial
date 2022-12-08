with source as (
    select * from {{ source('dh_datastack_marketing','CAMPAIGNS') }}
),
campaigns as (
    select
        campaign_id,
        display_name,
        target_audience,
        start_dt,
        end_dt
    from source
)
select * from campaigns