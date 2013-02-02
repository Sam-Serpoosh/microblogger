require_relative "message_formatter"

describe MessageFormatter do
  it "creates a tweet specific for direct messaging" do
    receiver, message = "receiver", "some message"
    dm = "dm #{receiver} #{message}"
    tweet = MessageFormatter.shape_dm_tweet(receiver, message)
    tweet.should == "D #{receiver} #{message}"
  end
end
