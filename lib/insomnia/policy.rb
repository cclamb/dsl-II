class Policy

  attr_accessor :restricted_activities, :obligators

  def initialize(&b)
    instance_exec(&b) if block_given?
  end
  
  def obligate(*args)
    @restricted_activities = []
    @obligators = []
    args.each do |x|
      @restricted_activities.push(x) if x.kind_of? Restrict
      @obligators = @obligators.push(x[:with]).flatten if x.kind_of? Hash
    end
  end

end
