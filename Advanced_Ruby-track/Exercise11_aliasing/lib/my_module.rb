# Module MyModule
module MyModule
  REGEX_FOR_METHOD_NAME = /(\w*)([?=!]?)/

  def chained_aliasing(orig_meth, aliased_meth)
    meth_with_alias, meth_without_alias = generate_aliased_names(orig_meth, aliased_meth)

    alias_method meth_without_alias, orig_meth
    alias_method orig_meth, meth_with_alias

    setup_methods_scope(orig_meth, meth_with_alias, meth_without_alias)
  end

  def generate_aliased_names(orig_meth, aliased_meth)
    method_name = fetch_name_and_modifier(orig_meth)
    meth_with_alias = "#{method_name['name']}_with_#{aliased_meth}#{method_name['modifier']}".to_sym
    meth_without_alias = "#{method_name['name']}_without_#{aliased_meth}#{method_name['modifier']}".to_sym
    [meth_with_alias, meth_without_alias]
  end

  def fetch_name_and_modifier(orig_method_name)
    method_name_hash = {}
    name_with_modifier = orig_method_name.match(REGEX_FOR_METHOD_NAME)
    method_name_hash['name'] = name_with_modifier[1]
    method_name_hash['modifier'] = name_with_modifier[2]
    method_name_hash
  end

  def setup_methods_scope(original_meth, meth_with_alias, meth_without_alias)
    if public_method_defined?(meth_without_alias)
      class_eval do
        public meth_with_alias, original_meth
      end
    elsif protected_method_defined?(meth_without_alias)
      class_eval do
        protected meth_with_alias, original_meth
      end
    elsif private_method_defined?(meth_without_alias)
      class_eval do
        private meth_with_alias, original_meth
      end
    end
  end
end
