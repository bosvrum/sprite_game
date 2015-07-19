require "gosu"
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SpriteGame < Gosu::Window
  WIDTH = 800
  HEIGHT = 600
  ENEMY_FREQUENCY = 0.02
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = 'Sprite Game'
    #in SpriteGame window is self!!
    @player = Player.new(self)
    @enemies = [] #we create an array where we collect our enemies
    @bullets = []
    @explosions = []
  end


  # we call the player methods to move the ship using gosu keys
  #button_down? method is part of gosu::window class
  # update method knowing as -60 times per second
  def update
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move
    #When used without an argument, the rand() method returns a value between zero and one. 
    #If ENEMY_FREQUENCY is 0.05, we add an enemy about one frame in twenty. 
    if rand < ENEMY_FREQUENCY
      @enemies.push Enemy.new(self)
    end
    # iterate to move all the enemies
    @enemies.each do |enemy|
      enemy.move
    end

    @bullets.each do |bullet|
      bullet.move
    end

    # iterate through bouth of enemies and bullets, establish the distance 
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) #We use the Gosu.distance() method here
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
        end
      end
    end

    @explosions.dup.each do |explosion|
      @explosions.delete explosion if explosion.finished
    end
    
    #eliminate the enemies from the array
    @enemies.dup.each do |enemy|
      if enemy.y > HEIGHT + enemy.radius
        @enemies.delete enemy
      end
    end

    #eliminate the bullets using the onscreen method
    @bullets.dup.each do |bullet|
      @bullets.delete bullet unless bullet.onscreen?
    end

  end

  # happens immediately after each iteration of the update method and is used to 'draw' the changes on screen.
  # do not put any logic in here !!!!
  def draw
    @player.draw
    @enemies.each do |enemy|
      enemy.draw
    end

    @bullets.each do |bullet|
      bullet.draw
    end

    @explosions.each do |explosion| 
     explosion.draw
    end
  end
 
 
  def button_down(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end
end

window = SpriteGame.new
window.show




