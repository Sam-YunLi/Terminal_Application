# main menu
def main_menu
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
  question = TTY::Prompt.new
  choises = ["SHOP", "Start Battle", "Save and Exit to main menu", "Save and Exit"]
  case question.select("MENU", choises)
  when "SHOP"
    shop(char, day)

  when "Start Battle"
    pp "Start Battle"

  when "Save and Exit to main menu"
    save_game
    main_menu

  when "Save and Exit"
    save_game
    exit_game
  end

end

# shop page
def shop(char, day)
  char = char
  day = day
  question = TTY::Prompt.new

  # Creat all the item will sell in shop
  shoplist = ["Heal poiton", "MAX HP +50", "ATT +20"]

  # random pick 2 item from shop list add leave
  choises = shoplist.sample(2).push("Leave.")

  while char.alive
    case question.select("SHOP", choises)
    when shoplist[0]
      pp "Heal poiton"

    when shoplist[1]
      pp "MAX HP +20"

    when shoplist[2]
      pp "ATT +5"

    when choises[-1]
      return daily_menu(char, day)
    end
  end

  # error message if something went wrong
  pp "You should not see this message!!! Your are already dead!!!"
end

# battle page
def battle(char, day)
  char = char
  day = day
  monster = Monster.new(day)
  question = TTY::Prompt.new
  choises = ["Attack", "First Aid", "Run"]

  print char.info
  pp "----------------"
  print monster.info

  while char.alive
    pp "It's your turn."
    case question.select("BATTLE", choises)
    when "Attack"
      pp "Attack move!"

      # Roll damge print message 
      char_damge = count_damge(char.att)
      pp "You roll dice got #{char_damge[0]} point, #{char_damge[2]}"
      if char_damge[1] != 0 
        pp "#{monster.name} receive #{char_damge[1]} points of damage."
      end

      # damage the monster
      monster.get_hurt(char_damge[1])

    when "First Aid"
      pp "First Aid"
      # Can't attack but heal yourself 30 hp
      char.heal(30)

    when "Run"
      pp "Run"

      # 1/6 of chance to fail running.
      if roll_dice(1,6) != 1
        return daily_menu(char, day)
      end

      # when faild running, lose attack chance.
      pp "You failed!"
    end

    print char.info
    pp "----------------"
    print monster.info

    # Check monster hp 
    if monster.hp < 1

      # loot gold
      pp "Congratulations on defeating the monster, You picked up #{monster.gold} gold!"
      char.loot(monster.gold)
      question.select("After the fierce battle, you fall asleep", "Next day...")

      # after battle heal 50 point of hp
      char.heal(50)
      print char.info # test
      # break battle loop to daily menu
      return daily_menu(char, day + 1)
    end

    # if monster still alive monster turn
    pp "It's #{monster.name} turn."
    # monster roll damge
    mon_damge = count_damge(monster.att)
    pp "#{monster.name} roll dice got #{mon_damge[0]} point, #{mon_damge[2]}"
    if mon_damge[1] != 0 
      pp "You receive #{mon_damge[1]} points of damage."
    end

    # Hero get the damge
    char.get_hurt(mon_damge[1])

    print char.info
    pp "----------------"
    print monster.info
  end
  pp "You should not see this message!!! Your are already dead!!!"
end