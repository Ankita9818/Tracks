require 'csv'
require_relative '../lib/employee.rb'

#class CSVReader
class CSVReader < Employee
  attr_accessor :file_name, :employees
  def initialize(filename)
    @employees = Hash.new { |hash, key| hash[key] = [] }
    @file_name = filename
  end

  def read_csv
    begin
      CSV.foreach(File.expand_path(file_name, File.dirname(__FILE__)), headers: true) do |row|
        @employees[row[2].strip] << Employee.new(row[0].strip, row[1].strip.to_i, row[2].strip)
      end
    rescue
      puts "File not found, Please check name of csv file"
    end
    sort_employees_by_id
    @employees = @employees.sort.to_h
  end

  def sort_employees_by_id
    @employees.each do |key, value|
      value.sort!
    end
  end

  def write_into_file
    File.open(File.expand_path('employee.txt', File.dirname(__FILE__)), 'w') do |file|
      @employees.each do |designation, value|
        @employees[designation].length > 1 ? (file.puts "#{designation}s") : (file.puts "#{designation}")
        file.puts value
        file.puts
      end
    end
    "Employee records entered successfully"
  end
end

if ARGV.empty?
  puts 'Please provide an input'
else
  csv_reader = CSVReader.new(ARGV[0])
  csv_reader.read_csv
  puts csv_reader.write_into_file
end