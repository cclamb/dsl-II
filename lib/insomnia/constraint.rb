class Constraint

  attr_accessor :block

  def initialize(&b)
    @block = b
  end

  def call(h = {})
    is_acceptable = true
    case @block.arity < 0 ? ~@block.arity : @block.arity
      when 0 ; instance_exec { is_acceptable = @block.call }
      when 1 ; instance_exec { is_acceptable = @block.call(h[:context]) }
      when 2 ; instance_exec { is_acceptable = @block.call(h[:context], h[:artifact]) }
      else ; raise DslSyntaxError.new('incorrect constraint arity')
    end unless @block == nil
    return is_acceptable
  end

end
