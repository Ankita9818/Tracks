module MyObjectStore

  def self.included(base)
    base.extend ClassMethods
    base.generate_dynamic_finder
  end

  module ClassMethods
    def get_saved_objects
      @saved_objects ||= []
    end

    def get_validator_methods
      @validator_methods ||= []
    end

    def count
      get_saved_objects.length
    end

    def collect
      get_saved_objects
    end

    def validate_presence_of(*args)
      args.each do |name|
        method_name = "present_#{ name }?"
        get_validator_methods << method_name
        define_method(method_name) do
          error_messages[name] << "#{ name } must exist" unless public_send(name)
        end
      end
    end

    def generate_dynamic_finder
      dynamic_finders.each do |param|
        singleton_class.instance_eval do
          define_method("find_by_#{ param }") do |value|
            get_saved_objects.find_all { |object| object.public_send(param) == value }
          end
        end
      end
    end
  end

  def save
    self.methods.include?(:validate) ? check_for_errors : save_objects
  end

  private

  def check_for_errors
    validate
    error_messages.empty? ? save_objects : "Object unsaved because of #{error_messages}"
  end

  def save_objects
    self.class.get_saved_objects << self
    "Object has been created :\n #{ self.inspect }"
  end
end
