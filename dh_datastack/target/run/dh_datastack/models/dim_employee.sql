
  
    

        create or replace transient table DH_DATASTACK_ANALYTICS.PUBLIC.dim_employee  as
        (select * from DH_DATASTACK_ANALYTICS.snapshot.employee_snapshot
        );
      
  