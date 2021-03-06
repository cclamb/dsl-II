require_relative '../../lib/insomnia/constraint'

describe 'create constraint' do

  it 'should be creatable with a block' do
    c1 = Constraint.new { true }
    c2 = Constraint.new do
      true
    end
    c1.should_not == nil
    c2.should_not == nil
  end

  it 'should be creatable without a block' do
    c1 = Constraint.new
    c1.should_not == nil
  end

end

describe 'call constraint' do

  it 'should handle a block' do
    c1_called, c2_called = false, false
    c1 = Constraint.new { c1_called = true }
    c2 = Constraint.new do
      c2_called = true
    end
    c1.call
    c1_called.should == true
    c2.call
    c2_called.should == true
  end

  it 'should handle no block' do
    c1 = Constraint.new
    c1.should_not == nil
    c1.call.should == true
  end

  it 'should handle optional context' do
    c1 = Constraint.new do |context| 
      context.should_not == nil
      true
    end
    c2 = Constraint.new { |context| true }
    c1.should_not == nil
    c1.call(:context => 'context').should == true
    c2.should_not == nil
    c2.call(:context => 'context').should == true
  end

  it 'should handle optional context and artifact' do
    c1 = Constraint.new do |context, artifact| 
      context.should_not == nil
      artifact.should_not == nil
      true
    end
    c2 = Constraint.new { |context, artfact| true }
    c1.should_not == nil
    c1.call(:context => 'context', :artifact => 'artifact').should == true
    c2.should_not == nil
    c2.call(:context => 'context', :artifact => 'artifact').should == true
  end

end
