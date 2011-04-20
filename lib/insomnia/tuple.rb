class Tuple
  
  attr_accessor :artifact, :policy

  def initialize(artifact, policy)
    @artifact = artifact
    @policy = policy
  end

  def method_missing(m, *args, &block)
    false
  end
end
