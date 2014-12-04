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

get "/airline_most_least_delays" do
  @content = OntimeDB.arrival_delays

  erb :airline_most_least_delays
end
