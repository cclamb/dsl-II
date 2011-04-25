class Activity

  attr_accessor :name, :block

  def initialize(name = nil, &b)
    @name = name
    @block = b
  end

  def call
    @block != nil ? block.call : true
  end

end
