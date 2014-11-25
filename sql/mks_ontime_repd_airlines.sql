select carrier, count(*)
from on_time_perf
group by carrier
order by count desc;