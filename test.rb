module Animal 
  class Mammal
    attr_accessor :name
    def initialize(n)
      @name = n
    end 
  end
  
  class Dog < Mammal
  end
end 
sparky = Animal::Dog.new('sparky')
p sparky.name