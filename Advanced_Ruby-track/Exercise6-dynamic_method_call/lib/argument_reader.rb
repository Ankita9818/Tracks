class ArgumentReader
  attr_reader :arguments
  REQUIRED_PARAM = /req/

  def initialize
    @arguments = []
  end

  def get_params(string, method_name)
    string.method(method_name.to_sym).parameters.each do |param|
      if param[0] =~ REQUIRED_PARAM
        get_required_params(param[1])
      else
        get_optional_params(param[1])
      end
    end
    arguments
  end

  private

  def get_required_params(parameter_name)
    print "Please enter the required argument #{parameter_name} : "
    arguments << gets.chomp
  end

  def get_optional_params(parameter_name)
    print "Please enter the optional argument #{parameter_name} : "
    arg = gets.chomp
    arguments <<  arg if arg != ""
  end
end