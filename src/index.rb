require "tty-prompt"
require "tty-box"
require 'colorize'
require 'artii'
require 'json'

require_relative './classes/character'
require_relative './classes/method'
require_relative './classes/menu_method'


# def load_game
#   puts "Load game!"

#   # check the save file is exit or not
#   if File::exists?('./save/save.json')
#     # Read save file
#     file = File.new('./save/save.txt','r')
    



#   # if the file is not exit
#   else
#     question.select("Sorry, no saving.", "back to main menu")
#     main_menu
#   end

# end

char = Character.new("Leo", 90, 100, 40, 100, true)
day = 6







# save_game(char, day)

# -----------------  one of the way to save
# char = Character.new("Kha", 90, 100, 40, 100, true)
# day = 3
# save_file = [char.name, char.hp, char.max_hp, char.att, char.gold, char.alive, day]

# if !(File::exists?('./save/save.json')) or File.read("./save/save.json") == ""
#   read_file = [].push(save_file)
#   File.open("./save/save.json","w") do |f|
#     f.write({save: read_file}.to_json)
#   end
# else
#   read_file = JSON.parse(IO.read("./save/save.json"))
#   read_file = read_file["save"].push(save_file)
#   File.open("./save/save.json","w") do |f|
#     f.write({save: read_file}.to_json)
#   end
# end
# -------------------------
# pp ({"save" => JSON.parse(File.read("./save/save.json"))["save"].push(save_file)}).to_json

# File.open("./save/save.json","w") do |f|
#   f.write({name: ["a","b","c"]}.to_json)
# end

# read_file = JSON.parse(IO.read("./save/save.json"))
# read_file = read_file["name"].push("d")
# pp read_file

# File.open("./save/save.json","w") do |f|
#   f.write({name: read_file}.to_json)
# end





# load_file = JSON.parse(File.read("./save/save.json"))
# pp load_file["save"]

# char = Character.new("Kha", 100, 100, 20, 100, true)
# show_box(char, 1, "SHOP")
# buy(char,60,"max_hp",50)
# show_box(char, 1, "SHOP")




# char = Character.new("Kha", 100, 100, 20, 100, true)
# monster = Monster.new(1)
# show_box(char,"crit damge", monster)
# show_box(char, "SHOP")

# battle(char,1)



# a = Artii::Base.new :font => 'larry3d'
# puts a.asciify("SHOP")

# print TTY::Box.frame "
# ░██████╗██╗░░██╗░█████╗░██████╗░
# ██╔════╝██║░░██║██╔══██╗██╔══██╗
# ╚█████╗░███████║██║░░██║██████╔╝
# ░╚═══██╗██╔══██║██║░░██║██╔═══╝░
# ██████╔╝██║░░██║╚█████╔╝██║░░░░░
# ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░"


# artii = Artii::Base.new :font => 'graceful'
# puts artii.asciify("SHOP")
