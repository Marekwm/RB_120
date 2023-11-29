module Prompt
  def prompt(message)
    puts ">>#{message}"
  end 
end 

class Move
  VALUES = ['rock', 'paper', 'scissors']
  MOVES = {'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock'}
  attr_reader :value
  
  def initialize(v)
    @value = v
  end
  
  def >(other_move)
    return true if MOVES[value] == other_move.value
    false
  end 
  
  def to_s
    value
  end 
end 

class Player
  include Prompt
  attr_accessor :move, :name
  
  def initialize
    set_name
  end 
end 

class Human < Player
  
  def set_name
    n = nil
    loop do 
      prompt "Please enter your name:"
      n = gets.chomp.capitalize
      break unless n.empty?
      prompt "Please enter a valid name."
    end 
    self.name = n
  end 
  
  def choose
    choice = nil
    loop do 
      prompt "Please choose rock, paper or scissors"
      choice = gets.chomp.downcase
      break if Move::VALUES.include?(choice)
      prompt "Please enter a valid choice."
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
  include Prompt
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    prompt "Hi #{human.name}! Welcome to Rock, Paper, Scissors!"
    prompt "You will be playing a computer named #{computer.name} and it will randomly choose a move."
    prompt "Let's get started!!!"
  end 
  
  def display_goodbye_message
    prompt "Thanks for playing Rock, Paper, Scissor. Good bye!"
  end 
  
  def display_choices
    prompt "#{human.name} chose #{human.move}"
    prompt "#{computer.name} chose #{computer.move}"
  end 
  
  def display_winner
    if human.move > computer.move
      prompt "#{human.name} won!"
    elsif computer.move > human.move
      prompt "#{computer.name} won!"
    else
      prompt "It's a tie"
    end 
  end 
  
  def play
    display_welcome_message
    human.choose
    computer.choose
    display_choices 
    display_winner
    display_goodbye_message
  end
end

RPSGame.new.play