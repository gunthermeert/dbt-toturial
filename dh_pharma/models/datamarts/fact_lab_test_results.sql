with cte_dim_physicians as (
select * from {{ ref('dim_physicians') }}
), cte_dim_patients as (
select * from {{ ref('dim_patients') }}
), cte_dim_lab_tests as (
select * from {{ ref('dim_lab_tests') }}
), cte_dim_lab_test_measurement_types as (
select * from {{ ref('dim_lab_test_measurement_types') }}
), cte_int_lab_test_results as (
select * from {{ ref('int_dh_pharma__lab_test_results') }}
), cte_fact_lab_test_results as (
select ciltr.lab_test_result_id
, order_date.date_id as order_date_id
, test_date.date_id as test_date_id
, coalesce(cdp.patient_sk, '-1') as patient_sk
, coalesce(dp.physician_sk, '-1') as physician_sk
, coalesce(lt.lab_test_sk, '-1') as lab_test_sk
, coalesce(ltmt.lab_test_measurement_type_sk, '-1') as lab_test_measurement_type_sk
, ciltr.observed_test_result_value
from cte_int_lab_test_results ciltr
inner join dh_pharma.dim_date order_date
on order_date.date = ciltr.order_date
inner join dh_pharma.dim_date test_date
on test_date.date = ciltr.test_date
left join cte_dim_patients cdp
on ciltr.patient_id = cdp.patient_id
and ciltr.insert_dt >= cdp.valid_from::date
and ciltr.insert_dt < cdp.valid_to::date
left join cte_dim_physicians dp
on ciltr.physician_id = dp.physician_id
and ciltr.insert_dt >= dp.valid_from::date
and ciltr.insert_dt < dp.valid_to::date
left join cte_dim_lab_tests lt
on ciltr.lab_test_id = lt.lab_test_id
and ciltr.insert_dt >= lt.valid_from::date
and ciltr.insert_dt < lt.valid_to::date
left join cte_dim_lab_test_measurement_types ltmt
on ciltr.lab_test_measurement_type_id = ltmt.lab_test_measurement_type_id
and ciltr.insert_dt >= ltmt.valid_from::date
and ciltr.insert_dt < ltmt.valid_to::date
) select * from cte_fact_lab_test_results






