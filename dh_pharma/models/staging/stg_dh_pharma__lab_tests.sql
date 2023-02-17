with lab_tests as (
select lab_test_id
, name
, category
from {{ ref('lab_test') }}
) select * from lab_tests