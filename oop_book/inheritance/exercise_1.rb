# Create a superclass called Vehicle for your MyCar class to inherit from and move
# the behavior that isn't specific to the MyCar class to the superclass. 
# Create a constant in your MyCar class that stores information about 
# the vehicle that makes it different from other types of Vehicles.

# Then create a new class called MyTruck that inherits from your superclass that also has
# a constant defined that separates it from the MyCar class in some way.

# =============
# Add a class variable to your superclass that can keep track of the number of objects
# created that inherit from the superclass. Create a method to print out the value of this class variable as well.
# ===========
# Create a module that you can mix in to ONE of your subclasses that describes a behavior unique to that subclass.
module TruckBed
  def large_capacity?(pounds)
    pounds >= 7000
  end 
end 
class Vehicle
  attr_accessor :year, :color, :model
  
  @@vehicle_count = 0
  
  def initialize(y,c,m)
    @model = m
    @year = y
    @color = c 
    @speed = 0
    @@vehicle_count += 1
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
  
  def to_s
    "#{color} #{model} made in #{year}"
  end
  
  def self.gas_mileage(gallons, miles)
     puts "#{miles / gallons} miles per gallon of gas"
  end
  
  def self.total_vehicle_count
    @@vehicle_count
  end 
  
  def age
    puts "Your #{model} is #{years_old} years old"
  end 
  
  private
  def years_old
    Time.now.year - year
  end 
end

class MyTruck < Vehicle
  include TruckBed
  NUMBER_OF_DOORS = 2
end 

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4
end

truck = MyTruck.new(2021, 'orange', 'toyota tacoma')
car = MyCar.new(2021, 'red', 'toyota supra')
p Vehicle.total_vehicle_count
p truck.large_capacity?(6000)
puts "#{'-' * 20}"
puts MyCar.ancestors
puts "#{'-' * 20}"
puts MyTruck.ancestors
puts "#{'-' * 20}"
puts Vehicle.ancestors

puts truck.age
# puts car.years_old