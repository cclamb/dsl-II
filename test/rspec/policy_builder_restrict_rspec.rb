require_relative '../../lib/insomnia/policy_builder'

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
