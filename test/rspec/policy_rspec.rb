require_relative '../../lib/insomnia/policy'

describe Policy do

  context 'with no obligations' do
    it 'should handle empty policies'
  end

  context 'with obligations' do
    it 'should handle single obligations'
    it 'should handle multiple obligations'
    it 'should handle one-to-one obligations'
    it 'should handle one-to-many obligations'
  end

  context 'with contraint evaluator' do
    it 'should handle a default evaluator value'
    it 'should handle a custom evaluator value'
  end

  context 'with policy evaluator' do
    it 'should handle a default evaluator value'
    it 'should handle a custom evaluator value'
  end
  
end
