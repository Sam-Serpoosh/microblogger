require_relative "command_parser"

describe CommandParser do
  it "extract command part" do
    input = "t this is a test tweet"
    command = subject.extract_command(input)
    command.should == "t"
  end

  it "extracts the tweet parameter" do
    tweet = "this is a test tweet"
    input = "t #{tweet}"
    parameter = subject.extract_single_parameter(input) 
    parameter.should == tweet
  end

  it "extarcts the dm receiver" do
    receiver = "receiver"
    dm = "dm receiver some message"
    extracted_receiver = subject.extract_receiver(dm)
    extracted_receiver.should == receiver
  end

  it "extracts the dm message" do
    dm = "direct message to someone"
    input = "dm receiver #{dm}"
    parameter = subject.extract_dm_message(input)
    parameter.should == dm
  end

  it "parse the tweet with url" do
    tweet = "I wrote this at:"
    url = "http://test.com"
    tweet_with_url = "turl #{tweet} #{url}"
    tweet_and_url = subject.extract_tweet_with_url(tweet_with_url)
    tweet_and_url[0].should == tweet
    tweet_and_url[1].should == url
  end
end
