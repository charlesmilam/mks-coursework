select name, count(description) as inspect_cnt
from restaurant_scores
group by name
order by inspect_cnt desc
