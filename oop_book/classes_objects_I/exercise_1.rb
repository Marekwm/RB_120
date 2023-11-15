=begin
Create a class called MyCar. When you initialize a new instance or object of the class,
allow the user to define some instance variables that tell us the year, color, and model of the car.
Create an instance variable that is set to 0 during instantiation of the object to track the current 
speed of the car as well. Create instance methods that allow the car to speed up, brake, and shut the car off.
////////////////
Add an accessor method to your MyCar class to change and view the color of your car. 
Then add an accessor method that allows you to view, but not modify, the year of your car.
/////
You want to create a nice interface that allows you to accurately describe the action
you want your program to perform. Create a method called spray_paint that can be called
on an object and will modify the color of the car.

Add a class method to your MyCar class that calculates the gas mileage (i.e. miles per gallon) of any car.
=end
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
end



lumina = MyCar.new(1997, 'white', 'chevy lumina')
lumina.speed_up(20)
lumina.current_speed
lumina.speed_up(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.brake(20)
lumina.current_speed
lumina.turn_off
lumina.current_speed


lumina.spray_paint('Purple')

