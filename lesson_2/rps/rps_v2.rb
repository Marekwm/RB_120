class Move
  VALUES = ['rock', 'paper', 'scissors']
  
  def intialize(v)
    @value = v
  end 
end 

class Player
  attr_accessor :move, :name
  
  def initialize
    set_name
  end 
end 

class Human < Player
  
  def set_name
    n = nil
    loop do 
      puts "Please enter your name:"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "Please enter a valid name."
    end 
    self.name = n
  end 
  
  def choose
    choice = nil
    loop do 
      puts "Please choose rock, paper or scissors"
      choice = gets.chomp.downcase
      break unless Move::VALUES.include?(choice)
      puts "Please enter a valid choice."
    end 
    self.move = Move.new(choice)
  end 
end 

class Computer < Player
  
  def set_name
    self.name = ['Loki', 'Asta', 'Isugi', 'Rayu', 'Naruto'].sample
  end 
  
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end 
end 
    

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end 
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissor. Good bye!"
  end 
  
  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play