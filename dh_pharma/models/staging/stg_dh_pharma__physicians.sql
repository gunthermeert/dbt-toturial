with physicians as (
select physician_id
, specialization
, "Street Name" as street_name
, "House Number" as house_number
, City
, District
, State
, Country
from {{ ref('physician') }}
) select * from physicians