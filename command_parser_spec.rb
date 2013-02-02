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
    parameter = subject.extract_tweet_message(input) 
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
end
