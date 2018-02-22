require_relative '../lib/csv_manager'
require_relative '../lib/file_not_found_error'
require_relative '../lib/invalid_header_name_error'

if ARGV.empty?
  puts 'Please provide an input'
else
  begin
    my_class = CSVManager.new(ARGV[0], File.dirname(__FILE__)).parse_csv
  rescue FileNotFoundError, InvalidHeaderNameError => e
    puts e.message
  end
end