SELECT 
  actors.name as Actor, 
  count(actors_movies.movie_id) as Appearances
FROM 
  public.actors_movies, 
  public.actors
WHERE 
  actors_movies.actor_id = actors.id
GROUP BY
  actors.name
ORDER BY
  actors.name ASC;
