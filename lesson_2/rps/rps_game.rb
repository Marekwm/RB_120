class Move
  VALUES = ['rock', 'paper', 'scissors']
  MOVES = { 'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock' }
  attr_reader :value
  
  def initialize(value)
    @value = value
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
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "sorry that's not a valid name"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts 'Sorry, invalid choice.'
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['Jonny5', 'Bolt', 'Ironside', 'Sabre', 'Ultron'].sample
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
    puts "First to 5 wins the game"
  end
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end
  
  def display_choices
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end
  
  def display_scores
    puts "#{human.name} has #{human.score} points"
    puts "#{computer.name} has #{computer.score} points"
  end 
  
  def display_winner
    if human.move > computer.move
      puts "#{human.name} Won!"
      human.score += 1
    elsif computer.move > human.move
      puts "#{computer.name} Won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again(y or n)"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry must be y or n"
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
        display_scores
        break if human.score == 5||computer.score == 5
      end
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
