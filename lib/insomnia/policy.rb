require_relative 'obligation'
require_relative 'policy_evaluator_factory'

class Policy

  def initialize(&b)
    @evaluators = {}
    instance_exec(&b) if block_given?
    if @evaluators.empty?
      @evaluators[:standard] = PolicyEvaluatorFactory.new.create(:standard)
    end
    @evaluators.each_value { |e| e.instance_exec(&b) } if block_given?
  end
  
    def method_missing(method_sym, *arguments, &block) ; end
  
  def context
    @evaluators.length > 1 ? process_mult_ctx : process_single_ctx
  end
  
  def policy_evaluators(*args)
    factory = PolicyEvaluatorFactory.new unless args.empty? || args == nil
    args.each do |tag|
      @evaluators[tag] = factory.create(tag) unless tag == nil
    end unless args == nil
  end
  
  private
  
    def process_single_ctx
      return @evaluators[@evaluators.keys[0]].context
    end
    
    def process_mult_ctx
      h = {}
      @evaluators.each do |k, v|
        h[k] = v.context
      end
      h
    end

end
