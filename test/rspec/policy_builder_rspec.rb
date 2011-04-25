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

describe 'restrict keyword' do

  it 'should be creatable with a block' do
    builder = PolicyBuilder.new do
      ra1 = restrict { true }
      ra2 = restrict do
        true
      end
      ra1.should_not == nil
      ra2.should_not == nil  
    end 
  end

  it 'should be creatable without a block' do
    builder = PolicyBuilder.new do
      ra1 = restrict
      ra2 = restrict
      ra1.should_not == nil
      ra2.should_not == nil
    end
  end

  it 'should handle with statements' do
    builder = PolicyBuilder.new do
      c1, c2 = constraint, constraint
      ra1 = restrict do
        with c1, c2
      end
    end
  end

  it 'should handle an activity to restrict' do
    builder = PolicyBuilder.new do
      a1 = activity :a1
      c1, c2 = constraint, constraint
      ra = restrict a1 do
        with c1, c2
      end
      ra.should_not == nil
      ra.activities.size.should == 1
      ra.activities[0].should == a1
      ra.activities[0].name.should == :a1
    end
  end

  it 'should handle multiple activites to restrict' do
    builder = PolicyBuilder.new do
      a1, a2, a3 = activity(:a1), activity(:a2), activity(:a3)
      c1, c2 = constraint, constraint
      ra = restrict a1, a2, a3 do
        with c1, c2
      end
      ra.should_not == nil
    end
  end
  
end

describe 'tuple keyword' do
  it 'should allow for tuple creation inside policy files'
end

describe 'script context' do

  context 'with an active policy script' do
    it 'should return a script context after processing'
  end

  context 'without an active policy script' do
    it 'should handle context requests with an empty context'
  end
end

describe 'script evaluation' do

  context 'with a correct policy script' do
    it 'should create a simple policy context based on the script' do
      builder = PolicyBuilder.new do
        instance_eval(File.read('policies/simple.pol'))
      end
      ctx = builder.context
      ctx.activities[:a1].should_not == nil
    end
  end

  context 'with a correct policy script' do
    it 'should handle constraints' do
      builder = PolicyBuilder.new do
        instance_eval(File.read('policies/simple-constraint.pol'))
      end
      ctx = builder.context
    end
  end

  context 'with a correct policy script' do
    it 'should handle restrictions' do
      builder = PolicyBuilder.new do
        instance_eval(File.read('policies/simple-restrict.pol'))
      end
      ctx = builder.context
      restrictions = ctx.restrictions
      restrictions.size.should == 4
      ra = restrictions[0]
      ra.activities.size.should == 1
      ra.activities[0].name.should == :play
      ra.constraints.size.should == 1
      ra.constraints[0].call().should == true

      ra = restrictions[1]
      ra.activities.size.should == 1
      ra.activities[0].name.should == :record
      ra.constraints.size.should == 2
      ra.constraints[0].call({:context => ''}).should == true
      ra.constraints[0].call({:artifact => '', :context => ''}).should == true

      ra = restrictions[2]
      ra.activities.size.should == 1
      ra.activities[0].name.should == :stop
      ra.constraints.size.should == 2
      ra.constraints[0].call().should == true
      ra.constraints[0].call({:artifact => '', :context => ''}).should == true

      ra = restrictions[3]
      ra.activities.size.should == 2
      ra.activities[0].name.should == :play
      ra.activities[1].name.should == :stop
      ra.constraints.size.should == 3
      ra.constraints[0].call().should == true
      ra.constraints[0].call({:context => ''}).should == true
      ra.constraints[0].call({:artifact => '', :context => ''}).should == true
    end
  end

end


