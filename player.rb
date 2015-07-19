class Player
  # the window argument we will use to let the ship interct with the edges of the window
  def initialize(window)
    # @x & @y to set the postion on the window
    @x = 200
    @y = 200
    @angle = 0
    #store the img on the @image instance variable
    @image = Gosu::Image.new('images/ship.png')
  end

  # we use draw_rot, a method from gosu::image,
  # the draw method draws the image rotated by any angle, measured in degrees
  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end


  #we need to make the ship rotate right and left
  def turn_right
    @angle += 3
  end

  def turn_left
    @angle -= 3
  end
end