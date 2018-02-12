require_relative '../lib/derived_class'

print 'Enter the string : '
str_instance = DerivedClass.new(gets.chomp)
print 'Applicable methods => '
p DerivedClass.instance_methods(false)
print 'Please enter the method name : '
method_name = gets.chomp
args = []
str_instance.method(method_name.to_sym).parameters.each do |param|
  print "Please enter the #{param[0] =~ /req/ ? 'required' : 'optional'} argument #{param[1]} : "
  arg = gets.chomp
  args <<  arg if arg != ""
end
begin
  puts str_instance.public_send method_name, *args
rescue StandardError => e
    p 'Error occurred - ' + e.message
end