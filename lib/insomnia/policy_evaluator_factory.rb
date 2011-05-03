require_relative 'standard_policy_evaluator'

class PolicyEvaluatorFactory
  def create(sym)
    case sym 
      when :standard ; StandardPolicyEvaluator.new
      else ; raise ArgumentError.new('unidentified evaluator requested')
    end
  end
end
