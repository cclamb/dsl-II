require_relative 'standard_policy_evaluator'
require_relative 'dummy_policy_evaluator'

class PolicyEvaluatorFactory
  def create(sym)
    case sym 
      when :standard ; StandardPolicyEvaluator.new
      when :dummy ; DummyPolicyEvaluator.new
      else ; raise ArgumentError.new('unidentified evaluator requested')
    end
  end
end
