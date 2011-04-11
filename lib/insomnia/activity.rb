

def activity(name, &b)
  
end

class Activity

  attr_accessor :block

  def initialize(&b)
    @block = &b
  end

end
