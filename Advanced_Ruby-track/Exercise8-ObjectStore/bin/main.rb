require_relative '../lib/play'

p1 = Play.new
p1.fname = 'Neha'
p1.lname = 'Sharma'
p1.age = 10
p p1.save
puts

p2 = Play.new
p2.fname = 'abc'
p2.lname = 'def'
p2.email = 'heloo@gmail.com'
p p2.save
puts
p3 = Play.new
p3.fname = 'anu'
p3.lname = 'verma'
p3.email = 'xyz@gmail.com'
p3.age = 14
p p3.save
puts
p4 = Play.new
p4.fname = 'ritu'
p4.lname = 'tyagi'
p4.email = 'riiriz@gmail.com'
p4.age = 19
p p4.save
puts
p5 = Play.new
p5.fname = 'pari'
p5.lname = 'rawat'
p5.email = 'prince@gmail.com'
p5.age = 11
p p5.save
puts
puts "all objects = #{Play.collect {|obj| obj.inspect}}\n"
puts "No of saved objects = #{Play.count}\n"
p Play.find_by_fname('anu')
puts
p Play.find_by_age(11)
# p Play.hjdhjbj #=> will give NoMethodError