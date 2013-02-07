class CommandParser  
  def extract_command(input)
    input.split(" ")[0]
  end

  def extract_tweet_message(input)
    parts = input.split(" ")
    parts[1..-1].join(" ")
  end

  def extract_spam_message(input)
    extract_tweet_message(input)
  end

  def extract_dm_message(input)
    parts = input.split(" ")
    parts[2..-1].join(" ")
  end

  def extract_receiver(dm)
    dm.split(" ")[1]
  end
end
