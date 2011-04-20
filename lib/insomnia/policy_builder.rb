require_relative 'activity'
require_relative 'constraint'
require_relative 'restrict'

class PolicyBuilder

  attr_accessor :activities

  def initialize(&block)
    @activities = {}
    instance_exec(&block)
  end

  def activity(name, &b)
    @activities[name] = Activity.new(&b)
  end

  def constraint(&b)
    Constraint.new(&b)
  end

  def restrict(*activities, &b)
    Restrict.new(activities, &b)
  end

end
