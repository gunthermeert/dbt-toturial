with patients as (
select patient_id
, age
, street_name
, house_number
, city
, district
, state
, country
from {{ ref('patient') }}
) select * from patients