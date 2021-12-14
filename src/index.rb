require "tty-prompt"
require "tty-box"
require 'colorize'
require 'artii'

require_relative './classes/character'
require_relative './classes/method'
require_relative './classes/menu_method'





char = Character.new("Kha", 100, 100, 20, 100, true)
show_box(char, 1, "SHOP")
buy(char,60,"max_hp",50)
show_box(char, 1, "SHOP")




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
