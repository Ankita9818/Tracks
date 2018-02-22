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
      unless options[:instance_writer].eql?(false) || options[:instance_accessor].eql?(false)
        create_instance_writer_method(attribute)
      end
      unless options[:instance_reader].eql?(false) || options[:instance_accessor].eql?(false)
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
    class_eval %(@@#{attribute} = nil unless defined? @@#{attribute})
  end

  def create_instance_writer_method(attribute)
    class_eval do
      define_method("#{attribute}=") do |value|
        self.class.class_eval("@@#{attribute} = #{value}")
      end
    end
  end

  def create_instance_reader_method(attribute)
    class_eval do
      define_method(attribute) do
        self.class.class_eval("@@#{attribute}")
      end
    end
  end
end