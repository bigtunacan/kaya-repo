## file: response_pair.rb
## Sample Data:
## bot_client_name = "14155086888"
## inbound = "what is going on?"

## RETURN values is a JSON string
## Needs to apply JSON.parse to access as key-value store

class ResponsePair
  require 'iron_cache'
  
  def self.store_last_inbound (inbound,bot_client_name)
    puts "store_last_inbound:"
    puts inbound.inspect
    
    cache_name = bot_client_name + "-response_pair"
    @client = IronCache::Client.new
    @cache = @client.cache(cache_name)
    @cache.put("inbound", "#{inbound}")
    unless @cache.get('outbound').nil?
      @cache.delete('outbound')
    end  
  end 
  
  def self.store_last_outbound (outbound,bot_client_name)
    cache_name = bot_client_name + "-response_pair"
    @client = IronCache::Client.new
    @cache = @client.cache(cache_name)
    @cache.put("outbound", "#{outbound}" )      
  end  
  
  def self.compare_response_pair (bot_client_name)
    cache_name = bot_client_name + "-response_pair"
    @client = IronCache::Client.new
    @cache = @client.cache(cache_name)
    outbound = @cache.get('outbound').value
    inbound = @cache.get('inbound').value
    return response_pair = {:outbound => outbound, :inbound => inbound}.to_json  
  end     
end  