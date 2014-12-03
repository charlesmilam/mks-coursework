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
  puts params
  @movie_result = JSON.parse(RestClient.get api + params["id"])
  @actors_result = JSON.parse(RestClient.get api + params["id"] + "/actors")
  @movie_result.each {|movie| puts movie}
  puts @movie_result["title"]
  @actors_result.each {|actor| puts actor}
  erb :"movies"
end

get "/actors/:id/movies"
  @actor_result = JSON.parse(RestClient.get api + params["id"] + "/actors")
end