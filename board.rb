require_relative 'space'
require 'pry'

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

  def drop_piece(column_num, piece)
    check_board = @game_board.reverse
    
    # each row, from the bottom up
    check_board.each do |row|
      unless row[column_num].filled?
        return row[column_num].space = piece 
      end
    end
  end

def wins_horizontally?
  check_board = game_board.reverse
  # check_array = []

  # check_board.each do |row|
  #   row.each do |slot|
  #     if slot.filled? && check_array == []
  #       check_array << slot.space
  #     elsif slot.filled? && slot.space == check_array.first
  #       check_array << slot.space
  #     else
  #       check_array = []
  #     end
  #     return true if check_array.length == 4
  #   end
  # end
  check_board.each do |row|
    row.each_cons(4) do |slice|
      if slice.length == 4 && slice.map(&:space).uniq.length == 1 && slice.first.space != nil
        return true
      end
    end
  end
  false
end

  def game_won?
    wins_horizontally?
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
