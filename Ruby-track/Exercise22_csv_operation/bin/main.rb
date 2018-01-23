require_relative '../lib/csvreader'

if ARGV.empty?
  puts 'Please provide an input'
else
  csv_reader = CSVReader.new(ARGV[0], File.dirname(__FILE__))
  begin
    csv_reader.read_csv
  rescue Exception => e
    puts e.message
  else
    csv_reader.write_into_file
  end
end