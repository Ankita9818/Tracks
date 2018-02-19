require_relative 'my_obj_store'
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