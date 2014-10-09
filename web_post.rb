require 'rubygems'
require 'sinatra'

get '/' do
  "Hello, World!"
end

get '/hello/:name' do
  params[:name]
end

get '/form' do
  erb :form
end

post '/form' do
  "You said '#{params[:message]}'"
end


