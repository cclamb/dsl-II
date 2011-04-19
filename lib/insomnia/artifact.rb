class Artifact

  def initialize(&block)
    @attributes = {}
    instance_exec(&block) if block_given?
  end

  def define(h)
    @attributes = @attributes.merge(h)
  end

  def method_missing(method, *args, &block)
    @attributes[method]
  end

end

