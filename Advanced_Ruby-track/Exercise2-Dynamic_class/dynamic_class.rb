# Class DynamicClass
class DynamicClass
  attr_reader :new_class_name, :new_class
  def initialize(class_name)
    @new_class_name = class_name
    @new_class = Object.const_set(new_class_name, Class.new)
  end

  def def_method(method_name, method_code)
    new_class.class_eval do
      define_method(method_name) do
        instance_eval method_code
      end
    end
    "--- Result ---\nHello, Your class #{new_class_name} with method #{method_name} is ready. Calling: #{new_class_name}.new.#{method_name}:"
  end

  def call(method_name)
    new_class.new.send method_name
  end
end

print 'Please enter the class name: '
class_name = gets.chomp
print 'Please enter the method name you wish to define: '
method_name = gets.chomp
print 'Please enter the method\'s code:'
method_code = gets.chomp
my_class = DynamicClass.new(class_name)
puts my_class.def_method(method_name, method_code)
puts my_class.call(method_name)
