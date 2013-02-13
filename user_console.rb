require_relative 'microblogger'

class UserConsole
  def initialize
    @command_parser = CommandParser.new
    @microblogger = MicroBlogger.new(JumpstartAuth.twitter)
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
          @microblogger.tweet(input)
        when "dm"
          @microblogger.dm(input)
        when "spam"
          @microblogger.spam_my_friends(input)
        when "elt"
          print_messages(@microblogger.everyone_last_message)
        else
          puts "Sorry, I don't know how to #{command}"
      end
  end

  def print_messages(messages)
    messages.each do |person, message|
      puts "#{person} said: #{message}"
    end
  end
end

console = UserConsole.new
console.run
