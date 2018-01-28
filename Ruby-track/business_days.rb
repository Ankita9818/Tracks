class Integer
  SECONDS_IN_A_DAY = 60 * 24 * 60
  def business_days
    date_after_business_days = Time.now
    no_of_days_required = self
    while(no_of_days_required > 0)
      date_after_business_days += SECONDS_IN_A_DAY
      no_of_days_required -= 1 unless (date_after_business_days.saturday? or date_after_business_days.sunday?)
    end
    date_after_business_days
  end
end

puts ARGV[0].empty? ? 'Please provide an input' : ARGV[0].to_i.business_days
