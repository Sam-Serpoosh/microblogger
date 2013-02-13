require 'jumpstart_auth'
require_relative 'command_parser'
require_relative 'message_formatter'

class MicroBlogger
  attr_reader :client 
  def initialize(twitter_client)
    @client = twitter_client
    @command_parser = CommandParser.new
  end

  def spam_my_friends(message)
    spam_message = @command_parser.extract_spam_message(message)
    followers_list.each do |f|
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

  def everyone_last_message
    followeds = @client.friends.sort_by { |f| f.screen_name.downcase }
    messages = [] 
    followeds.each do |friend|
      messages << Message.new(friend.screen_name.to_sym, friend.status.text,
                              friend.status.created_at)
    end
    messages
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

class Message
  attr_reader :sender, :timestamp, :text
  
  def initialize(sender, text, timestamp)
    @sender = sender
    @text = text
    @timestamp = timestamp.strftime("%A, %b %d")
  end

  def ==(other)
    return false if !other.is_a?(Message)
    return other.sender == @sender && other.timestamp == @timestamp && 
      other.text == @text
  end
end
