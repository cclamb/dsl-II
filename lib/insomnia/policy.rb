require_relative 'obligation'

class Policy

  attr_accessor :obligations

  def initialize(&b)
    @obligations = []
    instance_exec(&b) if block_given?
  end
  
  def obligate(*args)
    restricted_activities = []
    obligators = []
    args.each do |x|
      restricted_activities.push(x) if x.kind_of? Restrict
      obligators = obligators.push(x[:with]).flatten if x.kind_of? Hash
    end
    obligations.push(Obligation.new(restricted_activities, obligators))
  end

end
