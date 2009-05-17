Spec::Rails::Mocks.module_eval do

  module NullObject
    include ::RR::Space::Reader

    def method_missing(method_name, *args, &block)
      space.record_call(self, method_name, args, block)
      nil
    end
  end

  # Creates a mock object instance for a +model_class+ with common
  # methods stubbed out. Additional methods may be easily stubbed (via
  # add_stubs) if +stubs+ is passed.
  def mock_model(model_class, options_and_stubs = {})
    @options = parse_options(options_and_stubs)
    
    m = model_class.new
    id = next_id

    # our equivalent to Rspecs :errors => ''# stub("errors", :count => 0)
    stub(errors_stub = Object.new).count{0}

    options_and_stubs.reverse_merge!(
      :id => id,
      :to_param => "#{id}",
      :new_record? => false,
      :errors => errors_stub
    )

    m.extend NullObject if null_object?

    options_and_stubs.each do |method,value|
      stub(m).__send__(method) { value }
    end

    yield m if block_given?
    m
  end

  def stub_model(model_class, stubs={})
    stubs = {:id => next_id}.merge(stubs)
    @options = parse_options(stubs)
    
    returning model_class.new do |model|
      model.extend NullObject if null_object?
            
      model.id = stubs.delete(:id)
      model.extend Spec::Rails::Mocks::ModelStubber
      stubs.each do |k,v|
        if model.has_attribute?(k)
          model[k] = stubs.delete(k)
        end
      end
      stubs.each do |k,v|
        stub(model).__send__(k) { v }
      end
      yield model if block_given?
    end
  end

  private
  def parse_options(options)
    options.has_key?(:null_object) ? {:null_object => options.delete(:null_object)} : {}
  end
  
  def null_object?
    @options[:null_object]
  end
  
end
