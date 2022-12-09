{% test time_travel_comparison(model, column_name, unique_key, check_cols, count, period, expression, quote=False) %}

with time_travel as (
    select *
    from {{ model }}
    at(timestamp => dateadd({{ period }}, -{{ count }}, current_timestamp()))
), current_data as (
    select *
    from {{ model }}
), changes as (
    select tt.{{ unique_key }}, 'updated' as action_ind
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
        {%- if not loop.last %} or {% endif %}
    {%- endfor %}
), deletes as (
    select tt.{{ unique_key }}, 'deleted' as action_ind
    from time_travel tt
    left join current_data cd
    on tt.{{ unique_key }} = cd.{{ unique_key }}
    where cd.{{ unique_key }} is null
)
select *
from changes
union all
select *
from deletes
{% endtest %}


