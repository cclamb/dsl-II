class DummyPolicyEvaluator

  def initialize(&b)
    @dummy = []
    @was_block_attached = []
    @idx = 0
  end
  
  def method_missing(method_sym, *arguments, &block) ; end
  
  def context
    { :dummy => @dummy, :block => @was_block_attached }
  end
  
  def dummy(*args, &b)
    @dummy = @dummy.push(args).flatten
    @was_block_attached[@idx] = block_given?
    @idx = @idx + 1
  end
  
end
