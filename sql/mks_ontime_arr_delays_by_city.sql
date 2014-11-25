select origin_city_name, count(dep_delay_new) as delays
from on_time_perf
where arr_delay_new > 0
group by origin_city_name
order by delays desc;