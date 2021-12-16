require 'tty-prompt'
require 'colorize'

# build a progress bar
def set_progress(index, char = '░')
	(char * (index / 2.5).floor).ljust(40, " ") + " #{index}%\r"
end
100.times do |i|
	print set_progress(i + 1)
	$stdout.flush
	sleep 0.03
end
puts set_progress(100)
sleep 0.5

# running app
question = TTY::Prompt.new
answer = question.select("The installation is complete.".colorize(:light_green)) do |menu|
  menu.choice "Run Tiny hero".colorize(:light_yellow), "Run"
  menu.choice "Exit".colorize(:light_black), "Exit"
end
case answer
when "Run"
  puts "Opening."
  begin
    system("ruby",'./tinyhero.rb')
  rescue LoadError
    system("ruby", "./src/tinyhero.rb")
  end
when "Exit"
  system('clear')
end