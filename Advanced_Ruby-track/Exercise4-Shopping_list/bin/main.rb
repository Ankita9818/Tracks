require_relative '../lib/shopping_list'

sl = ShoppingList.new
sl.items do
  add("Toothpaste", 2)
  add("Computer", 1)
  add("Pen", 10)
end
puts sl