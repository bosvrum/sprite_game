require "gosu"
require_relative 'player'
require_relative 'enemy'

class SpriteGame < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sprite Game'
    #in SpriteGame window is self!!
    @player = Player.new(self)
    @enemy = Enemy.new(self)
  end


  # we call the player methods to move the ship using gosu keys
  #button_down? method is part of gosu::window class
  # update method knowing as -60 times per second
  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move
    @enemy.move
  end

  # happens immediately after each iteration of the update method and is used to 'draw' the changes on screen.
  # do not put any logic in here !!!!
  def draw
    @player.draw
    @enemy.draw
  end
end

window = SpriteGame.new
window.show




