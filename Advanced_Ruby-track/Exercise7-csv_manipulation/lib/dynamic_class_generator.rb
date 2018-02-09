require 'csv'
require_relative 'file_not_found_error'

# Class DynamicClassGenerator
class DynamicClassGenerator

  attr_reader :new_class_name, :new_class, :input_file_name, :path_to_file, :object_array

  def initialize(input_file_name, path_to_file)
    @input_file_name = input_file_name
    @path_to_file = path_to_file
    @new_class_name = input_file_name.scan(/\w+/)[0].capitalize
    @new_class = Object.const_set(new_class_name, Class.new)
    @object_array = []
  end

  def generate
    raise FileNotFoundError, "File not found, Please check name of csv file" unless File.exist?(file_path(input_file_name))
    headers = get_headers_from_csv(file_path(input_file_name))
    generate_dynamic_methods(headers)
    parse_csv(file_path(input_file_name), headers)
  end

  def parse_csv(file, headers)
    CSV.foreach(file, headers: true) do |row|
      klass = new_class.new
      headers.each_with_index do |header_name, index|
        klass.instance_variable_set(eval(":@#{header_name}"), row[index])
      end
      @object_array << klass
    end
  end

  def get_headers_from_csv(file)
    CSV.read(file, headers: true).headers
  end

  def generate_dynamic_methods(attributes)
    attributes.each_with_index do |attribute, index|
      new_class.class_eval("attr_reader #{:attribute}")
    end
    object_to_s
  end

  def file_path(filename)
    File.expand_path(filename, path_to_file)
  end

  def display
    object_array.each_with_index do |obj, index|
      display_str = "#{obj.class} #{index + 1} :"
      puts display_str, obj
    end
  end

  def object_to_s
    new_class.class_eval do
      def to_s
        display_str =""
        instance_variables.each do |var|
          display_str += "#{var.to_s.delete('@').capitalize} : #{instance_variable_get(var)}\n"
        end
        display_str
      end
    end
  end
end