require_relative 'product'

class Order
  attr_accessor :products
  def initialize
    @products = []
  end

  def add_order_item(product_name, price, imported, exempted_sales_tax)
    products << Product.new(product_name, price, imported, exempted_sales_tax)
  end

  def total_price
    calculate_total_price.round
  end

  def calculate_total_price
    products.inject(0) { |sum, product| sum += product.net_price }
  end

  def each_item
    products.each do |product|
      yield product
    end
  end
end