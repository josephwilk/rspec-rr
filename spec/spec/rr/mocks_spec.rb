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

    describe "null_object => true" do

      it "should return nil for unknown method" do
        model = mock_model(MockableModel, :null_object => true)

        model.a_method_which_does_not_exist.should == nil
      end

    end

    describe "null_object => false" do

      before(:each) do
        @model = mock_model(MockableModel, :null_object => false)
      end

      it "should raise an error for unknown method" do
        lambda{
          @model.a_method_which_does_not_exist
        }.should raise_error NoMethodError
      end

      it "should not stub null_object method" do
        lambda{
          @model.null_object
        }.should raise_error NoMethodError
      end

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

      model.should be_new_record
    end

    describe "null_object => true" do

      it "should return nil for unknown method" do
        model = stub_model(MockableModel, :null_object => true)
        model.a_method_which_does_not_exist.should == nil
      end

    end

    describe "null_object => false" do

      before(:each) do
        @model = stub_model(MockableModel, :null_object => false)
      end

      it "should raise an error for unknown method" do
        lambda{
          @model.a_method_which_does_not_exist
        }.should raise_error NoMethodError
      end

      it "should not stub null_object method" do
        lambda{
          @model.null_object
        }.should raise_error NoMethodError
      end

    end
    
  end

end
