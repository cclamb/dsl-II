require_relative '../../lib/insomnia/policy_builder'

describe 'activity keyword' do

  it 'should always require a name' do
    builder = PolicyBuilder.new do
      a1 = activity(:a1) { true }
      a2 = activity :a2 do
        true
      end
      a1.should_not == nil
      a1.name.should == :a1
      a2.should_not == nil
      a2.name.should == :a2
    end
  end

 it 'should be creatable with a block' do
    builder = PolicyBuilder.new do
      a1 = activity(:a1) { true }
      a2 = activity :a2 do
        true
      end
      a1.should_not == nil
      a2.should_not == nil 
    end  
  end

  it 'should be creatable without a block' do
    builder = PolicyBuilder.new do
      a1 = activity(:a1)
      a2 = activity :a2
      a1.should_not == nil
      a2.should_not == nil 
    end  
  end

end
