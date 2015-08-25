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
      board.drop_piece(0, 'standin piece')

      expect(board.game_board.last.first.space).to eq('standin piece')
    end

    it "the piece is only in the bottom most row in row one" do
      board.drop_piece(0, 'standin piece')

      expect(board.game_board.first.first.space).to eq(nil)
      expect(board.game_board[-2].first.space).to eq(nil)
      expect(board.game_board.last.first.space).to eq('standin piece')
    end

    it 'two pieces dropped in same column are in the bottom most row and the one above respectively' do
      board.drop_piece(0, 'standin piece')
      board.drop_piece(0, 'standin piece')

      expect(board.game_board.first.first.space).to eq(nil)
      expect(board.game_board[-2].first.space).to eq('standin piece')
      expect(board.game_board.last.first.space).to eq('standin piece')
    end

    it 'two pieces dropped do not appear in any other columns other than one designated' do
      board.drop_piece(0, 'standin piece')
      board.drop_piece(0, 'standin piece')

      expect(board.game_board.first.last.space).to eq(nil)
      expect(board.game_board.first[1].space).to eq(nil)
      expect(board.game_board[-2].first.space).to eq('standin piece')
      expect(board.game_board.last.first.space).to eq('standin piece')
    end

    it 'two pieces dropped in two different columns are on the bottom most row' do
      board.drop_piece(0, 'standin piece')
      board.drop_piece(1, 'standin piece')

      expect(board.game_board.first.last.space).to eq(nil)
      expect(board.game_board.first.first.space).to eq(nil)
      expect(board.game_board.first[1].space).to eq(nil)
      expect(board.game_board.first.last.space).to eq(nil)
      expect(board.game_board.last[1].space).to eq('standin piece')
      expect(board.game_board[-2].first.space).to eq(nil)
      expect(board.game_board.last.first.space).to eq('standin piece')
    end
  end

  context 'the board knows when the game is won horizontally' do
    it 'if the game is won horizontally' do
      board.drop_piece(0, 'standin piece')
      board.drop_piece(1, 'standin piece')
      board.drop_piece(2, 'standin piece')
      board.drop_piece(3, 'standin piece')
      #[X,X,X,X,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'if the game is won horizontally' do
      board.drop_piece(2, 'standin piece')
      board.drop_piece(3, 'standin piece')
      board.drop_piece(4, 'standin piece')
      board.drop_piece(5, 'standin piece')
      #[_,_,X,X,X,X,_]

      expect(board.game_won?).to eq(true)
    end

    it 'if the game is won horizontally' do
      board.drop_piece(0, 'standin piece')
      board.drop_piece(1, 'standin piece')
      board.drop_piece(2, 'standin piece')
      #[X,X,X,_,_,_,_]

      expect(board.game_won?).to eq(false)
    end

    it 'if the game is won horizontally' do
      board.drop_piece(0, 'standin piece')
      board.drop_piece(1, 'standin piece')
      board.drop_piece(2, 'standin piece')
      board.drop_piece(5, 'standin piece')
      #[X,X,X,_,_,X,_]

      expect(board.game_won?).to eq(false)
    end
  end
end
