

def activity(name, &b)
  Activity.new(&b)
end

class Activity

  attr_accessor :block

  def initialize(&b)
    @block = b
  end

  def call
    @block != nil ? block.call : true
  end

end
