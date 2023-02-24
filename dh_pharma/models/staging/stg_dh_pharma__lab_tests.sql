with lab_tests as (
select lab_test_id
, name
, category
from {{ source('dh_pharma', 'slab_test') }}
) select * from lab_tests