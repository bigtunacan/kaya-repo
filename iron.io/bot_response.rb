## file: bot_response.rb
## Sample Data:
## bot_client_name = "14155086888"
# sms_text = "timfong888@gmail.com"

class BotResponse
  require 'rest_client'
  require 'iron_cache'
  require 'twilio-ruby'
  
  def self.get_bot_response (bot_client_name, inbound_text) ## send the text to the bot and get a response back
    puts "inbound_text"
    puts inbound_text.inspect
    #puts sms_text
    #puts "#{sms_text}"
    
    url_talk_bot= "https://aiaas.pandorabots.com/talk/#{ENV['APP_ID']}/#{ENV['BOTNAME']}"
   # url_talk_bot = 'http://requestb.in/10ct31z1'
    puts "url_talk_bot = '#{url_talk_bot}'"
    
    data = {:input => "#{inbound_text}", 'user_key' => ENV['USER_KEY'], 'client_name' => "#{bot_client_name}" }
    puts data
    puts talkresponse = (RestClient.post url_talk_bot, data)
    talkresponse = JSON.parse(talkresponse)
    
    get_bot_response = {'session_id' => talkresponse['sessionid'],'bot_response' => talkresponse['responses'][0],'status' => talkresponse['status']}
    puts "inside get_bot_response to sms_text = #{inbound_text}: #{bot_client_name} #{get_bot_response}"
    return get_bot_response  
                
  end
  
  def self.send_sms (sms_number, bot_response)

    puts sms_number
    puts "bot_response: #{bot_response}"
    
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV["AUTH_TOKEN"]
 
    message = @client.account.messages.create(:body => "#{bot_response}", :to => "+#{sms_number}", :from => "+16264145292")
    puts message.to
    
  end
  
  def self.send_web_response (bot_response)
    return bot_response   
  end  
end