require_relative '../../lib/insomnia/policy_builder'

describe 'activity keyword' do

  it 'should always require a name' do
    builder = PolicyBuilder.new do
      a1 = activity(:a1) { true }
      a2 = activity :a2 do
        true
      end
      a1.should_not == nil
      a2.should_not == nil
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

  it 'should handle an activity to restrict'

  it 'should handle multiple activites to restrict'
  
end


