select count(*)
from dangerous_dogs
where description like '%male%'
and description not like '%female%'
order by count desc;