require "sinatra"

get '/' do
  erb :index
end

get '/movies' do
  erb :"movies/index"
end