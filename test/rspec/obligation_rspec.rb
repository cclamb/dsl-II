require_relative '../../lib/insomnia/obligation'

describe Obligation do

  context 'with varying args' do
  
    it 'should handle no args' do
      o = Obligation.new
      o.should_not == nil  
    end
    
    it 'should handle one arg' do
      o = Obligation.new :ra1
      o.should_not == nil
      o.obligatees.size.should == 1
      o.obligatees[0].should == :ra1
    end
    
  end
  
  context 'with two args' do
  
    it 'should handle empty lists' do
      o = Obligation.new [], []
      o.should_not == nil
      o.obligatees.size.should == 0
      o.obligators.size.should == 0
    end
    
    it 'should handle individual elements' do
      o = Obligation.new :ra1, :ra2
      o.should_not == nil
      o.obligatees.size.should == 1
      o.obligatees[0].should == :ra1
      o.obligators.size.should == 1
      o.obligators[0].should == :ra2
    end
    
    it 'should handle list elements' do
      o = Obligation.new [:ra1, :ra2], [:ra3, :ra4]
      o.should_not == nil
      o.obligatees.size.should == 2
      o.obligatees[0].should == :ra1
      o.obligatees[1].should == :ra2
      o.obligators.size.should == 2
      o.obligators[0].should == :ra3
      o.obligators[1].should == :ra4
    end
    
  end
  
end


