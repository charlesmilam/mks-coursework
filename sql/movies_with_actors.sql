SELECT 
  movies.title as movie, 
  actors.name as actor
FROM 
  public.actors, 
  public.movies_actors, 
  public.movies
WHERE 
  movies_actors.actor_id = actors.id AND
  movies_actors.movie_id = movies.id
ORDER BY
  movies.title ASC, 
  actors.name ASC;
