require_relative '../lib/derived_class'
require_relative '../lib/argument_reader'

print 'Enter the string : '
str_instance = DerivedClass.new(gets.chomp)
print 'Applicable methods => '
p DerivedClass.instance_methods(false)
print 'Please enter the method name : '
method_name = gets.chomp
begin
  args = ArgumentReader.new.get_params(str_instance, method_name)
  puts str_instance.public_send method_name, *args
rescue StandardError => e
  p 'Error occurred - ' + e.message
end