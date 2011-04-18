class Restrict

  def initialize(*activities, &b)
    instance_exec(&b) if block_given?
  end

  def with(*args)
    @constraints = @constraints == nil ? args : @constraints + args
  end

  def call(context = nil, artifact = nil)
    
  end

end
