require_relative '../../lib/insomnia/restrict'
require_relative '../../lib/insomnia/policy'
require_relative '../../lib/insomnia/obligation'

describe Policy do

  context 'with standard evaluator' do

    it 'should handle many-to-many obligations as default' do
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
      ctx = p.context
      obligations = ctx[:obligations] 
      obligations.size.should == 3
      obligations[0].obligatees[0].should == ra1
      obligations[0].obligators[0].should == ra2
      obligations[1].obligatees[0].should == ra2
      obligations[1].obligatees[1].should == ra3
      obligations[1].obligators[0].should == ra4
      obligations[2].obligatees[0].should == ra1
      obligations[2].obligators[0].should == ra4
      obligations[2].obligators[1].should == ra3
    end
    
    it 'should handle many-to-many obligations explicitly' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        policy_evaluators :standard
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
      ctx = p.context
      obligations = ctx[:obligations] 
      obligations.size.should == 3
      obligations[0].obligatees[0].should == ra1
      obligations[0].obligators[0].should == ra2
      obligations[1].obligatees[0].should == ra2
      obligations[1].obligatees[1].should == ra3
      obligations[1].obligators[0].should == ra4
      obligations[2].obligatees[0].should == ra1
      obligations[2].obligators[0].should == ra4
      obligations[2].obligators[1].should == ra3
    end
    
    it 'should fail with an unrecognized evaluator' do
      is_failed = false
      begin
        p = Policy.new do
          policy_evaluators :bogus
        end
      rescue ArgumentError
        is_failed = true
      rescue
        is_failed = false
      end
      fail 'incorrect or no exception thrown' unless is_failed
    end
    
  end

  context 'with multiple policy evaluator' do
  
    it 'should handle no content on second evaluator' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        policy_evaluators :standard, :dummy
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
      ctx = p.context
      obligations = ctx[:standard][:obligations] 
      obligations.size.should == 3
      obligations[0].obligatees[0].should == ra1
      obligations[0].obligators[0].should == ra2
      obligations[1].obligatees[0].should == ra2
      obligations[1].obligatees[1].should == ra3
      obligations[1].obligators[0].should == ra4
      obligations[2].obligatees[0].should == ra1
      obligations[2].obligators[0].should == ra4
      obligations[2].obligators[1].should == ra3
      dummy = ctx[:dummy][:dummy].size.should == 0
    end
    
    it 'should handle second evaluator with content' do
      ra1, ra2, ra3, ra4 = Restrict.new, Restrict.new, Restrict.new, Restrict.new
      p = Policy.new do
        policy_evaluators :standard, :dummy
        
        dummy :t1, :t2 do
          true
        end
        
        obligate ra1 do
          with ra2
        end
        
        obligate ra2, ra3 do
          with ra4
        end
        
        dummy :t3
        
        obligate ra1, do
          with ra4, ra3
        end

        dummy :t4 do
          true
        end
        
      end
      ctx = p.context
      obligations = ctx[:standard][:obligations] 
      obligations.size.should == 3
      obligations[0].obligatees[0].should == ra1
      obligations[0].obligators[0].should == ra2
      obligations[1].obligatees[0].should == ra2
      obligations[1].obligatees[1].should == ra3
      obligations[1].obligators[0].should == ra4
      obligations[2].obligatees[0].should == ra1
      obligations[2].obligators[0].should == ra4
      obligations[2].obligators[1].should == ra3
      
      dummy_args = ctx[:dummy][:dummy]
      dummy = dummy_args.size.should == 4
      dummy_args[0].should == :t1
      dummy_args[1].should == :t2
      dummy_args[2].should == :t3
      dummy_args[3].should == :t4
      was_block_submitted = ctx[:dummy][:block]
      was_block_submitted[0].should == true
      was_block_submitted[1].should == false
      was_block_submitted[2].should == true
    end
    
  end

  context 'with contraint evaluator' do
    it 'should handle a default evaluator value'
    it 'should handle a custom evaluator value'
  end
  
end
