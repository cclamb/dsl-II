require_relative '../../lib/insomnia/tuple'

describe 'Creation' do
  it 'should require an artifact and a policy' do
    t = Tuple.new('artifact', 'policy')
    t.artifact.should == 'artifact'
    t.policy.should == 'policy'
  end
end

describe 'Actions' do
  it 'should allow arbitrary method calls' do
    t = Tuple.new('artifact', 'policy')
    t.play.should == false
    t.make.should == false
    t.shoe.should == false
  end

  it 'should handle method calls as action queries' do

  end

  it 'should not except on non-existing actions when called'
  it 'should evaluate constraints on restricted actions'
  it 'should handle non-restricted actions'
end
