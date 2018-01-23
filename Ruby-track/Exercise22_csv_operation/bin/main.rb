require_relative '../lib/csvparser'

if ARGV.empty?
  puts 'Please provide an input'
else
  csv_parser = CSVParser.new(ARGV[0], ARGV[1], File.dirname(__FILE__))
  begin
    csv_parser.read_csv
  rescue FileNotFoundException => e
    puts e.message
  else
    csv_parser.write_into_file
  end
end