require_relative 'invalid_header_name_error'

# Class DynamicClassGenerator
class DynamicClassGenerator

  REGEX_FOR_ATTR_READER = /\A(?:[a-z_]\w*[?!=]?)\z/
  attr_reader :new_class_name, :new_class, :object_array, :csv_file_obj

  def initialize(input_file_name)
    @new_class_name = input_file_name.scan(/\w+/)[0].capitalize
    @new_class = Object.const_set(new_class_name, Class.new)
    @object_array = []
  end

  def generate(csv_file)
    @csv_file_obj = csv_file
    headers = csv_file.shift
    validate_headers(headers)
    create_object_attributes(headers)
    generate_dynamic_methods(headers)
  end

  def validate_headers(headers)
    headers.each do |col_header|
      raise InvalidHeaderNameError, "Invalid header name  - #{col_header}" unless col_header =~ REGEX_FOR_ATTR_READER
    end
  end

  def create_object_attributes(headers)
    @csv_file_obj.each do |row|
      klass = new_class.new
      headers.each_with_index do |header_name, index|
        klass.instance_variable_set("@#{header_name}", row[index])
      end
      @object_array << klass
    end
  end

  def generate_dynamic_methods(attributes)
    attributes.each_with_index do |attribute, index|
      new_class.class_eval("attr_reader #{:attribute}")
    end
    add_to_s_method
  end

  def display
    object_array.each_with_index do |obj, index|
      display_str = "#{obj.class} #{index + 1} :"
      puts display_str, obj
    end
  end

  def add_to_s_method
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