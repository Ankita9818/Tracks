require 'forwardable'
module MyObjectStore

  def self.included(base)
    base.extend ClassMethods
  end


  module ClassMethods
    include Enumerable
    extend Forwardable
    def_delegators :get_saved_objects, :each, :delegate_each

    def delegate_each
      get_saved_objects
    end

    def get_saved_objects
      @_saved_objects ||= []
    end

    def get_validator_methods
      @_validator_methods ||= []
    end

    def validate_presence_of(*args)
      args.each do |name|
        method_name = "_#{ name }_present?"
        get_validator_methods << method_name
        define_method(method_name) do
          get_error_messages[name] << "#{ name } must exist" unless public_send(name)
        end
      end
    end

    def method_missing(dynamic_finder, *args)
      if(dynamic_finder =~ /find_by_(.*)/)
        attribute = $~[1]
        self.singleton_class.instance_eval do
          define_method(dynamic_finder) do |param|
            get_saved_objects.find_all { |object| object.public_send(attribute) == param }
          end
        end
        public_send dynamic_finder, args[0]
      end
    end
  end

  def get_error_messages
    @_error_messages ||= Hash.new { |hash, key| hash[key] = [] }
  end

  def save
    valid? ? save_objects : "Object unsaved because of #{get_error_messages}"
  end

  private

  def valid?
    self.class.get_validator_methods.each do |method_name|
      public_send(method_name)
    end
    check_for_errors if self.methods.include?(:validate)
    get_error_messages.empty?
  end

  def check_for_errors
    get_error_messages['validate'] << "validate function returned false" unless validate
  end

  def save_objects
    self.class.get_saved_objects << self
    self
  end
end
