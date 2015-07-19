require 'gosu'
require_relative 'player' 
require_relative 'enemy' 
require_relative 'bullet' 
require_relative 'explosion' 
class SectorFive < Gosu::Window
  WIDTH = 800
  HEIGHT = 600 
  ENEMY_FREQUENCY = 0.02
  MAX_ENEMIES = 100
  def initialize
    super(WIDTH, HEIGHT)
    self.caption = "Sector Five"
    @background_image = Gosu::Image.new('images/start_screen.png') 
    #here we have our new class with it's initialized method
    @scene = :start
  end 

  def initialize_game
    @player = Player.new(self) 
    @enemies = []
    @bullets = []
    @explosions = []
    @scene = :game
    #to track :how many enemies appeared and destroyed
    @enemies_appeared = 0
    @enemies_destroyed = 0
  end

  def draw
    case @scene
    when :start
      draw_start
    when :game
      draw_game
    when :end
      draw_end
    end
  end

  def draw_game
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

  def draw_start
    @background_image.draw(0,0,0)
  end

  def update
    case @scene
    when :game
      update_game
    when :end
      update_end
    end
  end

  def update_game
    @player.turn_left if button_down?(Gosu::KbLeft)
    @player.turn_right if button_down?(Gosu::KbRight)
    @player.accelerate if button_down?(Gosu::KbUp)
    @player.move
    #When used without an argument, the rand() method returns a value between zero and one. 
    #If ENEMY_FREQUENCY is 0.05, we add an enemy about one frame in twenty. 
    if rand < ENEMY_FREQUENCY
      @enemies.push Enemy.new(self)
      @enemies_appeared += 1
    end
    # iterate to move all the enemies
    @enemies.each do |enemy|
      enemy.move
    end

    @bullets.each do |bullet|
      bullet.move
    end

    @explosions.each do |explosion|
      explosion.move 
    end

    # iterate through bouth of enemies and bullets, establish the distance
    # dup ruby method creates a copy of the array 
    @enemies.dup.each do |enemy|
      @bullets.dup.each do |bullet|
        distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y) #We use the Gosu.distance() method here
        if distance < enemy.radius + bullet.radius
          @enemies.delete enemy
          @bullets.delete bullet
          @explosions.push Explosion.new(self, enemy.x, enemy.y)
          @enemies_destroyed += 1
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

    #initialize_end() method
    initialize_end(:count_reached) if @enemies_appeared > MAX_ENEMIES

    @enemies.each do |enemy|
      distance = Gosu.distance(enemy.x, enemy.y, @player.x, @player.y)
      initialize_end(:hit_by_enemy) if distance < @player.radius + enemy.radius
    end

    initialize_end(:off_top) if @player.y < -@player.radius
  end

  def button_down(id) 
    case @scene
    when :start
      button_down_start(id) 
    when :game
      button_down_game(id) 
    when :end
      button_down_end(id)
    end 
  end

  def button_down_start(id) 
    initialize_game
  end

  def button_down_game(id)
    if id == Gosu::KbSpace
      @bullets.push Bullet.new(self, @player.x, @player.y, @player.angle)
    end
  end
end
window = SectorFive.new
window.show