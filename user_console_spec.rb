require_relative 'user_console'

describe UserConsole do
  it "generates Goodbye! message for user when command is q" do
    subject.generate_message_for("q").should == "Goodbye!"
  end

  it "generates unknown command message for unknown commands" do
    subject.generate_message_for("unknown command").should == "Sorry, I don't know how to unknown command"
  end
end
