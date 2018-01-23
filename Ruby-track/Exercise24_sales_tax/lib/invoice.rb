require_relative 'product'
require_relative 'order'
class Invoice
  attr_accessor :order
  INVOICE_HEADER = ["Name", "Price", "Tax", "MRP"]

  def initialize(order)
    @order = order
  end

  def generate
    invoice_details = "\n----------------------------------------\n"
    INVOICE_HEADER.each { | header | invoice_details += "#{ header.ljust(12) }" }
    order.each_item { | item | invoice_details += item.to_s }
    invoice_details += "\n----------------------------------------\n"
    invoice_details += "Grand Total : Rs#{ order.total_price }/-"
  end
end
