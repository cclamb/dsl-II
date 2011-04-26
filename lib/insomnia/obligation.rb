class Obligation
  
  attr_reader :obligatees, :obligators
  
  def initialize(obligatees = [], obligators = [])
    @obligatees = [obligatees].flatten
    @obligators = [obligators].flatten
  end
  
end
