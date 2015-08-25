require 'rspec'
require 'pry'
require_relative '../board'

describe Board do 
  let (:board) { Board.new }

  it "a board has 6 rows" do
    expect(board.game_board.length).to eq(6)
  end

  it 'a board has 7 columns' do
    board.game_board.each do |row|
      expect(row.length).to eq(7) 
    end    
  end

  context 'a piece can be dropped in a board' do
    it "a piece can be dropped in row 1" do
      board.drop_piece(1, 'standin piece')

      expect(board.game_board.last.first).to eq('standin piece')
    end

  end
end
