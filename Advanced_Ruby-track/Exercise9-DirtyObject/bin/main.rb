require_relative '../lib/user'

u = User.new
u.name  = 'Akhil'
u.email = 'akhil@vinsol.com'
u.age   = 30
puts "u.changed? = #{u.changed?}"
puts "u.changes = #{u.changes}"     #{ name: [nil, 'Akhil], age: [nil, 30] }
puts "u.name_was = #{u.name_was}"   #nil
u.email_was rescue puts 'undefined method'   #undef
puts "u.age_was = #{u.age_was}"     #nil
u.save
puts "u.changed? = #{u.changed?}" #false
puts "u.changes = #{u.changes}"   #{}
u.name = 'New name'
u.age  = 31
puts "u.changes = #{u.changes}"   #{name: ['Akhil', 'New name'], age: [30, 31]}
puts "u.name_was = #{u.name_was}" #'Akhil'
u.name = 'Akhil'
puts "u.changes = #{u.changes}"    #{age: [30, 31]}
puts "u.changed? = #{u.changed?}"  #true
u.age = 30
puts "u.changed? = #{u.changed?}"   #false
puts "u.changes = #{u.changes}"     #{}
u.save
puts u.changed?
puts u.changes
u.name = 'Anita'
puts u.name_was
puts u.changed?
puts u.changes
u.name = 'Babbi'
puts u.name_was
puts u.changed?
puts u.changes
u.save
puts u.name_was
u.name = "shammo"
puts u.name_was
puts u.changes