require_relative 'piece'
require_relative 'array'

class SingleStepPiece < Piece

  def get_pathspace(permitted_directions, board)
    pathspace = []
    permitted_directions.each do |dir|
      neighbor = pos.neighbor(@@directions[dir])
      next if out_of_bounds?(neighbor)
      if board[neighbor].is_a?(Piece) #include an enemy block into pathspace
        pathspace << neighbor unless board[neighbor].color == self.color
        next
      end
      pathspace << neighbor
    end
    pathspace
  end

end

class King < SingleStepPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright, :up, :down,
                           :left, :right]

  def pathspace(board)
    get_pathspace(@@permitted_directions, board)
  end

  def to_s
    color == :white ? "wK" : "bK"
  end

end

class Pawn < SingleStepPiece
  @@permitted_directions = [:upleft, :up, :upright]

  def pathspace(board)
    path = []
    @@permitted_directions.each do |dir|
      neighbor = pos.neighbor(@@directions[dir])
      next if out_of_bounds?(neighbor)
      if dir == :upleft || dir == :upright
        path << neighbor if board[neighbor].is_a?(Piece) && board[neighbor].color != self.color
      elsif dir == :up
        path << neighbor if board[neighbor] == nil
      end
    end
    path
  end

  def to_s
    color == :white ? "wP" : "bP"
  end

end

class Horse  < SingleStepPiece
  @@permitted_directions = [[-1, 2], [-1, -2], [1, 2], [1, -2], [-2, 1], [-2, -1], [2, 1], [2, -1]]

  def pathspace(board)
    pathspace = []
    @@permitted_directions.each do |dir|
      neighbor = pos.neighbor(dir)
      next if out_of_bounds?(neighbor)
      if board[neighbor].is_a?(Piece)
        pathspace << neighbor unless board[neighbor].color == self.color
        next
      end
      pathspace << neighbor
    end
    pathspace
  end

  def to_s
    color == :white ? "wH" : "bH"
  end

end
