require 'rubygems'
require 'sinatra'
require 'sinatra/json'
require 'json'
require 'iron_cache'

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
  return "hello"
end

post '/angular' do

  data = JSON.parse(request.body.read)
  json data

end

post '/cache/:task_id' do
  @client = IronCache::Client.new
  @cache = @client.cache("kaya_web_response")
  return @cache.get(params[:task_id]).value
end  


