class Player
  attr_accessor :move, :name
  
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end
  
  def set_name
    if human?
      n = nil
      loop do 
        puts "What's your name?"
        n = gets.chomp
        break unless n.empty?
        puts "sorry that's not a valid name"
      end 
      self.name = n
    else 
      self.name = ['Jonny5', 'Bolt', 'Ironside', 'Sabre', 'Ultron'].sample
    end 
  end 
  
  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper or scissors:"
        choice = gets.chomp
        break if ['rock', 'paper', 'scissors'].include?(choice)
        puts 'Sorry, invalid choice.'
       end
      self.move = choice
    else 
      self.move = ['rock', 'paper', 'scissors'].sample
    end 
  end 
  
  def human?
    @player_type == :human
  end 
end 

class RPSGame
  attr_accessor :human, :computer

  WINNING_COMBOS = {'rock' => 'scissors', 'scissors' => 'paper', 'paper' => 'rock'}
  
  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end 
  
  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Goodbye!"
  end
  
  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    
    if WINNING_COMBOS[human.move] == computer.move
      puts "#{human.name} Won!"
    elsif WINNING_COMBOS[computer.move] == human.move
      puts "#{computer.name} Won!"
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
    return false
  end 
  
  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end 
    display_goodbye_message
  end
end

RPSGame.new.play