require 'forwardable'

# Module MyObjectStore
module MyObjectStore
  def self.included(base)
    base.extend ClassMethods
  end

  # Inner module
  module ClassMethods
    REGEX_DYNAMIC_FINDER = /find_by_(.*)/
    include Enumerable
    extend Forwardable
    def_delegators :saved_objects, :each, :delegate_each

    def delegate_each
      saved_objects
    end

    def saved_objects
      @_saved_objects ||= []
    end

    def validator_method_names
      @_validator_methods ||= []
    end

    def validate_presence_of(*args)
      args.each do |name|
        method_name = "_#{name}_present?"
        validator_method_names << method_name
        define_method(method_name) do
          error_messages[name] << "#{name} must exist" unless public_send(name)
        end
      end
    end

    def method_missing(dynamic_finder, *args)
      if dynamic_finder =~ REGEX_DYNAMIC_FINDER
        attribute = $~[1]
        singleton_class.instance_eval do
          define_method(dynamic_finder) do |param|
            saved_objects.find { |object| object.public_send(attribute) == param }
          end
        end
        public_send dynamic_finder, args[0]
      else
        super
      end
    end
  end

  def error_messages
    @_error_messages ||= Hash.new { |hash, key| hash[key] = [] }
  end

  def save
    valid? ? save_objects : "Object unsaved because of #{error_messages}"
  end

  private

  def valid?
    validate_attribute_presence
    check_for_errors if methods.include?(:validate)
    error_messages.empty?
  end

  def validate_attribute_presence
    self.class.validator_method_names.each { |method_name| public_send(method_name) }
  end

  def check_for_errors
    error_messages['validate'] << 'validate function returned false' unless validate
  end

  def save_objects
    self.class.saved_objects << self
    self
  end
end
