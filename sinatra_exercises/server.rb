require "rubygems"
require "sinatra"
require "pry-byebug"

get "/welcome/:name" do 
  @name = params[:name]
  erb :welcome
end

get "/say/*/to/*" do
  puts params
  erb :say
end

get "/registration" do
  @name = params[:name]
  @breed = params[:breed]
  @vaccinated = params[:vaccinated]
  @color = params[:color]
  erb :registration
end

get "/results" do
  erb :results
end