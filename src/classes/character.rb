class Character 
  attr_accessor :name, :att, :hp, :live, :level

  def initialize(name, hp, att)
    @name = name
    @hp = hp
    @att = att
    @live = true
    @level = 1
  end

end