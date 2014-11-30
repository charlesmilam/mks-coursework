require "pg"
require "json"
require "rest-client"

class MoviesSetup
  def initialize
    # connection to database
    @db = PG::Connection.open(dbname: 'movies')
    # database tables
    @movies_table = "movies"
    @actors_table = "actors"
    @movies_actors_table = "movies_actors"
    @actors_movies_table = "actors_movies"
    # api url
    @api = "http://movies.api.mks.io/"
    # api resources
    @movies = "movies/"
    @actors = "actors/"
    @movies_actors = "movies/"
    @actors_movies = "actors/"
    
  end

  # create database tables
  def make_tables
    sql_create_tables = %Q[
      create table if not exists #{@movies_table}
      (id integer primary key, 
      title varchar not null
      );

      create table if not exists #{@actors_table}
      (id integer primary key, 
      name varchar not null
      );

      create table if not exists #{@actors_movies_table}
      (id serial primary key,
      actor_id integer references #{@actors_table} (id), 
      movie_id integer references #{@movies_table} (id)
      );

      create table if not exists #{@movies_actors_table}
      (id serial primary key,
      movie_id integer references #{@movies_table} (id),
      actor_id integer references #{@actors_table} (id)
      );
    ]
    
    @db.exec(sql_create_tables)
  end

  # populate movies table
  def populate_movies
    result =  JSON.parse(RestClient.get @api + @movies)
    
    # prepared statement
    statement_insert_movies = %Q[ 
        insert into #{@movies_table}
        (id, title)
        values ($1, $2)
      ]
    @db.prepare("insert_movies", statement_insert_movies)

    # populate table using prepared statement  
    result.each do |movie|
      @db.exec_prepared("insert_movies", [movie["id"], movie["title"]])
    end
  end

  # populate actors table
  def populate_actors
    result =  JSON.parse(RestClient.get @api + @actors)

    # prepared statement
    statement_insert_actors = %Q[ 
        insert into #{@actors_table}
        (id, name)
        values ($1, $2)
      ]
    @db.prepare("insert_actors", statement_insert_actors)

    # populate table using prepared statement  
    result.each do |actor|
      @db.exec_prepared("insert_actors", [actor["id"], actor["name"]])
    end
  end

  # populate actors_movies table
  def populate_actors_movies
    # prepared statement
    statement_insert_actors_movies = %Q[ 
        insert into #{@actors_movies_table}
        (actor_id, movie_id)
        values ($1, $2)
      ]
    @db.prepare("insert_actors_movies", statement_insert_actors_movies)

    # query for existing actors
    sql_actors = %Q[select * from #{@actors_table}]
    result_actors = @db.exec(sql_actors)

    # # iterate through actors
    result_actors.each do |actor|
      result_actors_movies = JSON.parse(RestClient.get @api + @actors + actor["id"] + "/" + @movies)
        # iterate through actors_movies and insert into table
        result_actors_movies.each do |actor_movie|
         @db.exec_prepared("insert_actors_movies", [actor["id"].to_i, actor_movie["id"].to_i])
        end
    end
  end

   # populate movies_actors table
  def populate_movies_actors
    # prepared statement
    statement_insert_movies_actors = %Q[ 
        insert into #{@movies_actors_table}
        (actor_id, movie_id)
        values ($1, $2)
      ]
    @db.prepare("insert_movies_actors", statement_insert_movies_actors)

    # query for existing actors
    sql_actors = %Q[select * from #{@movies_table}]
    result_movies = @db.exec(sql_actors)

    # # iterate through actors
    result_movies.each do |movie|
      result_movies_actors = JSON.parse(RestClient.get @api + @actors + movie["id"] + "/" + @movies)
        # iterate through movies_actors and insert into table
        result_movies_actors.each do |movie_actor|
         @db.exec_prepared("insert_movies_actors", [movie["id"].to_i, movie_actor["id"].to_i])
        end
    end
  end

  # retrieve all actors, sorted ascending
  def all_actors
    sql = %Q[
      select * from #{@actors_table}
      order by name asc
    ]

    # output a header
    puts "Actors"
    puts "------------------------"

    # execute query and iterate through the result set
    results = @db.exec(sql)
    results.each do |actor|
      puts "#{actor["name"]}"
    end
  end

  # retrieve all movies, sorted ascending
  def all_movies
    sql = %Q[
      select title from #{@movies_table}
      order by title asc
    ]

    # output a header
    puts "Movies"
    puts "------------------------"

    # execute query and iterate through the result set
    results = @db.exec(sql)
    results.each do |movie|
      puts "#{movie["title"]}"
    end 
  end

  # retrieve actors and count the frequency of their movie appearances
  def actors_frequency
    sql = %Q[
      SELECT 
        actors.name as actor, 
        count(actors_movies.movie_id) as appearances
      FROM 
        public.actors_movies, 
        public.actors
      WHERE 
        actors_movies.actor_id = actors.id
      GROUP BY
        actors.name
      ORDER BY
        actors.name ASC
    ]

    # output a header
    puts "Actor      |       Appearances"
    puts "______________________________"

    #execut the query and iterate through the result set
    results = @db.exec(sql)
    results.each do |actor|
      puts "#{actor["actor"]} | 
      #{actor["appearances"]}"
    end
  end

  # retrieve all movies and list actors
  def all_movies_with_actors movie
    sql = %Q[
      SELECT 
        movies.title as movie, 
        actors.name as actor
      FROM 
        public.actors, 
        public.movies_actors, 
        public.movies
      WHERE 
        movies.title = '#{movie}' AND
        movies_actors.actor_id = actors.id AND
        movies_actors.movie_id = movies.id
      ORDER BY
        movies.title ASC, 
        actors.name ASC
    ]

    # output a header
    puts "Movie         |  Actor"
    puts "----------------------"

    # execute the query and iterate through the results
    results = @db.exec(sql)
    results.each do |movie|
      puts "#{movie["movie"]}       #{movie["actor"]}"
    end
  end

end 

movies = MoviesSetup.new

movies.make_tables
#movies.populate_movies
#movies.populate_actors
#movies.populate_actors_movies
#movies.populate_movies_actors
#movies.all_actors
#movies.all_movies
#movies.actors_frequency
movies.all_movies_with_actors "Star Dust"
#movies.all_pets