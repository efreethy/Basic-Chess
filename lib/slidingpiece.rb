require_relative 'piece'

class SlidingPiece < Piece

  def get_pathspace(directions, board)
    pathspace = []
    directions.each do |dir|
      pathspace << trace_path(pos, @@directions[dir], board)
    end
    pathspace = clean_pathspace(pathspace)
  end



  #collect positions along a direction until the board ends
  def trace_path(pos, dir, board)
    path = []
    loop do
      next_step = pos.neighbor(dir)
      break if out_of_bounds?(next_step)
      if board[next_step].is_a?(Piece)
        path << next_step if board[next_step].color != self.color
        break
      end
      path << next_step
      pos = next_step
    end
    path
  end

  def clean_pathspace(pathspace)
    clean_pathspace = []
    pathspace = pathspace.flatten(1)
    pathspace.each do |pos|
      clean_pathspace << pos unless pos.empty?
    end
    clean_pathspace
  end

end

class Queen < SlidingPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright, :up, :down,
                           :left, :right]
  def pathspace(board)
    get_pathspace(@@permitted_directions, board)
  end

  def to_s
    color == :white ? "wQ" : "bQ"
  end

end

class Bishop < SlidingPiece
  @@permitted_directions = [:upleft, :upright, :downleft, :downright]

  def pathspace(board)
    get_pathspace(@@permitted_directions,board)
  end

  def to_s
    color == :white ? "wB" : "bB"
  end

end

class Rook < SlidingPiece
  @@permitted_directions = [:up, :down, :left, :right]

  def pathspace(board)
    get_pathspace(@@permitted_directions,board)
  end

  def to_s
    color == :white ? "wR" : "bR"
  end

end
