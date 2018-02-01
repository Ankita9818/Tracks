# Class Item
class Item
  attr_reader :name, :quantity
  def initialize(name, qty)
    @name = name
    @quantity = qty
  end

  def to_s
    "\n#{ name.capitalize.ljust(12) } #{ quantity }"
  end
end