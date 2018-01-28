require_relative 'movie'
class Bollywood < Movie
  @instances = Array.new
  def initialize(title)
    super
    Bollywood.all_movies << self
  end
end