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
            get_saved_objects.find_all { |object| object.public_send(param).eql? value }
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

class Play

  def self.dynamic_finders
    [:fname, :lname, :age, :email]
  end

  include MyObjectStore
  attr_accessor :fname, :lname, :age, :email, :error_messages
  validate_presence_of :fname, :email

  def initialize
    self.error_messages = Hash.new { |hash, key| hash[key] = [] }
  end

  def validate
    error_messages.clear
    self.class.get_validator_methods.each do |method_name|
      public_send(method_name)
    end
  end
end

p1 = Play.new
p1.fname = 'Neha'
p1.lname = 'Sharma'
p1.age = 10
puts p1.save

p2 = Play.new
p2.fname = 'abc'
p2.lname = 'def'
p2.email = 'heloo@gmail.com'
puts p2.save

p3 = Play.new
p3.fname = 'anu'
p3.lname = 'verma'
p3.email = 'xyz@gmail.com'
p3.age = 14
puts p3.save

p Play.collect
p Play.count

p Play.find_by_fname('anu')
p Play.find_by_age(14)