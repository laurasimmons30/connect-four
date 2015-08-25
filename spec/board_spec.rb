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
      board.drop_piece(0, 'X')

      expect(board.game_board.last.first.space).to eq('X')
    end

    it "the piece is only in the bottom most row in row one" do
      board.drop_piece(0, 'X')

      expect(board.game_board.first.first.space).to eq(nil)
      expect(board.game_board[-2].first.space).to eq(nil)
      expect(board.game_board.last.first.space).to eq('X')
    end

    it 'two pieces dropped in same column are in the bottom most row and the one above respectively' do
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')

      expect(board.game_board.first.first.space).to eq(nil)
      expect(board.game_board[-2].first.space).to eq('X')
      expect(board.game_board.last.first.space).to eq('X')
    end

    it 'two pieces dropped do not appear in any other columns other than one designated' do
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')

      expect(board.game_board.first.last.space).to eq(nil)
      expect(board.game_board.first[1].space).to eq(nil)
      expect(board.game_board[-2].first.space).to eq('X')
      expect(board.game_board.last.first.space).to eq('X')
    end

    it 'two pieces dropped in two different columns are on the bottom most row' do
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'X')

      expect(board.game_board.first.last.space).to eq(nil)
      expect(board.game_board.first.first.space).to eq(nil)
      expect(board.game_board.first[1].space).to eq(nil)
      expect(board.game_board.first.last.space).to eq(nil)
      expect(board.game_board.last[1].space).to eq('X')
      expect(board.game_board[-2].first.space).to eq(nil)
      expect(board.game_board.last.first.space).to eq('X')
    end
  end

  context 'the board knows when the game is won horizontally' do
    it 'game is won if first four are consecutive' do
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'X')
      board.drop_piece(2, 'X')
      board.drop_piece(3, 'X')
      #[X,X,X,X,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'game is won if four in a row with spaces on ends' do
      board.drop_piece(2, 'X')
      board.drop_piece(3, 'X')
      board.drop_piece(4, 'X')
      board.drop_piece(5, 'X')
      #[_,_,X,X,X,X,_]

      expect(board.game_won?).to eq(true)
    end

    it 'does not win if only three in a row' do
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'X')
      board.drop_piece(2, 'X')
      #[X,X,X,_,_,_,_]

      expect(board.game_won?).to eq(false)
    end

    it 'does not win if four in a row are not consecutive' do
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'X')
      board.drop_piece(2, 'X')
      board.drop_piece(5, 'X')
      #[X,X,X,_,_,X,_]

      expect(board.game_won?).to eq(false)
    end
  end

  context 'the board knows when the game is won vertically' do
    it 'game won if 4 consecutive pieces in first slots in bottom 4 rows' do
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'game won if 4 consecutive vertical pieces in any column' do
      board.drop_piece(3, 'X')
      board.drop_piece(3, 'X')
      board.drop_piece(3, 'X')
      board.drop_piece(3, 'X')
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,_,_,X,_,_,_]
      # [_,_,_,X,_,_,_]
      # [_,_,_,X,_,_,_]
      # [_,_,_,X,_,_,_]

      expect(board.game_won?).to eq(true)      
    end

    it 'game won if 4 vertical pieces with a space between one' do
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [O,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'does not win if only 3 consecutive vertical pieces with spaces above' do 
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]

      expect(board.game_won?).to eq(false)
    end

    it 'does not win if only 3 consecutive pieces are the same' do
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [O,_,_,_,_,_,_]
      # [O,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]

      expect(board.game_won?).to eq(false)    
    end

    it 'does not win vertically if the pieces are not in the same column' do
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'X')
      board.drop_piece(1, 'X')
      board.drop_piece(1, 'X')
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,X,_,_,_,_,_]
      # [_,X,_,_,_,_,_]
      # [X,X,_,_,_,_,_]

      expect(board.game_won?).to eq(false)
    end
  end

  context 'the board knows when it wins diagonally' do
    it 'starting at bottom left, wins if 4 of the same consecutive diagonal pieces' do       
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'O')
      board.drop_piece(1, 'O')
      board.drop_piece(1, 'X')
      board.drop_piece(2, 'O')
      board.drop_piece(2, 'X')
      board.drop_piece(3, 'X')
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,X,_,_,_,_,_]
      # [X,O,X,_,_,_,_]
      # [O,O,O,X,_,_,_]

      expect(board.wins_diagonally?).to eq(true)
    end
  end
end
