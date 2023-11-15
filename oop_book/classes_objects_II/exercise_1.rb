# Add a class method to your MyCar class that calculates the gas mileage (i.e. miles per gallon) of any car.

# Override the to_s method to create a user friendly print out of your object.
class MyCar
  attr_accessor :color
  attr_reader :year
  
  def initialize(y,c,m)
    @year = y
    @color = c 
    @model = m
    @speed = 0
  end 
  
  def speed_up(num)
    @speed += num
    puts "You sped up #{num} mph!"
  end 
  
  def brake(num)
    @speed -= num
    puts "You slowed down #{num} mph"
  end 
  
  def current_speed
    puts "You are currently driving #{@speed} mph"
  end 
  
  def turn_off
    @speed = 0
    puts "You are stopped and the car is now off."
  end 
  
  def spray_paint(color)
    self.color = color
    puts "Your vehicle just got a new paint job, #{color} looks great!"
  end 
  
  def self.gas_mileage(gallons, miles)
     puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def to_s
    "#{color} #{@model} made in #{year}"
  end
end



lumina = MyCar.new(1997, 'white', 'chevy lumina')
# lumina.speed_up(20)
# lumina.current_speed
# lumina.speed_up(20)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.turn_off
# lumina.current_speed


# lumina.spray_paint('Purple')
MyCar.gas_mileage(13, 351)
puts lumina