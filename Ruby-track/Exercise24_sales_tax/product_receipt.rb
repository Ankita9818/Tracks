require_relative 'product'

class ProductReceipt
  attr_accessor :products
  INVOICE_HEADER = ["Name", "Price", "Tax", "MRP"]

  def initialize(products_array)
    @products = products_array
  end

  def total_price
    calculate_total_price.round(2).to_i
  end

  def calculate_total_price
    products.inject(0) { |sum, product| sum += product.net_price }
  end

  def display
    invoice_details = "\n--------------------------------------\n"
    INVOICE_HEADER.each { | header | invoice_details += "#{ header.ljust(12) }" }
    products.each { | product | invoice_details += product.to_s }
    invoice_details += "\n--------------------------------------\n"
    invoice_details += "Grand Total : Rs#{ total_price }/-"
  end
end