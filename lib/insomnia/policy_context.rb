class PolicyContext

  attr_accessor :activities, :restrictions

  def initialize(activities = {}, restrictions = {})
    @activities = activities
    @restrictions = restrictions
  end

end
