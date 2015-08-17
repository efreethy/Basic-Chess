require_relative 'board'

class Piece
  attr_accessor :color, :pos, :simplegrid

  @@directions = { up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1],
                   upleft: [-1,-1], upright: [-1, 1], downleft: [1, -1],
                   downright: [1, 1] }

  def initialize(board = Board.new, options = {})
    defaults = { color: :white }
    options = defaults.merge(options)

    @pos = options[:pos]
    @color = options[:color]
    @board = board
  end


end
