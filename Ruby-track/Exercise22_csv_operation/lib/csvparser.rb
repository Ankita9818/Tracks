require 'csv'
require_relative 'employee.rb'

#class CSVParser
class CSVParser
  attr_reader :input_file_name, :output_file_name, :path_to_file, :employees
  def initialize(input_filename, output_filename, path_to_file)
    @employees = Hash.new { |hash, key| hash[key] = [] }
    @input_file_name = input_filename
    @output_file_name = output_filename
    @path_to_file = path_to_file
  end

  def read_csv
    raise FileNotFoundError, "File not found, Please check name of csv file" unless File.exist?(file_path(input_file_name))
    CSV.foreach(file_path(input_file_name), headers: true, col_sep: ', ') do |row|
      employees[row[2]] << Employee.new(row[0], row[1].to_i, row[2])
    end
    sort_employees_by_id
    @employees = employees.sort.to_h
  end

  def sort_employees_by_id
    employees.each do |key, value|
      value.sort!
    end
  end

  def file_path(filename)
    File.expand_path(filename, path_to_file)
  end

  def write_into_file
    File.open(file_path(output_file_name), 'w') do |file|
      employees.each do |designation, value|
        file.puts @employees[designation].length > 1 ? "#{designation}s" : "#{designation}"
        file.puts value
        file.puts
      end
    end
  end
end
