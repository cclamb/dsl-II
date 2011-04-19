class Tuple
  def method_missing(m, *args, &block)
    false
  end
end
