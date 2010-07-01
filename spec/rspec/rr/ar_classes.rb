class FakeActiveRecord

  attr_accessor :errors, :name, :id
  
  def initialize
    @errors = Error.new
    @name = @id
  end

  def create!
  end
  
  def has_attribute?(k)
  end
  
end

class Error
  def count
  end
end

class MockableModel < FakeActiveRecord
end

class SubMockableModel < MockableModel
end

class AssociatedModel < FakeActiveRecord
end