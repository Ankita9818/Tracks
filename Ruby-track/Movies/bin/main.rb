require_relative '../lib/movie'
require_relative '../lib/bollywood'
require_relative '../lib/tollywood'

bollywood_movie_1 = Bollywood.new("Sholay")
bollywood_movie_1.sh?
puts bollywood_movie_1

bollywood_movie_2 = Bollywood.new("Pardes")
bollywood_movie_2.sh?
bollywood_movie_2.sh?
puts bollywood_movie_2

tollywood_movie_1 = Tollywood.new('Surya')
tollywood_movie_1.sh?
tollywood_movie_1.sh?
puts tollywood_movie_1

tollywood_movie_2 = Tollywood.new('Indira')
tollywood_movie_2.sh?
tollywood_movie_2.sh?
puts tollywood_movie_2

puts "\nPresenting All Bollywood movies"
print Bollywood.all_movies

puts "\n\nPresenting All Tollywood movies"
print Tollywood.all_movies

puts "\n\nPresenting All Movies"
print Movie.all_movies

puts "\n\nPresenting super hit Bollywood movies"
print Bollywood.super_hit_movies

puts "\n\nPresenting super hit Tollywood movies"
print Tollywood.super_hit_movies

puts "\n\nPresenting super hit movies"
print Movie.super_hit_movies
puts
