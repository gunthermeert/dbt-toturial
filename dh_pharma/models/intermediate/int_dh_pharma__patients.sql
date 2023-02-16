{{
    config(
        materialized='incremental'
    )
}}

with patients as (
select dbt_scd_id as patient_sk
, patient_id
, age
, street_name
, house_number
, city
, district
, state
, country
, dbt_updated_at as insert_ts
, dbt_updated_at as update_ts
, dbt_valid_from as valid_from
, coalesce(dbt_valid_to, '9999-12-31')::timestamp as valid_to
, case when dbt_valid_to is null then 1 else 0 end as current_flg
from {{ ref('snap_patients') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where dbt_updated_at > (select max(dbt_updated_at) from {{ this }})

{% endif %}
) select * from patients