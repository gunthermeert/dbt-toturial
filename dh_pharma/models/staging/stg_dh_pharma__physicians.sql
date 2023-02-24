with physicians as (
select physician_id
, specialization
, street_name
, house_number
, City
, District
, State
, Country
from {{ ref('physician') }}
) select * from physicians