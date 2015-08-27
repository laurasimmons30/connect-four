class Player
  attr_accessor :name, :piece_type
  def initialize(name, piece_type)
    @name = name
    @piece_type = piece_type
  end

  def make_move
    gets.chomp
  end

end
