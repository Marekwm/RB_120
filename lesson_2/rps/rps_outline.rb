class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_goodbye_message
  end
end

end

class Player
  def initialize
    # name of player and maybe the move
  end 
  
  def choose
  end
end 

class Move
   def initialize
    # seems like we need something to keep track
    # of the choice... a move object can be "paper", "rock" or "scissors"
  end
end 

class Rules 
  def initialize
    # not sure what the "state" of a rule object should be
  end
end 

# not sure where "compare" goes yet
def compare(move1, move2)

end

RPSGame.new.play()