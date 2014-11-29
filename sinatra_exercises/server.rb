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
