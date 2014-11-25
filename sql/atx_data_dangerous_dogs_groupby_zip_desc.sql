select zip_code, count(*)
from dangerous_dogs
group by zip_code
order by count desc;