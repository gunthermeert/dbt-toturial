{% test time_travel_record_count_threshold(model, period, period_value, threshold_value) %}
-- time travel comparison that checks if the new data has grown or decreased within the treshold limit
-- e.g. when count(*) of time travel state = 100 and threshold = 10%, the count(*) of the current data must be between 90 and 110.
/*
parameters:
    period: seconds, minutes, hours, days, months, ...
    period_value: integer of how much you want to go back in time from the current_timestamp
    threshold_value: integer for how much % the threshold may be from the time_travelled value
*/
with cte_time_travel as (
select count(*) as cnt_time_travel, 'time_travel' as source
from {{ model }}
at(timestamp => dateadd({{ period }}, -{{ period_value }}, current_timestamp()))
), cte_current_data as (
select count(*) as cnt_current, 'current' as source
from {{ model }}
), cte_prepare_threshold as (
select ctt.cnt_time_travel, ccd.cnt_current, abs(cnt_time_travel - cnt_current) as cnt_diff, (cnt_time_travel/100)*{{ threshold_value }} as threshold
from cte_time_travel ctt
inner join cte_current_data ccd
on ccd.source = 'current')
select * from cte_prepare_threshold
where cnt_diff > threshold

{% endtest %}


