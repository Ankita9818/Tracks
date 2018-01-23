require_relative 'tax_calculator'

class Product
  attr_reader :price, :net_price, :name, :total_tax, :exempted_from_sales_tax, :imported, :import_duty, :sales_tax

  def initialize(name, price, imported, exempted_sales_tax)
    @name = name
    @price = price
    @imported = imported
    @exempted_from_sales_tax = exempted_sales_tax
    @import_duty = TaxCalculator.calculate_import_duty(price, imported?)
    @sales_tax = TaxCalculator.calculate_sales_tax(price, exempted_from_sales_tax?)
    @total_tax = calculate_total_tax
    @net_price = price_including_tax
  end

  def exempted_from_sales_tax?
    (exempted_from_sales_tax =~ REGEX_FOR_YES)
  end

  def imported?
    imported =~ REGEX_FOR_YES
  end

  def price_including_tax
    price + total_tax
  end

  def calculate_total_tax
    import_duty + sales_tax
  end

  def to_s
    "\n#{ name.capitalize.ljust(12) }Rs#{ price }\tRs#{ total_tax }\t Rs#{ net_price }"
  end
end
