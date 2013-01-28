require_relative "microblogger"

describe MicroBlogger do
  let(:twitter_client) { stub }
  let(:blogger) { MicroBlogger.new(twitter_client) }

  it "sends a tweet under 140 characters" do
    message = "sample tweet"
    twitter_client.should_receive(:update).with(message)
    blogger.tweet(message)
  end

  it "does not send tweet if more than 140 characters" do
    long_message = "".ljust(141, "abcd")
    twitter_client.should_not_receive(:update)
    blogger.tweet(long_message)
  end
end
