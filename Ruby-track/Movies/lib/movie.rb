class Movie
  @instances = Array.new
  attr_reader :title, :sh
  def initialize(title)
    @title = title
    Movie.all_movies << self
  end

  def sh?
    @sh ||= (rand(2) == 0 ? 'false' : 'true')
  end

  def self.all_movies
    @instances
  end

  def self.super_hit_movies
    @instances.select { |obj| obj.sh == 'true' }
  end

  def to_s
    "\nName: #{title}\n Superhit status : #{sh}"
  end
end