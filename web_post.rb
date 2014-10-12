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
  puts request.body.rewind
  puts request_payload = JSON.parse(request.body.read)
  
  puts "params: #{params}"

  puts @json = JSON.parse(request.body.read)
  
  return RestClient.post 'https://worker-aws-us-east-1.iron.io/2/projects/542c8609827e3f0005000123/tasks/webhook?code_name=botweb&oauth=LOo5Nc0x0e2GJ838_nbKoheXqM0'
   
end

post '/cache/:task_id' do
  @client = IronCache::Client.new
  @cache = @client.cache("kaya_web_response")
  return @cache.get(params[:task_id]).value
end  


