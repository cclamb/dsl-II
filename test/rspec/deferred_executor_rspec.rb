require_relative '../../lib/insomnia/deferred_executor'

describe 'create executor' do

  it 'should be creatable with a block' do
    de1 = DeferredExecutor.new { true }
    de2 = DeferredExecutor.new do
      true
    end
    de1.should_not == nil
    de2.should_not == nil
  end

  it 'should be creatable without a block' do
    de1 = DeferredExecutor.new
    de1.should_not == nil
  end

end

describe 'call executor' do

  it 'should handle a block' do
    de1_called, de2_called = false, false
    de1 = DeferredExecutor.new { de1_called = true }
    de2 = DeferredExecutor.new do
      de2_called = true
    end
    de1.call
    de1_called.should == true
    de2.call
    de2_called.should == true
  end

  it 'should handle no block' do
    de1 = DeferredExecutor.new
    de1.should_not == nil
    de1.call.should == true
  end
end
