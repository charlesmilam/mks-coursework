select zip, avg(score) as avg
from restaurant_scores
group by zip
order by avg desc