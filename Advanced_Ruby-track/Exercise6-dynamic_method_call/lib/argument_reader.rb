class ArgumentReader
  attr_reader :arguments
  REQUIRED_PARAM = /req/

  def initialize
    @arguments = []
  end

  def get_params(string, method_name)
    string.method(method_name.to_sym).parameters.each do |param|
      print "Please enter the #{param[0] =~ REQUIRED_PARAM ? 'required' : 'optional'} argument #{param[1]} : "
      if param[0] =~ REQUIRED_PARAM
        get_required_params
      else
        get_optional_params
      end
    end
    arguments
  end

  def get_required_params
    arguments << gets.chomp
  end

  def get_optional_params
    arg = gets.chomp
    arguments <<  arg if arg != ""
  end
end