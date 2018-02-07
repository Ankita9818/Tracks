require_relative '../lib/derived_class'

print 'Enter the string : '
str_instance = DerivedClass.new(gets.chomp)
print 'Applicable methods => '
p DerivedClass.instance_methods(false)
print 'Please enter the method name : '
method_name = gets.chomp
print 'Please enter the arguments : '
*arguments = gets.chomp.split(' ')
begin
  puts str_instance.public_send method_name, *arguments
rescue StandardError => e
  puts 'Error occurred - ' + e.message
end