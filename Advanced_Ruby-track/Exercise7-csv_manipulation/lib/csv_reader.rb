require 'csv'
require_relative 'file_not_found_error'
require_relative 'dynamic_class_generator'

class CSVReader

  attr_reader :input_file_name, :path_to_file, :csv_file
  def initialize(input_file_name, path_to_file)
    @input_file_name = input_file_name
    @path_to_file = path_to_file
  end

  def file_path(filename)
    File.expand_path(filename, path_to_file)
  end

  def parse_csv
    raise FileNotFoundError, "File not found, Please check name of csv file" unless File.exist?(file_path(input_file_name))
    @csv_file = CSV.read(file_path(input_file_name))
    @csv_creator_obj = DynamicClassGenerator.new(input_file_name)
    @csv_creator_obj.generate(@csv_file)
    @csv_creator_obj.display
  end
end