require_relative 'movie'
class Tollywood < Movie
  @instances = Array.new
  def initialize(title)
    super
    Tollywood.all_movies << self
  end
end