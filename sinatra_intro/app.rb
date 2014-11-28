require "rubygems"
require "sinatra"
require "pry-byebug"

get "/time" do
  erb :time
end