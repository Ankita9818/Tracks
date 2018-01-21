class Product
  REGEX_FOR_EXEMPTED_TAX = /book|food|medicine(s?)/i
  SALES_TAX = 0.1
  IMPORT_DUTY = 0.05
  attr_accessor :price, :net_price, :name, :total_tax, :exempted_from_sales_tax, :imported

  def initialize(name, price, imported, exempted_sales_tax)
    @name = name
    @price = price
    @imported = imported
    @exempted_from_sales_tax = exempted_sales_tax
    @total_tax = calculate_total_tax
    @net_price = price_including_tax
  end

  def calculate_sales_tax
    @exempted_from_sales_tax = 'y' if name =~ REGEX_FOR_EXEMPTED_TAX
    (exempted_from_sales_tax? ? 0 : (price * SALES_TAX)).round(2)
  end

  def calculate_total_tax
    (calculate_sales_tax + calculate_import_duty).round(2)
  end

  def exempted_from_sales_tax?
    (exempted_from_sales_tax =~ /y|yes/i)
  end

  def price_including_tax
    price + total_tax
  end

  def import_duty?
    imported =~ /y|yes/i
  end

  def calculate_import_duty
    (import_duty? ? (price * IMPORT_DUTY) : 0).round(2)
  end

  def to_s
    "\n#{ name.ljust(12) }Rs#{ price }\tRs#{ total_tax }\t Rs#{ net_price }"
  end
end