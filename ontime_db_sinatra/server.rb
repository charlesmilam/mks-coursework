require "sinatra"
require "./lib/ontime_db"


get "/" do 
  erb :index
end

get "/airlines" do
  #puts OntimeDB.methods
  @content = OntimeDB.airlines

  erb :airlines
end
