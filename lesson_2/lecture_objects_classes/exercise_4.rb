# let's create a few more people -- that is, Person objects.
# If we're trying to determine whether the two objects contain the same name, how can we compare the two objects?
class Person
  attr_accessor :first_name, :last_name
  
  def initialize(full_name)
    parse_full_name(full_name)
  end 
  
  def name
    "#{first_name} #{last_name}".strip
  end 
  
  def name=(full_name)
    parse_full_name(full_name)
  end
  
  def same_name(other_name)
    name == other_name
  end 
  
  def to_s
    name
  end 
  
  def parse_full_name(full_name)
    names = full_name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end 
  
  private :parse_full_name
end 
bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p bob.same_name(rob.name)

puts "The person's name is: #{bob}"