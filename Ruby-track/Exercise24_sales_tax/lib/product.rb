require_relative 'tax_calculator'

class Product
  REGEX_FOR_YES = /y|yes/i
  attr_accessor :price, :net_price, :name, :total_tax, :exempted_from_sales_tax, :imported

  def initialize(name, price, imported, exempted_sales_tax)
    @name = name
    @price = price
    @imported = imported
    @exempted_from_sales_tax = exempted_sales_tax
    @total_tax = TaxCalculator.calculate_total_tax(price, import_duty?, exempted_from_sales_tax?)
    @net_price = price_including_tax
  end

  def exempted_from_sales_tax?
    (exempted_from_sales_tax =~ REGEX_FOR_YES)
  end

  def import_duty?
    imported =~ REGEX_FOR_YES
  end

  def price_including_tax
    price + total_tax
  end

  def to_s
    "\n#{ name.capitalize.ljust(12) }Rs#{ price }\tRs#{ total_tax }\t Rs#{ net_price }"
  end
end
