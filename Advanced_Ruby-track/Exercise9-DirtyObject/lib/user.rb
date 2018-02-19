require_relative 'dirty_obj'

#class User
class User
  include DirtyObject

  attr_accessor :name, :age, :email

  define_dirty_attributes :name, :age
end