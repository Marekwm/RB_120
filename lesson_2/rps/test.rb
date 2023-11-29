class Dog
  attr_accessor :score
  def initialize
    @score = 0
  end 
end 

dog = Dog.new
dog.score += 1
p dog.score
dog.score += 1
p dog.score
dog.score += 1
p dog.score