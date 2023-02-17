{{
    config(
        materialized='incremental'
        unique_key='patient_sk'
    )
}}

with patients as (
select patient_sk
, patient_id
, age
, street_name
, house_number
, city
, district
, state
, country
, insert_ts
, update_ts
, valid_from
, valid_to
, current_flg
from {{ ref('int_dh_pharma__patients') }}
{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where update_ts > (select max(update_ts) from {{ this }})

{% endif %}
) select * from patients