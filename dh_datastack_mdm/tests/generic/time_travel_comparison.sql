{% test time_travel_comparison(model, column_name, unique_key, check_cols, expression, quote=True) %}

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
    on tt.{{ unique_key }} = cd.{{ unique_key }}
    where
        {% for col in check_cols -%}
        {% if quote -%}
        tt.'{{ col }}' <> cd.'{{ col }}'
        {%- else -%}
        tt.{{ col }} <> cd.{{ col }}
        {%- endif -%}
        {%- if not loop.last -%} or {%- endif %}
    {%- endfor %}


)
select
    *
from meet_condition
{% endtest %}


