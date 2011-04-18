class Restrict

  attr_accessor :activities

  def initialize(*activities, &b)
    @activities = activities
    instance_exec(&b) if block_given?
  end

  def with(*args)
    @constraints = @constraints == nil ? args : @constraints + args
  end

  def call(context = nil, artifact = nil)
    
  end

end
