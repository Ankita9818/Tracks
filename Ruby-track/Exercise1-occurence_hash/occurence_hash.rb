if ARGV.empty?
  puts 'Please provide an input'
else
  occurence = Hash.new(0)
  ARGV[0].scan(/[^\d\W]/) do |char|
    occurence[char] += 1
  end
  puts occurence
end