require_relative '../lib/insomnia/activity'

describe 'create activity' do

  it 'should be creatable with a block' do
    a1 = Activity.new { true }
    a2 = Activity.new do
      true
    end
    a1.should_not == nil
    a2.should_not == nil
  end

  it 'should be creatable without a block' do
    a1 = Activity.new
    a1.should_not == nil
  end

end

describe 'call activity' do

  it 'should handle a block' do
    a1_called, a2_called = false, false
    a1 = Activity.new { a1_called = true }
    a2 = Activity.new do
      a2_called = true
    end
    a1.call
    a1_called.should == true
    a2.call
    a2_called.should == true
  end

  it 'should handle no block' do
    a1 = Activity.new
    a1.should_not == nil
    a1.call.should == true
  end
end

describe 'keyword' do
  it 'should be creatable with a block'
  it 'should be creatable withough a block'
  it 'should always require a name'
end
