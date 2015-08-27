require_relative 'player'
require_relative 'board'

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
    
    while !@board.game_won? || !@game.stalemate?
      # first player move
      player1_prompt
      move = player_move
      @board.drop_piece(move, @player1.piece_type)
      @board.print_board(@board.game_board)
        if @board.game_won? || @game.stalemate?
          yield player1_wins
        else
      # second player move
      player2_prompt
      move = player_move



  end

  def player_setup
    puts "Player 1, please enter your name"
    name1 = "Mina"
    puts "A player name cannot be blank, please enter a name" if name1 == ''
    @player1 = Player.new(name1,"X")
    puts "Player 1 is #{@player1.name} and will be #{@player1.piece_type}"

    puts "Player 2 please enter your name"
    name2 = "Rei"
    puts "player name cannot be blank, please enter a name" if name2 == ''

    @player2 = Player.new(name2, "O")
    puts "Player 2 is #{@player2.name} and will be #{@player2.piece_type}"
  end

  def player1_prompt
    puts "#{@player1.name} select a column to place your piece"
  end

  def player_move
    gets.chomp
  end

  def player2_prompt
    puts "#{@player2.name} select a column to place your piece"
  end

  def player1_wins
    puts "#{@player1.name} Wins!!"
    play_again?
  end

  def player2_wins
    puts "#{@player2.name} Wins!!"
    play_again?
  end

  def play_again?
    puts "Would you like to play again? (Y/N?)"
    result = gets.chomp
    if result == "y".upcase
      new_game
    elsif result == "n".upcase
      puts "Thanks for playing!"
    else
      puts "Please enter Y/N "
      gets.chomp
    end
  end

  def new_game
    game = Game.new
    puts game.play
  end

end

new_game
