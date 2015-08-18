require_relative 'board'

class Piece
  attr_accessor :color, :pos

  @@directions = { up: [-1, 0], down: [1, 0], left: [0, -1], right: [0, 1],
                   upleft: [-1,-1], upright: [-1, 1], downleft: [1, -1],
                   downright: [1, 1] }

  def initialize(options = {})
    defaults = { color: :white }
    options = defaults.merge(options)


    @pos = options[:pos]
    @color = options[:color]
  end

  def out_of_bounds?(pos)
    (pos[0] > 7 || pos[1] > 7) || (pos[0] < 0 || pos[1] < 0) ? true : false
  end

  def position_blocked?(pos)
    board[pos].is_a?(Piece) ? true : false
  end

  def mark_pathspace(board)
    pathspace(board).each do |pos|
      board.mark(pos,"ps")
    end
  end


end
