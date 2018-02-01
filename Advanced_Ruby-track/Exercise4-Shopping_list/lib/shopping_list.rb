require_relative 'item'

#Class ShoppingList
class ShoppingList
  LIST_HEADER = ['Item Name', 'Quantity']

  def initialize
    @list_items = Array.new
  end

  def items(&block)
    instance_eval(&block)
  end

  def add(item_name, quantity)
    @list_items << Item.new(item_name, quantity)
  end

  def to_s
    shopping_list_details = "\n-------------------------------------\n"
    LIST_HEADER.each { | header | shopping_list_details += "#{ header.ljust(12) }" }
    @list_items.each { | item | shopping_list_details += item.to_s }
    shopping_list_details += "\n-------------------------------------\n"
  end
end