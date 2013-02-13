require_relative "microblogger"
require 'date'

describe MicroBlogger do
  let(:twitter_client) { stub.as_null_object }
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
    follower = stub(:screen_name => receiver)

    twitter_client.stub(:followers => [follower])
    twitter_client.should_receive(:update).with(tweet)
    blogger.dm(dm)
  end

  it "does not send DM to non followers" do
    bob = stub(:screen_name => "bob")
    twitter_client.should_receive(:followers).and_return [bob]
    twitter_client.should_not_receive(:update)
    blogger.dm("dm alice test message")
  end

  it "spam all friends with a message" do
    spam_tweet = "t D foo bar"
    friends = [stub(:screen_name => "bob"), 
               stub(:screen_name => "alice")]
    twitter_client.stub(:followers => friends)
    twitter_client.should_receive(:update).with("D bob foo bar")
    twitter_client.should_receive(:update).with("D alice foo bar")

    blogger.spam_my_friends("spam foo bar")
  end

  it "gets last message of friends" do
    timestamp = DateTime.new(2012, 2, 21)
    followed = stub(:screen_name => "bob", 
                    :status => stub(:text => "hello", 
                                    :created_at => timestamp))
    twitter_client.should_receive(:friends).and_return([followed])
    last_messages = blogger.everyone_last_message
    message = last_messages.first
    message.should == Message.new(:bob, "hello", timestamp)
  end
end
