class TaxCalculator
  SALES_TAX = 0.1
  IMPORT_DUTY = 0.05

  def self.calculate_total_tax(price, import_duty_applicable, exempted_from_sales_tax_applicable)
    (calculate_sales_tax(price, exempted_from_sales_tax_applicable) + calculate_import_duty(price, import_duty_applicable)).round(2)
  end

  def self.calculate_import_duty(price, import_duty_applicable)
    (import_duty_applicable ? (price * IMPORT_DUTY) : 0).round(2)
  end

  def self.calculate_sales_tax(price, exempted_from_sales_tax_applicable)
    (exempted_from_sales_tax_applicable ? 0 : (price * SALES_TAX)).round(2)
  end
end
