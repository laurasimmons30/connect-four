# type is 'X' or 'O'

class Piece
  attr_reader :type

  def initialize(type)
    @type = type
  end
end
