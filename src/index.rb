require "tty-prompt"
require "tty-box"
require 'colorize'
require 'artii'

require_relative './classes/character'
require_relative './classes/method'
require_relative './classes/menu_method'








char = Character.new("Kha", 100, 100, 20, 100, true)
battle(char, 1)


# a = Artii::Base.new :font => 'larry3d'
# puts a.asciify("SHOP")

# print TTY::Box.frame "
# ░██████╗██╗░░██╗░█████╗░██████╗░
# ██╔════╝██║░░██║██╔══██╗██╔══██╗
# ╚█████╗░███████║██║░░██║██████╔╝
# ░╚═══██╗██╔══██║██║░░██║██╔═══╝░
# ██████╔╝██║░░██║╚█████╔╝██║░░░░░
# ╚═════╝░╚═╝░░╚═╝░╚════╝░╚═╝░░░░░"

