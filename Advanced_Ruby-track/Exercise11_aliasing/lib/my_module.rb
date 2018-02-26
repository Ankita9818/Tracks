module MyModule
  def chained_aliasing(orig_meth, aliased_meth)
    method_name, modifier = fetch_name_and_modifier(orig_meth)
    method_name_with_modifier = "#{method_name}_with_#{aliased_meth}#{modifier}".to_sym
    method_name_without_modifier = "#{method_name}_without_#{aliased_meth}#{modifier}".to_sym

    alias_method method_name_without_modifier, orig_meth
    alias_method orig_meth, method_name_with_modifier

    setup_methods_scope(orig_meth, method_name_with_modifier, method_name_without_modifier)
  end

  def fetch_name_and_modifier(orig_method_name)
    name_array = []
    method_name_with_modifier = orig_method_name.match(/(\w*)([?=!]?)/)
    name_array << method_name_with_modifier[1] << method_name_with_modifier[2]
  end

  def setup_methods_scope(method_original, method_name_with_modifier, method_name_without_modifier)
    if public_method_defined?(method_name_without_modifier)
      class_eval do
        public method_name_with_modifier, method_original
      end
    elsif protected_method_defined?(method_name_without_modifier)
      class_eval do
        protected method_name_with_modifier, method_original
      end
    elsif private_method_defined?(method_name_without_modifier)
      class_eval do
        private method_name_with_modifier, method_original
      end
    end
  end
end
