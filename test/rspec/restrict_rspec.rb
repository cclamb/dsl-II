require_relative '../../lib/insomnia/restrict'
require_relative '../../lib/insomnia/constraint'
require_relative '../../lib/insomnia/activity'

describe 'create restrict' do

  it 'should be creatable with a block' do
    ra1 = Restrict.new { true }
    ra2 = Restrict.new do
      true
    end
    ra1.should_not == nil
    ra2.should_not == nil
  end

  it 'should be creatable without a block' do
    ra1 = Restrict.new
    ra1.should_not == nil
  end

  it 'should handle with statement' do
    c1, c2 = Constraint.new, Constraint.new
    ra1 = Restrict.new do
      with c1, c2
    end
  end

  it 'should handle an activity to restrict' do
    a1 = Activity.new
    c1, c2 = Constraint.new, Constraint.new
    ra = Restrict.new a1 do
      with c1, c2
    end
    ra.should_not == nil
    ra.activities.size.should == 1 
    ra.activities[0].should == a1
  end

  it 'should handle multiple activites to restrict' do
    a1, a2, a3 = Activity.new(:foo), Activity.new, Activity.new(:bar)
    c1, c2 = Constraint.new, Constraint.new
    ra = Restrict.new a1, a2, a3 do
      with c1, c2
    end
    ra.should_not == nil
    ra.activities.size.should == 3
    ra.activities[0].name.should == :foo
    ra.activities[1].name.should == nil
    ra.activities[2].name.should == :bar
  end

end

describe 'call restrict' do

  it 'should handle a block' do
    ra1_called, ra2_called = false, false
    ra1 = Restrict.new { ra1_called = true }
    ra2 = Restrict.new do
      ra2_called = true
    end
    ra1.call
    ra1_called.should == true
    ra2.call
    ra2_called.should == true
  end

  it 'should handle no block' do
    ra1 = Restrict.new
    ra1.should_not == nil
    ra1.call
  end

  it 'should support calls with activities that have been restricted' do
    a1, a2, a3 = Activity.new, Activity.new, Activity.new
    c1, c2 = Constraint.new, Constraint.new
    ra = Restrict.new a1, a2, a3 do
      with c1, c2
    end
    ra.should_not == nil
    ra.call
  end

end
