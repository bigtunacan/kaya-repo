require 'rubygems'
require 'sinatra'
require 'json'
require 'iron_cache'
require 'haml'
require "bundler/setup"
require 'rest_client'

get '/' do
  haml :index
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
  puts "params: #{params}"
  puts params[:input]
  puts @json = JSON.parse(request.body.read)
  return params[:input]  
end

post '/cache/:task_id' do
  @client = IronCache::Client.new
  @cache = @client.cache("kaya_web_response")
  return @cache.get(params[:task_id]).value
end  


