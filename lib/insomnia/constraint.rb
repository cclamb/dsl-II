require_relative 'deferred_executor'

def constraint(&b)
  Constraint.new(&b)
end

class Constraint < DeferredExecutor; end
