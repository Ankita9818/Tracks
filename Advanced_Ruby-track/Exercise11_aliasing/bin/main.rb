require_relative '../lib/my_module'
require_relative '../lib/hello'

say = Hello.new
say.send :greet # =>  hello

require_relative '../lib/reopen_hello.rb'

say = Hello.new
say.send :greet

# --logging start
# hello
# --logging end


say.send :greet_with_logger
# --logging start
# hello
# --logging end

say.send :greet_without_logger
# hello

# p say.private_methods