## file: email_client.rb
## contains class for communicating with client through email

class EmailClient
  require 'mandrill'
  
  def self.send(email, first_name)
    mandrill = Mandrill::API.new ENV['MANDRILL_API_KEY']
  
    template_name = "Outbound from Kaya"
    template_content = [{"content"=>"example content", "name"=>"example name"}]
    message = {"google_analytics_campaign"=>"message.from_email@example.com",
      "url_strip_qs"=>nil,
      "from_name"=>"Kaya",
      "preserve_recipients"=>nil,
      "auto_text"=>nil,
      "metadata"=>{"website"=>"www.example.com"},
      "important"=>false,
      "auto_html"=>nil,
      "track_opens"=>nil,
      "signing_domain"=>nil,
       "to"=>
        [{"email"=>"#{email}",
            "name"=>"#{first_name}",
            "type"=>"to"}],
       "google_analytics_domains"=>["example.com"],
       "track_clicks"=>nil,
       "headers"=>{"Reply-To"=>"kaya@hellokaya.com"},
       "tags"=>["email-intro"],
       "view_content_link"=>nil,
       "from_email"=>"kaya@hellokaya.com",
       "recipient_metadata"=>
          [{"rcpt"=>"recipient.email@example.com", "values"=>{"user_id"=>123456}}],
       "merge_vars"=>
          [{"rcpt"=>"recipient.email@example.com",
              "vars"=>[{"content"=>"merge2 content", "name"=>"merge2"}]}]}

  #      send_at = "example send_at"
        result = mandrill.messages.send_template template_name, template_content, message
  end    
end