{% test value_higher_then(model, column_name, number_value) %}

with value_higher_then as (
        select {{ column_name }}
        from {{ model }}
        where {{ column_name }} < {{ number_value }}
)
select * from value_higher_then

{% endtest %}




