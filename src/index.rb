require "tty-prompt"
require "tty-box"
require 'colorize'

require_relative './classes/character'
require_relative './classes/method'


def daily_menu(char , day = 1)
  question = TTY::Prompt.new
  choises = { 
    "SHOP" => "shop", 
    "Start Battle" => "Battle" ,
    "Save and Exit to main menu" => "saetmm",
    "Save and Exit" => "sae"
  }

  case question.select("MENU", choises)
  when "shop"
    pp "shop"

  when "Battle"
    pp "Battle"

  when "saetmm"
    pp "saetmm"
    pp "save"
    main_menu

  when "sae"
    pp "sae"
  end

end


char = Character.new("Kha", 100, 20)




