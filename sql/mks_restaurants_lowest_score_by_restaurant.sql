select name, min(score) as min_score
from restaurant_scores
group by name
order by min_score
