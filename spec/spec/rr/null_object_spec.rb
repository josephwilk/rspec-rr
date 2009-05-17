require File.dirname(__FILE__) + '/../../spec_helper.rb'

describe NullObject do

  before(:each) do
    @subject = Object.new
    @subject.extend NullObject
  end

  it "should overide nil methods when using stub" do
    stub(@subject).testing{ true }

    @subject.testing.should == true
  end

  it "should overide nil methods when using mock" do
    mock(@subject).testing{ true }

    @subject.testing.should == true
  end

  include RR::Adapters::Rspec

  it "should record undefined methods that return nil" do
    pending do
      @subject.moonkins
      @subject.should have_received(:moonkins)
    end
  end

end

