# Class InteractiveProgram
class InteractiveProgram
  @complete_command = ''
  class << self
    @last_command = ""
    def create_command
      while(@last_command != "q\n")
        @last_command = gets
        @complete_command += @last_command
        evaluate_command if @last_command == "\n"
      end
    end

    def evaluate_command
      eval(@complete_command, TOPLEVEL_BINDING)
      @complete_command = ''
    end
  end
end

begin
  InteractiveProgram.create_command
rescue Exception => e
  puts 'Exception arises - ' + e.message
end
