class Player
  ROTATION_SPEED = 3
  ACCELERATION = 2
  FRICTION = 0.9
  # the window argument we will use to let the ship interct with the edges of the window
  def initialize(window)
    # @x & @y to set the postion on the window
    @x = 200
    @y = 200
    @angle = 0
    #store the img on the @image instance variable
    @image = Gosu::Image.new('images/ship.png')
    # add instance variables for speed
    @velocity_x = 0
    @velocity_y = 0
    #instance variable to define the edges of the window 
    #Gosu::Window class has methods that let us use our @window reference to get the width and height of the window
    @window = window
    #radius method to take the center of the ship
    @radius = 0
  end

  # we use draw_rot, a method from gosu::image,
  # the draw method draws the image rotated by any angle, measured in degrees
  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end


  #we need to make the ship rotate right and left
  def turn_right
    @angle += ROTATION_SPEED
  end

  def turn_left
    @angle -= ROTATION_SPEED
  end

  # we need to change the velocity with the accelerate method
  # we use offset_x/y gosu methods 
  #offset_x takes the angle and an amount as argument and returns the amount in the x directions 
  def accelerate
    @velocity_x += Gosu.offset_x(@angle, ACCELERATION)
    @velocity_y += Gosu.offset_y(@angle, ACCELERATION)
  end

  # we move the ship 
  def move
    @x += @velocity_x
    @y += @velocity_y
    #we use these to slow down the speed, acting like a friction
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION
    # we add conditionals to delimt the edge of the window
    if @x > @window.width - @radius
      @velocity_x = 0
      @x = @window.width - @radius 
    end
    if @x < @radius
      @velocity_x = 0
      @x = @radius
    end
    if @y > @window.height - @radius
      @velocity_y = 0
      @y = @window.height - @radius
    end
  end

end