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

p4 = Play.new
p4.fname = 'ritu'
p4.lname = 'tyagi'
p4.email = 'riiriz@gmail.com'
p4.age = 19
puts p4.save

p "all objects = #{Play.collect}"
p "No of saved objects = #{Play.count}"

p Play.find_by_fname('anu')
p Play.find_by_age(19)