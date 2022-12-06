with source as (
    select * from {{ source('active_campaign','campaigns') }}
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