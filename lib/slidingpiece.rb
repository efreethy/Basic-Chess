require_relative 'piece'
require_relative 'array'
class SlidingPiece < Piece

  #collect positions along a direction until the board ends
  def trace_path(pos, dir)
      path =  []
      until @board.out_of_bounds?(pos)
        next_step = pos.neighbor(dir)
        pos = next_step
        path << next_step
      end
      path.pop #last position is invalid
      path
  end

  def get_pathspace(directions)
    pathspace = []
    directions.each do |dir|
      pathspace << trace_path(pos, @@directions[dir])
    end
    pathspace
  end

end

class Queen < SlidingPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright, :up, :down,
                           :left, :right]
  def pathspace
    get_pathspace(@@permitted_directions)
  end

end

class Bishop < SlidingPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright]

  def pathspace
    get_pathspace(@@permitted_directions)
  end

end

class Rook < SlidingPiece
  @@permitted_directions = [:up, :down, :left, :right]

  def pathspace
    get_pathspace(@@permitted_directions)
  end

end
