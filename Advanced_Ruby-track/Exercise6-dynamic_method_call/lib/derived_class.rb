class DerivedClass < String
  def exclude?(substr, *)
    !include?(substr)
  end

  def succ_n(n, *)
    n, nth_succ = n.to_i, self
    while (n > 0)
      n -= 1
      nth_succ.succ!
    end
    nth_succ
  end

  def print_arguments(req, *optional)
    "Hello from #{self}, I have #{optional.length + 1} arguments => \nRequired - #{req}\nOptional - #{optional.inspect}"
  end
end