require_relative 'activity'
require_relative 'constraint'
require_relative 'restrict'

class PolicyBuilder

  def initialize(&block)
    instance_exec(&block)
  end

  def activity(name, &b)
    Activity.new(&b)
  end

  def constraint(&b)
    Constraint.new(&b)
  end

  def restrict(*activities, &b)
    Restrict.new(activities, &b)
  end

end
