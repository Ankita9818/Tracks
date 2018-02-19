require_relative '../lib/play'

p1 = Play.new
p1.fname = 'Neha'
p1.lname = 'Sharma'
p1.age = 10
puts p1.save

p2 = Play.new
p2.fname = 'abc'
p2.lname = 'def'
p2.email = 'heloo@gmail.com'
puts p2.save

p3 = Play.new
p3.fname = 'anu'
p3.lname = 'verma'
p3.email = 'xyz@gmail.com'
p3.age = 14
puts p3.save

p Play.collect
p Play.count

p Play.find_by_fname('anu')
p Play.find_by_age(14)