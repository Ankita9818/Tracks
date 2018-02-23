require_relative 'invalid_option_error'

# Class Class
class Class
  def cattr_accessor(*args)
    options = extract_options(*args)
    validate_options(options)
    create_cattr_methods(*args, options)
  end

  private

  def extract_options(*args)
    args.last.is_a?(::Hash) ? args.pop : {}
  end

  def validate_options(options)
    if options.key?(:instance_accessor) && (options.key?(:instance_reader) || options.key?(:instance_writer))
      raise InvalidOptionError, 'Invalid options passed to method'
    end
  end

  def create_cattr_methods(*args, options)
    args.each do |attribute|
      name_hash = {
        getter_method_name: attribute.to_sym,
        setter_method_name: "#{attribute}=".to_sym,
        class_attribute: "@@#{attribute}".to_sym
      }
      initialize_class_attr(name_hash)
      create_class_accessors(name_hash)
      create_instance_accessors(name_hash, options)
    end
  end

  def create_class_accessors(name_hash)
    singleton_class.class_eval do
      define_method(name_hash[:setter_method_name]) { |value| class_variable_set(name_hash[:class_attribute], value) }
      define_method(name_hash[:getter_method_name]) { class_variable_get(name_hash[:class_attribute]) }
    end
  end

  def create_instance_accessors(name_hash, options)
    create_instance_writer_method(name_hash) unless check_for_options(options, :instance_writer)
    create_instance_reader_method(name_hash) unless check_for_options(options, :instance_reader)
  end

  def check_for_options(options, method_to_check)
    options[method_to_check].eql?(false) || options[:instance_accessor].eql?(false)
  end

  def initialize_class_attr(name_hash)
    class_variable_set(name_hash[:class_attribute], nil)
  end

  def create_instance_writer_method(name_hash)
    define_method(name_hash[:setter_method_name]) do |value|
      self.class.class_variable_set(name_hash[:class_attribute], value)
    end
  end

  def create_instance_reader_method(name_hash)
    define_method(name_hash[:getter_method_name]) do
      self.class.class_variable_get(name_hash[:class_attribute])
    end
  end
end
