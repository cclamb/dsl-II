class PolicyContext

  attr_accessor :activities, :restrictions, :policies

  def initialize(activities = {}, restrictions = [], policies = [])
    @activities = activities
    @restrictions = restrictions
    @policies = policies
  end

end
