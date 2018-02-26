# reopening Hello class
class Hello
  extend MyModule

  def greet_with_logger
    puts '--logging start'
    greet_without_logger
    puts "--logging end"
  end

  chained_aliasing :greet, :logger
end