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
        obligate ra1
      end
      ctx = p.context
      obligations = ctx[:obligations] 
      obligations[0].obligatees[0].should == ra1
    end
    
    it 'should handle multiple obligations' do
      ra1 = Restrict.new
      ra2 = Restrict.new
      ra3 = Restrict.new
      ra4 = Restrict.new
      p = Policy.new do
        obligate ra1 do
          with ra2
        end
        obligate ra3 do
          with ra4
        end
      end
      ctx = p.context
      obligations = ctx[:obligations] 
      obligations.size.should == 2
      obligations[0].obligatees[0].should == ra1
      obligations[0].obligators[0].should == ra2
      obligations[1].obligatees[0].should == ra3
      obligations[1].obligators[0].should == ra4
    end
    
    it 'should handle one-to-many obligations' do
      ra1, ra2, ra3 = Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        obligate ra1 do
          with ra2, ra3
        end
      end
      #p.obligations.size.should == 1
      #p.obligations[0].obligatees[0].should == ra1
      #p.obligations[0].obligators[0].should == ra2
      #p.obligations[0].obligators[1].should == ra3
    end
    
    it 'should handle many-to-one obligations' do
      ra1, ra2, ra3 = Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        obligate ra1, ra2 do
          with ra3
        end
      end
      #p.obligations.size.should == 1
      #p.obligations[0].obligatees[0].should == ra1
      #p.obligations[0].obligatees[1].should == ra2
      #p.obligations[0].obligators[0].should == ra3
    end
    
    it 'should handle many-to-many obligations' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        obligate ra1 do
          with ra2
        end
        obligate ra2, ra3 do
          with ra4
        end
        obligate ra1, do
          with ra4, ra3
        end
      end
      #p.obligations.size.should == 3
      #p.obligations[0].obligatees[0].should == ra1
      #p.obligations[0].obligators[0].should == ra2
      #p.obligations[1].obligatees[0].should == ra2
      #p.obligations[1].obligatees[1].should == ra3
      #p.obligations[1].obligators[0].should == ra4
      #p.obligations[2].obligatees[0].should == ra1
      #p.obligations[2].obligators[0].should == ra4
      #p.obligations[2].obligators[1].should == ra3
    end
  end
  
  context 'with permit statement' do

    it 'should handle no permissions' do
      p = Policy.new do
        permit
      end    
      #p.included_activities.size.should == 0
    end
    
    
    it 'should handle onen permission' do
      ra1 = Restrict.new
      p = Policy.new do
        permit ra1
      end    
      #p.included_activities.size.should == 1
      #p.included_activities[0].should == ra1
    end
    
    it 'should handle many permissions' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      ra1 = Restrict.new
      p = Policy.new do
        permit ra1, ra2, ra3, ra4
      end    
      #p.included_activities.size.should == 4
      #p.included_activities[0].should == ra1
      #p.included_activities[1].should == ra2
      #p.included_activities[2].should == ra3
      #p.included_activities[3].should == ra4
    end
    
    it 'should handle many permission statments' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      ra1 = Restrict.new
      p = Policy.new do
        permit ra1 
        permit ra2
        permit ra3
        permit ra4
      end    
      #p.included_activities.size.should == 4
      #p.included_activities[0].should == ra1
      #p.included_activities[1].should == ra2
      #p.included_activities[2].should == ra3
      #p.included_activities[3].should == ra4
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
