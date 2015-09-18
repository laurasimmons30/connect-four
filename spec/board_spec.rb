require 'rspec'
require_relative '../board'

describe Board do 
  let (:board) { Board.new }
  # its great that you have some specs! Unfortunately since the majority of the code in the app is all in the
  # Board class as a result this test file is very very large.

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

    it 'a piece cannot be added to a full column' do
      7.times { board.drop_piece(0, "X") }
      board.game_board.each_cons(6) do |slice|
        expect(slice.length).to eq(6)
      end
      expect(board.column_full?(0)).to eq(true)
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
      4.times { board.drop_piece(0, 'X') } 
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'game won if 4 consecutive vertical pieces in any column' do
      4.times { board.drop_piece(3, 'X') } 
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
      4.times { board.drop_piece(0, 'X')} 
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]
      # [O,_,_,_,_,_,_]
      # [X,_,_,_,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'does not win if only 3 consecutive vertical pieces with spaces above' do 
      3.times { board.drop_piece(0, 'X') } 
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
      2.times { board.drop_piece(0, 'O') }
      3.times { board.drop_piece(3, 'X') } 
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
      3.times { board.drop_piece(1, 'X') } 
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
    it 'wins if 4 of the same consecutive diagonal pieces win right down' do       
      board.drop_piece(0, "O")
      3.times { board.drop_piece(0, 'X') }     
      2.times { board.drop_piece(1, 'O') }
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

      expect(board.game_won?).to eq(true)
    end

    it 'wins if 4 diagonal right down from top left slot' do    
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      2.times { board.drop_piece(1, 'O') }
      board.drop_piece(1, 'X')
      board.drop_piece(1, 'O')
      board.drop_piece(1, 'X')
      3.times { board.drop_piece(2, 'O') }
      board.drop_piece(2, 'X')
      3.times { board.drop_piece(3, 'X') }
      # [X,_,_,_,_,_,_]
      # [O,X,_,_,_,_,_]
      # [X,O,X,_,_,_,_]
      # [O,X,O,X,_,_,_]
      # [X,O,O,X,_,_,_]
      # [O,O,O,X,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'wins diagonal right down starting in second top slot' do
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      board.drop_piece(0, 'O')
      board.drop_piece(0, 'X')
      2.times { board.drop_piece(0, 'O') }
      board.drop_piece(1, 'X')
      board.drop_piece(1, 'O')
      board.drop_piece(1, 'X')
      board.drop_piece(1, 'O')
      2.times { board.drop_piece(1, 'X') }
      3.times { board.drop_piece(2, 'O') }
      2.times { board.drop_piece(2, 'X') }
      board.drop_piece(3, 'O')            
      3.times { board.drop_piece(3, 'X') }
      board.drop_piece(4, 'X')
      board.drop_piece(4, 'O')
      board.drop_piece(4, 'X')                  
      # [O,X,_,_,_,_,_]
      # [O,X,X,_,_,_,_]
      # [X,O,X,X,_,_,_]
      # [O,X,O,X,X,_,_]
      # [X,O,O,X,O,_,_]
      # [O,X,O,O,X,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'wins diagonal right down starting in bottom right slot' do 
      board.drop_piece(2, 'O')
      3.times { board.drop_piece(2, 'X') }
      2.times { board.drop_piece(3, 'O') }
      board.drop_piece(3, 'X')
      board.drop_piece(4, 'O')
      board.drop_piece(4, 'X')
      board.drop_piece(5, 'X')
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,_,_,X,_,_,_]
      # [_,_,_,X,X,_,_]
      # [_,_,_,X,O,X,_]
      # [_,_,_,O,O,O,X]

      expect(board.game_won?).to eq(true)
    end

    it "wins diagonal left down starting in bottom left slot" do 
      board.drop_piece(0, 'X')
      board.drop_piece(1, 'O')
      board.drop_piece(1, 'X')
      3.times { board.drop_piece(2, 'X') }
      2.times { board.drop_piece(3,'O') }
      2.times { board.drop_piece(3,'X') }
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,_,_,X,_,_,_]
      # [_,_,X,X,_,_,_]
      # [_,X,X,O,_,_,_]
      # [X,O,X,O,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'wins diagonal left down starting on left side, third from bottom' do
      2.times { board.drop_piece(0, "O")}
      board.drop_piece(0, 'X')
      3.times { board.drop_piece(1, 'O') }
      board.drop_piece(1, 'X')
      3.times { board.drop_piece(2, 'X') }
      board.drop_piece(2, 'O')
      board.drop_piece(2, 'X')
      3.times { board.drop_piece(3,'O') }
      3.times { board.drop_piece(3,'X') }
      # [_,_,_,X,_,_,_]
      # [_,_,X,X,_,_,_]
      # [_,X,O,X,_,_,_]
      # [X,O,X,O,_,_,_]
      # [O,O,X,O,_,_,_]
      # [O,O,X,O,_,_,_]

      expect(board.game_won?).to eq(true)
    end

    it 'wins diagonal left starting on right side third slot' do
      board.drop_piece(3, 'X')
      board.drop_piece(4, 'O')
      board.drop_piece(4, 'X')
      3.times { board.drop_piece(5, 'X') }
      2.times { board.drop_piece(6,'O') }
      2.times { board.drop_piece(6,'X') }
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,_]
      # [_,_,_,_,_,_,X]
      # [_,_,_,_,_,X,X]
      # [_,_,_,_,X,X,O]
      # [_,_,_,X,O,X,O]

      expect(board.game_won?).to eq(true)
    end
  end

  context 'board knows if there ia a stalemate' do
    it 'game ends if there are no available spaces' do
      2.times {board.drop_piece(0, "X")}
      2.times {board.drop_piece(0, "O")}
      board.drop_piece(0, "X")
      board.drop_piece(0, "O")
      2.times {board.drop_piece(1, "O")}
      3.times {board.drop_piece(1, "X")}
      board.drop_piece(1, "O")
      board.drop_piece(2, "O")
      board.drop_piece(2, "X")
      3.times {board.drop_piece(2, "O")}
      board.drop_piece(2, "X")
      2.times {board.drop_piece(3,"X")}
      board.drop_piece(3, "O")
      board.drop_piece(3, "X")
      board.drop_piece(3, "O")
      board.drop_piece(3, "X")
      3.times {board.drop_piece(4, "O")}
      2.times {board.drop_piece(4, "X")}
      board.drop_piece(4, "O")
      3.times {board.drop_piece(5, "X")}
      2.times {board.drop_piece(5, "O")}
      board.drop_piece(5, "X")
      2.times {board.drop_piece(6, "O")}
      3.times {board.drop_piece(6, "X")}
      board.drop_piece(6, "O")
      # [O,O,X,X,O,X,O]
      # [X,X,O,O,X,O,X]
      # [O,X,O,X,X,O,X]
      # [O,X,O,O,O,X,X]
      # [X,O,X,X,O,X,O]
      # [X,O,O,X,O,X,O]

    expect(board.game_won?).to eq(false)
    expect(board.stalemate?).to eq(true)
    end

    it 'game does not end in draw if there are still spaces' do
      expect(board.stalemate?).to eq(false)
    end

  end
end
