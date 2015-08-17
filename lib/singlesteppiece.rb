require_relative 'piece'
require_relative 'board'
require_relative 'array'

class SingleStepPiece < Piece

  def get_pathspace(permitted_directions)
    pathspace = []
    permitted_directions.each do |dir|
      neighbor = pos.neighbor(@@directions[dir])
      pathspace << neighbor unless @board.out_of_bounds?(neighbor)
    end
    pathspace
  end

end

class King < SingleStepPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright, :up, :down,
                           :left, :right]

  def pathspace
    get_pathspace(@@permitted_directions)
  end
end

class Pawn < SingleStepPiece
  @@permitted_directions = [:upleft, :up, :upright]

  def pathspace
    get_pathspace(@@permitted_directions)
  end

end

class Horse  < SingleStepPiece
  @@permitted_directions = [[-1, 2], [-1, -2], [1, 2], [1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]]

  def pathspace
    pathspace = []
    @@permitted_directions.each do |dir|
      target_pos = pos.neighbor(dir)
      pathspace << target_pos unless @board.out_of_bounds?(target_pos)
    end
    pathspace
  end

end
