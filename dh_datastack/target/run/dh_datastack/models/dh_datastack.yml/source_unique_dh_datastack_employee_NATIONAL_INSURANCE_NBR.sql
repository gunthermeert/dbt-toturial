select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    NATIONAL_INSURANCE_NBR as unique_field,
    count(*) as n_records

from DH_DATASTACK_RAW.REAL_ESTATE_ATLAS.employee
where NATIONAL_INSURANCE_NBR is not null
group by NATIONAL_INSURANCE_NBR
having count(*) > 1



      
    ) dbt_internal_test