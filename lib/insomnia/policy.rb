require_relative 'obligation'
require_relative 'policy_evaluator_factory'

class Policy

  #attr_accessor :obligations, :included_activities

  def initialize(&b)
    #@obligations = []
    #@included_activities = []
    @evaluator = nil
    instance_exec(&b) if block_given?
    @evaluator = PolicyEvaluatorFactory.new.create(:standard) if @evaluator == nil
    @evaluator.instance_exec(&b) if block_given?
  end
  
  def policy_evaluators(args)
    @evaluator = PolicyEvaluatorFactory.new.create(args)
  end
  
  def method_missing(method_sym, *arguments, &block)
  
  end
  
  def context
    return @evaluator.context
  end
  
#  def obligate(*args, &b)
#    obligation = Obligation.new(*args, &b)
#    @obligations.push(obligation)
#    obligation
#  end
  
#  def permit(*args)
#    @included_activities = @included_activities.push(args).flatten
#  end

end
