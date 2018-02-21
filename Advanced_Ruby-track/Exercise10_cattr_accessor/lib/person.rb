require_relative 'cattr_accessor'
require_relative 'invalid_option_error'

class Person
  begin
    cattr_accessor :hair_colors
  rescue InvalidOptionError => e
    puts e.message
  end
end
