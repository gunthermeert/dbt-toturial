select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select national_insurance_nbr
from DH_DATASTACK_ANALYTICS.PUBLIC.stg_employee
where national_insurance_nbr is null



      
    ) dbt_internal_test