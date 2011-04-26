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
      p.restricted_activities.size.should == 1
      p.obligators.size.should == 1
      p.restricted_activities[0].should == ra1
      p.obligators[0].should == ra2
    end
    
    it 'should handle multiple obligations' do
      fail 'policy implementation cannot support this; need obligation class'
      ra1 = Restrict.new
      ra2 = Restrict.new
      ra3 = Restrict.new
      ra4 = Restrict.new
      p = Policy.new do
        obligate ra1, :with => ra2
        obligate ra3, :with => ra4
      end
      p.restricted_activities.size.should == 1
      p.obligators.size.should == 1
      p.restricted_activities[0].should == ra1
      p.obligators[0].should == ra2
    end
    
    it 'should handle one-to-one obligations'
    it 'should handle one-to-many obligations'
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
