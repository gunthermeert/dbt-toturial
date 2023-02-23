with physicians as (
select physician_id
, specialization
, street_name
, house_number
, City
, District
, State
, Country
from {{ source('dh_pharma', 'physician') }}
) select * from physicians