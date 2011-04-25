class Restrict

  attr_accessor :activities, :constraints

  def initialize(*activities, &b)
    @activities = activities.flatten
    @constraints = []
    instance_exec(&b) if block_given?
  end

  def with(*args)
    @constraints.push(args)
    @constraints = @constraints.flatten
  end

  def call(context = nil, artifact = nil)
    
  end

end
