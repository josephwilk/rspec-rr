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

    it "should allow stubbing of error" do
      #This is the nearest way we can express errors in RR
      stub(error_stub = Object.new).count{5}
      model = mock_model(MockableModel, :errors => error_stub )
      
      model.errors.count.should eql(5)
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

  describe "adding stubs" do

    it "should create a stubbed object when given a string name" do
      stubbed_string = add_stubs("test", :yokai? => true)

      stubbed_string.yokai?.should be_true
    end
    
    it "should create a stubbed object when given a symbol" do
      stubbed_string = add_stubs(:test, :yokai? => true)

      stubbed_string.yokai?.should be_true
    end

    it "should stub existing object" do
      object = MockableModel.new
      add_stubs(object, :yokai? => true)

      object.yokai?.should be_true
    end

    it "should return the same existing object it passed to stub" do
      object = MockableModel.new
      object_returned = add_stubs(object, :yokai? => true)

      object.should equal(object_returned)
    end
  
  end

end
