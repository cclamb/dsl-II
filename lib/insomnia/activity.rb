require_relative 'deferred_executor'

def activity(name, &b)
  Activity.new(&b)
end

class Activity < DeferredExecutor; end
