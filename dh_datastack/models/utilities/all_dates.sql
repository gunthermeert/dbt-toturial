{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2022-10-01' as date)",
    end_date="cast('2022-11-23' as date)"
   )
}}