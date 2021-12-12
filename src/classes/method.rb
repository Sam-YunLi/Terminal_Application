# dice roll from a to b
def roll_dice(min, max)
  rand(min.to_i..max.to_i)
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
  return Character.new(name, hp, hp, att, 100, true)
end

# return [dice, damage, message]
def count_damge(damage)
  damage = damage
  message = ""
  dice = roll_dice(1,6)
  case dice
  when 1
    damage = 0
    message = "Miss!"
  when 2
    damage = roll_dice((damage * 0.5).to_i ,(damage * 0.8).to_i)
    message = "Almost miss!"
  when 3..5
    damage = roll_dice((damage * 0.9).to_i ,(damage * 1.2).to_i)
    message = "Hit!"
  when 6
    damage = roll_dice((damage * 1.5).to_i ,(damage * 2).to_i)
    message = "Crit!"
  end
  return [dice, damage, message]
end

# Save game method
def save_game
  puts "Save game!"
end


# Load game method
def load_game
  puts "Load game!"
end


# Show Hall of fame method
def hall_of_fame
  puts "Hall of fame!"
end


# Exit game method
def exit_game
  puts "GOODBYE HERO!"

end