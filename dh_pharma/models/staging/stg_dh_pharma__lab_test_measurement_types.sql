with lab_test_measurement_types as (
select Lab_Test_Measurement_Type_ID
, Unit_Of_Measure
, Reference_Minimum_Value
, Reference_Maximum_Value
, Description
from {{ source('dh_pharma', 'lab_test_measurement_type') }}
) select * from lab_test_measurement_types