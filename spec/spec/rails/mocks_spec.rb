require File.dirname(__FILE__) + '/../../spec_helper.rb'
require File.dirname(__FILE__) + '/ar_classes.rb'

describe "RR overriding" do

  describe "mocking a model" do

    it "should create a instance of model" do
      mockable = MockableModel.new
      mock(MockableModel).new{mockable}.once

      mock_model(MockableModel)
    end

    it "should return a real model" do
      mock_model(MockableModel).should be_instance_of(MockableModel)
    end

    it "should add stub to model" do
      model = mock_model(MockableModel, :are_you_mocking_me_sir? => true)

      model.are_you_mocking_me_sir?.should be_true
    end

  end

  describe "stubbing a model" do

    it "should create a instance of model" do
      mockable = MockableModel.new
      mock(MockableModel).new{mockable}.once

      stub_model(MockableModel, :new_record? => true)
    end

    it "should return a real model" do
      stub_model(MockableModel).should be_instance_of(MockableModel)
    end

    it "should add stub to model" do
      model = stub_model(MockableModel, :new_record? => true)

      model.new_record?.should be_true
    end

  end

end
