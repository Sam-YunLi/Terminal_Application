# dice roll from a to b
def roll_dice(min, max)
  rand(min.to_i..max.to_i)
end

# main menu
def main_menu
  question = TTY::Prompt.new
  choises = { "New Game" => "new_game", 
    "Load Game" => "load_game", 
    "Hall of fame" => "hof", 
    "Exit" => "exit"
  }
  case question.select("MENU", choises)
    when "new_game"
      pp "new_game"

    when "load_game"
      pp "load_game"

    when "hof"
      pp "hof"

    when "exit"
      pp "exit"
  end
end