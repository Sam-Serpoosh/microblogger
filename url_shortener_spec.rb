require_relative "url_shortener"

describe UrlShortener do
  let(:short_url) { stub }
  let(:bitly) { stub }
  
  before do
    Bitly.stub(:new => bitly)
  end

  it "delegates to Bitly for shortening" do
    short_url.should_receive(:short_url).and_return("test.com")
    bitly.should_receive(:shorten).and_return(short_url)

    Bitly.should_receive(:use_api_version_3)
    
    subject.shorten("whatever long url").should == "test.com"
  end
end
