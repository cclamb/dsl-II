require_relative '../../lib/insomnia/policy_builder'

describe 'script evaluation' do

  context 'with a correct policy script' do

    it 'should create a simple policy context based on the script' do
      builder = PolicyBuilder.new do
        instance_eval(File.read('policies/simple.pol'))
      end
      ctx = builder.context
      ctx.activities[:a1].should_not == nil
    end

    it 'should handle activities' do
      builder = PolicyBuilder.new do
        instance_eval(File.read('policies/simple-activities.pol'))
      end
      ctx = builder.context
      ctx.activities.size == 3
      ctx.activities[:foo].name.should == :foo
      ctx.activities[:foo].call().should == true
      ctx.activities[:bar].name.should == :bar
      ctx.activities[:bar].call().should == true
      ctx.activities[:blech].name.should == :blech
      ctx.activities[:blech].call().should == true
    end

    it 'should handle constraints' do
      builder = PolicyBuilder.new do
        instance_eval(File.read('policies/simple-constraint.pol'))
      end
      ctx = builder.context
    end

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


