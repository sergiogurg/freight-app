class Volume
  attr_accessor :length, :height, :width
  def initialize(length:, height:, width:)
    @length = length
    @height = height
    @width = width
  end

  def calculate_volume()
    @length*@height*@width
  end
end