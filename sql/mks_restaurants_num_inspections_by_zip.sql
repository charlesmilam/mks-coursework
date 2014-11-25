select zip, count(description)
from restaurant_scores
group by zip
order by count desc;
