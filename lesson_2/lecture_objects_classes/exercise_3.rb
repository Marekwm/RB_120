# Now create a smart name= method that can take just a first name or a full name,
# and knows how to set the first_name and last_name appropriately.

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
  
  def parse_full_name(full_name)
    names = full_name.split
    @first_name = names.first
    @last_name = names.size > 1 ? names.last : ''
  end 
  
  private :parse_full_name
end 

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name == 'John'
p bob.last_name  == 'Adams'
