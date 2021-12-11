class Character 
  attr_accessor :name, :att, :hp
  def new_char(name, hp, att)
    @name = name
    @hp = hp
    @att = att
  end
end