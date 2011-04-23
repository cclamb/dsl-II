require_relative '../../lib/insomnia/policy_context'

describe PolicyContext do
  context 'with policy content' do
    it 'should return activities, hashed by symbolic name' do
      PolicyContext.new({:a1 => 'foo'}).activities[:a1].should == 'foo'
    end
  end

  context 'with no policy content' do
    it 'should return an empty hash' do
      PolicyContext.new.activities.should == {}
    end
  end
end
