with lab_test_results as (
select lab_test_result_id,
order_date,
test_date,
patient_id,
physician_id,
lab_test_id,
lab_test_measurement_type_id,
unit_of_measure,
observed_test_result_value
from {{ source('dh_pharma', 'lab_test_results') }}
) select * from lab_test_results