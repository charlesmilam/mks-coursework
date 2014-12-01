require 'sinatra'
require "pig_latin"

get '/translate' do
  erb :translate
end

post '/translate' do
  puts params
  @word = params[:word]
  @pigified = PigLatin.translate(@word)
  erb :result
end
