require_relative '../../lib/insomnia/restrict'
require_relative '../../lib/insomnia/policy'
require_relative '../../lib/insomnia/obligation'

describe Policy do

  context 'with no obligations' do
    it 'should handle empty policies' do
      p = Policy.new
      p.should_not == nil
    end
  end

  context 'with obligations' do
    it 'should handle single obligations' do
      ra1 = Restrict.new
      ra2 = Restrict.new
      p = Policy.new do
        obligate ra1, :with => ra2
      end
      p.obligations.size.should == 1
      p.obligations[0].obligatees[0].should == ra1
      p.obligations[0].obligators[0].should == ra2
    end
    
    it 'should handle multiple obligations' do
      ra1 = Restrict.new
      ra2 = Restrict.new
      ra3 = Restrict.new
      ra4 = Restrict.new
      p = Policy.new do
        obligate ra1, :with => ra2
        obligate ra3, :with => ra4
      end
      p.obligations.size.should == 2
      p.obligations[0].obligatees[0].should == ra1
      p.obligations[0].obligators[0].should == ra2
      p.obligations[1].obligatees[0].should == ra3
      p.obligations[1].obligators[0].should == ra4
    end
    
    it 'should handle one-to-many obligations' do
      ra1, ra2, ra3 = Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        obligate ra1, :with => [ra2, ra3]
      end
      p.obligations.size.should == 1
      p.obligations[0].obligatees[0].should == ra1
      p.obligations[0].obligators[0].should == ra2
      p.obligations[0].obligators[1].should == ra3
    end
    
    it 'should handle many-to-one obligations' do
      ra1, ra2, ra3 = Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        obligate ra1, ra2, :with => ra3
      end
      p.obligations.size.should == 1
      p.obligations[0].obligatees[0].should == ra1
      p.obligations[0].obligatees[1].should == ra2
      p.obligations[0].obligators[0].should == ra3
    end
    
    it 'should handle many-to-many obligations' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        obligate ra1, :with => ra2
        obligate ra2, ra3, :with => ra4
        obligate ra1, :with => [ra4, ra3]
      end
    end
  end

  context 'with contraint evaluator' do
    it 'should handle a default evaluator value'
    it 'should handle a custom evaluator value'
  end

  context 'with policy evaluator' do
    it 'should handle a default evaluator value'
    it 'should handle a custom evaluator value'
  end
  
end
