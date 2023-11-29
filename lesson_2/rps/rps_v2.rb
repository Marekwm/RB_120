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
  attr_accessor :move, :name, :score
  
  def initialize
    @score = 0
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
    sleep(0.5)
    prompt "You will be playing a computer named #{computer.name} and it will randomly choose a move."
    sleep(2)
    prompt "First to 5 wins, Let's get started!!!"
    sleep(1)
  end 
  
  def display_goodbye_message
    prompt "Thanks for playing Rock, Paper, Scissor. Good bye!"
  end 
  
  def display_choices
    prompt "#{human.name} chose #{human.move}"
    sleep(1)
    prompt "#{computer.name} chose #{computer.move}"
    sleep(1)
  end 
  
  def display_score
    prompt "#{human.name} has #{human.score} points"
    sleep(0.25)
    prompt "#{computer.name} has #{computer.score} points"
    sleep(2)
  end 
  
  def display_winner
    if human.move > computer.move
      prompt "#{human.name} won!"
      human.score += 1
    elsif computer.move > human.move
      prompt "#{computer.name} won!"
      computer.score += 1
    else
      prompt "It's a tie"
    end 
  end 
  
  def play_again?
    answer = nil
    loop do 
      prompt "Do you wish to play again? (y or n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      prompt "Please enter y or n"
    end 
    return true if answer == 'y'
    false 
  end 
      
  def play
    display_welcome_message
    loop do 
      loop do 
        human.choose
        computer.choose
        display_choices 
        display_winner
        display_score
        system 'clear'
        break if human.score == 5 || computer.score == 5
      end 
      break unless play_again?
    end 
    display_goodbye_message
  end
end

RPSGame.new.play