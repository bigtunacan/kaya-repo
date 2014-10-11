## file: schedule_bot.rb
## sample data:
## bot_client_name = "14155086888"
## date = "tomorrow"
## reminder_type = "quadrinity"
## get_schedule: returns a Tim class
## input to create_schedule is a String


class ScheduleBot
  require 'chronic'
  require 'iron_cache'
  
  def self.create_schedule (bot_client_name, date)
    # write to the cache for this client's schedules
    cache_name = bot_client_name + "-schedule"
    @client = IronCache::Client.new
    @cache = @client.cache(cache_name)
    scheduled_time = Chronic.parse(date)
    @cache.put("quadrinity", scheduled_time)
  end
  
  def self.get_schedule (bot_client_name, reminder_type)
    cache_name = bot_client_name + "-schedule"
    @client = IronCache::Client.new
    @cache = @client.cache(cache_name)
    scheduled_time = @cache.get(reminder_type).value 
    return Chronic.parse(scheduled_time)  ## this returns a Time class
  end  
end