require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client 
  def initialize(twitter_client)
    @client = twitter_client
  end

  def run
    puts "welcome to the twitter client app!"
    command = ""
    while command != "q"
      printf "enter a command: "
      input = gets.chomp
      command = extract_command(input)
      parameter = extract_parameter(input)
      process_command(command, parameter)
    end
  end

  def process_command(command, parameter)
      case command
        when "q"
          puts "Goodbye!"
        when "t"
          tweet(parameter)
        else
          puts "Sorry, I don't know how to #{command}"
      end
  end

  def tweet(message)
    if message.length <= 140
      @client.update(message)
    else
      puts "Your message can't be more than 140 chars!!!should "
    end
  end

  def extract_command(input)
    input.split(" ")[0]
  end

  def extract_parameter(input)
    parts = input.split(" ")
    parts[1..-1].join(" ")
  end
end

blogger = MicroBlogger.new(JumpstartAuth.twitter)
blogger.run
