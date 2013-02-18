require_relative 'microblogger'
require_relative 'command_parser'
require_relative 'url_shortener'

class UserConsole
  def initialize
    @command_parser = CommandParser.new
    @microblogger = MicroBlogger.new(JumpstartAuth.twitter)
    @url_shortener = UrlShortener.new
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
          puts generate_message_for(command)
        when "t"
          @microblogger.tweet(@command_parser.extract_single_parameter(input))
        when "dm"
          @microblogger.dm(input)
        when "spam"
          @microblogger.spam_my_friends(input)
        when "elt"
          print_messages(@microblogger.everyone_last_message)
        when "turl"
          tweet_with_url(input)
        else
          puts generate_message_for(command)
      end
  end
  
  def generate_message_for(command)
    return "Goodbye!" if command.eql?("q")
    "Sorry, I don't know how to #{command}"
  end

  def print_messages(messages)
    messages.each do |message|
      puts "#{message.sender} said this on #{message.timestamp}"
      puts "#{message.text}"
    end
  end

  def tweet_with_url(tweet_text)
    tweet_and_url = @command_parser.extract_tweet_with_url(tweet_text)
    @microblogger.tweet(tweet_and_url[0] + " " + @url_shortener.shorten(tweet_and_url[1]))
  end
end

console = UserConsole.new
console.run
