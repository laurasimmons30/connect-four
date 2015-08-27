require_relative 'player'
require_relative 'board'
require 'pry'

class Game
  def initialize
    @board = Board.new
  end

  def play
    puts "Welcome to Ruby Connect Four!"
    puts " "
    player_setup
    puts " "
    @board.print_board(@board.game_board)
    puts " "
    
    while !@board.game_won? 
      # || !@game.stalemate?
      # first player move
      player_prompt(@player1)
      @move = get_player_move_choice

      unless @move.to_i 
        puts "Please only use numbers"
        @move = get_player_move_choice
      end 
      
      player_move(@player1)
      return player_wins(@player1) if @board.game_won? 
      # || @game.stalemate?
      
      # second player move
      player_prompt(@player2)
      @move = get_player_move_choice
      unless @move.to_i 
        puts "Please only use numbers"
        @move = get_player_move_choice
      end  

      player_move(@player2)
      return player_wins(@player2) if @board.game_won? 
      # || @game.stalemate?
    end
  end

  def player_setup
    puts "Player 1, please enter your name"
    name1 = gets.chomp
    puts "A player name cannot be blank, please enter a name" if name1 == ''
    @player1 = Player.new(name1,"X")
    puts "Player 1 is #{@player1.name} and will be #{@player1.piece_type}"

    puts "Player 2 please enter your name"
    name2 = gets.chomp
    puts "player name cannot be blank, please enter a name" if name2 == ''

    @player2 = Player.new(name2, "O")
    puts "Player 2 is #{@player2.name} and will be #{@player2.piece_type}"
  end

  def player_prompt(player)
    puts "#{player.name} select a column to place your piece"
  end

  def get_player_move_choice
    gets.chomp
  end

  def player_move(player)
    @board.drop_piece(@move.to_i, player.piece_type)
    @board.print_board(@board.game_board)
  end

  def player_wins(player)
    puts "#{player.name} Wins!!"
    play_again?
  end

  def play_again?
    puts "Would you like to play again? (Y/N?)"
    result = gets.chomp.upcase
    if result == "Y"
      game = Game.new
      puts game.play
    elsif result == "N"
      puts "Thanks for playing!"
    else
      puts "Please enter Y/N "
      gets.chomp
    end
  end
end

game = Game.new
game.play

# why is the board being shown when I commented out the game?
