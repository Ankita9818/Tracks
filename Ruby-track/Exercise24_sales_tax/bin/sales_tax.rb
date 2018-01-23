require_relative '../lib/product'
require_relative '../lib/invoice'

REGEX_FOR_YES = /^(y|yes)$/i
current_order = Order.new

begin
  print 'Name of the product : '
  product_name = gets.chomp

  print 'Is Product Imported? (yes/no): '
  imported = gets.chomp

  print 'Exempted from tax? (yes/no): '
  exempted_sales_tax = gets.chomp

  print 'Price of Product: '
  price = gets.to_f

  current_order.add(Product.new(product_name, price, imported, exempted_sales_tax))

  print 'Do you want to add more products ? (y/n):'
  choice = gets.chomp
end while(REGEX_FOR_YES === choice)

puts Invoice.new(current_order).generate
