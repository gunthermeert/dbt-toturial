{% test time_travel_equal_nbr_of_records(model, column_name, count, period, expression, where_clause, quote=False) %}

with time_travel as (
    select count(*) nbr_records_time_travel
    from {{ model }}
    at(timestamp => dateadd({{ period }}, -{{ count }}, current_timestamp()))
    where {{ where_clause }}
), current_data as (
    select count(*) as nbr_records_current_data
    from {{ model }}
    where {{ where_clause }}
), difference as (
select abs((select nbr_records_time_travel from  time_travel)- (select nbr_records_current_data from  current_data)) as nbr_different
)
select *
from difference
where nbr_different <> 0
{% endtest %}


