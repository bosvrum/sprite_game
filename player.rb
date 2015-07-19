class Player
  def initialize(window)
    # @x & @y to set the postion on the window
    @x = 200
    @y = 200
    @angle = 0
    #store the img on the @image instance variable
    @image = Gosu::Image.new('images/ship.png')
  end
end