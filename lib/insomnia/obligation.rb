class Obligation
  
  attr_reader :obligatees, :obligators
  
  def initialize(*obligatees, &b)
    @obligatees = obligatees.flatten
    @obligators = []
    instance_exec(&b) if block_given?
  end
  
  def with(*obligators)
    @obligators = @obligators.push(obligators).flatten
  end
  
end
