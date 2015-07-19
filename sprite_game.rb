require "gosu"
require_relative 'player'

class SpriteGame < Gosu::Window
  def initialize
    super(800, 600)
    self.caption = 'Sprite Game'
    #in SpriteGame window is self!!
    @player = Player.new(self)
  end

  def draw
    @player.draw
  end
end

window = SpriteGame.new
window.show