select carrier, count(*) as delays
from on_time_perf
where arr_delay_new > 0
or dep_delay_new > 0
group by carrier
order by delays desc;