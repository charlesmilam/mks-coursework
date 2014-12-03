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
  @movie_result.each {|movie| puts movie}
  @actors_result.each {|actor| puts actor}
  erb :"movies"
end

get "/actors/:id" do
  puts params
  @actor_result = JSON.parse(RestClient.get api_actors + params["id"] + "/movies")
  @actor_name = JSON.parse(RestClient.get api_actors + params["id"])
  puts @actor_result
end