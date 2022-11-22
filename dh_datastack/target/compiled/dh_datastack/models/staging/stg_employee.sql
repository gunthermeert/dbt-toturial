

select id
, national_insurance_nbr
, first_name
, last_name
, city
, update_ts
, current_timestamp as insert_ts
from DH_DATASTACK_RAW.REAL_ESTATE_ATLAS.EMPLOYEE



  -- this filter will only be applied on an incremental run
  where update_ts > (select max(update_ts) from DH_DATASTACK_ANALYTICS.PUBLIC.stg_employee)

