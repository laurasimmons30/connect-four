require 'rspec'
require_relative '../piece'
require_relative '../player'

describe Piece do 
  let (:piece) { Piece.new("X") }
  let (:player1) { Player.new("Babs", "X") }
  let (:player2) { Player.new("Jarlax", "O") }

  it 'a piece has a particular type' do
    expect(piece.type).to eq("X")
  end

  it "a piece matches a player's assigned type" do 
    check_piece = Piece.new(player1.piece_type)    
    expect(check_piece.type).to eq("X")

    check_piece = Piece.new(player2.piece_type)
    expect(check_piece.type).to eq("O")
  end
end
