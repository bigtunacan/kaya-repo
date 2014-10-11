## When the User sends an SMS
## SendHub POSTs the payload through Webhoook
## SAMPLE RAW PAYLOAD below

##  

## bot_client_name = "+14155086888"
## sms_text = "gratitude checkin"

#  Set up SendHub variables
#   ENV["NUMBER"] = '4155086888'
#   ENV["APIKEY"] =  'ab94c92b97bc6c18e53d4c4465ebd84318029ccc'

require 'cgi'
require 'iron_cache'

load './bot_response.rb'
load './email_client.rb'
load './response_pair.rb'

puts "Payload: #{@payload}"

puts params = CGI::parse(@payload)
puts "sms_text from botwillio_worker.rb"
sms_text = params['Body'][0]
puts sms_text.inspect

phone_number = params['From'] #this ends up being an array
puts sms_number = phone_number[0]  #this extracts the number as a string
puts bot_client_name = phone_number[0].gsub!(/[^a-zA-Z0-9\-]/,"") #this turns it into a usable string by removing the +

ResponsePair.store_last_inbound(sms_text,bot_client_name)

get_bot_response = BotResponse.get_bot_response(bot_client_name, sms_text)

puts "get_bot_response: #{get_bot_response}"

unless sms_text.match(/\b\S+@\S+\b/).nil?
  ## extra email address from get_bot_response
  puts email = sms_text.match(/\b\S+@\S+\b/)
  puts EmailClient.send(email, email)
end  

BotResponse.send_sms(sms_number, get_bot_response['bot_response'])  
ResponsePair.store_last_outbound(get_bot_response['bot_response'],bot_client_name)

response_pair = JSON.parse(ResponsePair.compare_response_pair (bot_client_name))

if response_pair['outbound'].include? "I will remind you tomorrow for you quadrinity check"
  ScheduleBot.create_schedule(bot_client_name, "tomorrow")
end  


      
      
