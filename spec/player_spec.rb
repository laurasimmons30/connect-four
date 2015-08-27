require 'rspec'
require_relative '../player'
require_relative '../piece'

describe Player do 
  let (:player1) { Player.new("Babs", "X") }
  let (:player2) { Player.new("Jarlax", "O") }

  it 'a player has a name' do
    expect(player1.name).to eq("Babs")
    expect(player2.name).to eq("Jarlax")
  end

  it 'a player has a piece type' do
    expect(player1.piece_type).to eq("X")
  end

  it "a piece always matches a player's piece type" do 
    piece = Piece.new(player1.piece_type)
    expect(piece.type).to eq("X")
  end
end
