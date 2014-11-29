require "rubygems"
require "sinatra"
require "pry-byebug"

get "/welcome" do 
  erb :welcome
end
