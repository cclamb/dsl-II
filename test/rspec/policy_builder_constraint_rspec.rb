require_relative '../../lib/insomnia/policy_builder'

describe 'constraint keyword' do

  it 'should be creatable with a block' do
    builder = PolicyBuilder.new do
      c1 = constraint { true }
      c2 = constraint do
        true
      end
      c1.should_not == nil
      c2.should_not == nil
    end
  end

  it 'should be creatable without a block' do
    builder = PolicyBuilder.new do
      c1 = constraint
      c2 = constraint
      c1.should_not == nil
      c2.should_not == nil   
    end
  end

  it 'should be creatable with optional args' do
    builder = PolicyBuilder.new do
      c1 = constraint { |c| true }
      c2 = constraint { |c, a| true }
      c1.should_not == nil
      c2.should_not == nil
    end
  end
  
end
