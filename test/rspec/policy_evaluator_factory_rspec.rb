require_relative '../../lib/insomnia/policy_evaluator_factory'
require_relative '../../lib/insomnia/standard_policy_evaluator'

describe PolicyEvaluatorFactory do

  before :all do
    @factory = PolicyEvaluatorFactory.new
  end

  context 'with a standard tag' do
    it 'should create a standard evaluator' do
      evaluator = @factory.create(:standard)
      fail 'bad evaluator' unless evaluator.kind_of? StandardPolicyEvaluator
    end
  end
  
end
