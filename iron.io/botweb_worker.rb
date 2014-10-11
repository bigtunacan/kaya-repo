## file:  botweb_worker.rb
## When the User POSTS to this worker
## from the web client  

## bot_client_name = "+14155086888"
## sms_text = "gratitude checkin"

require 'cgi'
require 'iron_cache'

load './bot_response.rb'
load './email_client.rb'
load './response_pair.rb'

puts "Payload: #{@payload}"
puts params

web_inbound = params['input']
puts web_inbound.inspect

#bot_client_name needs to be established from either a cookie
#or from a login from the user.  Until then, it is UNKNOWN

bot_client_name = "unknown"

ResponsePair.store_last_inbound(web_inbound,bot_client_name)

get_bot_response = BotResponse.get_bot_response(bot_client_name, web_inbound)

puts "get_bot_response: #{get_bot_response}"

##write the response to the cache using iron_task_id

@client = IronCache::Client.new
@cache = @client.cache('kaya_web_response')
puts iron_task_id
puts get_bot_response['bot_response']

@cache.put(iron_task_id,get_bot_response['bot_response'])


unless web_inbound.match(/\b\S+@\S+\b/).nil?
  ## extra email address from get_bot_response
  puts email = web_inbound.match(/\b\S+@\S+\b/)
  puts EmailClient.send(email, email)
end  

BotResponse.send_web_response(get_bot_response['bot_response'])  
ResponsePair.store_last_outbound(get_bot_response['bot_response'],bot_client_name)

response_pair = JSON.parse(ResponsePair.compare_response_pair (bot_client_name))

## need to send response back to the client that made the POST request???

      
      
