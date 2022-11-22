begin;
    
        
            
            
        
    

    

    merge into DH_DATASTACK_ANALYTICS.PUBLIC.stg_employee as DBT_INTERNAL_DEST
        using DH_DATASTACK_ANALYTICS.PUBLIC.stg_employee__dbt_tmp as DBT_INTERNAL_SOURCE
        on 
                DBT_INTERNAL_SOURCE.national_insurance_nbr = DBT_INTERNAL_DEST.national_insurance_nbr
            

    
    when matched then update set
        city = DBT_INTERNAL_SOURCE.city
    

    when not matched then insert
        ("ID", "NATIONAL_INSURANCE_NBR", "FIRST_NAME", "LAST_NAME", "CITY", "UPDATE_TS", "INSERT_TS")
    values
        ("ID", "NATIONAL_INSURANCE_NBR", "FIRST_NAME", "LAST_NAME", "CITY", "UPDATE_TS", "INSERT_TS")

;
    commit;