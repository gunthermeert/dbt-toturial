{% test time_travel_comparison(model, column_name, expression) %}

with time_travel as (
    select *
    from {{ model }}
    at(timestamp => dateadd(minute, -2, current_timestamp()))
    where customer_id = 1
), current_data as (
    select *
    from {{ model }}
    where customer_id = 1
), meet_condition as (
    select *
    from time_travel tt
    inner join current_data cd
    on tt.customer_id = cd.customer_id
    where tt.first_name <> cd.first_name
)
select
    *
from meet_condition
{% if column_name is none %}
where not({{ expression }})
{%- else %}
where not({{ column_name }} {{ expression }})
{%- endif %}

{% endtest %}


