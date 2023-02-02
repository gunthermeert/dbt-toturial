{% test time_travel_compare_values(model, date_part, time_travel_interval, unique_key, compare_columns) %}
-- time travel comparison that checks if all values in column x are the same as before the load
-- test must also include checking for deleted records
-- e.g. test will fail if within timetravel record id=1 column_x = x and after load, record id=1 column_x = y -> column_x was updated
/*
parameters:
    date_part: string with values: seconds, minutes, hours, days, months, ...
    interval: integer of how much you want to go back in time from the current_timestamp
    unique_key: string,list, needed for check
    check_columns: string, list with columns to compare
*/
with cte_time_travel as (
select *, 'time_travel' as source
from {{ model }}
at(timestamp => dateadd({{ date_part }}, -{{ time_travel_interval }}, current_timestamp()))
), cte_current_data as (
select *, 'current' as source
from {{ model }}
), cte_updates as (
select ctt.customer_id
    from cte_time_travel ctt
    inner join cte_current_data ccd
    on ctt.{{ unique_key }} = ccd.{{ unique_key }}
    where coalesce(ctt.first_name, 'NULL') <> coalesce(ccd.first_name, 'NULL')
), cte_deletes as (
select ctt.customer_id
    from cte_time_travel ctt
    left join cte_current_data ccd
    on ctt.{{ unique_key }} = ccd.{{ unique_key }}
    {% for column in compare_columns -%}
    {%- if loop.first -%} where ctt."{{ column }}" <> ccd."{{ column }}"
    {%- else -%} or ctt."{{ column }}" <> ccd."{{ column }}"
    {%- endif %}
    {%- endfor %}
), cte_final as (
select count(*) as cnt
    from cte_updates
union all
select count(*) as cnt
    from cte_deletes
)
select cnt
from cte_final
where cnt <> 0;

{% endtest %}



