# main menu
def main_menu
  system('clear')
  show_box()
  question = TTY::Prompt.new
  choises = ["New Game", "Load Game", "Hall of fame", "Exit"]
  case question.select("MENU", choises)
  when "New Game"
    # build new char
    char = new_character
    # put char to daily menu
    daily_menu(char, 1)
    
  when "Load Game"
    load_game

  when "Hall of fame"
    hall_of_fame

  when "Exit"
    exit_game
  end
end

# daily menu
def daily_menu(char , day)
  char = char
  day = day
  # Show the show_box with message
  system('clear')
  show_box(char, day, "DAY #{day} !")
  # List for choise
  question = TTY::Prompt.new
  choises = ["SHOP", "Battle", "Save and Exit to main menu", "Save and Exit"]
  case question.select("Daily Menu", choises)
  when "SHOP"
    question.select("Walking to the shop...", "Opening the heavy wooden door...")
    shop(char, day)
  when "Battle"
    puts "Take a deep breath."
    question.select("Opening the dungeon gate...", "Strat Battle")
    battle(char, day)
  when "Save and Exit to main menu"
    save_game(char, day)
    puts "Saving"
    sleep 1
    question.select("Saved", "Main menu")
    main_menu
  when "Save and Exit"
    save_game(char, day)
    puts "Saving"
    sleep 1
    question.select("Saved", "Exit")
    exit_game
  end
end

# shop page
def shop(char, day)
  char = char
  day = day
  question = TTY::Prompt.new
  # Creat all the item will sell in shop
  shoplist = ["MAX HP +50 Potion - cost 60 gold",
    "Attack +10 Potion - cost 60 gold", 
    "MAX HP +100 Potion - cost 80 gold",
    "Attack +20 Potion - cost 80 gold"]
  # random pick 2 item from shop list add leave
   choises = shoplist.sample(2).push("Fully heal - cost 10 gold","Leave.")

  while char.alive
    system('clear')
    show_box(char, day, "DAY #{day} !")
    case question.select("SHOP", choises)
    when shoplist[0]
      # check if the price is affordable
      # "MAX HP +50 Potion - cost 60 gold"
      buy(char,60,"max_hp",50)
    when shoplist[1]
      # "Attack +10 Potion - cost 60 gold"
      buy(char,60,"att",10)
    when shoplist[2]
      # "MAX HP +100 Potion - cost 80 gold"
      buy(char,80,"max_hp",100)
    when shoplist[3]
      # "Attack +20 Potion - cost 80 gold"
      buy(char,80,"att",20)
    when choises[-2]
      # "Fully heal - cost 10gold"
      buy(char,10,"f_heal",char.max_hp)
    when choises[-1]
      # "Leave"
      return daily_menu(char, day)
    end 
  end

  # error message if something went wrong
  puts "You should not see this message!!! Error!!!"
end

# battle page
def battle(char, day)
  char = char
  day = day
  monster = Monster.new(day)
  question = TTY::Prompt.new
  choises = ["Attack", "Heal", "Run"]

  # show the box at top
  system('clear')
  show_box(char, day,"Battle Start!", monster)

  while char.alive
    case question.select("BATTLE", choises)
    when "Attack"
      # Roll damge print message 
      char_damge = count_damge(char.att)
      sleep 1
      puts "You roll dice got #{char_damge[0]} point, #{char_damge[2]}"
      if char_damge[1] != 0
        sleep 1
        puts "#{monster.name} receive #{char_damge[1]} points of damage."
      end
      # damage the monster
      monster.get_hurt(char_damge[1])
      # show the box
      sleep 1
      system('clear')
      show_box(char, day, "#{char_damge[2]}", monster)
      puts "You roll dice got #{char_damge[0]} point, #{char_damge[2]}"
      if char_damge[1] != 0
        puts "#{char_damge[2]} \n#{monster.name} receive #{char_damge[1]} points of damage."
      end

    when "Heal"
      # Can't attack but heal yourself
      char.heal(50)
      # show the box
      sleep 1
      question.select("Using bandage.", "Healing yourself")
      system('clear')
      show_box(char, day, "Heal yourlesf.", monster)
      puts "Healing yourself."
      puts "You got 50 HP."

    when "Run"
      # 1/6 of chance to fail running.
      question.select("Tring to run away.","Run.")
      if roll_dice(1,6) != 1
        question.select("Successful","Go back to town.")
        return daily_menu(char, day)
      end
      # when faild running, lose attack chance.
      # show the box
      system('clear')
      show_box(char, day, "You failed!", monster)
      puts "Running faild!."
    end

    # Check monster hp 
    if monster.hp < 1
      sleep 1
      system('clear')
      show_box(char, day, "Congratulations!", monster)
      # loot gold
      puts "Congratulations on defeating the monster, You picked up #{monster.gold} gold!"
      sleep 1
      char.loot(monster.gold)
      question.select("After the fierce battle, you fall asleep", "Next day...")
      # after battle heal 80 point of hp
      char.heal(80)
      # break battle loop to daily menu day + 1
      return daily_menu(char, day + 1)
    end

    # if monster still alive monster turn
    # show the box
    # count 2 sec
    question.select("Hero turn finished", "Monster turn.")
    system('clear')
    show_box(char, day, "#{monster.name} TURN", monster)
    puts "It's #{monster.name} turn."
    # monster roll damge
    mon_damge = count_damge(monster.att)
    sleep 1
    puts "#{monster.name} roll dice got #{mon_damge[0]} point, #{mon_damge[2]}"
    if mon_damge[1] != 0 
      sleep 1
      puts "You receive #{mon_damge[1]} points of damage."
    end

    # Hero get the damge
    char.get_hurt(mon_damge[1])

    # Check char hp 
    if char.alive
      # char alive
      sleep 1
      system('clear')
      show_box(char, day, mon_damge[2], monster)
      puts "It's #{monster.name} turn."
      puts "#{monster.name} roll dice got #{mon_damge[0]} point, #{mon_damge[2]}"
      if mon_damge[1] != 0 
        puts "You receive #{mon_damge[1]} points of damage."
      end
      # go back to hero turn
      question.select("Monster turn finished", "Hero Turn")     
      system('clear')
      show_box(char, day, "HERO TURN", monster)
      puts "Hero Turn."

    else
      # when hp < 1 lose game
      sleep 1
      system('clear')
      show_box(char, day, "YOU LOSE", monster)
      # use this method to delet from save file, put in hof file
      hero_dead(char,day)
      question.select("You lose.", "Main menu")
      # break loot go to main_menu
      return main_menu
    end
  end
  # Error if you see this
  puts "You should not see this message!!! Your are already dead!!!"
end

