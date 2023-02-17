{{
    config(
        materialized='incremental',
        unique_key='lab_test_measurement_type_sk'
    )
}}

with lab_test_measurement_types as (
select dbt_scd_id as lab_test_measurement_type_sk
, lab_test_measurement_type_id
, unit_Of_Measure
, reference_minimum_value
, reference_maximum_value
, description
, dbt_updated_at as insert_ts
, coalesce(dbt_valid_to, dbt_updated_at) as update_ts
, dbt_valid_from as valid_from
, coalesce(dbt_valid_to, '9999-12-31')::timestamp as valid_to
, case when dbt_valid_to is null then 1 else 0 end as current_flg
from {{ ref('int_dh_pharma__lab_test_measurement_types') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where coalesce(dbt_valid_to, dbt_updated_at) > (select max(update_ts) from {{ this }})

{% endif %}
) select * from lab_test_measurement_types




