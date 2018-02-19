module DirtyObject

  module ClassMethods
    def get_obj_hash
      @_dirty_obj_hash ||= Hash.new { |h, k| h[k] = [nil, nil] }
    end

    def define_dirty_attributes(*args)
      anonymous_module = Module.new do
        args.each do |attribute|
          define_method("#{attribute}=") do |value|
            update_dirty_obj_hash(attribute, value)
            super(value)
          end

          define_method("#{attribute}_was") do
            self.class.get_obj_hash[attribute].first
          end
        end
      end
      prepend anonymous_module
    end
  end

  def update_dirty_obj_hash(attribute, value)
    self.class.get_obj_hash[attribute][1] = value
  end

  def changed?
    !changes.empty?
  end

  def changes
    self.class.get_obj_hash.select { |_key, value| value[0] != value[1] }
  end

  def save
    self.class.get_obj_hash.each { |_key, value| value[0] = value[1] }
  end

  def self.included(base)
    base.extend ClassMethods
  end
end