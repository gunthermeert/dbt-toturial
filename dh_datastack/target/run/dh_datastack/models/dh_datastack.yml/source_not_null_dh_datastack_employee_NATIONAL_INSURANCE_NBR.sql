select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select NATIONAL_INSURANCE_NBR
from DH_DATASTACK_RAW.REAL_ESTATE_ATLAS.employee
where NATIONAL_INSURANCE_NBR is null



      
    ) dbt_internal_test