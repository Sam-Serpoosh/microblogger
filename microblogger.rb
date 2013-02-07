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
        when "spam"
          spam_my_friends(input)
        else
          puts "Sorry, I don't know how to #{command}"
      end
  end

  def spam_my_friends(message)
    spam_message = @command_parser.extract_spam_message(message)
    friends = followers_list
    friends.each do |f|
      dm("dm #{f} #{spam_message}")
    end
  end

  def dm(dm_text)
    receiver = @command_parser.extract_receiver(dm_text)
    return if not_followed_by?(receiver)
    message = @command_parser.extract_dm_message(dm_text) 
    tweet("t #{MessageFormatter.shape_dm_tweet(receiver, message)}")
  end

  def tweet(tweet_text)
    message = @command_parser.extract_tweet_message(tweet_text)
    if message.length <= 140
      @client.update(message)
    else
      puts "Your message can't be more than 140 chars!!!should "
    end
  end

  def not_followed_by?(name)
    not_followed = !followers_list.include?(name)
    puts "You can only DM your followers" if not_followed
    not_followed
  end

  def followers_list
    @client.followers.map(&:screen_name)
  end
end

blogger = MicroBlogger.new(JumpstartAuth.twitter)
blogger.run
