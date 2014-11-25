select carrier, count(dep_delay_new) + count(arr_delay_new) as delays
from on_time_perf
where arr_delay_new > 0
and dep_delay_new > 0
group by carrier
order by delays desc;