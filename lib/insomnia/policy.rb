require_relative 'obligation'
require_relative 'policy_evaluator_factory'

class Policy

  def initialize(&b)
    @evaluator = nil
    instance_exec(&b) if block_given?
    @evaluator = PolicyEvaluatorFactory.new.create(:standard) if @evaluator == nil
    @evaluator.instance_exec(&b) if block_given?
  end
  
  def policy_evaluators(args)
    @evaluator = PolicyEvaluatorFactory.new.create(args)
  end
  
  def method_missing(method_sym, *arguments, &block) ; end
  
  def context
    return @evaluator.context
  end

end
