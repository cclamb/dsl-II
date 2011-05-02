require_relative 'obligation'

class Policy

  attr_accessor :obligations, :included_activities

  def initialize(&b)
    @obligations = []
    @included_activities = []
    instance_exec(&b) if block_given?
  end
  
  def obligate(*args, &b)
    obligation = Obligation.new(*args, &b)
    @obligations.push(obligation)
    obligation
  end
  
  def permit(*args)
    @included_activities = @included_activities.push(args).flatten
  end

end
