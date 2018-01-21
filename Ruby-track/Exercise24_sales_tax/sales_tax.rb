require_relative 'product'
require_relative 'product_receipt'

products_array = []

begin
  print 'Name of the product : '
  product_name = gets.chomp

  print 'Is Product Imported? (yes/no): '
  imported = gets.chomp

  print 'Exempted from tax? (yes/no): '
  exempted_sales_tax = gets.chomp

  print 'Price of Product: '
  price = gets.to_f

  products_array << Product.new(product_name, price, imported, exempted_sales_tax)
  print 'Do you want to add more products ? (y/n):'
  choice = gets.chomp
end while(/^(y|yes)$/i === choice)

invoice = ProductReceipt.new(products_array)
puts invoice.display