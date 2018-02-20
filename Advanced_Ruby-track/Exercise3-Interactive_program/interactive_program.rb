# Class InteractiveProgram
class InteractiveProgram

  def initialize(cmd)
    @command = cmd
  end

  def evaluate_command
    eval(@command, TOPLEVEL_BINDING)
  end
end

begin
  cmd = ''
  complete_command = ''
  while(cmd != "q\n")
    cmd = gets
    complete_command += cmd
    if cmd == "\n"
      InteractiveProgram.new(complete_command).evaluate_command
      complete_command = ''
    end
  end
rescue Exception => e
  puts 'Exception arises - ' + e.message
end