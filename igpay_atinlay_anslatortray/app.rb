require 'sinatra'
require "pig_latin"

get '/translate' do
  erb :translate
end

post '/translate' do
  puts params
  # pigger = PigLatin.new
  @word = params[:word]
  @pigified = PigLatin.translate(@word)
  erb :result
end
