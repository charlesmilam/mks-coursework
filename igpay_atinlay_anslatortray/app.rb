require 'sinatra'

get '/translate' do
  erb :translate
end

post '/translate' do
  erb :result
end