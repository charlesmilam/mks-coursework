require "sinatra"
require "json"
require "rest-client"

api = "http://movies.api.mks.io/movies"

get '/' do
  @index_results = JSON.parse(RestClient.get api)
  erb :"index"
end

get '/movies' do

  erb :"movies/index"
end