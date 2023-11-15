class Box
  def initialize(w, h)
    @width, @height = w, h
  end 
  
  def width 
    @width
  end 
  
  def height
    @height
  end 
end 

box = Box.new(30,50)
x = box.width
y = box.height

puts "The area of a box with a width of #{x}m and a height of #{y}m is #{x * y} meters"