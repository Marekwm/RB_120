require 'yaml'
MESSAGES = YAML.load_file('final_ttt_text.yml')

class Board
  WINNING_LINES = [[1, 2 ,3], [4, 5, 6], [7, 8, 9], #rows
                [1, 4, 7], [2, 5, 8],[3, 6, 9],  #columns
                [1, 5, 9], [3, 5, 7]]       #diagonals
  
  attr_accessor :squares
  
  def initialize
    @squares = {}
    reset
  end
  
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  
  def reset
    (1..9).each {|key| @squares[key] = Square.new}
  end
  
  def []=(square, marker)
    @squares[square].marker = marker
  end 
  
  def unmarked_keys
    @squares.select {|_,sq| sq.unmarked?}.keys 
  end

  def full?
    unmarked_keys.empty?
  end 
  
  def round_winner? 
    !!winning_marker
  end 
  
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end 
    end 
    nil
  end 
  
  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end 
end

class Square
  INITIAL_MARKER = " "
  
  attr_accessor :marker

  def initialize
    @marker = INITIAL_MARKER
  end

  def to_s
    @marker
  end

  def unmarked?
    @marker == INITIAL_MARKER
  end
  
  def marked?
    @marker != INITIAL_MARKER
  end 
end

class Player 
  
  attr_accessor :score, :name, :marker
  
  def initialize
    reset_score
  end 
  
  def increment_score
    self.score += 1
  end 
  
  def reset_score 
    @score = 0
  end 
end 

class Human < Player
  
  def set_name
    puts MESSAGES['ask_for_name']
    name = nil
    loop do 
      name = gets.chomp.capitalize
      break unless name.empty?
      puts MESSAGES['ask_for_valid_input']
    end 
    self.name = name
  end 
  
  def set_marker
    puts "Hi #{name}, Choose any character that you wish to use for marking the board."
    marker = nil
    loop do 
      marker = gets.chomp.capitalize
      break if marker.size == 1 && marker != ' '
      puts MESSAGES['ask_for_valid_marker']
    end 
    self.marker = marker
  end 
  
  def choose_move(board)
    puts "Please choose a square #{board.unmarked_keys.join(', ')}"
    square = nil
    loop do 
      square = gets.to_i
      break if board.unmarked_keys.include?(square)
      puts MESSAGES['ask_for_valid_square']
    end 
    board[square] = marker
  end 
  
end 

class Computer < Player
  
  def initialize
    super
    @name = ['Asta', 'Cliford', 'Reeka', 'Ilyana'].sample
  end 
  
  def set_marker(other_marker)
    #we want the first character of it's name and if that's taken then random letter
    if name[0] != other_marker
      self.marker = name[0]
    else 
      self.marker = (('A'..'Z').to_a - [other_marker]).sample
    end 
  end 
  
  def choose_move(board, human_marker)
    if find_offensive_move(board)
      board[find_offensive_move(board)] = marker
    elsif find_defensive_move(board, human_marker)
      board[find_defensive_move(board, human_marker)] = marker
    else
      board[board.unmarked_keys.sample] = marker
    end
  end

  def find_defensive_move(board, human_marker)
    lines_marked_twice = find_lines_marked_twice(board, human_marker)
    return nil unless lines_marked_twice
    lines_marked_twice.flatten.select do |square_key|
      board.squares[square_key].marker == Square::INITIAL_MARKER
    end.first
  end

  def find_offensive_move(board)
    lines_marked_twice = find_lines_marked_twice(board, marker)
    return nil unless lines_marked_twice
    lines_marked_twice.flatten.select do |square_key|
      board.squares[square_key].marker == Square::INITIAL_MARKER
    end.first
  end

  def find_lines_marked_twice(board, player_marker)
    lines_marked_twice = Board::WINNING_LINES.select do |line|
      current_squares = board.squares.values_at(*line)
      current_squares.map(&:marker).count(player_marker) == 2
    end
    lines_marked_twice.empty? ? nil : lines_marked_twice
  end
end 

class TTTGame
  
  attr_accessor :current_marker
  attr_reader :human, :computer, :board
  
  def initialize
    @human = Human.new
    @computer = Computer.new
    @board = Board.new
  end 
  
  def play
    clear
    display_welcome_message
    setup_game_choices
    loop do
      loop do
        main_game
        display_board
        display_round_winner
        break if human.score == 3 || computer.score == 3 
        reset
      end 
      display_grand_winner
      break unless play_again?
      reset
      reset_scores
    end
    display_goodbye_message
  end 
  
  private 
  
  def main_game
    loop do  
      clear
      display_board
      current_player_moves
      break if board.round_winner? || board.full?
      display_board if human_move?
    end
  end
  
  def clear
    system 'clear'
  end 
  
  def display_welcome_message
    puts MESSAGES['welcome']
  end 
  
  def display_goodbye_message
    puts MESSAGES['goodbye']
  end 
  
  def display_round_winner
    if board.winning_marker == human.marker
      puts "You won this round"
      human.increment_score
    elsif board.winning_marker == computer.marker
      puts "#{computer.name} won this round"
      computer.increment_score
    else 
      puts "It's a tie!"
    end 
  end 
  
  def display_grand_winner
    if human.score == 3 
      puts MESSAGES['grand_winner']
    else 
      puts "#{computer.name} won the Game!"
    end 
  end 
  
  def play_again?
    answer = nil
    loop do
      puts MESSAGES['play_again']
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts MESSAGES['y_or_n']
    end
    answer == 'y'
  end
  
  def setup_game_choices 
    setup_human_choices
    setup_computer_choices 
  end 
  
  def setup_human_choices 
    human.set_name
    human.set_marker
    who_starts
  end 
  
  def setup_computer_choices
    computer.set_marker(human.marker)
  end 
  
  def who_starts
    puts "If you wish to start type 1, if you want #{computer.name} to start type 2"
    choice = nil 
    loop do 
      choice = gets.to_i
      break if [1, 2].include?(choice)
      puts "Please choose 1 or 2"
    end 
    if choice == 1 
      self.current_marker = human.marker
    else 
      self.current_marker = computer.marker
    end 
  end 
  
  def current_player_moves
    if human_move?
      human.choose_move(board)
      self.current_marker = computer.marker
    else
      computer.choose_move(board, human.marker)
      self.current_marker = human.marker
    end 
  end 
  
  def human_move?
    current_marker == human.marker
  end 
    
  def display_board
    puts "#{human.name} is a #{human.marker}, score: #{human.score}"
    puts "#{computer.name} is a #{computer.marker}, score: #{computer.score}"
    puts ''
    board.draw
    puts ''
  end 
  
  def reset
    board.reset
    clear
    who_starts
  end 
  
  def reset_scores
    human.reset_score
    computer.reset_score
  end 
end 

game = TTTGame.new
game.play