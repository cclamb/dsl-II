require_relative 'obligation'

class Policy

  attr_accessor :obligations

  def initialize(&b)
    @obligations = []
    instance_exec(&b) if block_given?
  end
  
  def obligate(*args, &b)
    obligation = Obligation.new(*args, &b)
    @obligations.push(obligation)
    obligation
  end

end
