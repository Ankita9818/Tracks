require_relative '../lib/dynamic_class_generator'
require_relative '../lib/file_not_found_error'

if ARGV.empty?
  puts 'Please provide an input'
else
  my_class = DynamicClassGenerator.new(ARGV[0], File.dirname(__FILE__))
  begin
    my_class.generate
  rescue FileNotFoundError => e
    puts e.message
  else
    my_class.display
  end
end