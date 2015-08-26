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

  def check_board 
    game_board.reverse
  end

  def drop_piece(column_num, piece)    
    # each row, from the bottom up
    check_board.each do |row|
      unless row[column_num].filled?
        return row[column_num].space = piece 
      end
    end
  end

  def wins_horizontally?
    check_board.each do |row|
      return true if check_row_for_win(row)
    end
    false
  end

  def check_row_for_win(row)
    row.each_cons(4) do |slice|
      if slice.length == 4 && slice.map(&:space).uniq.length == 1 && slice.first.space != nil
        return true
      end
    end
    false
  end

  def wins_vertically?
    (0...check_board.length).each do |index|
      vert = check_board.map { |row| row[index] }
      return true if check_row_for_win(vert)
    end
    false
  end

  def diagonal_down_left_bottom_quadrant?
    master_check = []
    (0...game_board.length).to_a.reverse.each do |index|
      row_index = 0
      column_index = index
      check_array = []
      while game_board[column_index] && game_board[column_index][row_index]
        check_array << game_board[column_index][row_index]
        row_index += 1
        column_index += 1
      end
      master_check << check_array if check_array.length >= 4
    end
    if master_check.map {|array| check_row_for_win(array)}.include?(true)
      return true
    else
      false
    end
  end

  def diagonal_down_left_top_quadrant?
    master_check = []
    (0...game_board.length).to_a.each do |index|
      row_index = index
      column_index = 0
      check_array = []
      while game_board[column_index] && game_board[column_index][row_index]
        check_array << game_board[column_index][row_index]
        row_index += 1
        column_index += 1
      end
      master_check << check_array if check_array.length >= 4
    end
    if master_check.map {|array| check_row_for_win(array)}.include?(true)
      return true
    else
      false
    end
  end

  def wins_diagonally?
    diagonal_down_left_bottom_quadrant? || diagonal_down_left_top_quadrant?

    # master_check = []
    # (0...game_board.length).to_a.reverse.each do |index|
    #   row_index = 0
    #   column_index = index
    #   check_array = []
    #   while game_board[column_index] && game_board[column_index][row_index]
    #     check_array << game_board[column_index][row_index]
    #     row_index += 1
    #     column_index += 1
    #   end
    #   master_check << check_array if check_array.length >= 4
    # end
    # if master_check.map {|array| check_row_for_win(array)}.include?(true)
    #   return true
    # else
    #   false
    # end
  end

  def game_won?
    wins_horizontally? || wins_vertically? 
  end

end
