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
    hp = roll_dice(80,100)
    att = roll_dice(35,40)

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
    message = "Effictive!"
  when 6
    damage = roll_dice((damage * 1.5).to_i ,(damage * 2).to_i)
    message = "Crit!"
  end
  return [dice, damage, message]
end

# show Visible part
def show_box(char = "", day = "?",  message = "", monster = "")
  # battle page need all 4
  if monster != ""
    artii = Artii::Base.new :font => 'smslant'
    box = TTY::Box.frame(width: 80, height: 20, border: :thick, align: :center, 
      title: {bottom_right: "Day No. #{day}"},
      style: {fg: :bright_red}) do
      monster.info + artii.asciify(message) + "\n\n" + char.info 
    end
  # daily and shop page need char and day  must have message
  elsif char != ""
    artii = Artii::Base.new :font => 'slant'
    title = artii.asciify("TINY HERO !")
    artii = Artii::Base.new :font => 'smslant'
    box = TTY::Box.frame(width: 80, height: 20, border: :thick, align: :center, 
      title: {bottom_right: " Day No. #{day} "},
      style: {fg: :bright_yellow}) do
      title + "\n" + artii.asciify(message) + "\n\n"  + char.info
    end
  # main menu dont need anything
  else

    artii = Artii::Base.new :font => 'slant'
    title = artii.asciify("TINY HERO !")
    artii = Artii::Base.new :font => 'smslant'
    box = TTY::Box.frame(width: 80, height: 20, border: :thick, align: :center, 
      title: {bottom_right: " Day No. #{day} "},
        style: {fg: :bright_green}) do
      title + "\n" + artii.asciify("MAIN MENU") + "\n"  + artii.asciify("WELCOME HERO!")
    end
  end
  puts "
   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
   ░░████████╗██╗███╗░░██╗██╗░░░██╗░░░░██╗░░██╗███████╗██████╗░░█████╗░██╗░░
   ░░╚══██╔══╝██║████╗░██║╚██╗░██╔╝░░░░██║░░██║██╔════╝██╔══██╗██╔══██╗██║░░
   ░░░░░██║░░░██║██╔██╗██║░╚████╔╝░░░░░███████║█████╗░░██████╔╝██║░░██║██║░░
   ░░░░░██║░░░██║██║╚████║░░╚██╔╝░░░░░░██╔══██║██╔══╝░░██╔══██╗██║░░██║╚═╝░░
   ░░░░░██║░░░██║██║░╚███║░░░██║░░░░░░░██║░░██║███████╗██║░░██║╚█████╔╝██╗░░
   ░░░░░╚═╝░░░╚═╝╚═╝░░╚══╝░░░╚═╝░░░░░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░
   ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
  print box
end

# buy item check then use
def buy(char, price, effect, number)
  if char.check(price)
    # use item
    puts "Drinking the potion."
    sleep 1
    puts  "Your body feels stronger."
    sleep 1
    # spend money 
    char.spend(price)
    # get effect
    if effect == "max_hp"
      char.increase_max_hp(number)
    elsif effect == "att"
      char.increase_att(number)
    elsif effect == "f_heal"
      char.heal(number)
    else
      puts "Sorry, there are some problem"
    end
  else
    puts "Sorry, You can't affored."
  end
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
  system('clear')
  puts "
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
  ░░░██████╗░░█████╗░░█████╗░██████╗░██████╗░██╗░░░██╗███████╗░░
  ░░██╔════╝░██╔══██╗██╔══██╗██╔══██╗██╔══██╗╚██╗░██╔╝██╔════╝░░
  ░░██║░░██╗░██║░░██║██║░░██║██║░░██║██████╦╝░╚████╔╝░█████╗░░░░
  ░░██║░░╚██╗██║░░██║██║░░██║██║░░██║██╔══██╗░░╚██╔╝░░██╔══╝░░░░
  ░░╚██████╔╝╚█████╔╝╚█████╔╝██████╔╝██████╦╝░░░██║░░░███████╗░░
  ░░░╚═════╝░░╚════╝░░╚════╝░╚═════╝░╚═════╝░░░░╚═╝░░░╚══════╝░░
  ░░░░░░░░░░░░░░██╗░░██╗███████╗██████╗░░█████╗░██╗░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░██║░░██║██╔════╝██╔══██╗██╔══██╗██║░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░███████║█████╗░░██████╔╝██║░░██║██║░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░██╔══██║██╔══╝░░██╔══██╗██║░░██║╚═╝░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░██║░░██║███████╗██║░░██║╚█████╔╝██╗░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░░░░░░░░░░░░
  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
end