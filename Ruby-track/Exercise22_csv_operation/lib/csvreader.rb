require 'csv'
require_relative 'employee.rb'

#class CSVReader
class CSVReader < Employee
  attr_accessor :file_name, :employees, :path_to_file
  def initialize(filename, path_to_file)
    @employees = Hash.new { |hash, key| hash[key] = [] }
    @file_name = filename
    @path_to_file = path_to_file
  end

  def read_csv
    raise Exception, "File not found, Please check name of csv file" unless File.exist?(File.expand_path(file_name, path_to_file))
    CSV.foreach(File.expand_path(file_name, path_to_file), headers: true) do |row|
      @employees[row[2].strip] << Employee.new(row[0].strip, row[1].strip.to_i, row[2].strip)
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
    File.open(File.expand_path('employee.txt', path_to_file), 'w') do |file|
      @employees.each do |designation, value|
        @employees[designation].length > 1 ? (file.puts "#{designation}s") : (file.puts "#{designation}")
        file.puts value
        file.puts
      end
    end
  end
end