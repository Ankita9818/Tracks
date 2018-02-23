require_relative '../lib/person'
require_relative '../lib/male'

begin
  p Male.hair_colors
  p Person.new.hair_colors
  p Person.hair_colors
  p Person.new.hair_colors
  Person.new.hair_colors = :pink_blue
  p Person.hair_colors
  p Person.new.hair_colors
  Person.hair_colors = [:brown, :black, :blonde, :red]
  p Person.hair_colors
  p Person.new.hair_colors
  Person.new.hair_colors << :pink
  p Person.hair_colors
  p Person.new.hair_colors
  Male.hair_colors << :blue
  p Male.hair_colors
  p Person.hair_colors
  Person.hair_colors << :yellow
  p Male.hair_colors
  p Person.hair_colors
  Person.new.hair_colors << :green
  p Person.hair_colors

rescue NoMethodError => e
  puts e
end
