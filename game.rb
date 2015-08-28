require_relative 'player'
require_relative 'board'
require 'pry'

class Game
  def initialize
    @board = Board.new
  end

  def start
    welcome_prompt
    play
  end

  def play 
    while true
      player_turn(@player1)
      break if check_game_won?(@player1)

      player_turn(@player2)
      break if check_game_won?(@player2)
    end
    play_again?
  end

  def player_turn(player)
    player_prompt(player)
    move = get_player_move    
    player_move(player, move)
  end

  def welcome_prompt
    puts "Welcome to Ruby Connect Four!"
    puts " "
    player_setup
    puts " "
    @board.print_board
    puts " "
  end

  def player_setup
    puts "Player 1, please enter your name"
    name1 = gets.chomp
    while name1 == ''
      puts "A player name cannot be blank. Please enter a name"
      name1 = gets.chomp
    end
    @player1 = Player.new(name1,"\e[0;31mX\e[0m")
    puts "Player 1 is #{@player1.name} and will be #{@player1.piece_type}"
    puts ""
    puts "Player 2 please enter your name"
    name2 = gets.chomp
    while name2 == '' || name2 == name1
      puts "Player name cannot be blank or same as #{@player1.name}. Please enter a name"
      name2 = gets.chomp
    end
    @player2 = Player.new(name2, "\e[0;33mO\e[0m") 
    puts "Player 2 is #{@player2.name} and will be #{@player2.piece_type}"
  end

  def player_prompt(player)
    puts "#{player.name} select a column to place your piece"
  end

  def get_player_move_choice
    gets.chomp
  end

  def player_move(player, move)
    @board.drop_piece(move.to_i, player.piece_type)
    @board.print_board
  end

  def get_player_move
    @move = get_player_move_choice
    if !(/\A[0-6]\z/.match(@move)) || @move == ''
      puts "Invalid choice, please select column again"
      get_player_move
    end
    return @move
  end

  def player_wins(player)
    puts "#{player.name} Wins!!"
    true
  end

  def stalemate_end
    puts "Stalemate! No more available moves!"
    true
  end

  def check_game_won?(player)
    if @board.game_won?
      return player_wins(player)
    elsif @board.stalemate?
      return stalemate_end
    end
  end

  def play_again?
    puts "Would you like to play again? (Y/N?)"
    result = gets.chomp.upcase
    if result == "Y"
      @board = Board.new
      @board.print_board
      play
    elsif result == "N"
      puts "Thanks for playing!"
    else
      puts "Please enter Y/N "
      play_again?
    end
  end
end
