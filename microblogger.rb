require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client 
  def initialize(twitter_client)
    puts "initializing"
    @client = twitter_client
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Your message can't be more than 140 chars!!!should "
    end
  end
end

#blogger = MicroBlogger.new(JumpstartAuth.twitter)
