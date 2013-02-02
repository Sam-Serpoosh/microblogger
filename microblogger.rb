require 'jumpstart_auth'
require_relative 'command_parser'
require_relative 'message_formatter'

class MicroBlogger
  attr_reader :client 
  def initialize(twitter_client)
    @client = twitter_client
    @command_parser = CommandParser.new
  end

  def run
    puts "welcome to the twitter client app!"
    command = ""
    while command != "q"
      printf "enter a command: "
      input = gets.chomp
      command = @command_parser.extract_command(input)
      process_command(command, input)
    end
  end

  def process_command(command, input)
      case command
        when "q"
          puts "Goodbye!"
        when "t"
          tweet(input)
        when "dm"
          dm(input)
        else
          puts "Sorry, I don't know how to #{command}"
      end
  end

  def tweet(tweet_text)
    message = @command_parser.extract_tweet_message(tweet_text)
    if message.length <= 140
      @client.update(message)
    else
      puts "Your message can't be more than 140 chars!!!should "
    end
  end

  def dm(dm_text)
    receiver = @command_parser.extract_receiver(dm_text)
    message = @command_parser.extract_dm_message(dm_text) 
    tweet("t #{MessageFormatter.shape_dm_tweet(receiver, message)}")
  end
end

#blogger = MicroBlogger.new(JumpstartAuth.twitter)
#blogger.run
