select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select national_insurance_nbr
from DH_DATASTACK_ANALYTICS.snapshot.employee_snapshot
where national_insurance_nbr is null



      
    ) dbt_internal_test