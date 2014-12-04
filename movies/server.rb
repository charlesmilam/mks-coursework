require "sinatra"
require "json"
require "rest-client"

api = "http://movies.api.mks.io/movies/"
api_actors = "http://movies.api.mks.io/actors/"

get '/' do
  @index_results = JSON.parse(RestClient.get api)
  erb :"index"
end

get '/movies/:id' do
  @movie_result = JSON.parse(RestClient.get api + params["id"])
  @actors_result = JSON.parse(RestClient.get api + params["id"] + "/actors")

  erb :"movies"
end

get '/actors/:id' do
  @actor_result = JSON.parse(RestClient.get api_actors + params["id"] + "/movies")
  @actor_name = JSON.parse(RestClient.get api_actors + params["id"])
  
  erb :"actors"
end