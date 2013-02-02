require_relative "microblogger"

describe MicroBlogger do
  let(:twitter_client) { stub }
  let(:blogger) { MicroBlogger.new(twitter_client) }

  it "sends a tweet under 140 characters" do
    message = "sample tweet"
    tweet_text = "t #{message}"
    twitter_client.should_receive(:update).with(message)
    blogger.tweet(tweet_text)
  end

  it "does not send tweet if more than 140 characters" do
    long_message = "".ljust(141, "abcd")
    tweet_text = "t #{long_message}"
    twitter_client.should_not_receive(:update)
    blogger.tweet(tweet_text)
  end

  it "sends the dm-style tweet" do
    receiver, message = "receiver", "some message"
    dm = "dm #{receiver} #{message}"
    tweet = "D #{receiver} #{message}"
    twitter_client.should_receive(:update).with(tweet)
    blogger.dm(dm)
  end
end
