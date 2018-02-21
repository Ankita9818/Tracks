require_relative 'my_obj_store'
class Play

  include MyObjectStore

  attr_accessor :fname, :lname, :age, :email

  validate_presence_of :fname, :email

  def validate
    self.age ? self.age <= 14 : false
  end
end
