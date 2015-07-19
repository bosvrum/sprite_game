require "gosu"

class SpriteGame < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Sprite Game'
  end
end

window = SpriteGame.new
window.show