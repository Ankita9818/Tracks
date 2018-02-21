require_relative 'invalid_option_error'

# Class Class
class Class
  def cattr_accessor(*args)
    options = args.last.is_a?(::Hash) ? args.pop : {}
    if options.key?(:instance_accessor) && (options.key?(:instance_reader) || options.key?(:instance_writer))
      raise InvalidOptionError, 'Invalid options passed to method'
    end
    create_cattr_methods(*args, options)
  end

  def create_cattr_methods(*args, options)
    args.each do |attribute|
      initialize_class_attr(attribute)
      create_class_accessor_methods(attribute)
      unless options[:instance_writer] == false || options[:instance_accessor] == false
        create_instance_writer_method(attribute)
      end
      unless options[:instance_reader] == false || options[:instance_accessor] == false
        create_instance_reader_method(attribute)
      end
    end
  end

  def create_class_accessor_methods(attribute)
    singleton_class.class_eval do
      define_method("#{attribute}=") { |value| class_variable_set("@@#{attribute}", value) }
      define_method("#{attribute}") { class_variable_get("@@#{attribute}") }
    end
  end

  def initialize_class_attr(attribute)
    class_eval %(
      unless defined? @@#{attribute}
        @@#{attribute} = nil
      end
    )
  end

  def create_instance_writer_method(attribute)
    class_eval %(
      def #{attribute}=(value)
        @@#{attribute} = value
      end
    )
  end

  def create_instance_reader_method(attribute)
    class_eval %(
      def #{attribute}
        @@#{attribute}
      end
    )
  end
end