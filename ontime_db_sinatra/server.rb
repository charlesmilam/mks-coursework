require "sinatra"
require "./lib/ontime_db"

get "/" do 
  erb :index
end