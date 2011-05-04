require_relative '../../lib/insomnia/policy_builder'

describe PolicyBuilder do

  it 'should handle empty policies' do
    builder = PolicyBuilder.new do
      a1 = activity(:a1) { true }
      a2 = activity :a2 do
        true
      end
      p = policy
      a1.should_not == nil
      a1.name.should == :a1
      a2.should_not == nil
      a2.name.should == :a2
      p.should_not == nil
    end
  end

end
