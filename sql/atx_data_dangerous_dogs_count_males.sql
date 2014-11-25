select count(*)
from dangerous_dogs
where description like '%female%'
order by count desc;