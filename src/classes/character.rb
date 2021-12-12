# Character class
class Character 
  attr_accessor :name, :att, :hp, :max_hp, :gold, :alive

  def initialize(name, hp, max_hp, att, gold, alive)
    @name = name
    @hp = hp
    @max_hp = max_hp
    @att = att
    @gold = gold
    @alive = alive
  end

  # Return box with char infomation.
  def info
    box = TTY::Box.frame(width: 26, height: 6, border: :thick, align: :center, title: {top_left: " #{@name} ".colorize(:light_green), bottom_right: " Gold: " + "#{gold} ".colorize(:light_yellow)}) do  
      "\nHP: " + "#{hp}/#{max_hp}".colorize(:light_red) + "\n" + "Attack: " + "#{@att}".colorize(:light_blue) + "\n"
    end 
    return box
  end

  # loot gold
  def loot(gold)
    @gold += gold
  end

  # heal hp, max to max_hp
  def heal(heal)
    if (@hp + heal) > @max_hp
      @hp = @max_hp
    else
      @hp += heal
    end
  end

  # check price is affordable or not
  def check(price)
    if @gold < price
      return false
    else
      return true
    end
  end

  # spend money
  def buy(price)
    @gold = @gold - price
  end
  
  # increase max_hp
  def increase_max_hp(max_hp)
    @max_hp += max_hp
    @hp += max_hp
  end
  
  # increase att
  def increase_att(att)
    @att += att
  end

  # get damge
  def get_hurt(hurt)
    if (@hp - hurt) < 1
      @hp = 0
      @alive = false
    else
      @hp = @hp - hurt
    end
  end
end


# Monster Class
class Monster
  attr_accessor :name, :att, :hp, :max_hp, :gold, :day
  
  def initialize(day)
    @day = day.to_i
    case @day
      # Random monster name and att base on the day
    when 1..5
      @name = ["Slima", "Goblin", "Spirit", "Fly"].sample
      @att = roll_dice(15,18) + @day
      @max_hp = roll_dice(70,100) + @day * 10
      @hp = @max_hp
      @gold = roll_dice(10,20)
    when 6..10
      @name = ["Goblin", "Spirit", "Skeletor", "Troll", "Vampire", "Zombie", "Ghoul"].sample
      @att = roll_dice(20,25) + (@day - 5) * 2
      @max_hp = roll_dice(130,150) + (@day - 5) * 15
      @hp = @max_hp
      @gold = roll_dice(15,25)
    else
      @name =["Werewolf", "Yeti", "Godzilla", "Troll", "Vampire", "Zombie", "Ghoul"].sample
      @att = roll_dice(30,38) + (@day - 10) * 3
      @max_hp = roll_dice(205,225) + (@day - 10) * 20
      @hp = @max_hp
      @gold = roll_dice(20,30)
    end
  end

  # Retuen the monster info box 
  def info
    box = TTY::Box.frame(width: 26, height: 6, border: :thick, align: :center, title: {top_right: " #{@name} ".colorize(:light_yellow), bottom_right: " Gold: " + "#{gold} ".colorize(:light_black)}) do  
      "\nHP: " + "#{hp}/#{max_hp}".colorize(:light_red) + "\n" + "Attack: " + "#{@att}".colorize(:light_blue) + "\n"
    end 
    return box
  end

  # get damge
  def get_hurt(hurt)
    if (@hp - hurt) < 1
      @hp = 0
    else
      @hp = @hp - hurt
    end
  end

end
