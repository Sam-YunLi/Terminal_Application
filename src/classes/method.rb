# dice roll from a to b
def roll_dice(min, max)
  rand(min.to_i..max.to_i)
end

# main menu
def main_menu
  question = TTY::Prompt.new
  choises = { 
    "New Game" => "new_game", 
    "Load Game" => "load_game", 
    "Hall of fame" => "hof", 
    "Exit" => "exit"
  }

  case question.select("MENU", choises)
    when "new_game"
      pp "new_game"

      # build new char
      char = new_character
      # put char to daily menu
      daily_menu(char)
      
      # test
      pp char.name

    when "load_game"
      pp "load_game"

    when "hof"
      pp "hof"

    when "exit"
      pp "exit"
  end

end

# new character method use to build new character class
def new_character
  question = TTY::Prompt.new

  # ask the name 
  name = question.ask("Hero, What is your name?") do |q|
    q.required true
    q.modify   :capitalize
  end

  # random hp and att, player reroll until they happy with it
  while 
    hp = roll_dice(65,100)
    att = roll_dice(15,20)
  

    reroll = question.select("Your HP: #{hp}, Attact power: #{att}".colorize(:light_red)) do |menu|
      menu.choice "Reroll Attibutes.".colorize(:light_blue), false
      menu.choice "i am done.".colorize(:light_blue), true
    end

    if reroll
      break
    end

  end

  # return a character class
  return Character.new(name, hp, att)
end