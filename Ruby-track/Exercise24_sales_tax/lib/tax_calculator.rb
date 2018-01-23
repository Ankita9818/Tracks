class TaxCalculator
  SALES_TAX = 0.1
  IMPORT_DUTY = 0.05

  def self.calculate_import_duty(price, imported)
    (imported ? (price * IMPORT_DUTY) : 0).round(2)
  end

  def self.calculate_sales_tax(price, exempted_from_sales_tax)
    (exempted_from_sales_tax ? 0 : (price * SALES_TAX)).round(2)
  end
end
