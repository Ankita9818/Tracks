# Class InteractiveProgram
class InteractiveProgram
  @complete_command = ''
  @binding_extracted = binding

  class << self
    def create_command(cmd)
      @last_command = cmd
      @complete_command += @last_command
      evaluate_command if @last_command == "\n"
    end

    def evaluate_command
      eval(@complete_command, @binding_extracted)
      @complete_command = ''
    end
  end
end

begin
  cmd = gets
  InteractiveProgram.create_command(cmd)
rescue Exception => e
  puts 'Exception arises - ' + e.message
  exit
end until(cmd == "q\n")