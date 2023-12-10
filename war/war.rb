require 'yaml'
MESSAGES = YAML.load_file('war_text.yml')

class Cards
	include Comparable
	
	SUITS = ['H', 'C', 'D', 'S']
	FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

	def initialize(face,suit)
		@face = face
		@suit = suit
	end 	

	def to_s
		"The #{face} of #{suit}"
	end 	
	
	def <=>(other_card)
		convert_card <=> other_card.convert_card
	end 
	
	def face 
		case @face 
		when 'J' then 'Jack'
		when 'Q' then 'Queen'
		when 'K' then 'King'
		when 'A' then 'Ace'
		else 
			@face 
		end 
	end 
	
	def suit
		case @suit
		when 'H' then 'Hearts'
		when 'D' then 'Diamonds'
		when 'S' then 'Spades'
		when 'C' then 'Clubs'
		else 
			@face 
		end 
	end 
	
	def jack?
		face == 'Jack'
	end 
	
	def queen?
		face == 'Queen'
	end 
	
	def king?
		face == 'King'
	end 
	
	def ace?
		face == 'Ace'
	end 
	
	
	def convert_card
		case face
		when jack? then 11
		when queen? then 12
		when king? then 13
		when ace? then 14
		else
			face.to_i
		end 
	end 
	
end 

class Deck
	attr_accessor :cards
	
	def initialize
		@cards = []
		Cards::SUITS.each do |suit|
			Cards::FACES.each do |face|
				@cards << Cards.new(face, suit)
			end
		end 
		mix_cards! 
	end 

	def to_s
	  @cards
	end 
	
	def mix_cards!
		cards.shuffle!
	end 

	def deal_card
		cards.pop
	end 
	
	def show_cards
		puts @cards
	end 
end 

class Player
	attr_accessor :hand

	def initialize
		@hand = []
	end 

	def play_card
		hand.shift
	end 
	
	def show_cards
		puts hand
	end 
	
	def number_of_cards
		hand.size
	end 
end 


class WarGame
	attr_accessor :player1, :player2, :deck
  RULES = <<-MSG
War is played amongst 2 players, divide the cards evenly amongst the players. 
Each player turns up a card at the same time and the player with the higher 
card takes both cards and puts them, face down, on the bottom of his stack.
	
If the cards are the same rank, it is War. Each player turns up one card face
down and one card face up. The player with the higher cards takes both piles (six cards).
If the turned-up cards are again the same rank, each player places another card face down
and turns another card face up. The player with the higher card takes all 10 cards, and so on.
  MSG
  
	def initialize
	  @player1 = Player.new
	  @player2 = Player.new
	  @deck = Deck.new
	end 
	
	def display_welcome_message
		puts MESSAGES['intro_messages']
	end 
	
	def display_rules 
	  puts ''
	  puts RULES
	  puts ''
	end
 
  def display_goodbye_message
  	puts MESSAGES['goodbye_message']
  end 
	
		
	def deal_cards
		until deck.cards.empty?
			player1.hand << deck.deal_card
			player2.hand << deck.deal_card
		end
	end
	
	def war?(pool)
		pool[0] == pool[1]
	end 
	
	def initiate_war(pool)
		war_pool = pool
		2.times do 
			return if someone_won?
			war_pool.concat([player1.play_card, player2.play_card])
			display_cards(war_pool.last(2))
		end 
		if war?(war_pool.last(2)) 
			puts "Another war!"
			initiate_war(war_pool) unless someone_won?
		elsif war_pool[-2] > war_pool[-1]
			puts "Player1 won the war"
			player1.hand.concat(war_pool)
		else 
			puts "Player2 won the war"
			player2.hand.concat(war_pool)
		end 
	end 
	
	def play_cards 
		pool = [player1.play_card, player2.play_card]
		display_cards(pool)
		if war?(pool)
			puts "It's War!"
			initiate_war(pool)
		elsif pool[0] > pool[1]
			puts "Player1 won the hand"
			player1.hand.concat([pool[0], pool[1]])
		else
			puts "Player2 won the hand"
			player2.hand.concat([pool[0], pool[1]])
		end 
	end
	
	def display_cards(pool) 
		puts "Player1 card is #{pool[0]}"
		puts "Player2 card is #{pool[1]}"
	end 
	
	def someone_won?
		player1.hand.empty? || player2.hand.empty?
	end 
	
	def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include?(answer)
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end
	
	def play
		display_welcome_message
		display_rules
		loop do
			deal_cards
			until someone_won?
				play_cards
			end 
			break unless play_again?
		end 
		display_goodbye_message
	end 
	
end

game = WarGame.new
game.play
