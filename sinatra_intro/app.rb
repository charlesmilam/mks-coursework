require "rubygems"
require "sinatra"
require "pry-byebug"

get "/time" do
  erb :time
end

get "/gather-info" do
  erb :info 
end