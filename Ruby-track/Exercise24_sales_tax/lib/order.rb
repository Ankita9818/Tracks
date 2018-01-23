class Order
  attr_reader :products
  def initialize
    @products = []
  end

  def add(product_item)
    products << product_item
  end

  def total_price
    calculate_total_price.round
  end

  def calculate_total_price
    products.inject(0) { |sum, product| sum += product.net_price }
  end
end