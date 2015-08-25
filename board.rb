require 'space'

class Board
  attr_accessor :game_board
  def initialize
    @game_board = build_game_board
  end

  def build_game_board
    all_rows_and_columns = []
    6.times do 
      row = []
      7.times do
        row << Space.new
      end
      all_rows_and_columns << row
    end
    all_rows_and_columns
  end

  # def game_board
    
  #   [["", "", "", "", "", "", ""],
  #    ["", "", "", "", "", "", ""],
  #    ["", "", "", "", "", "", ""],
  #    ["", "", "", "", "", "", ""],
  #    ["", "", "", "", "", "", ""],
  #    ["", "", "", "", "", "", ""]]
  # end
end
