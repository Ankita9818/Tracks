module DirtyObject

  def initialize
    @dirty_obj_hash = Hash.new{ |h, k| h[k] = ['nil'] }
    @obj_changed = false
  end

  def update_dirty_obj_hash(value, attribute)
    if @dirty_obj_hash[attribute].first != value
      update_attr_value(attribute, value)
    else
      update_again_to_previous_value(value, attribute)
    end
  end

  def update_again_to_previous_value(value, attribute)
    @dirty_obj_hash.delete(attribute)
    @obj_changed = false if @dirty_obj_hash.empty?
  end

  def update_attr_value(attribute, value)
    @dirty_obj_hash[attribute] << value
    @dirty_obj_hash[attribute].shift if @dirty_obj_hash[attribute].length > 2
  end

  def changed?
    @obj_changed
  end

  def changes
    changed? ? @dirty_obj_hash : {}
  end

  def save
    @obj_changed = false
    @dirty_obj_hash.each { |key, value| value.shift }
  end

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def define_dirty_attributes(*args)
      args.each do |attribute|
        define_method(attribute) do
          @attribute
        end

        define_method("#{attribute}=") do |value|
          @obj_changed = true
          @attribute = value
          update_dirty_obj_hash(value, attribute)
        end

        define_method("#{attribute}_was") do
          @dirty_obj_hash[attribute].first
        end
      end
    end
  end
end