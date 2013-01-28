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

  it "extract command part out of the input" do
    input = "t this is a test tweet"
    command = blogger.extract_command(input)
    command.should == "t"
  end

  it "extracts the parameter out of the input" do
    tweet = "this is a test tweet"
    input = "t #{tweet}"
    parameter = blogger.extract_parameter(input) 
    parameter.should == tweet
  end
end
