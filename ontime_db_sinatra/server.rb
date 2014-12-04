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

get "/city_depart_delays" do
  @content = OntimeDB.city_depart_delays

  erb :city_depart_delays
end

get "/city_arrv_delays" do
  @content = OntimeDB.city_arrv_delays

  erb :city_arrv_delays
end

get "/avg_delay_all" do
  @content = OntimeDB.avg_delay_all

  erb :avg_delay_all
end

get "/airline_avg_delay" do
  @content = OntimeDB.airline_avg_delay

  erb :airline_avg_delay
end