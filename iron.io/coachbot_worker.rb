require 'rest_client'

## When the User sends an SMS
## SendHub POSTs the payload through Webhoook
## SAMPLE RAW PAYLOAD below

## {"timestamp": 1412199885, "type": "receivedMessage", "requestId": "SHda40cb6a4bc821868d2bfba1bc856e0d", "data": {"message": {"direction": "incoming", "user_id": "110071782766020150", "deleted": false, "text": "Hello testbin", "created_at": "2014-10-01T21:44:44", "modified_at": "2014-10-01T21:44:44", "id": "110429192706853754", "thread_id": "110408889879497140", "link": "", "hash": ""}}}

## This is going to be set in coachbot.worker file

   ENV["APP_ID"] = "1409611358153"
   ENV["USER_KEY"] = '3b9ccb48e734fce6b982a9c1c2cef301'
   ENV["BOTNAME"] = 'coachbot'

#  Set up SendHub variables
   ENV["NUMBER"] = '4155086888'
   ENV["APIKEY"] =  'ab94c92b97bc6c18e53d4c4465ebd84318029ccc'

puts "Payload: #{params}"

puts sms_message_id = params['data']['message']['id']
puts sms_text = params['data']['message']['text']

## IS THERE A WAY TO RUN A RUBY SCRIPT BASED ON A THREAD?

## get message status based on message ID
## get contact ID
## passing:  sms_message_id


## Talk with a Bot based on
## SendHub ContactID
## Send SMS Text to the Bot
## Assign Client Name based on contact_id

class BotResponse
  require 'rest_client'

  def self.get_contact_id_from_inbound_sms 
     url_get_status = "https://api.sendhub.com/v1/messages/#{sms_message_id}/?username=#{ENV['NUMBER']}&api_key=#{ENV['APIKEY']}"
     response_get_status = JSON.parse(RestClient.get url_get_status)
     contact_id = response_get_status['contacts'][0]['id']
   
     return contact_id
  end
  
  def self.get_bot_response (contact_id, sms_text) ## send the text to the bot and get a response back
    
    url_talk_bot= "https://aiaas.pandorabots.com/talk/#{ENV['APP_ID']}/#{ENV['BOTNAME']}"
    talkresponse = JSON.parse(RestClient.post url_talk_bot, :user_key => "#{ENV['USER_KEY']}", :input=>"#{sms_text}", :client_name => "#{contact_id}")
    bot_response = {'session_id' => talkresponse['sessionid'],'botresponse' => talkresponse['responses'][0],'status' => talkresponse['status']}
    
    return bot_response              
  end
  
  def self.send_sms (contact_id, botresponse)
    url_sms = "https://api.sendhub.com/v1/messages/?username=#{ENV['NUMBER']}\&api_key=#{ENV['APIKEY']}"

    ## smspacket = "{'contacts':[110159322493749259], 'text' : 'Testing' }" 
    smspacket = {:contacts => ["#{contact_id}"], :text => "#{botresponse}" }.to_json

    response = RestClient.post url_sms , smspacket, {:content_type => 'application/json'}

    return response
  end
end
BotResponse.get_contact_id_from_inbound_sms

get_bot_response = BotResponse.get_bot_response(contact_id,sms_text)

BotResponse.send_sms(contact_id, get_bot_response['botresponse'])  

      
      
