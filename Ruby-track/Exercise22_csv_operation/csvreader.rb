require 'csv'
require 'employee'

#class CSVReader
class CSVReader < Employee
  attr_accessor :file_name
  def initialize(filename)
    @employees = Hash.new { |hash, key| hash[key] = [] }
    @file_name = filename
  end

  def read_csv
    CSV.foreach(file_name, headers: true) do |row|
      @employees[row[2].strip] << Employee.new(row[0], row[1], row[2])
    end
    @employees = @employees.sort.to_h
  end

  def write_into_file
    File.open('employee.txt', 'w') do |file|
      @employees.each do |designation, value|
        @employees[designation].length > 1 ? (file.puts "#{designation}s") : (file.puts "#{designation}")
        file.puts value
        file.puts
      end
    end
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  csv_reader = CSVReader.new(ARGV[0])
  csv_reader.read_csv
  csv_reader.write_into_file
end