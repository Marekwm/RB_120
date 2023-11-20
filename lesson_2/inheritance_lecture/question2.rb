# Create a new class called Cat, which can do everything a dog can, except swim or fetch.
# Assume the methods do the exact same thing. Hint: don't just copy and paste all methods
# in Dog into Cat; try to come up with some class hierarchy.
class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end 

class Cat < Pet
  def speak
    'Meow!'
  end 
end

class Dog < Pet
  def speak
    'Bark!'
  end 
  
  def swim
    'swimming!'
  end

  def jump
    'jumping!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end 
end 


pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

p pete.run                # => "running!"
# p pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
# p kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"