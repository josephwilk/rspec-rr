module Spec::Rails::Mocks

  # Creates a mock object instance for a +model_class+ with common
  # methods stubbed out. Additional methods may be easily stubbed (via
  # add_stubs) if +stubs+ is passed.
  def mock_model(model_class, options_and_stubs = {})

    m = model_class.new

    id = next_id
    options_and_stubs.reverse_merge!({
      :id => id,
      :to_param => "#{id}",
      :new_record? => false
      # :errors => ''# stub("errors", :count => 0) - cannot do this in RR
    })
    
    #Errors needs a proxy
    if options_and_stubs.has_key?(:errors)
      stub(m.errors).count{options_and_stubs[:errors]}
    else
      stub(m.errors).count{0}
    end

    options_and_stubs.each do |method,value|
      eval "stub(m).#{method}{value}"
    end

    # I'm a real object so I dont need any of this! 
    # m = mock("#{model_class.name}_#{options_and_stubs[:id]}", options_and_stubs)
    #
    # m.send(:__mock_proxy).instance_eval <<-CODE
    #   def @target.is_a?(other)
    #     #{model_class}.ancestors.include?(other)
    #   end
    #   def @target.kind_of?(other)
    #     #{model_class}.ancestors.include?(other)
    #   end
    #   def @target.instance_of?(other)
    #     other == #{model_class}
    #   end
    #   def @target.class
    #     #{model_class}
    #   end
    # CODE
    yield m if block_given?
    m
  end
  
end