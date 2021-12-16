require 'tty-box'
require_relative '../lib/method.rb'
require_relative '../lib/class.rb'

describe Character do
  before :each do
    @char = Character.new("Yunli", 90, 100, 40, 110, true)
  end

  it "should be an Character object" do
    expect(@char).to be_a Character
  end

  it "should have 6  properties" do
    expect(@char.name).to eq("Yunli")
    expect(@char.hp).to eq(90)
    expect(@char.max_hp).to eq(100)
    expect(@char.att).to eq(40)
    expect(@char.gold).to eq(110)
    expect(@char.alive).to eq(true)
  end

  describe ".loot" do
    it "should be added the gold to character" do
      @char.loot(20)
      expect(@char.gold).to eq(130)
    end
  end

  describe ".heal" do
    it "should heal the character" do
      @char.heal(5)
      expect(@char.hp).to eq(95)
    end

    it "should not over heal the character" do
      @char.heal(20)
      expect(@char.hp).to eq(100)
    end
  end

  describe ".check" do
    it "should return the currect check result" do
      expect(@char.check(120)).to eq(false)
      expect(@char.check(80)).to eq(true)
    end
  end

  describe ".spend" do
    it "should decrease the gold currect" do
      expect(@char.spend(10)).to eq(100)
      expect(@char.spend(90)).to eq(10)
    end
  end

  describe ".get_hurt" do
    it "should decrease the hp not max_hp" do
      @char.get_hurt(50)
      expect(@char.hp).to eq(40)
      expect(@char.max_hp).to eq(100)
    end

    it "should not make the hp lower than 0" do
      @char.get_hurt(110)
      expect(@char.hp).to eq(0)
      expect(@char.alive).to eq(false)
    end
  end
end

describe Monster do
  before :all do 
    @monster = Monster.new(3)
  end 

  it "should be an Monster object" do
    expect(@monster).to be_a Monster
  end

  describe ".get_hurt" do
    it "should decrease the hp not max_hp" do
      @monster.get_hurt(100)
      expect(@monster.hp).to be_between(15, 45)
      expect(@monster.max_hp).to be_between(115, 145)
    end

    it "should not make the hp lower than 0" do
      @monster.get_hurt(160)
      expect(@monster.hp).to eq(0)
    end
  end

  # make sure the monster ability is currectly rolled. 
  it "should have currect properties in day 1..5" do
    @monster = Monster.new(4)
    expect(["Slima", "Goblin", "Spirit", "Fly"]).to include(@monster.name)
    expect(@monster.att).to be_between(29, 34)
    expect(@monster.max_hp).to be_between(130, 160)
    expect(@monster.hp).to eq(@monster.max_hp)
    expect(@monster.gold).to be_between(20,50)
  end

  it "should have currect properties in day 6..10" do
    @monster = Monster.new(8)
    expect(["Goblin", "Spirit", "Skeletor", "Troll", "Vampire", "Zombie", "Ghoul"]).to include(@monster.name)
    expect(@monster.att).to be_between(39, 44)
    expect(@monster.max_hp).to be_between(190, 210)
    expect(@monster.hp).to eq(@monster.max_hp)
    expect(@monster.gold).to be_between(30,60)
  end

  it "should have currect properties in day > 10" do
    @monster = Monster.new(20)
    expect(["Werewolf", "Yeti", "Godzilla", "Troll", "Vampire", "Zombie", "Ghoul"]).to include(@monster.name)
    expect(@monster.att).to be_between(100, 105)
    expect(@monster.max_hp).to be_between(505, 525)
    expect(@monster.hp).to eq(@monster.max_hp)
    expect(@monster.gold).to be_between(40,70)
  end
end