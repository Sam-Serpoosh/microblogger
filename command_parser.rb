class CommandParser  
  def extract_command(input)
    input.split(" ")[0]
  end

  def extract_single_parameter(input)
    parts = input.split(" ")
    parts[1..-1].join(" ")
  end

  def extract_dm_message(input)
    parts = input.split(" ")
    parts[2..-1].join(" ")
  end

  def extract_tweet_with_url(input)
    parts = input.split(" ")
    tweet = parts[1..-2].join(" ")
    url = parts[-1]
    [tweet, url]
  end

  def extract_receiver(dm)
    dm.split(" ")[1]
  end
end
