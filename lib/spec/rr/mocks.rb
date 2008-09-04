Spec::Rails::Mocks.module_eval do

  # Creates a mock object instance for a +model_class+ with common
  # methods stubbed out. Additional methods may be easily stubbed (via
  # add_stubs) if +stubs+ is passed.
  def mock_model(model_class, options_and_stubs = {})
    m = model_class.new
    id = next_id

    # our equivalent to Rspecs :errors => ''# stub("errors", :count => 0)
    stub(errors_stub = Object.new).count{0}
    
    options_and_stubs.reverse_merge!({
      :id => id,
      :to_param => "#{id}",
      :new_record? => false,
      :errors => errors_stub
    })

    options_and_stubs.each do |method,value|
      eval "stub(m).#{method}{value}"
    end

    yield m if block_given?
    m
  end

  # TODO - Shouldn't this just be an extension of stub! ??
  # - object.stub!(:method => return_value, :method2 => return_value2, :etc => etc)
  #++
  # Stubs methods on +object+ (if +object+ is a symbol or string a new mock
  # with that name will be created). +stubs+ is a Hash of +method=>value+
  def add_stubs(object, stubs = {}) #:nodoc:
    m = [String, Symbol].index(object.class) ? Object.new : object
    stubs.each {|k,v| eval "stub(m).#{k}{v}"}
    m
  end

end