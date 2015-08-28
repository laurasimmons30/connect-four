require 'rspec'
require_relative '../player'

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
end
