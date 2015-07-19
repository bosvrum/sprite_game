class Enemy
  SPEED = 4
  def initialize(window)
    @radius = 20
    @x = rand(window.width - 2 * @radius) + @radius #we set x to a random number, that will be the center of the enemy ship
    @y = 0 # to be on top of the window
    @image = Gosu::Image.new('images/enemy.png') #add enemy image
    @window = window
  end

  # it moves only in the y direction
  def move
    @y += SPEED
  end

  #we center the image on @x and @y using @radius
  def draw
    @image.draw(@x - @radius, @y - @radius, 1)
  end
end